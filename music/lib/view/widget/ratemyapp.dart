import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../controller/music_controller/music_controller.dart';
import '../constants/colors/colors.dart';
import '../constants/sizedbox/sizedbox.dart';

class RatemyApp extends StatelessWidget {
  const RatemyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Center(
          child: Text(
            'Rate my App',
            style: TextStyle(color: kwhiteText),
          ),
        ),
        backgroundColor: kblack,
        actions: <Widget>[
          GetBuilder<MusicController>(
            init: MusicController(),
            builder: (MusicController rateController) {
              return Column(
                children: <Widget>[
                  Text(
                    'Rating ${rateController.rating}',
                    style: const TextStyle(
                      color: kwhiteText,
                    ),
                  ),
                  kHeight20,
                  RatingBar.builder(
                    unratedColor: kwhiteIcon,
                    itemBuilder: (BuildContext context, int _) => const Icon(
                      Icons.star,
                      color: kamber,
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
                                  color: kwhiteText,
                                ),
                              ),
                            ),
                            messageText: const Center(
                              child: Text(
                                'Successfully Added',
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
