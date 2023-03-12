import 'package:MyMovie/models/genre.dart';
import 'package:MyMovie/models/responseGenre.dart';
import 'package:MyMovie/service/service_API.dart';
import 'package:MyMovie/widget/starsRating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:MyMovie/screen/screen_main.dart';
import 'package:MyMovie/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class ScreenDetailList extends StatefulWidget {
  const ScreenDetailList({Key? key}) : super(key: key);

  @override
  State<ScreenDetailList> createState() => _ScreenDetailListState();
}

class _ScreenDetailListState extends State<ScreenDetailList> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final overview = Get.parameters["overview"];
  final title = Get.parameters["title"];
  final backdrop = Get.parameters["backdrop"];
  final voteAverage = Get.parameters["voteAverage"];
  final releaseDate = Get.parameters["releaseDate"];
  final genreMovie = Get.parameters["genre"];
  final controllerNotes = TextEditingController();

  var showScroll = true;
  var backscreen = true;
  List<GenreElement> listGenre = [];

  @override
  void initState() {
    getListGenre();
    super.initState();
  }

  @override
  void dispose() {
    controllerNotes.dispose();
    super.dispose();
  }

  getListGenre() async {
    try {
      EasyLoading.show(
          status: 'loading...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black);

      var responseGenre = await CallApi.callApiInstance?.getGenres();

      if (responseGenre != null) {
        var _genre = genreMovie!.split('|');
        var a = responseGenre.genres;
        for (var i = 0; i < a.length; i++) {
          for (var ii = 0; ii < _genre.length; ii++) {
            if (a[i].id.toString() == _genre[ii].toString()) {
              setState(() {
                listGenre.add(GenreElement.fromJson(a[i].toJson()));
              });
            }
          }
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

  List<Widget> _buildCategoryChips() {
    return listGenre.map((genre) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(
            genre.name.toString(),
            style: fontMon.copyWith(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        subMenu: true,
        backScreen: backscreen,
        title: title.toString(),
        body: SizedBox(
          height: 90.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(backdrop!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 60.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toString(),
                        style: fontMon.copyWith(
                            fontSize: 25.sp, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: _buildCategoryChips(),
                      ),
                      const Spacer(),
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      Text(
                        "Overview Movies",
                        style: fontMon.copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 25.h,
                        child: SingleChildScrollView(
                          child: Text(
                            overview.toString(),
                            style: fontMon.copyWith(
                                fontSize: 16.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Text(
                            "Rating : ",
                            style: fontMon.copyWith(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          StarRating(
                            rating: double.parse(voteAverage!) / 2,
                            onRatingChanged: (rating) => null,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Release Date : ${formatter.format(DateTime.parse(releaseDate.toString()))}",
                        style: fontMon.copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
