import 'package:flutter/material.dart';
import 'package:music/navbar/navbar.dart';
import 'package:music/screen/eachplaylistscreen.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
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
          title: const Text('Playlist'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return const NavBar();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4/ 3,
          ),
          itemCount: listofitemsgrid.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: InkWell(
                onLongPress: () {
                  deletedPlayList();
                },
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const EachPlayList();
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white54,
                      style: BorderStyle.solid,
                      width: 2.5,
                    ),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      listofitemsgrid[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const RadialGradient(
              colors: [
                Color(0xFF911BEE),
                Color(0xFF4D0089),
              ],
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text('Playlist Name'),
                    content: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Playlist Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Color.fromARGB(255, 49, 185, 11),
                              margin: EdgeInsets.all(30),
                              behavior: SnackBarBehavior.floating,
                              content: Center(
                                heightFactor: 1.0,
                                child: Text(
                                  "Added Succesfully",
                                ),
                              ),
                              duration: Duration(seconds: 1),
                              shape: StadiumBorder(),
                              elevation: 100,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 82, 189),
                              margin: EdgeInsets.all(20),
                              behavior: SnackBarBehavior.floating,
                              content: Center(
                                heightFactor: 1.0,
                                child: Text(
                                  "Longpress to delete",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              duration: Duration(seconds: 3),
                              elevation: 100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                            ),
                          );
                          Navigator.pop(context, 'ok');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  void deletedPlayList() {
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
  }

  final listofitemsgrid = [
    'Malaylam',
    'English',
    'Hindi',
    'Melody',
    'tamil',
    // 'Favourites',
    'Sleep',
    'Gym',
  ];
}
