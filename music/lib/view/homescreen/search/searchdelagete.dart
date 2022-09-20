import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/view/splashscreen/splashscreen.dart';
import 'package:music/view/widget/openplayer.dart';

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
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
          color: Colors.white,
        ),
      ),
      hintColor: Colors.white,
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
        color: Colors.white,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searched = fullSongs
        .toList()
        .where(
          (element) => element.metas.title!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: searched.isEmpty
          ? const Center(
              child: Text(
                "No Search Result !",
                style: TextStyle(
                  color: Colors.white,
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
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15).r,
                      ),
                      child: ListTile(
                        onTap: (() async {
                          Navigator.pop(context);
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
                        }),
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
                              color: Colors.black,
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
                    context,
                    index,
                  ) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  itemCount: searched.length),
            ),
    );
  }

// search element
  @override
  Widget buildSuggestions(BuildContext context) {
    final searched = fullSongs
        .toList()
        .where(
          (element) => element.metas.title!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: searched.isEmpty
          ? const Center(
              child: Text(
                "No Search Result !",
                style: TextStyle(
                  color: Colors.white,
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
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15).r,
                      ),
                      child: ListTile(
                        onTap: (() async {
                          Navigator.pop(context);
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
                        }),
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
                              color: Colors.black,
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
                    context,
                    index,
                  ) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  itemCount: searched.length),
            ),
    );
  }
}
