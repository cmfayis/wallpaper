import 'dart:convert';
import 'package:wallpaper_app/feature/data/model/photos_model.dart';
import 'package:wallpaper_app/feature/domain/repository/photo_repo.dart';
import 'package:http/http.dart' as http;

class PhotoRepositoryImpl implements PhotoRepository {
  final String baseUrl = 'https://api.pexels.com/v1/curated';
  final String apiKey =
      '563492ad6f91700001000001fead046b5c28412cb20719b61dd8fbbf';

  @override
  Future<List<PhotosModel>> getPhotos(int page, int perPage) async {
    final response = await http.get(
      Uri.parse('$baseUrl?page=$page&per_page=$perPage'),
      headers: {'Authorization': apiKey},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List photos = data['photos'] as List;

      List<PhotosModel> photoModels = photos.map((photoJson) {
        return PhotosModel.fromJson(photoJson as Map<String, dynamic>);
      }).toList();

      return photoModels;
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
