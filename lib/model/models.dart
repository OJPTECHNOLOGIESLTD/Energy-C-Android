import 'dart:convert';

import 'package:http/http.dart' as http;

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
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String wasteWeight;
  final int levelNumber;
  final String levelName;
  final String levelPercent;
  final String points;
  final bool isVerified;
  final String otp;
  final String verificationToken;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.wasteWeight,
    required this.levelNumber,
    required this.levelName,
    required this.levelPercent,
    required this.points,
    required this.isVerified,
    required this.otp,
    required this.verificationToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      wasteWeight: json['wasteWeight'],
      levelNumber: json['level']['number'],
      levelName: json['level']['name'],
      levelPercent: json['level']['percent'],
      points: json['points'],
      isVerified: json['isVerified'].toString().toLowerCase() == 'true',
      otp: json['otp'],
      verificationToken: json['verificationToken'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

Future<User?> fetchUserDetails(String userId) async {
  final url = Uri.parse('https://your-api-base-url.com/api/users/$userId'); // Replace with your base URL
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      print('Failed to load user details: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching user details: $e');
    return null;
  }
}

