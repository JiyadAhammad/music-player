import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/model/musicdb.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

List playlists = [];

List<dynamic>? playlistSongs = [];

class CreatePlaylist extends StatelessWidget {
  const CreatePlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Songs> playlist = [];
    String? title;
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      title: const Center(
        child: Text(
          "Give Your Playlist Name",
          style: TextStyle(color: Colors.black),
        ),
      ),

      // form validation
      content: Form(
        key: formKey,
        child: TextFormField(
          onChanged: (value) {
            title = value.trim();
          },
          validator: (value) {
            List keys = box.keys.toList();
            if (value!.trim() == "") {
              return "Name Required";
            }
            if (keys
                .where(
                  (element) => element == value.trim(),
                )
                .isNotEmpty) {
              return "This Name Already Exist";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 5.w),
            ),
            // fillColor: textblack,
            hintText: 'Playlist Name',
            hintStyle: const TextStyle(color: Colors.blueGrey),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.deepPurpleAccent, width: 5.0.w),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                ),
                onPressed: () {
                  Get.back();
                },
              ),

              // add playlist from db
              ElevatedButton(
                child: Text("Create", style: TextStyle(fontSize: 16.sp)),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    box.put(title, playlist);
                    Get.back();
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
                          'Playlist Added',
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
}
