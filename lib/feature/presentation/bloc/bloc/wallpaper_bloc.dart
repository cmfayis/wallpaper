import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/feature/domain/entity/photos.dart';
import 'package:wallpaper_app/feature/domain/usecase/photo_usecase.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  final GetPhotos getPhotos;

  WallpaperBloc(this.getPhotos) : super(WallpaperInitial()) {
    on<FetchWallpapers>(_onFetchWallpapers);
  }

  Future<void> _onFetchWallpapers(
      FetchWallpapers event, Emitter<WallpaperState> emit) async {
    try {
      final currentState = state;
      List<Photo> wallpapers = [];
      int page = event.page ?? 1;

      if (currentState is WallpaperLoaded) {
        wallpapers = List.from(currentState.wallpapers);
        page = currentState.page + 1;
        emit(currentState.copyWith(isLoading: true));
      } else {
        emit(WallpaperLoading());
      }

      final newWallpapers = await getPhotos.execute(page, event.perPage);
      wallpapers.addAll(newWallpapers);

      emit(WallpaperLoaded(
        wallpapers: wallpapers,
        page: page,
        perPage: event.perPage,
        isLoading: false,
      ));
    } catch (error) {
      emit(WallpaperError(error.toString()));
    }
  }
}
