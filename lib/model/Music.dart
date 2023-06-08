import 'dart:convert';

class Music {
  String id;
  String title;
  String url;
  String creator;
  String creatorUrl;
  String license;
  String licenseVersion;
  String licenseUrl;
  String? thumbnail;

  Music({
    required this.id,
    required this.title,
    required this.url,
    required this.creator,
    required this.thumbnail,
    required this.creatorUrl,
    required this.license,
    required this.licenseVersion,
    required this.licenseUrl,
  });

  @override
  bool operator ==(Object other){
    return other is Music  && id == other.id;
  }

  factory Music.fromJson(String json) {
    return Music.fromMap(jsonDecode(json)["results"]);
  }

  static List<Music> fromJsonList(String json) {
    List<dynamic> jsonList = jsonDecode(json)["results"];
    List<Music> musicList = jsonList.map((json) => Music.fromMap(json)).toList();
    return musicList;
  }

  factory Music.fromMap(Map<String, dynamic> map) {
    Music music =  Music(
      id: map['id'],
      title: map['title'],
      url: map['url'],
      creator: map['creator'],
      thumbnail: map['thumbnail'],
      creatorUrl : map['creator_url'],
      license : map['license'],
      licenseVersion : map['license_version'],
      licenseUrl : map['license_url'],
    );
    return music;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'creator': creator,
      'thumbnail': thumbnail,
      'creator_url': creatorUrl,
      'license': license,
      'license_version': licenseVersion,
      'license_url': licenseUrl,
    };
  }

  @override
  int get hashCode => id.hashCode;
}