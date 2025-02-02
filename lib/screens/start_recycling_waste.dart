import 'package:energy_chleen/screens/recyclingpage.dart';
import 'package:energy_chleen/screens/wastes/waste_type.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class StartRecyclingWaste extends StatefulWidget {
  const StartRecyclingWaste({super.key});

  @override
  State<StartRecyclingWaste> createState() => _StartRecyclingWasteState();
}

class _StartRecyclingWasteState extends State<StartRecyclingWaste> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Recycle'),
        SizedBox(height: 8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35, // Adjust the height of the PageView to fit content
          child: PageView.builder(
            itemCount: 3, // Define how many pages you want to display
            itemBuilder: (context, index) {
              return PageviewItem(
                title: 'Recycle ${_getWasteTypeTitle(index)}',
                onPressed: () {
                  _navigateToRecyclingPage(context, index);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: (){
              print('View All');
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WasteTypesPage()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: 
            BoxDecoration(color: Customcolors.teal,
            borderRadius: BorderRadius.circular(40)),
            child: Text('View All',
            style: TextStyle(color: Customcolors.white, fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
    );
  }

  String _getWasteTypeTitle(int index) {
    switch (index) {
      case 0:
        return 'Plastic';
      case 1:
        return 'Glass';
      case 2:
        return 'Metal';
      default:
        return 'Recycle';
    }
  }

  void _navigateToRecyclingPage(BuildContext context, int index) {
    // Get waste type title based on index
    String wasteTypeTitle = _getWasteTypeTitle(index);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecyclingPage(wasteType: wasteTypeTitle, actionType1: false,), // Pass waste type title
      ),
    );
    print("Recycling item: $index");
  }
}


class PageviewItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const PageviewItem({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,

      child: Card(
        color: Customcolors.offwhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Recycle-bin-green.png', width: MediaQuery.of(context).size.width * 0.4),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: Customcolors.teal,
                  side: BorderSide(
                    color: Customcolors.offwhite, // Border color
                    width: 0, // Border thickness
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onPressed,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18, // Adjusts the text size inside the button
                    fontWeight: FontWeight.bold,
                    color: Customcolors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
