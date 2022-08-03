import 'package:flutter/material.dart';
import 'package:music/navbar/navbar.dart';
import 'package:music/screen/musicplayscreen.dart';

class FavouriteMusicScreen extends StatelessWidget {
  const FavouriteMusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF911BEE),
            Colors.black.withOpacity(0.94),
            Colors.black,
            Colors.black.withOpacity(0.94),
            const Color(0xFF911BEE),
          ],
          stops: const [
            0.01,
            0.3,
            0.5,
            0.7,
            1,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Favourite'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) =>  NavBar()),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.white54,
                      width: 2.0,
                    ),
                  ),
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) =>
                                 MusicPlaySceeen()),
                          ),
                        );
                      },
                      leading: const CircleAvatar(
                        child: Icon(
                          Icons.music_note,
                          color: Colors.white,
                        ),
                      ),
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "Song Name  ${index + 1}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      subtitle: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "<artist name ${index + 1}>",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              margin: EdgeInsets.all(20),
                              behavior: SnackBarBehavior.floating,
                              content: Center(
                                  heightFactor: 1.0,
                                  child: Text(
                                    "Succesfully removed",
                                  )),
                              duration: Duration(seconds: 1),
                              shape: StadiumBorder(),
                              elevation: 100,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
