

class NewsEvent {

  final String title;
  final String description;
  final List<String> images;

  NewsEvent({
    required this.title,
    required this.description,
    required this.images,
  });

  factory NewsEvent.fromJson(Map<String, dynamic> json) {
    return NewsEvent(
      title: json['title'],
      description: json['description'],
      images: List<String>.from(json['images']),
    );
  }
}
class RecycleEssentials {
  final int id;
  final String title;
  final String description;
  final String images;
  final String price;
  final double rating;

  RecycleEssentials({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.rating,
  });

  factory RecycleEssentials.fromJson(Map<String, dynamic> json) {
    return RecycleEssentials(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      images: json['images'],
      price: json['price'],
      rating: double.parse(json['rating']),
    );
  }
}


class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final int wasteWeight;
  final int points;
  final String level;
  final bool isVerified;
  final String otp;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.wasteWeight,
    required this.points,
    required this.level,
    required this.isVerified,
    required this.otp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print('Phone Number from API: ${json['phoneNumber']}');
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      wasteWeight: json['wasteWeight'],
      points: json['points'],
      level: json['level'],
      isVerified: json['isVerified'] == 1,
      otp: json['otp'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class WasteItem {
  final String name;
  final String? category;  // Allow category to be nullable
  final double weight;
  final double price;
  final String image;
  final String video;
  final String description;
  final List<Instruction> instructions;

  WasteItem({
    required this.name,
    this.category,  // Nullable field
    required this.weight,
    required this.price,
    required this.image,
    required this.video,
    required this.description,
    required this.instructions,
  });

  factory WasteItem.fromJson(Map<String, dynamic> json) {
    return WasteItem(
      name: json['name'] ?? 'Unknown',  // Fallback if name is null
      category: json['category'],       // This can be null
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,  // Handle potential null
      price: (json['price'] as num?)?.toDouble() ?? 0.0,    // Handle potential null
      image: json['image'] ?? '',      // Provide fallback if null
      video: json['video'] ?? '',      // Provide fallback if null
      description: json['description'] ?? 'No description',  // Fallback if null
      instructions: (json['instructions'] as List)
          .map((i) => Instruction.fromJson(i))
          .toList(),
    );
  }
}

class Instruction {
  final int id;
  final String description;

  Instruction({
    required this.id,
    required this.description,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      id: json['id'] ?? 0,  // Fallback to 0 if ID is null
      description: json['description'] ?? '',  // Provide fallback if null
    );
  }
}


class Order {
  final String orderId;
  final String status;
  final double totalWeight;
  final double totalPrice;
  final String date;
  final String address;
  final String cityName;
  final String stateName;

  Order({
    required this.orderId,
    required this.status,
    required this.totalWeight,
    required this.totalPrice,
    required this.date,
    required this.address,
    required this.cityName,
    required this.stateName,
  });

  // Factory method to create an Order object from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      status: json['status'],
      totalWeight: double.parse(json['totalWeight']),
      totalPrice: double.parse(json['totalPrice']),
      date: json['date'],
      address: json['address'],
      cityName: json['cityId']['cityName'],
      stateName: json['stateId']['stateName'],
    );
  }
}


// class LevelProgress {
//   final String currentLevel;
//   final int totalPoints;
//   final String nextLevel;
//   final int pointsRequired;

//   LevelProgress({
//     required this.currentLevel,
//     required this.totalPoints,
//     required this.nextLevel,
//     required this.pointsRequired,
//   });

//   factory LevelProgress.fromJson(Map<String, dynamic> json) {
//     return LevelProgress(
//       currentLevel: json['currentLevel'] != null ? json['currentLevel'] as String : 'Unknown',
//       totalPoints: json['totalPoints'] != null ? json['totalPoints'] as int : 0,
//       nextLevel: json['nextLevel'] != null ? json['nextLevel'] as String : 'Unknown',
//       pointsRequired: json['pointsRequired'] != null ? json['pointsRequired'] as int : 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'currentLevel': currentLevel,
//       'totalPoints': totalPoints,
//       'nextLevel': nextLevel,
//       'pointsRequired': pointsRequired,
//     };
//   }

//   @override
//   String toString() {
//     return 'LevelProgress(currentLevel: $currentLevel, totalPoints: $totalPoints, nextLevel: $nextLevel, pointsRequired: $pointsRequired)';
//   }
// }

class LevelProgress {
  final int currentLevel;
  final int nextLevelPoints;
  final int progressPercentage;

  LevelProgress({
    required this.currentLevel,
    required this.nextLevelPoints,
    required this.progressPercentage,
  });

  factory LevelProgress.fromJson(Map<String, dynamic> json) {
    return LevelProgress(
      currentLevel: json['current_level'],
      nextLevelPoints: json['next_level_points'],
      progressPercentage: json['progress_percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_level': currentLevel,
      'next_level_points': nextLevelPoints,
      'progress_percentage': progressPercentage,
    };
  }

  @override
  String toString() {
    return 'LevelProgress(currentLevel: $currentLevel, nextLevelPoints: $nextLevelPoints, progressPercentage: $progressPercentage)';
  }
}
class PurchaseModel {
  final int purchase_id;
  final String item_name;
  final int quantity;
  final double total_price;


  PurchaseModel({
    required this.purchase_id,
    required this.item_name,
    required this.quantity,
    required this.total_price,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      purchase_id: json['purchase_id'],
      item_name: json['item_name'],
      quantity: json['quantity'],
      total_price: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'purchase_id': purchase_id,
      'item_name': item_name,
      'quantity': quantity,
      'total_price': total_price,
    };
  }
}
