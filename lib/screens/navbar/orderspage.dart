import 'dart:convert';
import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  final String baseUrl =
      "https://backend.energychleen.ng/api"; // Replace with your API base URL

  Future<Map<String, dynamic>> cancelOrder(String orderId) async {
    final url = Uri.parse(
        "$baseUrl/orders/${AuthController.instance.userDetails.value!.id}/cancel/$orderId"); //
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token')?.trim() ?? '';

    print("Token: Bearer $token"); // Check the full token format

    try {
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer $token", // Correctly formatted with "Bearer"
            "Accept": "application/json",
          },
          body: jsonEncode({
            "orderId": orderId, // Include orderId in the request body
          }));

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar("Success", 'Order ${orderId} been successfully canceled',
            backgroundColor: Customcolors.teal, colorText: Customcolors.white);
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to cancel order",
          "statusCode": response.statusCode,
          "message": response.body
        };
      }
    } catch (e) {
      return {"error": "An error occurred", "details": e.toString()};
    }
  }
}

class OrdersPage extends StatefulWidget {
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool approved = true;
  bool pending = false;
  bool cancelled = false;
  bool completed = false;

  void setActiveTab(String tabName) {
    setState(() {
      approved = tabName == 'Active';
      pending = tabName == 'Pending';
      cancelled = tabName == 'Cancelled';
      completed = tabName == 'Completed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tab buttons
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                    color: Customcolors.offwhite,
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabButton(
                      title: 'Active',
                      isActive: approved,
                      onTap: () {
                        setActiveTab('Active');
                      },
                    ),
                    TabButton(
                      title: 'Pending',
                      isActive: pending,
                      onTap: () {
                        setActiveTab('Pending');
                      },
                    ),
                    TabButton(
                      title: 'Cancelled',
                      isActive: cancelled,
                      onTap: () {
                        setActiveTab('Cancelled');
                      },
                    ),
                    TabButton(
                      title: 'Completed',
                      isActive: completed,
                      onTap: () {
                        setActiveTab('Completed');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Search bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      strutStyle: StrutStyle(
                          height: 2,
                          forceStrutHeight: true,
                          fontStyle: FontStyle.normal),
                      decoration: InputDecoration(
                        hintText: 'Search History',
                        prefixIcon: Icon(Icons.search),
                        enabledBorder:
                            InputBorder.none, // Removes the border when enabled
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.filter_alt_outlined),
                ],
              ),
              SizedBox(height: 16),

              FutureBuilder<List<Order>>(
                future: AuthController.instance.fetchOrders(
                  AuthController.instance.userDetails.value!.id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ShimmerEffects(height: 0.7);
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(
                      'Nothing to see here.',
                      style: TextStyle(color: Colors.black),
                    ));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final order = snapshot.data![index];

                          if (approved && order.status == 'Approved') {
                            return OrderCard(
                              materialType: order.wasteItems
                                  .map((item) => item.category)
                                  .join(', '), // Join names of waste items
                              orderId: order.orderId,
                              status: order.status,
                              quantity: order.totalWeight,
                              estIncome: order.totalPrice,
                              pickUpDate: order.date,
                              address: order.address,
                              cityName: AuthController.instance.getCityName(order
                                  .cityId), // Get city name from backend data
                              stateName: AuthController.instance.getStateName(order
                                  .stateId), // Get state name from backend data
                              points: order.point,
                            );
                          } else if (pending && order.status == 'Pending') {
                            return OrderCard(
                              materialType: order.wasteItems
                                  .map((item) => item.category)
                                  .join(', '), // Join names of waste items
                              orderId: order.orderId,
                              status: order.status,
                              quantity: order.totalWeight,
                              estIncome: order.totalPrice,
                              pickUpDate: order.date,
                              address: order.address,
                              cityName: AuthController.instance
                                  .getCityName(order.cityId),
                              stateName: AuthController.instance
                                  .getStateName(order.stateId),
                              points: order.point,
                            );
                          } else if (cancelled && order.status == 'Canceled') {
                            return OrderCard(
                              materialType: order.wasteItems
                                  .map((item) => item.category)
                                  .join(', '),
                              orderId: order.orderId,
                              status: order.status,
                              quantity: order.totalWeight,
                              estIncome: order.totalPrice,
                              pickUpDate: order.date,
                              address: order.address,
                              cityName: AuthController.instance
                                  .getCityName(order.cityId),
                              stateName: AuthController.instance
                                  .getStateName(order.stateId),
                              points: order.point,
                            );
                          } else if (completed && order.status == 'Completed') {
                            return OrderCard(
                              materialType: order.wasteItems
                                  .map((item) => item.category)
                                  .join(', '), // Join names of waste items
                              orderId: order.orderId,
                              status: order.status,
                              quantity: order.totalWeight,
                              estIncome: order.totalPrice,
                              pickUpDate: order.date,
                              address: order.address,
                              cityName: AuthController.instance.getCityName(order
                                  .cityId), // Get city name from backend data
                              stateName: AuthController.instance.getStateName(order
                                  .stateId), // Get state name from backend data
                              points: order.point,
                            );
                          }

                          // If no order matches, return empty container
                          return SizedBox.shrink();
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const TabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Customcolors.teal : Colors.grey[100],
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: isActive ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  final String materialType;
  final String orderId;
  final String status;
  final double quantity;
  final double estIncome;
  final String pickUpDate;
  final String address;
  final String cityName;
  final String stateName;
  final double points;

  const OrderCard({
    required this.materialType,
    required this.orderId,
    required this.status,
    required this.quantity,
    required this.estIncome,
    required this.pickUpDate,
    required this.address,
    required this.cityName,
    required this.stateName,
    required this.points,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isLoading = false;

  void cancelUserOrder() async {
    setState(() {
      isLoading = true;
    });

    String orderId = widget.orderId; // Example order ID
    OrderService orderService = OrderService();

    var response = await orderService.cancelOrder(orderId);

    setState(() {
      isLoading = false;
    });

    if (response.containsKey("error")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response['message']}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Success: ${response['message']}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        // color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Material Type and Order ID
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Customcolors.teal,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      widget.materialType,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Customcolors.white),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(widget.orderId.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),

                      // Status
                      Text(
                        widget.status,
                        style: TextStyle(
                          color: widget.status == 'Approved'
                              ? Colors.green
                              : widget.status == 'Pending'
                                  ? Colors.orange
                                  : widget.status == 'Completed'
                                      ? Colors.green
                                      : widget.status == 'Canceled'
                                          ? Colors.red
                                          : Colors
                                              .black, // Default color if none match
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Estimated Weight and Income
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Est. Weight:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Text(
                          '${widget.quantity.toString()} kg',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Est. Income:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Text(
                          'NGN ${widget.estIncome.toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pickup Date:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Text(
                          widget.pickUpDate,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Address
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pickup Address:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            '${widget.address} ${widget.cityName} ${widget.stateName}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    if (widget.status == 'Completed')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '+ ${widget.points} points earned',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Customcolors.teal),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Cancel Request Button
              Visibility(
                visible:
                    widget.status == "Approved" || widget.status == "Pending",
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (widget.status == 'Approved' ||
                              widget.status == 'Pending') {
                            cancelUserOrder();
                          } else {
                            // ApiService.instance.createPost(
                            //     context: context,
                            //     date: widget.pickUpDate,
                            //     address: widget.address,
                            //     cityId: widget.cityName,
                            //     stateId: widget.stateName,
                            //     pickupType: widget.materialType,
                            //     wasteItems: [],
                            //     images: [],
                            //     videos: []);

                            print('Rescheduling..');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: Customcolors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child:
                            //  widget.status == 'Approved' || widget.status =='Pending'
                            // ?
                            Text(
                          'Cancel Request',
                          style: TextStyle(
                              color: Customcolors.white,
                              fontWeight: FontWeight.bold),
                        )
                        // : Text(
                        //     'Reschedule',
                        //     style: TextStyle(
                        //         color: Customcolors.white,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
