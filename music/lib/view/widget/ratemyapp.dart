import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/controller/getx/music_controller.dart';

// ignore: must_be_immutable
class RatemyApp extends StatelessWidget {
  const RatemyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Center(
          child: Text(
            "Rate my App",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          GetBuilder<MusicController>(
            init: MusicController(),
            builder: (rateController) {
              return Column(
                children: [
                  Text(
                    "Rating ${rateController.rating}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  RatingBar.builder(
                    unratedColor: Colors.white,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      rateController.isRatingChanged(rating);
                      // setState(() {
                      //   this.rating = rating;
                      // });
                    },
                    minRating: 1,
                    updateOnDrag: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.snackbar(
                            '😊',
                            'message',
                            titleText: const Center(
                              child: Text(
                                '😊',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            messageText: const Center(
                              child: Text(
                                'Successfully Added',
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
                        child: const Text("OK"),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
