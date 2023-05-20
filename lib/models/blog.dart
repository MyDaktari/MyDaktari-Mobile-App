class BlogModel {
  String? title;
  String? author;
  String? content;
  String? category;
  String? featuredImage;
  String? date;
  String? url;

  BlogModel(
      {this.title,
      this.author,
      this.content,
      this.category,
      this.featuredImage,
      this.date,
      this.url});

  BlogModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    content = json['content'];
    category = json['category'];
    featuredImage = json['featuredImage'];
    date = json['date'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['content'] = this.content;
    data['category'] = this.category;
    data['featuredImage'] = this.featuredImage;
    data['date'] = this.date;
    data['url'] = this.url;
    return data;
  }
}
