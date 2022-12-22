import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviesappokoul/cubit/cubit.dart';
import 'package:moviesappokoul/cubit/states.dart';
import 'package:moviesappokoul/models/nowplaying.dart';
import 'package:moviesappokoul/modules/details.dart';

class TopRated extends StatelessWidget {
  const TopRated({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
        builder: (context, state) {
          var cubit = MoviesCubit.get(context);
          return ListView.separated(
            itemCount: 10,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            itemBuilder: (context, index) => cardOfCatogries(
                context, index, cubit.nowPlayingImage, cubit.nowPlayingModel!),
          );
        },
        listener: (context, state) {});
  }

  Widget cardOfCatogries(
      BuildContext context, int index, List<Widget> images, NowPlaying model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Details(
                        id: model.result[index].id,
                        imagePoster: images[index],
                        adult: model.result[index].adult,
                        name: model.result[index].originalTitle,
                        overview: model.result[index].overview,
                        stars: model.result[index].vote,
                        originalLanguage:
                            model.result[index].originalLanguage.toUpperCase(),
                      )));
        },
        child: Row(
          children: [
            Container(
                // clipBehavior: Clip.antiAlias,
                height: 120,
                width: 100,
                child: images[index]),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    model.result[index].originalTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${model.result[index].vote / 2} / 5",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      RatingBar.builder(
                        initialRating: 1,
                        maxRating: 1,
                        minRating: 1,
                        allowHalfRating: true,
                        itemSize: 22,
                        itemCount: 1,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
//
  }
}
