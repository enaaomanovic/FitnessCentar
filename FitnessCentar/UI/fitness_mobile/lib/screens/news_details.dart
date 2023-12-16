import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/novosti.dart';
import 'package:fitness_mobile/models/recommender.dart';
import 'package:fitness_mobile/providers/news_provider.dart';
import 'package:fitness_mobile/providers/recommender_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewsDetails extends StatefulWidget {
  final Novosti novost;

  const NewsDetails({Key? key, required this.novost}) : super(key: key);

  @override
  _NewsDetails createState() => _NewsDetails();
}

class _NewsDetails extends State<NewsDetails> {
  late UserProvider _userProvider;
  late RecommenderProvider _recommenderProvider;
  late NewsProvider _newsProvider;
  bool isLoading = true;

  List<Novosti> listaNovosti = [];

  @override
  void initState() {
    _userProvider = context.read<UserProvider>();
    _recommenderProvider = context.read<RecommenderProvider>();
    _newsProvider = context.read<NewsProvider>();
    super.initState();

    initForm();
  }

  Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await _userProvider.getById(userId);
    return user;
  }

  Future<Novosti?> getNovostFromId(int novostId) async {
    final novost = await _newsProvider.getById(novostId);
    return novost;
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  Future<List<Recommender>> getRecommendedNews(int novostId) async {
    try {
      Recommender preporukeData = await _recommenderProvider.getById(novostId);

      int? coNovostId1 = preporukeData.coNovostId1;
      int? coNovostId2 = preporukeData.coNovostId2;
      int? coNovostId3 = preporukeData.coNovostId3;

      List<Recommender> recommendedNews = [];

      if (coNovostId1 != null) {
        Recommender recommendedNews1 =
            await _recommenderProvider.getById(coNovostId1);
        recommendedNews.add(recommendedNews1);
      }

      if (coNovostId2 != null) {
        Recommender recommendedNews2 =
            await _recommenderProvider.getById(coNovostId2);
        recommendedNews.add(recommendedNews2);
      }

      if (coNovostId3 != null) {
        Recommender recommendedNews3 =
            await _recommenderProvider.getById(coNovostId3);
        recommendedNews.add(recommendedNews3);
      }

      return recommendedNews;
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    getRecommendedNews(widget.novost.id!);
    return MasterScreanWidget(
      title_widget: Text(widget.novost.naslov ?? "News Details"),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading ? Container() : _buildNewsDetailsCard(),
            SizedBox(height: 20),
            Text(
              "Preporučene novosti",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            isLoading ? Container() : _buildRecommendedNews(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsDetailsCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.purple,
          width: 3.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.novost.naslov!,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            FutureBuilder<Korisnici?>(
              future: getUserFromUserId(widget.novost.autorId ?? 0),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final author = snapshot.data;
                  if (author != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Objavio: ${author.ime} ${author.prezime}",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Datum objave: ${DateFormat('dd.MM.yyyy').format(widget.novost.datumObjave ?? DateTime.now())}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    );
                  } else {
                    return Text("Nepoznat autor");
                  }
                } else {
                  return Text("Učitavanje autora...");
                }
              },
            ),
            SizedBox(height: 15),
            Text(
              widget.novost.tekst!,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedNews() {
    return FutureBuilder<List<Recommender>>(
      future: getRecommendedNews(widget.novost.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Greška prilikom dohvatanja preporučenih novosti');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('Nema preporučenih novosti');
        } else {
          List<Recommender> recommendedNews = snapshot.data!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder<Novosti?>(
                future: getNovostFromId(recommendedNews[0].novostId!),
                builder: (context, novostSnapshot1) {
                  if (novostSnapshot1.connectionState == ConnectionState.done) {
                    final novost1 = novostSnapshot1.data;
                    return _buildRecommendedCard(
                        novost1?.naslov ?? "Naslov nije dostupan",
                        novost1?.tekst,
                        novost1?.autorId,
                        novost1!);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<Novosti?>(
                future: getNovostFromId(recommendedNews[1].novostId!),
                builder: (context, novostSnapshot2) {
                  if (novostSnapshot2.connectionState == ConnectionState.done) {
                    final novost2 = novostSnapshot2.data;
                    return _buildRecommendedCard(
                        novost2?.naslov ?? "Naslov nije dostupan",
                        novost2?.tekst,
                        novost2?.autorId,
                        novost2!);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<Novosti?>(
                future: getNovostFromId(recommendedNews[2].novostId!),
                builder: (context, novostSnapshot3) {
                  if (novostSnapshot3.connectionState == ConnectionState.done) {
                    final novost3 = novostSnapshot3.data;
                    return _buildRecommendedCard(
                        novost3?.naslov ?? "Naslov nije dostupan",
                        novost3?.tekst,
                        novost3?.autorId,
                        novost3!);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildRecommendedCard(String title, String? subtitle, int? authorId,
      Novosti recommendedNovost) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetails(novost: recommendedNovost),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.purple,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              if (subtitle != null)
                Text(
                  subtitle.length > 50
                      ? '${subtitle.substring(0, 50)}...'
                      : subtitle,
                  style: TextStyle(fontSize: 14.0),
                ),
              SizedBox(height: 5),
              if (authorId != null)
                FutureBuilder<Korisnici?>(
                  future: getUserFromUserId(authorId),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.done) {
                      final user = userSnapshot.data;
                      return Text(
                        'Autor: ${user?.ime} ${user?.prezime}' ??
                            'Nepoznat autor',
                        style: TextStyle(fontSize: 14.0),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
