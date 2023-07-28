class CategoryModel {
  String? collectionId;
  String? id;
  String? thumbnail;
  String? title;
  String? color;
  String? icon;

  CategoryModel({
    this.collectionId,
    this.id,
    this.thumbnail,
    this.title,
    this.color,
    this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      collectionId: json['collectionId'],
      id: json['id'],
      thumbnail:
          'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['thumbnail']}',
      title: json['title'],
      color: json['color'],
      icon:
          'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['icon']}',
    );
  }
}
