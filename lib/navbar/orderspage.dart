import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
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
              
              // Order list
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
               return  OrderCard(
                      materialType: 'Plastic',
                      orderId: 'ENC - 100201',
                      status: 'Pending Approval',
                      estWeight: '3kg',
                      estIncome: 'NGN 3,700',
                      pickUpDate: 'Flexible',
                      address: '28 Limca Road, Awada, Onitsha',
                    ); },

                ),
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
  final String estWeight;
  final String estIncome;
  final String pickUpDate;
  final String address;

  const OrderCard({
    required this.materialType,
    required this.orderId,
    required this.status,
    required this.estWeight,
    required this.estIncome,
    required this.pickUpDate,
    required this.address,
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
                    Text(orderId, style: TextStyle(fontWeight: FontWeight.bold)),
                                
            // Status
            Text(
              status,
              style: TextStyle(color: status == 'Approved' ? Colors.green : Colors.orange),
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
                       Text(estWeight,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Est. Income:',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                       Text(estIncome,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pickup Date:',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                       Text('31 Feb 2025 😂',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                    ],
                  ),            
                  // Address
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pickup Address:',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),),
                       Text('20 Nnamdi Kanu Way Nnewi',
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

