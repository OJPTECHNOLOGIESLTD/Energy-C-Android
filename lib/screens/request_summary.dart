import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/item_confirmation.dart';
import 'package:energy_chleen/screens/wastes/waste_info.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestSummary extends StatefulWidget {
  final String wasteItemName;
  final double weight;
  final double price;
  final int wasteId;
  const RequestSummary(
      {super.key,
      required this.wasteItemName,
      required this.weight,
      required this.price,
      required this.wasteId});

  @override
  State<RequestSummary> createState() => _RequestSummaryState();
}

class _RequestSummaryState extends State<RequestSummary> {
  String? wasteType;
  int? weight;
  int? estPrice;
  DateTime? pickupDate;
  final TextEditingController _pickupAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  List<WasteInfoCard> wasteCards = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPickupDetails(); // Load pickup details
    _loadWasteDetails();
  }

  double currentWeight = 0.0;
  double estimatedPrice = 0.0;

  Future<void> _loadPickupDetails() async {
    setState(() {
      isLoading = true; // Start loading
    });

    Map<String, dynamic> pickupDetails =
        await StorageService().loadPickupDetails();
    print('Pickup Address: ${pickupDetails['pickupAddress']}');
    print('City: ${pickupDetails['city']}');

    setState(() {
      // Update controllers with data from pickupDetails
      _pickupAddressController.text = pickupDetails['pickupAddress'] ?? '';
      _cityController.text = pickupDetails['city'] ?? '';
      _stateController.text = pickupDetails['state'] ?? '';

      isLoading = false; // End loading after data is loaded
    });
  }

  Future<void> _loadWasteDetails() async {
    setState(() {
      isLoading = true; // Start loading
    });
    // Add waste card after loading is complete
    _addWasteCard(
      widget.wasteItemName,
      widget.weight.toInt(),
      widget.price.toInt(),
      widget.wasteId,
    );

    setState(() {
      isLoading = false; // End loading after waste data is loaded
    });
  }

int wasteItemCount = 1; // Initial waste item count

RxList<WasteItem> wasteItemsArrey = <WasteItem>[].obs;

void _addWasteCard(
    String wasteType, int weight, int estimatedIncome, int wasteId) async {
  print('this is waste: ${wasteId}, $wasteType, $weight, $estimatedIncome');
  print(wasteItemCount);

  // Load pickup details asynchronously
  Map<String, dynamic> pickupDetails =
      await StorageService().loadPickupDetails();

  // Create a WasteItem object based on the provided wasteType and weight
  WasteItem newWasteItem = WasteItem(
    id: wasteId,
    name: wasteType,
    weight: weight.toDouble(),
    price: estimatedIncome.toDouble(), // Assuming estimatedIncome is the price
    image: [], // Dummy value, update as necessary
    video: [], // Dummy value, update as necessary
    instructions: [], // Dummy value, update as necessary
  );

  // Add the new waste item to the reactive list
  wasteItemsArrey.add(newWasteItem);

  // Increment waste item count
  wasteItemCount++;

  // Update the UI with the new waste card
  setState(() {
    wasteCards.add(WasteInfoCard(
      wasteType: wasteType,
      weight: weight,
      estimatedIncome: estimatedIncome,
      editWasteDetails: () {}, // Placeholder for edit functionality
      removeWasteType: () => _removeWasteType(wasteType),
      pickupDate: pickupDetails['pickupDate'] ?? DateTime.now(),
      wasteId: wasteId,
    ));
  });
}

