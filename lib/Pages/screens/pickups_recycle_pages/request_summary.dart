import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/recyclingpage.dart';
import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/waste_info.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestSummary extends StatefulWidget {
  const RequestSummary({super.key});

  @override
  State<RequestSummary> createState() => _RequestSummaryState();
}

class _RequestSummaryState extends State<RequestSummary> {
  String? wasteType;
  int? weight;
  int? estPrice;
  DateTime? pickupDate;

  @override
  void initState() {
    super.initState();
    _loadScheduleData();
  }

  Future<void> _loadScheduleData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      wasteType = prefs.getString('wasteType');
      weight = prefs.getInt('weight');
      estPrice = prefs.getInt('estPrice');
      // Set a hardcoded pickup date for now or retrieve from SharedPreferences
      pickupDate = DateTime.now(); // Use your logic to set this date
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Summary'),
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: 50,
          width: 50,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Customcolors.teal,
          ),
          child: IconButton(
            tooltip: 'Go back',
            icon: Icon(Icons.arrow_back_ios, size: 18, color: Customcolors.white),
            onPressed: () => Navigator.pop(context), // Navigate back
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          RecyclingScheduleProgress(isReviewing: true, isCompleted: false),
          _buildWasteTypeAndDetails(),
        ],
      ),
    );
  }

  // waste details
  Widget _buildWasteTypeAndDetails() {
    if (wasteType == null || weight == null || estPrice == null || pickupDate == null) {
      return Center(child: CircularProgressIndicator()); // Show loading indicator
    }

    return SizedBox(
      height: 300, // Define a fixed height for the list
      child: ListView.separated(
        itemCount: 1, // You are displaying only one item, so set count to 1
        itemBuilder: (context, index) {
          return WasteInfoCard(
            wasteType: wasteType!,
            weight: weight!,
            estimatedIncome: estPrice!,
            editWasteDetails: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecyclingPage(wasteType: wasteType.toString()),
                ),
              );
            },
            removeWasteType: () async {
              // Remove the waste type from SharedPreferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('wasteType');
              await prefs.remove('weight');
              await prefs.remove('estPrice');
              setState(() {
                wasteType = null;
                weight = null;
                estPrice = null;
              });
            },
            pickupDate: pickupDate!,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }
}
