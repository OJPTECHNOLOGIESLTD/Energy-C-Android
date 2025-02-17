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

