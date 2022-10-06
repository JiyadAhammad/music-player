import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/playlist_controller/playlist_controller.dart';
import '../../model/musicdb.dart';
import '../constants/colors/colors.dart';
import '../splashscreen/splashscreen.dart';

List<dynamic> playlists = <dynamic>[];

List<dynamic>? playlistSongs = <dynamic>[];

class CreatePlaylist extends StatelessWidget {
  const CreatePlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Songs> playlist = <Songs>[];
    String? title;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return AlertDialog(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      title: const Center(
        child: Text(
          'Give Your Playlist Name',
          style: TextStyle(color: kblackText),
        ),
      ),

      // form validation
      content: Form(
        key: formKey,
        child: GetBuilder<PlaylistController>(
            init: PlaylistController(),
            builder: (PlaylistController formContrl) {
              return TextFormField(
                onChanged: (String value) {
                  title = value.trim();
                },
                validator: (String? value) {
                  final List<dynamic> keys = box.keys.toList();
                  formContrl.playListNameCreate(value!, keys);
                  return null;
                },
                style: const TextStyle(color: kblackText),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: kHomeColor, width: 5.w),
                  ),
                  // fillColor: textblack,
                  hintText: 'Playlist Name',
                  hintStyle: const TextStyle(color: kbluegrey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.deepPurpleAccent, width: 5.0.w),
                  ),
                ),
              );
            }),
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
                child: Text(
                  'Create',
                  style: TextStyle(fontSize: 16.sp),
                ),
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
                            color: kgreen,
                          ),
                        ),
                      ),
                      messageText: const Center(
                        child: Text(
                          'Playlist Added',
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
}
