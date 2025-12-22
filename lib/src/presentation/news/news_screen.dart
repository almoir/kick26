import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/presentation/news/widgets/live_match_widget.dart';
import 'package:kick26/src/presentation/news/widgets/upcoming_match_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // NEWS CARD
              SizedBox(
                height: 260,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        NewsCardWidget(
                          image: ImagePaths.news.news1,
                          source: "Premier League",
                          category: "News",
                          dateTime: "9/3/25",
                          title: "Man. City VS Man. United\n\nDerby Manchester: The Biggest Match of This Week",
                        ),
                        NewsCardWidget(
                          image: ImagePaths.news.news2,
                          source: "Chelsea",
                          category: "Transfer",
                          dateTime: "7/3/25",
                          title:
                              "Joao Felix: Chelsea sign Atletico Madrid and Portugal forward on loan until end of the season | Transfer Centre News | Sky Sports",
                        ),
                        NewsCardWidget(
                          image: ImagePaths.news.news1,
                          source: "Premier League",
                          category: "News",
                          dateTime: "9/3/25",
                          title: "Man. City VS Man. United\n\nDerby Manchester: The Biggest Match of This Week",
                        ),
                        NewsCardWidget(
                          image: ImagePaths.news.news2,
                          source: "Chelsea",
                          category: "Transfer",
                          dateTime: "7/3/25",
                          title:
                              "Joao Felix: Chelsea sign Atletico Madrid and Portugal forward on loan until end of the season | Transfer Centre News | Sky Sports",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 24),

              // MATCHES & SCORES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Matches & Scores",
                      style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light),
                    ),
                    const Gap(16),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          LiveMatchWidget(
                            homeTeam: "Man City",
                            awayTeam: "Man United",
                            homeLogo: ImagePaths.home.manchesterCity,
                            awayLogo: ImagePaths.home.manchesterUnited,
                            homeScore: 2,
                            awayScore: 1,
                            league: "Premier League",
                            time: "FT",
                          ),
                          LiveMatchWidget(
                            homeTeam: "Real Madrid",
                            awayTeam: "Real Betis",
                            homeLogo: ImagePaths.home.realMadrid,
                            awayLogo: ImagePaths.home.realBetis,
                            homeScore: 1,
                            awayScore: 1,
                            league: "La Liga",
                            time: "78'",
                          ),
                          LiveMatchWidget(
                            homeTeam: "Liverpool",
                            awayTeam: "Arsenal",
                            homeLogo: ImagePaths.home.liverpool,
                            awayLogo: ImagePaths.home.arsenal,
                            homeScore: 2,
                            awayScore: 3,
                            league: "Premier League",
                            time: "FT",
                          ),
                          LiveMatchWidget(
                            homeTeam: "Barcelona",
                            awayTeam: "Athletic Bilbao",
                            homeLogo: ImagePaths.home.fcb,
                            awayLogo: ImagePaths.home.bilbao,
                            homeScore: 4,
                            awayScore: 1,
                            league: "La Liga",
                            time: "78'",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // UPCOMING MATCHES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Upcoming Matches",
                      style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light),
                    ),
                    const Gap(16),
                    UpcomingMatchWidget(
                      homeTeam: "Barcelona",
                      awayTeam: "PSG",
                      league: "UEFA Champions League",
                      date: "12 Mar 2025",
                      time: "03:00 AM",
                    ),
                    UpcomingMatchWidget(
                      homeTeam: "Bayern",
                      awayTeam: "Arsenal",
                      league: "UEFA Champions League",
                      date: "13 Mar 2025",
                      time: "03:00 AM",
                    ),
                  ],
                ),
              ),

              // FOR YOU
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("For You", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                    const Gap(16),
                    TabBar(
                      dividerColor: Colors.transparent,
                      isScrollable: true,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: ConstColors.gold),
                      ),
                      indicatorPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                      indicatorColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorAnimation: TabIndicatorAnimation.linear,
                      indicatorWeight: 1,
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.zero,
                      labelStyle: const TextStyle(fontFamily: poppinsRegular, color: ConstColors.gold, fontSize: 12),
                      unselectedLabelStyle: const TextStyle(
                        fontFamily: poppinsRegular,
                        color: ConstColors.gray10,
                        fontSize: 12,
                      ),
                      tabs: const [Tab(text: "All"), Tab(text: "News"), Tab(text: "Update"), Tab(text: "Transfers")],
                    ),
                    const Gap(16),
                    SizedBox(
                      height: 320,
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              ForYouWidget(
                                image: ImagePaths.news.forYou1,
                                category: "News",
                                title: "Real Madrid vs Atletico Madrid Result: 1 vs 1",
                                source: "UEFA CL R16 24/25",
                                dateTime: "5/3/2025",
                              ),
                              ForYouWidget(
                                image: ImagePaths.news.forYou2,
                                category: "News",
                                title: "Paris Saint Germain vs Liverpool Result: 0 vs 1",
                                source: "UEFA CL R16 24/25",
                                dateTime: "6/3/2025",
                              ),
                              ForYouWidget(
                                image: ImagePaths.news.forYou3,
                                category: "News",
                                title: "Bayern Munich vs Bayer Leverkusen: Kane 2 Goals and 1 Assist for Win",
                                source: "UEFA CL R16 24/25",
                                dateTime: "6/3/2025",
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              ForYouWidget(
                                image: ImagePaths.news.forYou1,
                                category: "News",
                                title: "Real Madrid vs Atletico Madrid Result: 1 vs 1",
                                source: "UEFA CL R16 24/25",
                                dateTime: "5/3/2025",
                              ),
                              ForYouWidget(
                                image: ImagePaths.news.forYou2,
                                category: "News",
                                title: "Paris Saint Germain vs Liverpool Result: 0 vs 1",
                                source: "UEFA CL R16 24/25",
                                dateTime: "6/3/2025",
                              ),
                              ForYouWidget(
                                image: ImagePaths.news.forYou3,
                                category: "News",
                                title: "Bayern Munich vs Bayer Leverkusen: Kane 2 Goals and 1 Assist for Win",
                                source: "UEFA CL R16 24/25",
                                dateTime: "6/3/2025",
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              ForYouWidget(
                                image: ImagePaths.news.forYou1,
                                category: "News",
                                title: "Real Madrid vs Atletico Madrid Result: 1 vs 1",
                                source: "UEFA CL R16 24/25",
                                dateTime: "5/3/2025",
                              ),
                              ForYouWidget(
                                image: ImagePaths.news.forYou2,
                                category: "News",
                                title: "Paris Saint Germain vs Liverpool Result: 0 vs 1",
                                source: "UEFA CL R16 24/25",
                                dateTime: "6/3/2025",
                              ),
                              ForYouWidget(
                                image: ImagePaths.news.forYou3,
                                category: "News",
                                title: "Bayern Munich vs Bayer Leverkusen: Kane 2 Goals and 1 Assist for Win",
                                source: "UEFA CL R16 24/25",
                                dateTime: "6/3/2025",
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              ForYouWidget(
                                image: ImagePaths.news.forYou1,
                                category: "News",
                                title: "Real Madrid vs Atletico Madrid Result: 1 vs 1",
                                source: "UEFA CL R16 24/25",
                                dateTime: "5/3/2025",
                              ),
                              ForYouWidget(
                                image: ImagePaths.news.forYou2,
                                category: "News",
                                title: "Paris Saint Germain vs Liverpool Result: 0 vs 1",
                                source: "UEFA CL R16 24/25",
                                dateTime: "6/3/2025",
                              ),
                              ForYouWidget(
                                image: ImagePaths.news.forYou3,
                                category: "News",
                                title: "Bayern Munich vs Bayer Leverkusen: Kane 2 Goals and 1 Assist for Win",
                                source: "UEFA CL R16 24/25",
                                dateTime: "6/3/2025",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForYouWidget extends StatelessWidget {
  final String image;
  final String category;
  final String title;
  final String source;
  final String dateTime;
  const ForYouWidget({
    super.key,
    required this.image,
    required this.category,
    required this.title,
    required this.source,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 88,
            width: 88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray10),
                ),
                const Gap(8),
                Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: poppinsMedium,
                    color: ConstColors.light,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(8),
                Text(
                  "$source \u2981 $dateTime",
                  style: const TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCardWidget extends StatelessWidget {
  final String image;
  final String source;
  final String category;
  final String dateTime;
  final String title;
  const NewsCardWidget({
    super.key,
    required this.image,
    required this.source,
    required this.category,
    required this.dateTime,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 220,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(color: ConstColors.baseColorDark2, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(image, fit: BoxFit.cover, height: 147),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$source \u2981 $category",
                      style: const TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray10),
                    ),
                    Text(
                      dateTime,
                      style: const TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray10),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  maxLines: 4,
                  style: const TextStyle(
                    fontFamily: poppinsMedium,
                    fontSize: 12,
                    color: ConstColors.light,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