void _removeWasteType(String wasteType) {
  print(wasteItemsArrey);
  setState(() {
    // Remove from the UI cards list
    wasteCards.removeWhere((card) => card.wasteType == wasteType);

    // Remove from the wasteItems list
    wasteItemsArrey.removeWhere((item) => item.name == wasteType);

    // Decrement waste item count
    if (wasteItemCount > 0) {
      wasteItemCount-- == wasteType;
    }
  });
}


  Widget _buildWasteTypeAndDetails() {
    if (isLoading) {
      return Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (wasteCards.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            'No Waste To Recycle',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: wasteCards.length,
        itemBuilder: (context, index) => wasteCards[index],
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: 'Request Summary'),
      floatingActionButton: wasteCards.isNotEmpty
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemConfirmation(
                        wasteItemsArrey: wasteItemsArrey,
                      ),
                    ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.93,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Customcolors.teal,
                ),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Customcolors.white),
                      ),
              ),
            )
          : SizedBox.shrink(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RecyclingScheduleProgress(
                  isReviewing: true, isCompleted: false, isTakingPhoto: false),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pickup Address',
                          style: TextStyle(
                              color: Customcolors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      '${_pickupAddressController.text} ${_cityController.text} ${_stateController.text}',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Waste Type',
                    style: TextStyle(
                        color: Customcolors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  if(wasteItemCount<=4)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.teal.withOpacity(0.1),
                    ),
                    child: TextButton(
                      onPressed: () {
                        _showAddWasteBottomSheet(
                          context,
                        );
                        // _addWasteCard(widget.wasteItemName, widget.weight.toInt(), widget.price.toInt());
                      },
                      child: Text(
                        'Add +',
                        style: TextStyle(
                            color: Customcolors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _buildWasteTypeAndDetails(),
            ],
          ),
        ),
      ),
    );
  }

  final List<String> wasteNames =
      AuthController.instance.wasteItems.map((waste) => waste.name).toList();

  WasteItem? _selectedWaste;

  void _showAddWasteBottomSheet(BuildContext context) {
    // Local state variables for the bottom sheet
    WasteItem? selectedWaste;
    int currentWeight = 0;
    double estimatedPrice = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Waste Item',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDropdown(
                    'Select Waste',
                    wasteNames,
                    selectedWaste?.name,
                    (value) {
                      setModalState(() {
                        selectedWaste = AuthController.instance.wasteItems
                            .firstWhere((waste) => waste.name == value);
                        currentWeight = selectedWaste?.weight.toInt() ?? 0;
                        estimatedPrice = currentWeight * selectedWaste!.price;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (selectedWaste != null)
                    WeightSelector(
                      currentWeight: currentWeight,
                      price: selectedWaste!.price,
                      onWeightChanged: (newWeight) {
                        setModalState(() {
                          currentWeight = newWeight;
                          estimatedPrice = newWeight * selectedWaste!.price;
                        });
                      },
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedWaste != null) {
                              Navigator.pop(context);
                              _addWasteCard(selectedWaste!.name, currentWeight,
                                  estimatedPrice.toInt(), selectedWaste!.id);

                                  if (selectedWaste==selectedWaste) {
                                    _removeWasteType(selectedWaste!.name);
                                    
                                  }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.teal.shade700,
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.red.shade700,
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

// Helper to build Dropdown
  Widget _buildDropdown(String labelText, List<String> items,
      String? selectedItem, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedItem,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              // Update _selectedWaste and other variables when value changes
              _selectedWaste = AuthController.instance.wasteItems
                  .firstWhere((waste) => waste.name == value);
              currentWeight = _selectedWaste!.weight.toDouble();
              estimatedPrice = currentWeight * _selectedWaste!.price;
            });
            // Call the onChanged callback to notify the parent of the change
            onChanged(value);
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class WeightSelector extends StatelessWidget {
  final int currentWeight;
  final double price;
  final Function(int) onWeightChanged;

  const WeightSelector({
    super.key,
    required this.currentWeight,
    required this.price,
    required this.onWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Minus Button
            GestureDetector(
              onTap: () {
                if (currentWeight > 1) {
                  onWeightChanged(currentWeight - 1);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Customcolors.offwhite,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.remove),
              ),
            ),
            const SizedBox(width: 16),
            // Weight Display
            Text(
              '$currentWeight kg',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),
            // Plus Button
            GestureDetector(
              onTap: () => onWeightChanged(currentWeight + 1),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Customcolors.offwhite,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Text(
              'Est. Price',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'NGN ${(currentWeight * price).toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
