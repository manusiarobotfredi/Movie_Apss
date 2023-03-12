import 'dart:convert';
import 'dart:developer';

import 'package:MyMovie/models/ResponseGenre.dart';
import 'package:MyMovie/models/responseMovies.dart';

import 'package:dio/dio.dart';
import 'package:alice/alice.dart';

import 'package:flutter/foundation.dart';

class CallApi {
  static CallApi? callApiInstance;
  static late Dio _dio;
  static String buildNumber = '';
  static String version = '';
  CallApi();

  static const _baseUrl = "https://api.themoviedb.org";
  factory CallApi.initialize(Alice alice) {
    if (callApiInstance == null) {
      callApiInstance = CallApi();
      Future.delayed(const Duration(seconds: 3), () {
        _dio = Dio();
        _dio.options.baseUrl = _baseUrl;
        _dio.options.connectTimeout = 30000;
        _dio.options.receiveTimeout = 30000;
        _dio.options.contentType = 'application/json';
        _dio.interceptors.add(alice.getDioInterceptor());

        _dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              if (kDebugMode) {
                log(
                  'onRequest : ${options.uri}\nheaders: ${options.headers}',
                );
              }
              handler.next(options);
            },
            onResponse: (response, ResponseInterceptorHandler handler) async {
              if (kDebugMode) {
                final prettyResponse =
                    const JsonEncoder.withIndent('  ').convert(response.data);
                log(
                  'onResponse ${response.statusCode} : ${response.requestOptions.uri}\n result: $prettyResponse',
                );
              }
              handler.next(response);
            },
          ),
        );
        return callApiInstance!;
      });
    }
    return callApiInstance!;
  }

  Future<ResponseMovie?> getMovies() async {
    try {
      // if (await CheckPhone().internetConnectivity() == false) {
      //   throw "offline";
      // }

      var response = await _dio.get(
          '/3/movie/popular?api_key=79aa709bee597100a4ce1190ae390b6a&language=en-US&page=1');

      return ResponseMovie.fromJson(response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw ("timeout");
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<ResponseGenre?> getGenres() async {
    try {
      // if (await CheckPhone().internetConnectivity() == false) {
      //   throw "offline";
      // }

      var response = await _dio.get(
          '/3/genre/movie/list?api_key=79aa709bee597100a4ce1190ae390b6a&language=en-US');

      return ResponseGenre.fromJson(response.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw ("timeout");
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
