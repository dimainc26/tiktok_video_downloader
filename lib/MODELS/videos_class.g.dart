// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) => VideoInfo(
      url: json['url'] as String,
      code: json['code'] as int?,
      id: json['id'] as String?,
      region: json['region'] as String?,
      title: json['title'] as String?,
      cover: json['cover'] as String?,
      origin_cover: json['origin_cover'] as String?,
      video: json['video'] as String?,
      wm_video: json['wm_video'] as String?,
      music: json['music'] as String?,
      music_title: json['music_title'] as String?,
      music_cover: json['music_cover'] as String?,
      plays: json['plays'] as String?,
      comments: json['comments'] as String?,
      shares: json['shares'] as String?,
      downloads: json['downloads'] as String?,
      author_id: json['author_id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      images: json['images'] as List?,
    );

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) => <String, dynamic>{
      'url': instance.url,
      'code': instance.code,
      'id': instance.id,
      'region': instance.region,
      'title': instance.title,
      'cover': instance.cover,
      'origin_cover': instance.origin_cover,
      'video': instance.video,
      'wm_video': instance.wm_video,
      'music': instance.music,
      'music_title': instance.music_title,
      'music_cover': instance.music_cover,
      'plays': instance.plays,
      'comments': instance.comments,
      'shares': instance.shares,
      'downloads': instance.downloads,
      'author_id': instance.author_id,
      'name': instance.name,
      'username': instance.username,
      'avatar': instance.avatar,
      'images': instance.images,
    };
