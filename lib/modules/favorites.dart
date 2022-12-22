import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesappokoul/components/components.dart';
import 'package:moviesappokoul/cubit/cubit.dart';
import 'package:moviesappokoul/cubit/states.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No. of Favorites: ${cubit.nowFavorites.length}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: cubit.nowFavorites.isNotEmpty,
                  fallback: (context) => Center(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Empty",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.bookmark_border,
                            size: 28,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  builder: (context) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 13,
                            crossAxisSpacing: 5,
                            childAspectRatio: 1 / 1.45,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => cardOfFavorite(context,
                        cubit.nowFavorites, index, cubit.nowPlayingModel!),
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.nowFavorites.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
