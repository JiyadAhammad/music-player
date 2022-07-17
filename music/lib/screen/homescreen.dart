import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music/function/searchdelagete.dart';
import 'package:music/navdrawer/navdrawer.dart';
import 'package:music/screen/musicplayscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
        drawer: const Navdrawer(),
        
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('jMUSIC'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearch(),
                );
              },
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder<String>(
          future:
              DefaultAssetBundle.of(context).loadString("AssetManifest.json"),
          builder: (context, item) {
            if (item.hasData) {
              Map? jsonMap = json.decode(item.data!);
              // List songs = jsonMap!.keys.toList();
              List? songs = jsonMap!.keys
                  .where((element) => element.endsWith(".mp3"))
                  .toList();

              return Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var path = songs[index].toString();
                    // path = path.replaceAll("%20", " ");
                    var songtitle = path.split('/').last.toString();
                    songtitle = songtitle.replaceAll("%20", " ");
                    songtitle = songtitle.replaceAll("%5", " ");
                    songtitle = songtitle.split(".").first;
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
                                builder: ((context) => MusicPlaySceeen(
                                      index: index,
                                      songtitle: songtitle,
                                    )),
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
                              songtitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          subtitle: const SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              " <unknown>",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                              ),
                              PopupMenuButton(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                                color: Colors.black,
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem(
                                      value: '1',
                                      child: Text(
                                        'Add to playlist',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                                onSelected: (String value) {},
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                      ),
                      
                    );
                    
                  },
                ),
                
              );
            } else {
              return const Center(
                child: Text(
                  'No songs found',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
          // child: SafeArea(
          //   child:
          // ),
        ),
        
      ),
    );
  }
}
