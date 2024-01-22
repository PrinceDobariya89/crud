class Recipe {
  final int? id;
  final String title;
  final String desc;
  final int isLiked;

  const Recipe({this.id,required this.title, required this.desc,required this.isLiked});

   Map<String, dynamic> toMap() {
    return {'name': title, 'desc': desc,'isLiked':isLiked};
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      title: map['title'],
      desc: map['desc'],
      isLiked: map['isLiked']
    );
  }
}
