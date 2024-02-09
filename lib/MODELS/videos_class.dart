// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'videos_class.g.dart';

@JsonSerializable()
class VideoInfo {
  String url;

  // Received datas
  int? code;
  String? id;
  String? region;
  String? title;
  String? cover;
  String? origin_cover;

  String? video;
  String? wm_video;

  // Music
  String? music;
  String? music_title;
  String? music_cover;

  // Details videos
  String? plays;
  String? comments;
  String? shares;
  String? downloads;

  // Author
  String? author_id;
  String? name;
  String? username;
  String? avatar;

  // Images
  List? images;

  VideoInfo({
    required this.url,
    this.code,
    this.id,
    this.region,
    this.title,
    this.cover,
    this.origin_cover,
    this.video,
    this.wm_video,
    this.music,
    this.music_title,
    this.music_cover,
    this.plays,
    this.comments,
    this.shares,
    this.downloads,
    this.author_id,
    this.name,
    this.username,
    this.avatar,
    this.images,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}
