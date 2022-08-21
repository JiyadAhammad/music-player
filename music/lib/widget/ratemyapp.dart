import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatemyApp extends StatefulWidget {
  const RatemyApp({Key? key}) : super(key: key);

  @override
  State<RatemyApp> createState() => _RatemyAppState();
}

class _RatemyAppState extends State<RatemyApp> {
  double rating = 0;
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
          Column(
            children: [
              Text(
                "Rating $rating",
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
                  setState(() {
                    this.rating = rating;
                  });
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
          ),
        ],
      ),
    );
  }
}
