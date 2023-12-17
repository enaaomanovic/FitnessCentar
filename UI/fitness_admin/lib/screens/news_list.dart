import 'dart:convert';
import 'package:fitness_admin/models/komentari.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/novosti.dart';
import 'package:fitness_admin/models/odgovoriNaKomentare.dart';
import 'package:fitness_admin/providers/comment_provider.dart';
import 'package:fitness_admin/providers/news_provider.dart';
import 'package:fitness_admin/providers/replyToComment_provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewsListScrean extends StatefulWidget {
  const NewsListScrean({Key? key}) : super(key: key);

  @override
  State<NewsListScrean> createState() => _NewsListScrean();
}

class _NewsListScrean extends State<NewsListScrean> {
  late NewsProvider _newsProvider;
  late UserProvider _userProvider;
  late CommentProvider _commentProvider;
  late ReplyToCommentProvider _replyToCommentProvider;
  bool isLoading = true;

  var page = 1;
  var totalcount = 0;
  var numberOfnews = 3;

  List<Novosti> _novosti = [];
  bool showComments = false;
  Map<int, bool> openedComments = {};

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    _userProvider = context.read<UserProvider>();
    _commentProvider = context.read<CommentProvider>();
    _replyToCommentProvider = context.read<ReplyToCommentProvider>();
    initForm();
    _loadData();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  void _loadData() async {
    var data = await _newsProvider
        .getPaged(filter: {'page': page, 'pageSize': numberOfnews});
    if (data != null) {
      setState(() {
        totalcount = data.count!;
        _novosti = data.result ?? [];
      });
    }
  }

  void refreshComments(int novostiId) async {
    await _loadComment(novostiId);
    setState(() {});
  }

  Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await _userProvider.getById(userId);

