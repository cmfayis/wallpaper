part of 'wallpaper_bloc.dart';

@immutable
sealed class WallpaperEvent {}

class FetchWallpapers extends WallpaperEvent {
  final int page;
  final int perPage;

  FetchWallpapers({this.page = 1, required this.perPage});
}
