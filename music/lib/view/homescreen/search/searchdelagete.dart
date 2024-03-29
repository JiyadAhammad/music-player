import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/colors/colors.dart';
import '../../constants/sizedbox/sizedbox.dart';
import '../../splashscreen/splashscreen.dart';
import '../../widget/openplayer.dart';

class MySearch extends SearchDelegate<dynamic> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(
              context,
              null,
            );
          } else {
            query = ' ';
          }
        },
        icon: const Icon(
          Icons.clear,
        ),
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: const TextTheme(
        displayMedium: TextStyle(
          color: kwhite,
        ),
      ),
      hintColor: kwhite,
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 38, 231, 238),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            border: InputBorder.none,
          ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
          context,
          null,
        );
      },
      icon: const Icon(
        Icons.arrow_back,
        color: kwhiteIcon,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Audio> searched = fullSongs
        .toList()
        .where(
          (Audio element) => element.metas.title!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return Scaffold(
      backgroundColor: kblack,
      body: searched.isEmpty
          ? const Center(
              child: Text(
                'No Search Result !',
                style: TextStyle(
                  color: kwhiteText,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ).r,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: kwhite,
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                    child: ListTile(
                      onTap: () async {
                        Get.back();
                        await Openplayer(
                          fullSongs: searched,
                          index: index,
                          songId: int.parse(
                            searched[index].metas.id!,
                          ).toString(),
                        ).openAssetPlayer(
                          index: index,
                          songs: searched,
                        );
                      },
                      title: Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          bottom: 3,
                          top: 3,
                        ).r,
                        child: Text(
                          searched[index].metas.title!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kblackText,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(
                          left: 7.0,
                        ).r,
                        child: Text(
                          fullSongs[index].metas.artist!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return kHeight;
                },
                itemCount: searched.length,
              ),
            ),
    );
  }

// search element
  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Audio> searched = fullSongs
        .toList()
        .where(
          (Audio element) => element.metas.title!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return Scaffold(
      backgroundColor: kblack,
      body: searched.isEmpty
          ? const Center(
              child: Text(
                'No Search Result !',
                style: TextStyle(
                  color: kwhiteText,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ).r,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: kwhite,
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                    child: ListTile(
                      onTap: () async {
                        Get.back();
                        await Openplayer(
                          fullSongs: searched,
                          index: index,
                          songId: int.parse(
                            searched[index].metas.id!,
                          ).toString(),
                        ).openAssetPlayer(
                          index: index,
                          songs: searched,
                        );
                      },
                      title: Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          bottom: 3,
                          top: 3,
                        ).r,
                        child: Text(
                          searched[index].metas.title!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kblackText,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(
                          left: 7.0,
                        ).r,
                        child: Text(
                          fullSongs[index].metas.artist!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return kHeight;
                },
                itemCount: searched.length,
              ),
            ),
    );
  }
}
