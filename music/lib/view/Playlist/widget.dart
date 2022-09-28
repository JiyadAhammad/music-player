import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../constants/colors/colors.dart';
import '../splashscreen/splashscreen.dart';
import 'playlist.dart';

Widget updatePlaylist(
    {required dynamic playlistName, required BuildContext context}) {
  String? title;
  return AlertDialog(
    backgroundColor: Colors.white,
    alignment: Alignment.center,
    title: const Center(
      child: Text(
        'Edit Playlist Name',
        style: TextStyle(color: kblackText),
      ),
    ),

    // form validation
    content: Form(
      key: formKey,
      child: TextFormField(
        initialValue: playlistName.toString(),
        style: const TextStyle(color: kblackText),
        onChanged: (String value) {
          title = value.trim();
        },
        validator: (String? value) {
          // List keys = box.keys.toList();
          musicController.playListNameEdit(value!);

          return null;
        },
        // style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kHomeColor, width: 5.w),
          ),
          // fillColor: textblack,
          hintText: 'Playlist Name',
          hintStyle: const TextStyle(color: kbluegrey),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.deepPurpleAccent, width: 5.0.w),
          ),
        ),
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: kblackText, fontSize: 16.sp),
              ),
              onPressed: () {
                Get.back();
              },
            ),

            // add playlist from db
            ElevatedButton(
              child: Text('update', style: TextStyle(fontSize: 16.sp)),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  musicController.validateEditPLayListName(
                      playlistName, title!);
                  Get.back();
                  Get.snackbar(
                    'title',
                    'message',
                    titleText: const Center(
                      child: Text(
                        'Success',
                        style: TextStyle(
                          fontSize: 20,
                          color: kgreen,
                        ),
                      ),
                    ),
                    messageText: const Center(
                      child: Text(
                        'Successfully updated',
                        style: TextStyle(
                          fontSize: 18,
                          color: kwhiteText,
                        ),
                      ),
                    ),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: kblack,
                    colorText: kwhiteText,
                    maxWidth: 250,
                    margin: const EdgeInsets.only(bottom: 15),
                  );
                }
              },
            )
          ],
        ),
      ),
    ],
  );
}

Widget deletePlaylist(
    {required BuildContext context,
    required List<dynamic> playlistsName,
    required int index}) {
  return AlertDialog(
    backgroundColor: kblack,
    title: const Center(
      child: Text(
        'ALERT !!',
        style: TextStyle(color: kred),
      ),
    ),
    content: Padding(
      padding: const EdgeInsets.only(top: 8.0).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Do you want to delete',
            style: TextStyle(color: kwhiteText, fontSize: 20.sp),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: kwhiteText, fontSize: 18.sp),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(color: kwhiteText, fontSize: 18.sp),
              ),
              onPressed: () {
                Get.back();
                musicController.playlistDelete(playlistsName, index);

                playlistsName = box.keys.toList();
                Get.snackbar(
                  'title',
                  'message',
                  titleText: const Center(
                    child: Text(
                      'Success',
                      style: TextStyle(
                        fontSize: 20,
                        color: kred,
                      ),
                    ),
                  ),
                  messageText: const Center(
                    child: Text(
                      'Successfully Deleted',
                      style: TextStyle(
                        fontSize: 18,
                        color: kwhiteText,
                      ),
                    ),
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: kblack,
                  colorText: kwhiteText,
                  maxWidth: 250,
                  margin: const EdgeInsets.only(bottom: 15),
                );
              },
            )
          ],
        ),
      ),
    ],
  );
}
