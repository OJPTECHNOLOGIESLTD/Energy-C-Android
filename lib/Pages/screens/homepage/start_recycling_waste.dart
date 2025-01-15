import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/recyclingpage.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class StartRecyclingWaste extends StatelessWidget {
  const StartRecyclingWaste({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Recycle'),
          SizedBox(height: 8),
          SizedBox(
            height: 350, // Adjust the height of the PageView to fit content
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
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Icon(Icons.arrow_forward),
      ],
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
        builder: (context) => RecyclingPage(wasteType: wasteTypeTitle), // Pass waste type title
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16),
          child: Column(
            children: [
              Image.asset('assets/recycle-bin.png', height: 150),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width * 0.5,
                height: 60,
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
      ),
    );
  }
}
