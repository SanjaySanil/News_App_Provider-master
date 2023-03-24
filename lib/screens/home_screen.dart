import 'dart:developer';
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_flutter_course/consts/vars.dart';
import 'package:news_app_flutter_course/inner_screens/search_screen.dart';
import 'package:news_app_flutter_course/services/utils.dart';
import 'package:news_app_flutter_course/widgets/drawer_widget.dart';
import 'package:news_app_flutter_course/widgets/empty_screen.dart';
import 'package:news_app_flutter_course/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../consts/global_colors.dart';
import '../models/news_model.dart';
import '../providers/news_provider.dart';

import '../widgets/articles_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/tabs.dart';
import '../widgets/top_tending.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: AppbarColor,
          centerTitle: true,
          title: Text(
            'Find News',
            style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.6),
                color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const SearchScreen(),
                      inheritTheme: true,
                      ctx: context),
                );
              },
              icon: const Icon(IconlyLight.search, color: Colors.white),
            )
          ],
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                TabsWidget(
                  text: 'All news',
                  color: newsType == NewsType.allNews
                      ? Theme.of(context).cardColor
                      : Colors.transparent,
                  function: () {
                    if (newsType == NewsType.allNews) {
                      return;
                    }
                    setState(() {
                      newsType = NewsType.allNews;
                    });
                  },
                  fontSize: newsType == NewsType.allNews ? 22 : 14,
                ),
                const SizedBox(
                  width: 25,
                ),
                TabsWidget(
                  text: 'Breaking News',
                  color: newsType == NewsType.topTrending
                      ? Theme.of(context).cardColor
                      : Colors.transparent,
                  function: () {
                    if (newsType == NewsType.topTrending) {
                      return;
                    }
                    setState(() {
                      newsType = NewsType.topTrending;
                    });
                  },
                  fontSize: newsType == NewsType.topTrending ? 22 : 14,
                ),
              ],
            ),

            const VerticalSpacing(10),
            newsType == NewsType.topTrending
                ? Container()
                : Container(
                    height: 220,
                    child: Flexible(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () async {
                                  if (!await launchUrl(
                                      Uri.parse(blogContent[index]['link']))) {
                                    throw 'Could not launch ${blogContent[index]['link']}}';
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                blogContent[index]['image'],
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 20,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .80,
                                            child: Text(
                                              blogContent[index]['title'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                          // separatorBuilder: (context, index) => const SizedBox(
                          //       width: 25,
                          //     ),
                          itemCount: blogContent.length),
                    ),
                  ),

            const VerticalSpacing(10),
            newsType == NewsType.topTrending
                ? Container()
                : Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                            value: sortBy,
                            items: dropDownItems,
                            onChanged: (String? value) {
                              setState(() {
                                sortBy = value!;
                              });
                            }),
                      ),
                    ),
                  ),
            FutureBuilder<List<NewsModel>>(
              future: newsType == NewsType.topTrending
                  ? newsProvider.fetchTopHeadlines()
                  : newsProvider.fetchAllNews(
                      pageIndex: currentPageIndex + 1, sortBy: sortBy),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return newsType == NewsType.allNews
                      ? LoadingWidget(newsType: newsType)
                      : Expanded(
                          child: LoadingWidget(newsType: newsType),
                        );
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: EmptyNewsWidget(
                      text: "an error occured ${snapshot.error}",
                      imagePath: 'assets/images/no_news.png',
                    ),
                  );
                } else if (snapshot.data == null) {
                  return const Expanded(
                    child: EmptyNewsWidget(
                      text: "No news found",
                      imagePath: 'assets/images/no_news.png',
                    ),
                  );
                }
                return newsType == NewsType.allNews
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (ctx, index) {
                              return ChangeNotifierProvider.value(
                                value: snapshot.data![index],
                                child: ArticlesWidget(
                                    // imageUrl: snapshot.data![index],
                                    // // dateToShow: snapshot.data![index].dateToShow,
                                    // // readingTime:
                                    // //     snapshot.data![index].readingTimeText,
                                    // // title: snapshot.data![index].title,
                                    // // url: snapshot.data![index].url,
                                    ),
                              );
                            }),
                      )
                    : SizedBox(
                        height: size.height * 0.6,
                        child: Swiper(
                          autoplayDelay: 8000,
                          autoplay: true,
                          itemWidth: size.width * 0.9,
                          layout: SwiperLayout.STACK,
                          viewportFraction: 1,
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return ChangeNotifierProvider.value(
                              value: snapshot.data![index],
                              child: const TopTrendingWidget(
                                  // url: snapshot.data![index].url,
                                  ),
                            );
                          },
                        ),
                      );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paginationButtons(
                    text: "Prev",
                    function: () {
                      if (currentPageIndex == 0) {
                        return;
                      }
                      setState(() {
                        currentPageIndex -= 1;
                      });
                    },
                  ),
                  // Flexible(
                  //   flex: 2,
                  //   child: ListView.builder(
                  //       itemCount: 3,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: ((context, index) {
                  //         return Padding(
                  //           padding: const EdgeInsets.all(10),
                  //           child: Material(
                  //             color: currentPageIndex == index
                  //                 ? AppbarColor
                  //                 : Theme.of(context).cardColor,
                  //             child: InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   currentPageIndex = index;
                  //                 });
                  //               },
                  //               child: Center(
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Text("${index + 1}"),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       })),
                  // ),
                  paginationButtons(
                    text: "Next",
                    function: () {
                      if (currentPageIndex == 4) {
                        return;
                      }
                      setState(() {
                        if (currentPageIndex < 2) {
                          currentPageIndex += 1;
                        } else {
                          currentPageIndex = 0;
                        }
                      });
                      // print('$currentPageIndex index');
                    },
                  ),
                ],
              ),
            ),
            //  LoadingWidget(newsType: newsType),
          ]),
        ),
      ),
    );
  }

  Widget paginationButtons({required Function function, required String text}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      child: Text(
        text,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: AppbarColor,
          textStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
