class Notice {
  String title;
  String author;
  String published_at;
  String post_url;

  Notice({
    this.title,
    this.author,
    this.published_at,
    this.post_url
  });

  Notice.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.author = json['author'];
    this.published_at = json['published_at'];
    this.post_url = json['post_url'];
  }
}