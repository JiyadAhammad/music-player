import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/getx/music_controller.dart';

class RatemyApp extends StatelessWidget {
  const RatemyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Center(
          child: Text(
            'Rate my App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          GetBuilder<MusicController>(
            init: MusicController(),
            builder: (MusicController rateController) {
              return Column(
                children: <Widget>[
                  Text(
                    'Rating ${rateController.rating}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  RatingBar.builder(
                    unratedColor: Colors.white,
                    itemBuilder: (BuildContext context, int _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (double rating) {
                      rateController.isRatingChanged(rating);
                    },
                    minRating: 1,
                    updateOnDrag: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
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
                        child: const Text('OK'),
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
