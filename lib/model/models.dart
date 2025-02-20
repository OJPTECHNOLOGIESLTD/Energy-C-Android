

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
  final double wasteWeight;
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

class Order {
  final String id;
  final String orderId;
  final String userId;
  final List<Item> items;
  final String totalWeight;
  final String totalPrice;
  final String date;
  final String address;
  final City city;
  final StateDetails state;
  final String pickupType;
  final String status;
  final int points;

  Order({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.items,
    required this.totalWeight,
    required this.totalPrice,
    required this.date,
    required this.address,
    required this.city,
    required this.state,
    required this.pickupType,
    required this.status,
    required this.points,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderId: json['orderId'],
      userId: json['userId'],
      items: List<Item>.from(json['items'].map((item) => Item.fromJson(item))),
      totalWeight: json['totalWeight'],
      totalPrice: json['totalPrice'],
      date: json['date'],
      address: json['address'],
      city: City.fromJson(json['city']),
      state: StateDetails.fromJson(json['state']),
      pickupType: json['pickupType'],
      status: json['status'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalWeight': totalWeight,
      'totalPrice': totalPrice,
      'date': date,
      'address': address,
      'city': city.toJson(),
      'state': state.toJson(),
      'pickupType': pickupType,
      'status': status,
      'points': points,
    };
  }
}

class Item {
  final String name;
  final String category;
  final String weight;
  final String price;
  final int point;
  final String date;
  final String address;
  final String image;
  final String video;

  Item({
    required this.name,
    required this.category,
    required this.weight,
    required this.price,
    required this.point,
    required this.date,
    required this.address,
    required this.image,
    required this.video,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      category: json['category'],
      weight: json['weight'],
      price: json['price'],
      point: json['point'],
      date: json['date'],
      address: json['address'],
      image: json['image'],
      video: json['video'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'weight': weight,
      'price': price,
      'point': point,
      'date': date,
      'address': address,
      'image': image,
      'video': video,
    };
  }
}

class City {
  final String id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class StateDetails {
  final String id;
  final String name;

  StateDetails({required this.id, required this.name});

  factory StateDetails.fromJson(Map<String, dynamic> json) {
    return StateDetails(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class LevelProgress {
  final int currentLevel;
  final int nextLevelPoints;
  final double progressPercentage;

  LevelProgress({
    required this.currentLevel,
    required this.nextLevelPoints,
    required this.progressPercentage,
  });

  factory LevelProgress.fromJson(Map<String, dynamic> json) {
    return LevelProgress(
      currentLevel: json['current_level'] as int,
      nextLevelPoints: json['next_level_points'] as int,
      progressPercentage: (json['progress_percentage'] as num).toDouble(),
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

