import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/controller/getx/music_controller.dart';

// ignore: must_be_immutable
class RatemyApp extends StatelessWidget {
  RatemyApp({Key? key}) : super(key: key);

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
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                shape: const StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.black,
                                // margin: EdgeInsets.all(20),
                                margin: const EdgeInsets.all(10).r,
                                content: const Center(
                                  heightFactor: 1.0,
                                  child: Text(
                                    "Thanks for Rating this App",
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    )
                  ],
                );
              }),
        ],
      ),
    );
  }
}
