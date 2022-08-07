
import 'package:flutter/material.dart';
import 'package:music/main.dart';

class ActionDelete extends StatelessWidget {
final int index;
  const ActionDelete({
    Key? key,required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.topRight,
      onPressed: () {
       showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Do you want to delete'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                playlistDb.deleteAt(index);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    margin: EdgeInsets.all(20),
                    behavior: SnackBarBehavior.floating,
                    content: Center(
    heightFactor: 1.0,
    child: Text(
      "Succesfully deleted Playlist",
    ),
                    ),
                    duration: Duration(seconds: 3),
                    shape: StadiumBorder(),
                    elevation: 100,
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
