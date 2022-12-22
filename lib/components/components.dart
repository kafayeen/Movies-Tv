import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviesappokoul/cubit/cubit.dart';
import 'package:moviesappokoul/cubit/states.dart';
import 'package:moviesappokoul/models/nowplaying.dart';
import 'package:moviesappokoul/modules/details.dart';
import 'package:moviesappokoul/shared/constant.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmer({required int itemCount}) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 13,
        crossAxisSpacing: 5,
        childAspectRatio: 1 / 1.1,
        crossAxisCount: 2),
    itemBuilder: (context, index) => Shimmer.fromColors(
        child: SizedBox(
          height: 100,
          width: 100,
        ),
        baseColor: Colors.grey,
        highlightColor: Colors.white),
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: itemCount,
  );
}

Widget cardOfNewPlaying(BuildContext context, List<Widget> images, int index,
    NowPlaying nowPlaying, List<ResultOfPlaying> models) {
  return BlocConsumer<MoviesCubit, MoviesStates>(
    listener: (context, state) {},
    builder: (context, state) {
      var cubit = MoviesCubit.get(context);
      return Container(
        child: Column(
          children: [
            InkWell(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(5),
                        bottomStart: Radius.circular(5))),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: images[index]),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(
                              id: nowPlaying.result[index].id,
                              imagePoster: images[index],
                              adult: nowPlaying.result[index].adult,
                              name: nowPlaying.result[index].originalTitle,
                              overview: nowPlaying.result[index].overview,
                              stars: nowPlaying.result[index].vote,
                              originalLanguage: nowPlaying
                                  .result[index].originalLanguage
                                  .toUpperCase(),
                            )));
              },
            ),
            Expanded(
                child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          nowPlaying.result[index].originalTitle,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    InkWell(
                      onTap: () {
                        indexOfMovies.add(index);
                        cubit.changeFavorites(id: nowPlaying.result[index].id);
                      },
                      child: cubit.mapFavorites[nowPlaying.result[index].id]!
                          ? const Icon(
                              Icons.bookmark,
                              size: 35,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.bookmark_outline,
                              size: 35,
                              color: Colors.white,
                            ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                RatingBar.builder(
                  initialRating: nowPlaying.result[index].vote / 2,
                  minRating: nowPlaying.result[index].vote / 2,
                  maxRating: nowPlaying.result[index].vote / 2,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemSize: 20,
                  itemCount: 5,
                  unratedColor: Colors.white,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    nowPlaying.result[index].overview,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      );
    },
  );
}

Widget cardOfFavorite(BuildContext context, List<ResultOfPlaying> models,
    int index, NowPlaying nowPlaying) {
  return BlocConsumer<MoviesCubit, MoviesStates>(
    listener: (context, state) {},
    builder: (context, state) {
      var cubit = MoviesCubit.get(context);
      return Container(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(5),
                        bottomStart: Radius.circular(5))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl + models[index].poster,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(
                              id: nowPlaying.result[indexOfMovies[index]].id,
                              imagePoster:
                                  cubit.nowPlayingImage[indexOfMovies[index]],
                              adult:
                                  nowPlaying.result[indexOfMovies[index]].adult,
                              name: nowPlaying
                                  .result[indexOfMovies[index]].originalTitle,
                              overview: nowPlaying
                                  .result[indexOfMovies[index]].overview,
                              stars:
                                  nowPlaying.result[indexOfMovies[index]].vote,
                              originalLanguage: nowPlaying
                                  .result[indexOfMovies[index]].originalLanguage
                                  .toUpperCase(),
                            )));
              },
            ),
            Expanded(
                child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          models[index].originalTitle,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    InkWell(
                      onTap: () {
                        cubit.changeFavorites(id: models[index].id);
                      },
                      child: cubit.mapFavorites[models[index].id]!
                          ? const Icon(
                              Icons.bookmark,
                              size: 35,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.bookmark_outline,
                              size: 35,
                              color: Colors.white,
                            ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                RatingBar.builder(
                  initialRating: models[index].vote / 2,
                  minRating: models[index].vote / 2,
                  maxRating: models[index].vote / 2,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemSize: 20,
                  itemCount: 5,
                  unratedColor: Colors.white,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    models[index].overview,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      );
    },
  );
}
