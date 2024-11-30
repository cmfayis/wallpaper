part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperState {}

class WallpaperInitial extends WallpaperState {}

class WallpaperLoading extends WallpaperState {}

class WallpaperLoaded extends WallpaperState {
  final List<Photo> wallpapers;
  final int page;
  final int perPage;
  final bool isLoading;

  WallpaperLoaded({
    required this.wallpapers,
    required this.page,
    required this.perPage,
    this.isLoading = false,
  });

  WallpaperLoaded copyWith({
    List<Photo>? wallpapers,
    int? page,
    int? perPage,
    bool? isLoading,
  }) {
    return WallpaperLoaded(
      wallpapers: wallpapers ?? this.wallpapers,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class WallpaperError extends WallpaperState {
  final String message;

  WallpaperError(this.message);
}
