class PostModel {
  final String imageUrl;
  final String description;
  final DateTime dateTime;
  final String postId;

  PostModel({
    required this.imageUrl,
    required this.description,
    required this.dateTime,
    required this.postId,
  });

  Map<String, dynamic> toFireStore() => {
        'imageurl': imageUrl,
        'desciption': description,
        'dateTime': dateTime,
        'postId': postId
      };
}
