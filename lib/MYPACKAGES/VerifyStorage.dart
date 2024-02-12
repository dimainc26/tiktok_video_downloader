// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:permission_handler/permission_handler.dart';

import '../CORE/core.dart';

class VerifyStorage {
  Directory directory = Directory("/DCIM");

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<String> findAndroidDirectory() async {
    String rootDirectory = "";
    Directory? externalDirectory = await getExternalStorageDirectory();
    List<String> folders = externalDirectory!.path.split("/");

    for (var i = 0; i < folders.length; i++) {
      if (folders[i] == "Android") break;
      rootDirectory += "/${folders[i]}";
    }

    return rootDirectory;
  }

  createDirectory() async {
    String androidDirectory = await findAndroidDirectory();
    // TikidownsPictures
    Directory imageDirectory =
        Directory("$androidDirectory/Pictures/TikiDownsImages");
    if (!imageDirectory.existsSync()) {
      // log("imageDirectory don't exists. Create now of course...");
      imageDirectory.create(recursive: true).then((tikidownDirectory) {
        // log(tikidownDirectory.path);
      });
    }

    // TikidownsVideos
    Directory videoDirectory =
        Directory("$androidDirectory/Movies/TikiDownsVideos");
    if (!videoDirectory.existsSync()) {
      // log("videoDirectory don't exists. Create now of course...");
      videoDirectory.create(recursive: true).then((tikidownDirectory) {
        // log(tikidownDirectory.path);
      });
    }

    // TikidownsMusics
    Directory musicDirectory =
        Directory("$androidDirectory/Music/TikiDownsMusics");
    if (!musicDirectory.existsSync()) {
      // log("musicDirectory don't exists. Create now of course...");
      musicDirectory.create(recursive: true).then((tikidownDirectory) {
        // log(tikidownDirectory.path);
      });
    }

    // log("IMG: ${imageDirectory.path}");
    // log("VID: ${videoDirectory.path}");
    // log("MP3: ${musicDirectory.path}");
  }

  bool existsDirectory(Directory directory) {
    // log(directory.existsSync().toString());
    return directory.existsSync();
  }

  VerifyStorage({required this.directory});
}

class GetMedia {
  Future<String> findAndroidDirectory() async {
    String rootDirectory = "";
    Directory? externalDirectory = await getExternalStorageDirectory();
    List<String> folders = externalDirectory!.path.split("/");

    for (var i = 0; i < folders.length; i++) {
      if (folders[i] == "Android") break;
      rootDirectory += "/${folders[i]}";
    }

    return rootDirectory;
  }

  Future<RxList> getAll() async {
    String androidDirectory = "/storage/emulated/0";
    Directory imageDirectory =
        Directory("$androidDirectory/Pictures/TikiDownsImages");
    List<FileSystemEntity> files = [];
    Directory videoDirectory =
        Directory("$androidDirectory/Movies/TikiDownsVideos");
    Directory musicDirectory =
        Directory("$androidDirectory/Music/TikiDownsMusics");

    RxList dataList = [].obs;
    dataList.value = jsonDecode(box.read("dataList"));

    for (var file in imageDirectory.listSync()) {
      if (file is File) {
        String type = file.path.split(".").last;
        if (type == ".jpg") {
          var position = dataList.indexWhere((e) => e["path"] == file.path);
          if (position != -1) {
            files.add(file);
            dataList[position]["isSelected"] = false.obs;
          }
        }
      }
    }

    for (var file in videoDirectory.listSync()) {
      if (file is File) {
        String type = file.path.split(".").last;
        if (type == ".mp4") {
          var position = dataList.indexWhere((e) => e["path"] == file.path);
          if (position != -1) {
            files.add(file);
            dataList[position]["isSelected"] = false.obs;
          }
        }
      }
    }

    for (var file in musicDirectory.listSync()) {
      if (file is File) {
        String type = file.path.split(".").last;
        if (type == ".mp3") {
          var position = dataList.indexWhere((e) => e["path"] == file.path);
          if (position != -1) {
            files.add(file);
            dataList[position]["isSelected"] = false.obs;
          }
        }
      }
    }

    return dataList;
  }

  Future<RxList> getImages() async {
    String androidDirectory = "/storage/emulated/0";
    Directory imageDirectory =
        Directory("$androidDirectory/Pictures/TikiDownsImages");
    List<FileSystemEntity> files = [];
    if (!imageDirectory.existsSync()) {
      return [].obs;
    }

    RxList dataList = [].obs;
    dataList.value = jsonDecode(box.read("dataList"));

    for (var file in imageDirectory.listSync()) {
      if (file is File) {
        String type = file.path.split(".").last;
        if (type == ".jpg") {
          var position = dataList.indexWhere((e) => e["path"] == file.path);
          if (position != -1) {
            files.add(file);
            dataList[position]["isSelected"] = false.obs;
          }
        }
      }
    }
    dataList.value = dataList.where((e) => e["type"] == ".jpg").toList();
    for (var e in dataList) {
      e["isSelected"] = false.obs;
    }
    log("TOTAL IMAGES: ${dataList.length}");

    return dataList;
  }

  Future<RxList> getVideos() async {
    String androidDirectory = "/storage/emulated/0";
    Directory videoDirectory =
        Directory("$androidDirectory/Movies/TikiDownsVideos");
    List<FileSystemEntity> files = [];
    if (!videoDirectory.existsSync()) {
      return [].obs;
    }

    RxList dataList = [].obs;
    dataList.value = jsonDecode(box.read("dataList"));

    for (var file in videoDirectory.listSync()) {
      if (file is File) {
        String type = file.path.split(".").last;
        if (type == ".mp4") {
          var position = dataList.indexWhere((e) => e["path"] == file.path);
          if (position != -1) {
            files.add(file);
            dataList[position]["isSelected"] = false.obs;
          }
        }
      }
    }
    dataList.value = dataList.where((e) => e["type"] == ".mp4").toList();
    for (var e in dataList) {
      e["isSelected"] = false.obs;
    }
    log("TOTAL VIDEOS: ${dataList.length}");
    return dataList;
  }

  Future<RxList> getMusics() async {
    String androidDirectory = "/storage/emulated/0";
    Directory musicDirectory =
        Directory("$androidDirectory/Music/TikiDownsMusics");
    List<FileSystemEntity> files = [];
    if (!musicDirectory.existsSync()) {
      return [].obs;
    }

    RxList dataList = [].obs;
    dataList.value = jsonDecode(box.read("dataList"));

    for (var file in musicDirectory.listSync()) {
      if (file is File) {
        String type = file.path.split(".").last;
        if (type == ".mp3") {
          var position = dataList.indexWhere((e) => e["path"] == file.path);
          if (position != -1) {
            files.add(file);
            dataList[position]["isSelected"] = false.obs;
          }
        }
      }
    }
    dataList.value = dataList.where((e) => e["type"] == ".mp3").toList();
    for (var e in dataList) {
      e["isSelected"] = false.obs;
    }
    log("TOTAL MUSICS: ${dataList.length}");

    return dataList;
  }

  Future<File> urlImageToFile(
      {required String name, required String url}) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath$name.gif');

    // New
    final d.Dio dio = d.Dio();

    // d.Response response =
    await dio.download(url, file.path, onReceiveProgress: (rec, total) {
      // var progressString = "${((rec / total) * 100).toStringAsFixed(0)}%";
    });
    return file;
  }
}
