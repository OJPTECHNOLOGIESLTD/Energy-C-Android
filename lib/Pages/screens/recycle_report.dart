import 'package:energy_chleen/appbars/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RecycleReportScreen extends StatefulWidget {
  @override
  _RecycleReportScreenState createState() => _RecycleReportScreenState();
}

class _RecycleReportScreenState extends State<RecycleReportScreen> {
  bool isMonthly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: 'Recycle Report'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Card(
              elevation: 5,
              color: Customcolors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Weight Recycled',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '18kg',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Weekly | Monthly',
                          style: TextStyle(color: Colors.white),
                        ),
                        Switch(
                          value: isMonthly,
                          onChanged: (value) {
                            setState(() {
                              isMonthly = value;
                            });
                          },
                          inactiveTrackColor: Colors.teal.shade200,
                          inactiveThumbColor: Colors.white,
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Total Est. Income',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 50),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  isVisible: false, // Removes gridline numbers
                ),
                series: <CartesianSeries>[
                  ColumnSeries<ChartData, String>(
                    dataSource:
                        isMonthly ? _createMonthlyData() : _createWeeklyData(),
                    xValueMapper: (ChartData data, _) => data.label,
                    yValueMapper: (ChartData data, _) => data.value,
                    pointColorMapper: (ChartData data, _) =>
                        _getBarColor(data), // Custom color for bars
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                      bottom: Radius.circular(10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            )
          ],
        ),
      ),
    );
  }

  // Assign colors to bars (highlight the current day or month)
  Color _getBarColor(ChartData data) {
    DateTime now = DateTime.now();
    if (isMonthly) {
      String currentMonth = _getMonthName(now.month);
      return data.label == currentMonth
          ? Customcolors.teal
          : Customcolors.offwhite;
    } else {
      String currentDay = _getDayName(now.weekday);
      return data.label == currentDay
          ? Customcolors.teal
          : Customcolors.offwhite;
    }
  }

  // Create data for monthly view
  List<ChartData> _createMonthlyData() {
    return [
      ChartData('Jan', 10),
      ChartData('Feb', 18),
      ChartData('Mar', 14),
      ChartData('Apr', 16),
      ChartData('May', 20),
      ChartData('Jun', 5),
      ChartData('Jul', 8),
      ChartData('Aug', 20),
      ChartData('Sep', 5),
      ChartData('Oct', 8),
      ChartData('Nov', 5),
      ChartData('Dec', 8),
    ];
  }

  // Create data for weekly view
  List<ChartData> _createWeeklyData() {
    return [
      ChartData('Monday', 4),
      ChartData('Tuesday', 6),
      ChartData('Wednesday', 8),
      ChartData('Thursday', 10),
      ChartData('Friday', 12),
      ChartData('Saturday', 14),
      ChartData('Sunday', 16),
    ];
  }

  // Helper function to get the name of the current month
  String _getMonthName(int month) {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  // Helper function to get the name of the current day
  String _getDayName(int day) {
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[day - 1];
  }
}

class ChartData {
  final String label;
  final int value;

  ChartData(this.label, this.value);
}