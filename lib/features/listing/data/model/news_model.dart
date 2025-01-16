// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  final Meta meta;
  final List<NewsData> data;

  NewsModel({
    required this.meta,
    required this.data,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        meta: Meta.fromJson(json["meta"]),
        data: List<NewsData>.from(json["data"].map((x) => NewsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NewsData {
  final String uuid;
  final String imageUrl;

  NewsData({
    required this.uuid,
    required this.imageUrl,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        uuid: json["uuid"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "image_url": imageUrl,
      };
}

class Meta {
  final int found;
  final int returned;
  final int limit;
  final int page;

  Meta({
    required this.found,
    required this.returned,
    required this.limit,
    required this.page,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        found: json["found"],
        returned: json["returned"],
        limit: json["limit"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "found": found,
        "returned": returned,
        "limit": limit,
        "page": page,
      };
}
