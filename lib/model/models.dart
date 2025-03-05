

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


// class User {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneNumber;
//   final double? wasteWeight;
//   final int points;
//   final String level;
//   final bool isVerified;
//   final String otp;
//   final String createdAt;
//   final String updatedAt;

//   User({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneNumber,
//     required this.wasteWeight,
//     required this.points,
//     required this.level,
//     required this.isVerified,
//     required this.otp,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     print('Phone Number from API: ${json['phoneNumber']}');
//     return User(
//       id: json['id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber']?.toString() ?? '',
//       wasteWeight: json['wasteWeight'] != null ? json['wasteWeight'].toDouble() : null,
//       points: json['points'],
//       level: json['level'],
//       isVerified: json['isVerified'] == 1,
//       otp: json['otp'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }

class OrderResponse {
  final Order order;

  OrderResponse({required this.order});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      order: Order.fromJson(json['order']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order": order.toJson(),
    };
  }
}

class Order { 
  final int id;
  final String orderId;
  final int userId;
  final double totalWeight;
  final double totalPrice;
  final double estimatedIncome;
  final String date;
  final String address;
  final int cityId;
  final int stateId;
  final String pickupType;
  final String status;
  final double point;
  final List<WasteItem> wasteItems; // List of waste items
  final List<String> images; // List of image URLs
  final List<String> videos; // List of video URLs
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.totalWeight,
    required this.totalPrice,
    required this.estimatedIncome,
    required this.date,
    required this.address,
    required this.cityId,
    required this.stateId,
    required this.pickupType,
    required this.status,
    required this.point,
    required this.wasteItems, // Initialize waste items
    required this.images, // Initialize images
    required this.videos, // Initialize videos
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // Convert waste items from JSON
    var wasteItemsFromJson = json['waste_items'] as List;
    List<WasteItem> wasteItemList = wasteItemsFromJson.map((item) => WasteItem.fromJson(item)).toList();

    // Convert images and videos from JSON
    List<String> imageList = List<String>.from(json['images'] ?? []);
    List<String> videoList = List<String>.from(json['videos'] ?? []);

    return Order(
      id: json['id'],
      orderId: json['orderId'],
      userId: json['userId'],
      totalWeight: double.tryParse(json['totalWeight'].toString()) ?? 0.0,
      totalPrice: double.tryParse(json['totalPrice'].toString()) ?? 0.0,
      estimatedIncome: double.tryParse(json['estimated_income'].toString()) ?? 0.0,
      point: double.tryParse(json['point'].toString()) ?? 0.0,
      date: json['date'],
      address: json['address'],
      cityId: json['cityId'],
      stateId: json['stateId'],
      pickupType: json['pickupType'],
      status: json['status'],
      wasteItems: wasteItemList, // Add waste items list
      images: imageList, // Add images list
      videos: videoList, // Add videos list
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "orderId": orderId,
      "userId": userId,
      "totalWeight": totalWeight,
      "totalPrice": totalPrice,
      "estimated_income": estimatedIncome,
      "date": date,
      "address": address,
      "cityId": cityId,
      "stateId": stateId,
      "pickupType": pickupType,
      "status": status,
      "point": point,
      "waste_items": wasteItems.map((item) => item.toJson()).toList(), // Convert waste items to JSON
      "images": images, // Convert images to JSON
      "videos": videos, // Convert videos to JSON
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}


class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final int? wasteWeight;
  final int? points;
  final String? level;
  final bool isVerified;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
     this.phoneNumber,
     this.wasteWeight,
     this.points,
     this.level,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      wasteWeight: json['wasteWeight'],
      points: json['points'],
      level: json['level'],
      isVerified: json['isVerified'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "wasteWeight": wasteWeight,
      "points": points,
      "level": level,
      "isVerified": isVerified,
    };
  }
}

class WasteItem {
  final int id;
  final String name;
  final String? category;
  final double price;
  double weight;
  final List<String> image;
  final List<String> video;
  final String? description;
  final int? orderId;
  final int? categoryId;
  final List<Instruction> instructions;

  WasteItem({
    required this.id,
    required this.name,
    this.category,
    required this.price,
    required this.weight,
    required this.image,
    required this.video,
    this.description,
    this.orderId,
    this.categoryId,
    required this.instructions,
  });

  factory WasteItem.fromJson(Map<String, dynamic> json) {
    return WasteItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      category: json['category'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] is List ? List<String>.from(json['image']) : [],  // Safely handle image as list
      video: json['video'] is List ? List<String>.from(json['video']) : [],  // Safely handle video as list
      orderId: json['orderId'] as int?,
      categoryId: json['category_id'] as int?,
      instructions: json['instructions'] is List
          ? (json['instructions'] as List)
              .map((e) => Instruction.fromJson(e))
              .toList()
          : [],  // Safely handle instructions as list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "description": description,
      "price": price,
      "weight": weight,
      "image": image,
      "video": video,
      "orderId": orderId,
      "categoryId": categoryId,
      "instructions": instructions.map((e) => e.toJson()).toList(),
    };
  }
}


class Instruction {
  final int id;
  final int wasteItemId;
  final String description;

  Instruction({
    required this.id,
    required this.wasteItemId,
    required this.description,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      id: json['id'] ?? 0,
      wasteItemId: json['waste_item_id'] ?? 0,
      description: json['description'] ?? 'No instruction',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "waste_item_id": wasteItemId,
      "description": description,
    };
  }
}

class CityName {
  final int id;
  final String name;

  CityName({required this.id, required this.name});

  factory CityName.fromJson(Map<String, dynamic> json) {
    return CityName(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

class StateData {
  final int id;
  final String name;

  StateData({required this.id, required this.name});

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

class LevelProgress {
  final String currentLevel;
  final String nextLevel;
  final int nextLevelPoints;
  final int progressPercentage;

  LevelProgress( {
    required this.currentLevel,
    required this.nextLevel,
    required this.nextLevelPoints,
    required this.progressPercentage,
  });

  factory LevelProgress.fromJson(Map<String, dynamic> json) {
    return LevelProgress(
      currentLevel: json['current_level'],
      nextLevel: json['next_level'],
      nextLevelPoints: json['next_level_points'],
      progressPercentage: json['progress_percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_level': currentLevel,
      'next_level': nextLevel,
      'next_level_points': nextLevelPoints,
      'progress_percentage': progressPercentage,
    };
  }

  @override
  String toString() {
    return 'LevelProgress(currentLevel: $currentLevel,nextLevel: $nextLevel, nextLevelPoints: $nextLevelPoints, progressPercentage: $progressPercentage)';
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

class Message {
  final int id;
  final int adminId;
  final int? receiverId; // Nullable for broadcast messages
  final String senderName;
  final String message;
  int isRead;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.adminId,
    required this.receiverId,
    required this.senderName,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      adminId: json['admin_id'],
      receiverId: json['receiver_id'], // Can be null
      senderName: json['sender_name'],
      message: json['message'],
      isRead: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  void markAsRead(){
    isRead=1;
  }
}