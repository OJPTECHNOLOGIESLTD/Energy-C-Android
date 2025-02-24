import 'dart:convert';

import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class OrdersPage extends StatelessWidget {
  final String baseUrl = "https://backend.energychleen.ng/api";

Future<List<Order>> fetchOrders() async {
  try {
    final url = Uri.parse('$baseUrl/orders');
    print('Requesting: $url');

    final response = await http.get(url).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      print('items${response.body}');

      if (response.headers['content-type']?.contains('application/json') ?? false) {
        // Parse the response body as a Map
        Map<String, dynamic> data = json.decode(response.body);

        // Access the 'orders' list from the response
        List<dynamic> ordersJson = data['orders'];

        // Map the orders list to Order objects
        return ordersJson.map((orderJson) => Order.fromJson(orderJson)).toList();
      } else {
        throw Exception('Invalid response format. Expected JSON.');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Endpoint not found. Check the URL.');
    } else {
      throw Exception('Failed to load orders. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Error fetching orders: $e');
  }
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
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabButton(title: 'Active', isActive: true),
                    TabButton(title: 'Cancelled', isActive: false),
                    TabButton(title: 'Completed', isActive: false),
                  ],
                ),
              ),
              SizedBox(height: 16),
              
              // Search bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *0.85,
                    decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)
                  ),
                    child: TextField(
                      strutStyle: StrutStyle(height: 2, forceStrutHeight: true, fontStyle: FontStyle.normal),
                      decoration: InputDecoration(
                        hintText: 'Search History',
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: InputBorder.none,  // Removes the border when enabled
                        focusedBorder: InputBorder.none, 
                      ),
                    ),
                  ),
              Icon(Icons.filter_alt_outlined),
                ],
              ),
              SizedBox(height: 16),
              
              FutureBuilder<List<Order>>(
              future: fetchOrders(),
              // ApiService.instance.fetchRecycleEssentials(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerEffects(height: 0.5);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('You Have no orders.'));
                } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final order = snapshot.data![index];
               return  OrderCard(
                      materialType: order.address,
                      orderId: order.orderId,
                      status: order.status,
                      quantity: order.totalWeight,
                      estIncome: order.totalPrice,
                      pickUpDate: order.date,
                      address: order.address, cityName: order.cityName, stateName: order.stateName,
                    ); },

                ),
              );
              
              }}),
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

  const TabButton({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Customcolors.teal : Colors.grey[100],
        borderRadius: BorderRadius.circular(40)
      ),
      child: GestureDetector(
        onTap:  () {
        // Handle tab click
      },
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(color: isActive ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String materialType;
  final String orderId;
  final String status;
  final double quantity;
  final double estIncome;
  final String pickUpDate;
  final String address;
    final int cityName;
  final int stateName;

  const OrderCard({
    required this.materialType,
    required this.orderId,
    required this.status,
    required this.quantity,
    required this.estIncome,
    required this.pickUpDate,
    required this.address, required this.cityName, required this.stateName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
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
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text( materialType,
                  style: TextStyle(fontWeight: FontWeight.w500, color: Customcolors.white),),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(orderId.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                                
            // Status
            Text(
  status,
  style: TextStyle(
    color: status == 'Approved' 
        ? Colors.green 
        : status == 'Pending' 
            ? Colors.orange 
            : status == 'Cancelled' 
                ? Colors.red 
                : Colors.black, // Default color if none match
  ),
),
                  ],
                ),
              ],
            ),
            
            // Estimated Weight and Income
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Est. Weight:',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                       Text(quantity.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Est. Income:',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                       Text(estIncome.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pickup Date:',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                       Text(pickUpDate,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                    ],
                  ),            
                  // Address
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pickup Address:',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                       Text('${address} ${cityName} ${stateName}',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            
            // Cancel Request Button
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                 width: double.infinity,
                child: ElevatedButton(
                  
                  onPressed: () {
                    // Handle cancel request
                  },
                   style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                backgroundColor: Customcolors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                  child: Text('Cancel Request', style: TextStyle(
                    color: Customcolors.white,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

