// ignore_for_file: file_names, unused_element

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class PhoneInfos {
  Future<Map<String, dynamic>> deviceInfos() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (!Platform.isAndroid) {
      return {"device": "This device isn't an Android System."};
    }

    var deviceData = <String, dynamic>{};

    deviceData.addAll(
      {
        "localName": Platform.localeName,
        "operatingSystem": Platform.operatingSystem,
        "operatingSystemVersion": Platform.operatingSystemVersion,
        "version": Platform.version,
        "ANDROID_STORAGE": Platform.environment["ANDROID_STORAGE"].toString(),
        "EXTERNAL_STORAGE": Platform.environment["EXTERNAL_STORAGE"].toString(),
      },
    );

    deviceData
        .addAll(_readAndroidBuildData(await deviceInfoPlugin.androidInfo));

    return deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'brand': build.brand,
      'device': build.device,
      'fingerprint': build.fingerprint,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayHeightPixels': build.displayMetrics.heightPx,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
