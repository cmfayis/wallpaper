import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/feature/data/repository/photo_repo_impl.dart';
import 'package:wallpaper_app/feature/domain/usecase/photo_usecase.dart';
import 'package:wallpaper_app/feature/presentation/bloc/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/feature/presentation/wallpaper_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperBloc(GetPhotos(PhotoRepositoryImpl())),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WallpaperScreen(),
      ),
    );
  }
}
