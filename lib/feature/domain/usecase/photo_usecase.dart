
import 'package:wallpaper_app/feature/domain/entity/photos.dart';
import 'package:wallpaper_app/feature/domain/repository/photo_repo.dart';

class GetPhotos {
  final PhotoRepository repository;

  GetPhotos(this.repository);

  Future<List<Photo>> execute(int page, int perPage) {
    return repository.getPhotos(page,perPage);
  }
}
