// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, file_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:tiktok_video_downloader/MYPACKAGES/GenerateRandom.dart';
import 'package:tiktok_video_downloader/MYPACKAGES/VerifyStorage.dart';
import '/CORE/core.dart';

import 'videos_class.dart';

GenerateRandom generateRandom = GenerateRandom();
VerifyStorage verifyStorage = VerifyStorage(directory: Directory(""));
GetMedia getMedia = GetMedia();

class VideoModel {
  final d.Dio _dio = d.Dio();
  final _baseUrl = 'https://www.tikwm.com/';
  Map<String, dynamic> queryParameters = {
    "sec-ch-ua":
        'Chromium";v="104", " Not A;Brand";v="99", "Google Chrome";v="104"',
    "accept": "application/json, text/javascript, */*; q=0.01",
    "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    "user-agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36",
  };

  Future<VideoInfo?> checkDatas(String link) async {
    Map<String, dynamic> data = {"url": link};

    try {
      d.Response response = await _dio.post(
          queryParameters: queryParameters,
          '$_baseUrl/api/',
          data: {"url": link});

      var datas = response.data;

      var retrievedVideo = VideoInfo(
        url: link,
        code: datas["code"],
        id: datas["data"]["id"],
        region: datas["data"]["region"],
        title: datas["data"]["title"],
        cover: datas["data"]["cover"],
        origin_cover: datas["data"]["origin_cover"],
        video: datas["data"]["play"],
        wm_video: datas["data"]["wmplay"],
        music: datas["data"]["music"],
        music_title: datas["data"]["music_info"]["title"],
        music_cover: datas["data"]["music_info"]["cover"],
        plays: datas["data"]["play_count"].toString(),
        comments: datas["data"]["comment_count"].toString(),
        shares: datas["data"]["share_count"].toString(),
        downloads: datas["data"]["download_count"].toString(),
        author_id: datas["data"]["author"]["id"],
        name: datas["data"]["author"]["unique_id"],
        username: datas["data"]["author"]["nickname"],
        avatar: datas["data"]["author"]["avatar"],
        images: datas["data"]["images"],
      );

      // log(retrievedVideo.wm_video.toString());
      return retrievedVideo;
    } catch (e) {
      log("Error to get video informations \n$e");
    }
    return null;
  }

  RxDouble downloadProgress = 0.0.obs;

  Future<RxDouble> downloadMedia(
      {required String mode,
      required VideoInfo? datas,
      required DateTime date}) async {
    String name = generateRandom.convertDateToString(date);
    String filePath = "";

    RxList dataList = [].obs;
    if (!box.hasData("dataList")) {
      box
          .write("dataList", jsonEncode(dataList.value))
          .then((value) => box.save());
    }

    dataList.value = jsonDecode(box.read("dataList"));

    if (mode == "authentik") {
      filePath =
          File("/storage/emulated/0/Movies/TikiDownsVideos/$name.mp4").path;
      File coverPath =
          await getMedia.urlImageToFile(name: name, url: datas!.cover!);
      Map<String, dynamic> newData = {
        "isSelected": false,
        "path": filePath,
        "cover": coverPath.path,
        "avatar": datas.avatar,
        "name": datas.name,
        "username": datas.username,
        "title": datas.title,
        "type": ".mp4",
      };

      if (verifyStorage.existsDirectory(
          Directory("/storage/emulated/0/Movies/TikiDownsVideos"))) {
        try {
          _dio.download(datas.video!, filePath,
              onReceiveProgress: (download, totalSize) {
            downloadProgress.value = download / totalSize;
          }).then((value) {
            dataList.add(newData);
            box
                .write("dataList", jsonEncode(dataList))
                .then((value) => box.save());
          });
        } catch (e) {
          log(e.toString());
          return 0.0.obs;
        }
      }

      name = "";
      return downloadProgress;
    } else if (mode == "watermark") {
      filePath =
          File("/storage/emulated/0/Movies/TikiDownsVideos/$name.mp4").path;
      File coverPath =
          await getMedia.urlImageToFile(name: name, url: datas!.cover!);
      Map<String, dynamic> newData = {
        "isSelected": false,
        "path": filePath,
        "cover": coverPath.path,
        "avatar": datas.avatar,
        "name": datas.name,
        "username": datas.username,
        "title": datas.title,
        "type": ".mp4",
      };

      if (verifyStorage.existsDirectory(
          Directory("/storage/emulated/0/Movies/TikiDownsVideos"))) {
        try {
          _dio.download(datas.wm_video!, filePath,
              onReceiveProgress: (download, totalSize) {
            downloadProgress.value = download / totalSize;
          }).then((value) {
            dataList.add(newData);
            box
                .write("dataList", jsonEncode(dataList))
                .then((value) => box.save());
          });
        } catch (e) {
          log(e.toString());
          return 0.0.obs;
        }
      }
      name = "";
      return downloadProgress;
    } else if (mode == "music") {
      filePath =
          File("/storage/emulated/0/Music/TikiDownsMusics/$name.mp3").path;
      File coverPath =
          await getMedia.urlImageToFile(name: name, url: datas!.music_cover!);

      Map<String, dynamic> newData = {
        "path": filePath,
        "name": datas.name,
        "cover": coverPath.path,
        "avatar": datas.avatar,
        "username": datas.username,
        "title": datas.title,
        "type": ".mp3",
      };

      if (verifyStorage.existsDirectory(
          Directory("/storage/emulated/0/Music/TikiDownsMusics"))) {
        try {
          _dio.download(datas.music!, filePath,
              onReceiveProgress: (download, totalSize) {
            downloadProgress.value = download / totalSize;
          }).then((value) {
            dataList.add(newData);
            box
                .write("dataList", jsonEncode(dataList))
                .then((value) => box.save());
          });
        } catch (e) {
          log(e.toString());
          return 0.0.obs;
        }
      }
      name = "";
      return downloadProgress;
    } else if (mode == "images") {
      // Il ya plusieurs images???
      int totalImgs = datas!.images!.length;

      for (var i = 0; i < totalImgs; i++) {
        String imgPath =
            File("/storage/emulated/0/Pictures/TikiDownsImages/$name$i.jpg")
                .path;
        Map<String, dynamic> newData = {
          "isSelected": false,
          "path": imgPath,
          "avatar": datas.avatar,
          "name": datas.name,
          "username": datas.username,
          "title": datas.title ?? "video $name",
          "type": ".jpg",
        };

        if (verifyStorage.existsDirectory(
            Directory("/storage/emulated/0/Pictures/TikiDownsImages"))) {
          try {
            _dio.download(datas.images![i], imgPath,
                onReceiveProgress: (download, totalSize) {
              downloadProgress.value = download / totalSize;
            }).then((value) {
              dataList.add(newData);
              box
                  .write("dataList", jsonEncode(dataList))
                  .then((value) => box.save());
            });
          } catch (e) {
            log(e.toString());
            return 0.0.obs;
          }
        }
      }

      name = "";
    }
    return downloadProgress;
  }
}
