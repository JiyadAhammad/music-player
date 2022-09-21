import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/view/Playlist/playlist.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

Widget updatePlaylist({required playlistName, required context}) {
  String? title;
  return AlertDialog(
    backgroundColor: Colors.white,
    alignment: Alignment.center,
    title: const Center(
      child: Text(
        "Edit Playlist Name",
        style: TextStyle(color: Colors.black),
      ),
    ),

    // form validation
    content: Form(
      key: formKey,
      child: TextFormField(
          initialValue: playlistName,
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            title = value.trim();
          },
          validator: (value) {
            // List keys = box.keys.toList();
            if (value!.trim() == "") {
              return "Name Required";
            }

            return null;
          },
          // style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 5.w)),
            // fillColor: textblack,
            hintText: 'Playlist Name',
            hintStyle: const TextStyle(color: Colors.blueGrey),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.deepPurpleAccent, width: 5.0.w),
            ),
          )),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text("Cancel",
                  style: TextStyle(color: Colors.black, fontSize: 16.sp)),
              onPressed: () {
                Get.back();
              },
            ),

            // add playlist from db
            ElevatedButton(
              child: Text("update", style: TextStyle(fontSize: 16.sp)),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  List? curentPlaylistName = box.get(playlistName);
                  box.put(title, curentPlaylistName!);
                  box.delete(playlistName);
                  Navigator.pop(context);
                  Get.snackbar(
                    'title',
                    'message',
                    titleText: const Center(
                      child: Text(
                        'Success',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    messageText: const Center(
                      child: Text(
                        'Successfully updated',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.black,
                    colorText: Colors.white,
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
    {required context, required playlistsName, required index}) {
  return AlertDialog(
    backgroundColor: Colors.black,
    title: const Center(
      child: Text(
        "ALERT !!",
        style: TextStyle(color: Colors.red),
      ),
    ),
    content: Padding(
      padding: const EdgeInsets.only(top: 8.0).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Do you want to delete",
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
        ],
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              onPressed: () {
                Get.back();
                box.delete(playlistsName[index]);

                playlistsName = box.keys.toList();
                Get.snackbar(
                  'title',
                  'message',
                  titleText: const Center(
                    child: Text(
                      'Success',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  messageText: const Center(
                    child: Text(
                      'Successfully Deleted',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.black,
                  colorText: Colors.white,
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
