import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesappokoul/cubit/states.dart';
import 'package:moviesappokoul/models/budget.dart';
import 'package:moviesappokoul/models/favoritesmodel.dart';
import 'package:moviesappokoul/models/nowplaying.dart';
import 'package:moviesappokoul/models/popularmodel.dart';
import 'package:moviesappokoul/models/upcomingmodel.dart';
import 'package:moviesappokoul/modules/details.dart';
import 'package:moviesappokoul/modules/favorites.dart';
import 'package:moviesappokoul/modules/main.dart';
import 'package:moviesappokoul/modules/toprated.dart';
import 'package:moviesappokoul/shared/constant.dart';
import 'package:moviesappokoul/shared/network/remote.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitialState());
  static MoviesCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [const New(), const TopRated(), const Favorites()];
  List<String> appBar = ["Movies App", "Top Rated", "Favorites"];
  void changeIndex(int v) {
    currentIndex = v;
    emit(MoviesChangeState());
  }

  List<Widget> trendingImage = [];
  PopularModel? popularModel;
  void getPopular() {
    DioHelper.getFuture(path: popular).then((value) {
      popularModel = PopularModel.fromJson(value.data);
      popularModel!.result.forEach((e) {
        trendingImage.add(Image.network(
          imageUrl + e.poster,
          fit: BoxFit.fill,
          height: 200,
          width: double.infinity,
        ));
      });
      emit(MoviesGetPopularSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(MoviesGetPopularErrorState());
    });
  }

  List<Widget> upcomingImage = [];
  UpcomingModel? upcomingModel;
  void getUpcoming() {
    DioHelper.getFuture(path: popular).then((value) {
      upcomingModel = UpcomingModel.fromJson(value.data);
      upcomingModel!.result.forEach((e) {
        upcomingImage.add(Image.network(
          imageUrl + e.poster,
          fit: BoxFit.fill,
          height: 200,
          width: double.infinity,
        ));
      });
      emit(MoviesGetUpcomingSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(MoviesGetUpcomingErrorState());
    });
  }

  List<Widget> nowPlayingImage = [];
  NowPlaying? nowPlayingModel;
  Map<int, bool> mapFavorites = {};
  List<ResultOfPlaying> nowFavorites = [];
  int? index;
  void changeFavorites({required int id}) {
    mapFavorites[id] = !mapFavorites[id]!;
    emit(MoviesChaneQuickFavoritesSuccessState());
    index = nowFavorites.indexWhere((element) => id == element.id);
    print(index);
    if (index! >= 0) {
      nowFavorites.removeAt(index!);
    } else {
      nowFavorites.add(
          nowPlayingModel!.result.firstWhere((element) => element.id == id));
    }

    emit(MoviesChaneFavoritesSuccessState());
  }

  void getNowPlaying() {
    DioHelper.getFuture(path: popular).then((value) {
      nowPlayingModel = NowPlaying.fromJson(value.data);
      nowPlayingModel!.result.forEach((e) {
        if (!mapFavorites.containsKey(e.id)) {
          mapFavorites.addAll({e.id: false});
          print(mapFavorites);
        }

        nowPlayingImage.add(Image.network(
          imageUrl + e.poster,
          fit: BoxFit.fill,
          height: 150,
          width: double.infinity,
        ));
      });
      emit(MoviesGetNowSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(MoviesGetNowErrorState());
    });
  }

  Budget? budget;
  void getBudget({required String id}) {
    DioHelper.getFuture(path: id).then((value) {
      budget = Budget.fromJson(value.data);
      emit(MoviesGetBudgetSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(MoviesGetBudgetErrorState());
    });
  }
}
