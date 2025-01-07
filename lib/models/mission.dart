class Mission {
  final String id;
  final String title;
  final String description;
  final int points;
  final String imageUrl;

  Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.imageUrl,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      points: json['points'],
      imageUrl: json['image_url'],
    );
  }
}
