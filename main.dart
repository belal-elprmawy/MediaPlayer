import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Myapp();
}

class _Myapp extends State {
  final player = AudioPlayer();
  bool audioState = false;
  PlayerState _playerState = PlayerState.stopped;
  List<bool> isSettings = [];
  var lastIndex;
  var IndexCopy;
  String playNowString = "";
  List<String> surahNames = [];
  Duration _duration = Duration();
  Duration _position = Duration();

  Future<List<dynamic>> readJson() async {
    try {
      final String response = await rootBundle.loadString("quran.json");
      final _items = await json.decode(response);
      return _items;
    } catch (e) {
      print(e);
    }

  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Builder(builder: (context) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      color: Colors.deepPurple,
                    ),
                  );
                }),
                Builder(builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.62,
                    child: FutureBuilder(
                        future: readJson(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              padding: EdgeInsets.all(12),
                              itemBuilder: (BuildContext context, int index) {
                                print("mohamed");

                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  surahNames
                                      .add(snapshot.data[index]["titleAr"]);
                                }
                                player.onDurationChanged
                                    .listen((Duration duration) {
                                  setState(() {
                                    _duration = duration;
                                  });
                                });

                                player.onPositionChanged
                                    .listen((Duration duration) {
                                  setState(() {
                                    _position = duration;
                                  });
                                });
                                isSettings.add(false);
                                return Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        player.onPlayerStateChanged.listen(
                                          (PlayerState s) => setState(() {
                                            _playerState = s;
                                          }),
                                        );

                                        if (player.state.name == "stopped") {
                                          if (index + 1 < 10) {
                                            player.play(UrlSource(
                                                "https://server10.mp3quran.net/minsh/00${index + 1}.mp3"));
                                            setState(() {
                                              playNowString = snapshot
                                                  .data[index]["titleAr"];
                                              isSettings[index] =
                                                  !isSettings[index];
                                              audioState = true;
                                              IndexCopy = index;
                                            });
                                          } else if (index + 1 > 9 &&
                                              index + 1 < 100) {
                                            player.play(UrlSource(
                                                "https://server10.mp3quran.net/minsh/0${index + 1}.mp3"));
                                            setState(() {
                                              playNowString = snapshot
                                                  .data[index]["titleAr"];
                                              isSettings[index] =
                                                  !isSettings[index];
                                              audioState = true;
                                              IndexCopy = index;
                                            });
                                          } else {
                                            player.play(UrlSource(
                                                "https://server10.mp3quran.net/minsh/${index + 1}.mp3"));
                                            setState(() {
                                              playNowString = snapshot
                                                  .data[index]["titleAr"];
                                              isSettings[index] =
                                                  !isSettings[index];
                                              audioState = true;
                                              IndexCopy = index;
                                            });
                                          }
                                        } else if (player.state.name ==
                                            "playing") {
                                          if (index == lastIndex) {
                                            player.pause();
                                            setState(() {
                                              playNowString = snapshot
                                                  .data[index]["titleAr"];
                                              isSettings[index] =
                                                  !isSettings[index];
                                              audioState = false;
                                            });
                                          } else {
                                            if (index + 1 < 10) {
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/00${index + 1}.mp3"));
                                              setState(() {
                                                playNowString = snapshot
                                                    .data[index]["titleAr"];
                                                isSettings[lastIndex] =
                                                    !isSettings[lastIndex];
                                                isSettings[index] =
                                                    !isSettings[index];
                                                audioState = true;
                                                IndexCopy = index;
                                              });
                                            } else if (index + 1 > 9 &&
                                                index + 1 < 100) {
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/0${index + 1}.mp3"));
                                              setState(() {
                                                playNowString = snapshot
                                                    .data[index]["titleAr"];
                                                isSettings[lastIndex] =
                                                    !isSettings[lastIndex];
                                                isSettings[index] =
                                                    !isSettings[index];
                                                audioState = true;
                                                IndexCopy = index;
                                              });
                                            } else {
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/${index + 1}.mp3"));
                                              setState(() {
                                                playNowString = snapshot
                                                    .data[index]["titleAr"];
                                                isSettings[lastIndex] =
                                                    !isSettings[lastIndex];
                                                isSettings[index] =
                                                    !isSettings[index];
                                                audioState = true;
                                                IndexCopy = index;
                                              });
                                            }
                                          }
                                        } else if (player.state.name ==
                                            "paused") {
                                          if (index + 1 < 10) {
                                            player.play(UrlSource(
                                                "https://server10.mp3quran.net/minsh/00${index + 1}.mp3"));
                                            setState(() {
                                              playNowString = snapshot
                                                  .data[index]["titleAr"];
                                              isSettings[index] =
                                                  !isSettings[index];
                                              audioState = true;
                                              IndexCopy = index;
                                            });
                                          } else if (index + 1 > 9 &&
                                              index + 1 < 100) {
                                            player.play(UrlSource(
                                                "https://server10.mp3quran.net/minsh/0${index + 1}.mp3"));
                                            setState(() {
                                              playNowString = snapshot
                                                  .data[index]["titleAr"];
                                              isSettings[index] =
                                                  !isSettings[index];
                                              audioState = true;
                                              IndexCopy = index;
                                            });
                                          } else {
                                            player.play(UrlSource(
                                                "https://server10.mp3quran.net/minsh/${index + 1}.mp3"));
                                            setState(() {
                                              playNowString = snapshot
                                                  .data[index]["titleAr"];
                                              isSettings[index] =
                                                  !isSettings[index];
                                              audioState = true;
                                              IndexCopy = index;
                                            });
                                          }
                                        }

                                        lastIndex = index;
                                      },
                                      icon: isSettings[index]
                                          ? Icon(Icons.pause)
                                          : Icon(Icons.play_arrow),
                                      label: Row(
                                        children: [
                                          Container(
                                              width: 50,
                                              child: Text(snapshot.data[index]
                                                  ["titleAr"])),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: 100,
                                            child: Text(
                                                "عدد آياتها :  ${snapshot.data[index]["count"]}"),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: 30,
                                            child: Text(
                                                "${snapshot.data[index]["type"]}"),
                                          ),
                                        ],
                                      ),
                                      style: ButtonStyle(
                                        textStyle: MaterialStateProperty.all<
                                                TextStyle>(
                                            TextStyle(color: Colors.black87)),
                                        alignment: Alignment.centerRight,
                                        padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          EdgeInsets.all(20.0),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                            );
                          }
                        }),
                  );
                }),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Builder(
                  builder: (context) {
                    return Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black12,
                      child: Column(children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(playNowString),
                        Container(
                          height: 35,
                          child: Slider(
                            min: 0.0,
                            max: _duration.inSeconds.toDouble(),
                            value: _position.inSeconds.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                player.seek(Duration(seconds: value.toInt()));
                              });
                            },
                            activeColor: Colors.deepPurple,
                            inactiveColor: Colors.deepPurpleAccent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  _position.inHours.toString().padLeft(2, '0') +
                                      ":" +
                                      _position.inMinutes
                                          .remainder(60)
                                          .toString()
                                          .padLeft(2, '0') +
                                      ":" +
                                      _position.inSeconds
                                          .remainder(60)
                                          .toString()
                                          .padLeft(2, '0')),
                              Text(
                                  _duration.inHours.toString().padLeft(2, '0') +
                                      ":" +
                                      _duration.inMinutes
                                          .remainder(60)
                                          .toString()
                                          .padLeft(2, '0') +
                                      ":" +
                                      _duration.inSeconds
                                          .remainder(60)
                                          .toString()
                                          .padLeft(2, '0'))
                            ],
                          ),
                        ),
                        Container(
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: playNowString.isNotEmpty
                                      ? () {
                                          if (player.state.name == "paused") {
                                            if (IndexCopy + 1 < 10) {
                                              lastIndex--;
                                              IndexCopy--;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/00${IndexCopy + 1}.mp3"));
                                              print(IndexCopy);
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            } else if (IndexCopy + 1 > 9 &&
                                                IndexCopy + 1 < 100) {
                                              lastIndex--;
                                              IndexCopy--;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/0${IndexCopy + 1}.mp3"));
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            } else {
                                              lastIndex--;
                                              IndexCopy--;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/${IndexCopy + 1}.mp3"));
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            }
                                          } else {
                                            if (IndexCopy + 1 < 10) {
                                              lastIndex--;
                                              IndexCopy--;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/00${IndexCopy + 1}.mp3"));
                                              print(IndexCopy);
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy + 1] =
                                                    !isSettings[IndexCopy + 1];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            } else if (IndexCopy + 1 > 9 &&
                                                IndexCopy + 1 < 100) {
                                              lastIndex--;
                                              IndexCopy--;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/0${IndexCopy + 1}.mp3"));
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy + 1] =
                                                    !isSettings[IndexCopy + 1];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            } else {
                                              lastIndex--;
                                              IndexCopy--;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/${IndexCopy + 1}.mp3"));
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy + 1] =
                                                    !isSettings[IndexCopy + 1];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            }
                                          }
                                        }
                                      : null,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 25,
                                  ),
                                ),
                                IconButton(
                                    onPressed: playNowString.isNotEmpty
                                        ? () {
                                            if (audioState) {
                                              isSettings[lastIndex] =
                                                  !isSettings[lastIndex];
                                              player.pause();
                                            } else {
                                              isSettings[lastIndex] =
                                                  !isSettings[lastIndex];
                                              player.resume();
                                            }
                                            player.onPlayerStateChanged.listen(
                                              (PlayerState s) => setState(() {
                                                if (s.name == "paused") {
                                                  audioState = false;
                                                } else {
                                                  audioState = true;
                                                }
                                              }),
                                            );
                                          }
                                        : null,
                                    icon: audioState
                                        ? Icon(Icons.pause)
                                        : Icon(Icons.play_arrow),
                                    iconSize: 35),
                                InkWell(
                                  onTap: playNowString.isNotEmpty
                                      ? () {
                                          if (player.state.name == "paused") {
                                            if (IndexCopy + 1 < 10) {
                                              lastIndex++;
                                              IndexCopy++;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/00${IndexCopy + 1}.mp3"));

                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                                audioState = false;
                                              });
                                            } else if (IndexCopy + 1 > 9 &&
                                                IndexCopy + 1 < 100) {
                                              lastIndex++;
                                              IndexCopy++;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/0${IndexCopy + 1}.mp3"));
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            } else {
                                              lastIndex++;
                                              IndexCopy++;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/${IndexCopy + 1}.mp3"));
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            }
                                          } else {
                                            if (IndexCopy + 1 < 10) {
                                              lastIndex++;
                                              IndexCopy++;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/00${IndexCopy + 1}.mp3"));

                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy - 1] =
                                                    !isSettings[IndexCopy - 1];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            } else if (IndexCopy + 1 > 9 &&
                                                IndexCopy + 1 < 100) {
                                              lastIndex++;
                                              IndexCopy++;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/0${IndexCopy + 1}.mp3"));
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy - 1] =
                                                    !isSettings[IndexCopy - 1];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            } else {
                                              lastIndex++;
                                              IndexCopy++;
                                              player.play(UrlSource(
                                                  "https://server10.mp3quran.net/minsh/${IndexCopy + 1}.mp3"));
                                              setState(() {
                                                playNowString =
                                                    surahNames[IndexCopy];
                                                isSettings[IndexCopy - 1] =
                                                    !isSettings[IndexCopy - 1];
                                                isSettings[IndexCopy] =
                                                    !isSettings[IndexCopy];
                                              });
                                            }
                                          }
                                        }
                                      : null,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ))
                      ]),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
