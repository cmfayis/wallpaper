import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_app/feature/presentation/bloc/bloc/wallpaper_bloc.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    context.read<WallpaperBloc>().add(FetchWallpapers(perPage: 10));

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final currentState = context.read<WallpaperBloc>().state;

        if (currentState is WallpaperLoaded && !currentState.isLoading) {
          context.read<WallpaperBloc>().add(FetchWallpapers(
                page: currentState.page + 1,
                perPage: 15,
              ));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // void save(String url) async {
    //   var status = await Permission.storage.request();
    //   if (status.isGranted) {
    //     var response = await Dio()
    //         .patch(url, options: Options(responseType: ResponseType.bytes));
    //     final result = await ImageGallerySaver.saveImage(
    //         Uint8List.fromList(response.data));
    //   }
    // }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 120,
        title: const Text('Dynamic Wallpapers'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Column(
          children: [
            const Center(
              child: Text(
                'All Wallpapers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: BlocBuilder<WallpaperBloc, WallpaperState>(
                builder: (context, state) {
                  if (state is WallpaperLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WallpaperLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MasonryGridView.builder(
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: state.wallpapers.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          final image = state.wallpapers[index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    // save(image.src.large);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      image.src.large,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(image.photographer),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is WallpaperError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(
                        child: Text('No wallpapers available.'));
                  }
                },
              ),
            ),
            BlocBuilder<WallpaperBloc, WallpaperState>(
              builder: (context, state) {
                if (state is WallpaperLoaded && state.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
