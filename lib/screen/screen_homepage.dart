import 'dart:convert';
import 'dart:ffi';

import 'package:MyMovie/models/movie.dart';
import 'package:MyMovie/styles.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:MyMovie/service/service_API.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ScreenHomepage extends StatefulWidget {
  const ScreenHomepage({Key? key}) : super(key: key);

  @override
  State<ScreenHomepage> createState() => _ScreenHomepageState();
}

class _ScreenHomepageState extends State<ScreenHomepage>
    with SingleTickerProviderStateMixin {
  List<Movie> listmovie = [];
  @override
  void initState() {
    getListMovies();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  getListMovies() async {
    try {
      EasyLoading.show(
          status: 'loading...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black);

      var responseMovies = await CallApi.callApiInstance?.getMovies();

      if (responseMovies != null) {
        var a = responseMovies.results;
        for (var i = 0; i < a.length; i++) {
          setState(() {
            listmovie.add(Movie.fromJson(a[i].toJson()));
          });
        }
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError("Try Again [204]");
      }
    } catch (e) {
      EasyLoading.dismiss();
      if (e == 'offline') {
        EasyLoading.showError('Check your connection [90]');
        Navigator.pop(context);
      } else {
        EasyLoading.showError('Failed with Error [96]');
        // Navigator.pop(context);
      }
      return null;
    }
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.5.h,
          ),
          RefreshIndicator(
            onRefresh: () async {
              await getListMovies();
            },
            child: SizedBox(
              height: 90.h,
              child: buildGrid(),
            ),
          ),
        ],
      ),
    );
  }

  buildGrid() {
    if (listmovie.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/man-holding-note.gif",
              // width: 20.w,
              height: 40.h,
            ),
          ),
          Text(
            "Data tidak ditemukan.",
            style: fontMon.copyWith(
              fontSize: 25.sp,
              color: Colors.grey[400],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 14.sp),
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 57, 67, 67),
              shape: const StadiumBorder(),
            ),
            onPressed: () async => await getListMovies(),
            child: Text(
              "Coba lagi",
              style: fontMon.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    } else {
      return buidArtistScreen(context, listmovie);
    }
  }

  Widget buidArtistScreen(BuildContext context, List<Movie> movies) =>
      GridView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) => buildImageCard(index, movies[index]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
      );

  Widget buildImageCard(int index, Movie movie) => Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: GestureDetector(
          onTap: () {
            Get.toNamed("detail_list", parameters: {
              "title": movie.title,
              "overview": movie.overview,
              "backdrop": movie.backdrop,
              "voteAverage": movie.voteAverage.toString(),
              "releaseDate": movie.releaseDate.toString(),
              "genre": movie.genreIds.join("|")
            });
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(movie.poster),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        //padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    movie.title,
                    style: fontMon.copyWith(
                        fontSize: 10.sp, fontWeight: FontWeight.w600),
                  )),
                )
              ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _buildBody(),
    );
  }
}