    return user;
  }

  Widget _buildPageNumbers() {
    int totalPages = (totalcount / numberOfnews).ceil();
    List<Widget> pageButtons = [];

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                page = i;
                _loadData();
              });
            },
            child: Text('$i'),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pageButtons,
    );
  }

  Future<List<Komentari>> _loadComment(int novostiId) async {
    var data = await _commentProvider.get(filter: {
      "novostId": novostiId,
    });

    if (data != null) {
      return data.result ?? [];
    } else {
      return [];
    }
  }

  Future<List<OdgovoriNaKomentare>> _loadReply(int komentarId) async {
    var data = await _replyToCommentProvider.get(filter: {
      "komentarId": komentarId,
    });

    if (data != null) {
      return data.result ?? [];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Prikaz novosti"),
      child: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            isLoading
                ? Container()
                : Column(
                    children: [
                      _buildDataListView(_novosti),
                      _buildPageNumbers(),
                    ],
                  ),
          ]),
        ),
      ),
    );
  }

  Widget _buildDataListView(List<Novosti> novosti) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Align(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 900,
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: novosti.asMap().entries.map((entry) {
                  int index = entry.key;
                  Novosti novost = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.purple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            novost.naslov ?? "",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Datum objave: ${DateFormat('dd.MM.yyyy').format(novost.datumObjave ?? DateTime.now())}",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<Korisnici?>(
                                  future:
                                      getUserFromUserId(novost.autorId ?? 0),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      final author = snapshot.data;
                                      if (author != null) {
                                        return ListTile(
                                          title: Text(
                                            "Objavio: ${author.ime} ${author.prezime}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                          subtitle: Text(
                                            "Sadržaj novosti: ${novost.tekst ?? ''}",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Text("Objavio: Nepoznat autor");
                                      }
                                    } else {
                                      return Text("Objavio: Učitavanje...");
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      openedComments[novost.id ?? 0] =
                                          !(openedComments[novost.id ?? 0] ??
                                              false);
                                    });
                                    if (showComments) {
                                      _buildComments(novost.id ?? 0);
                                    }
                                  },
                                  child: Text('Komentari'),
                                ),
                                if (openedComments[novost.id ?? 0] ?? false)
                                  _buildComments(novost.id ?? 0),
                              ],
                            ),
                            onTap: () {},
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComments(int novostiId) {
    return FutureBuilder<List<Komentari>>(
      future: _loadComment(novostiId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final comments = snapshot.data;

          if (comments != null && comments.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: comments.map((comment) {
                TextEditingController replyController = TextEditingController();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<Korisnici?>(
                          future: getUserFromUserId(comment.korisnikId ?? 0),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.done) {
                              final autor = userSnapshot.data;
                              final base64Image = autor?.slika;

                              if (base64Image != null &&
                                  base64Image.isNotEmpty) {
                                try {
                                  final decodedImage =
                                      base64.decode(base64Image);
                                  return Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage:
                                            MemoryImage(decodedImage),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${autor?.ime ?? 'Nepoznat'} ${autor?.prezime ?? 'Nepoznat'}",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Datum: ${DateFormat('dd.MM.yyyy HH:mm').format(comment.datumKomentara ?? DateTime.now())}",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                } catch (e) {}
                              }

                              return Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                        'assets/images/male_icon.jpg'),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${autor?.ime ?? 'Nepoznat'} ${autor?.prezime ?? 'Nepoznat'}",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Datum: ${DateFormat('dd.MM.yyyy HH:mm').format(comment.datumKomentara ?? DateTime.now())}",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        SizedBox(height: 8),
                        Text(
                          comment.tekst ?? "",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8),
                        _buildReplies(comment.id ?? 0),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: replyController,
                                decoration: InputDecoration(
                                  hintText: 'Odgovori na komentar...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            TextButton(
                              onPressed: () async {
                                var userProvider = Provider.of<UserProvider>(
                                    context,
                                    listen: false);
                                int? trenutniKorisnikId =
                                    userProvider.currentUserId;

                                if (trenutniKorisnikId != null) {
                                  int? komentarId = comment.id;

                                  String tekstOdgovora =
                                      replyController.text.trim();
                                  if (tekstOdgovora.isNotEmpty) {
                                    var request = <String, dynamic>{
                                      'komentarId': komentarId,
                                      'trenerId': trenutniKorisnikId,
                                      'tekst': tekstOdgovora,
                                      'datumOdgovora':
                                          DateTime.now().toIso8601String(),
                                    };

                                    if (request['tekst'].trim().isNotEmpty) {
                                      await _replyToCommentProvider
                                          .insert(request);
                                      refreshComments(comment.novostId ?? 0);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Uspješno ste dodali odgovor na komentar.'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Niste unijeli odgovor.'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Niste unijeli odgovor.'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text('Pošalji'),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Text("Nema komentara za ovu novost.");
          }
        } else {
          return Text("Učitavanje komentara...");
        }
      },
    );
  }

  Widget _buildReplies(int komentarId) {
    return FutureBuilder<List<OdgovoriNaKomentare>>(
      future: _loadReply(komentarId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final replies = snapshot.data;
          if (replies != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: replies.map((reply) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<Korisnici?>(
                          future: getUserFromUserId(reply.trenerId ?? 0),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.done) {
                              final trener = userSnapshot.data;
                              final base64Image = trener?.slika;

                              if (base64Image != null &&
                                  base64Image.isNotEmpty) {
                                try {
                                  final decodedImage =
                                      base64.decode(base64Image);
                                  return Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage:
                                            MemoryImage(decodedImage),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${trener?.ime ?? 'Nepoznat'} ${trener?.prezime ?? 'Nepoznat'}",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Datum: ${DateFormat('dd.MM.yyyy HH:mm').format(reply.datumOdgovora ?? DateTime.now())}",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                } catch (e) {}
                              }

                              return Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                        'assets/images/male_icon.jpg'),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${trener?.ime ?? 'Nepoznat'} ${trener?.prezime ?? 'Nepoznat'}",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Datum: ${DateFormat('dd.MM.yyyy HH:mm').format(reply.datumOdgovora ?? DateTime.now())}",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        SizedBox(height: 8),
                        Text(
                          reply.tekst ?? "",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Text("Greška pri dohvatanju odgovora");
          }
        } else {
          return Text("Učitavanje odgovora...");
        }
      },
    );
  }
}
