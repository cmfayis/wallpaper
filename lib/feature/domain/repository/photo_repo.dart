import 'package:wallpaper_app/feature/domain/entity/photos.dart';

abstract class PhotoRepository {
  Future<List<Photo>> getPhotos(int page, int perPage);
}
