import 'package:flutter/material.dart';
import 'package:music/screen/musicplayscreen.dart';

class MySearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    // assert(context != null);
    final ThemeData theme = Theme.of(context);
    // final ColorScheme colorScheme = theme.colorScheme;
    // assert(theme != null);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        // brightness: colorScheme.brightness,
        elevation: 0,
        backgroundColor: Colors.red,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        // textTheme: theme.textTheme,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listItems = query;
    // if (query.isEmpty) {}

    return listItems.isEmpty
        ? const Center(
            child: Text(
              "No Data Found!",
            ),
          )
        : const Center(
            child: Text(
              'Item Found',
            ),
          );
    // : ListView.builder(
    //     itemCount: listItems.length,
    //     itemBuilder: (
    //       context,
    //       index,
    //     ) {
    //       return Padding(
    //         padding: const EdgeInsets.only(
    //           left: 15.00,
    //           right: 15.00,
    //         ),
    //         child: Column(
    //           children: [
    //             ListTile(
    //               title: Text(
    //                 listItems[index],
    //               ),
    //               subtitle: Text(
    //                 listItems[index],
    //               ),
    //               onTap: () {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(
    //                     builder: (ctx) => const MusicPlaySceeen(),
    //                   ),
    //                 );
    //               },
    //             ),
    //             const Divider(
    //               thickness: 3,
    //               color: Colors.black,
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
  }
}
