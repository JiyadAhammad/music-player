// /import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:music/songsfetch/methodchannel.dart';
// import 'package:permission_handler/permission_handler.dart';

// List<String> fetchedVideosPath = []; //all videos path loaded first time
// ValueNotifier<List<String>> favVideos = ValueNotifier([]);

// onSuccess(List<String> data) {
//   fetchedVideosPath = data;
//   for (int i = 0; i < fetchedVideosPath.length; i++) {
//     if (fetchedVideosPath[i].startsWith('/storage/emulated/0/Android/data')) {
//       fetchedVideosPath.remove(fetchedVideosPath[i]);
//       i--;
//     }
//   }

//   // log("${fetchedVideosPath.length}");
//   // log('$fetchedVideosPath');
// }

// //first called from splash screen

// // Future splashFetch() async {
// //   log('object');
// //   if (await _requestPermission(Permission.storage)) {
// //     searchInStorage([
// //       '.mp3',
// //     ], onSuccess, (p0) {});
// //   } else {
// //     splashFetch();
// //   }
// // }

// // //request for the permission
// // Directory? dir;

// // Future<bool> _requestPermission(Permission permission) async {
// //   const store = Permission.storage;
// //   const access = Permission.accessMediaLocation;
// //   if (await permission.isGranted) {
// //     await access.isGranted && await access.isGranted;
// //     log('permission granted ');
// //     return true;
// //   } else {
// //     var result = await store.request();
// //     var oneresult = await access.request();
// //     log('permission request ');

// //     if (result == PermissionStatus.granted &&
// //         oneresult == PermissionStatus.granted) {
// //       log('permission status granted ');

// //       return true;
// //     } else {
// //       log('permission denied ');

// //       return false;
// //     }
// //   }
// // }
