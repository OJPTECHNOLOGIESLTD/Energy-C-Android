

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



