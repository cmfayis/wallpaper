

import 'package:wallpaper_app/feature/data/model/src_model.dart';
import 'package:wallpaper_app/feature/domain/entity/photos.dart';
import 'package:wallpaper_app/feature/domain/entity/src.dart';

class PhotosModel extends Photo {
  PhotosModel({
    required int id,
    required int width,
    required int height,
    required String url,
    required String photographer,
    required String photographerUrl,
    required int photographerId,
    required String avgColor,
    required Src src,
    required bool liked,
    required String alt,
  }) : super(
          id: id,
          width: width,
          height: height,
          url: url,
          photographer: photographer,
          photographerUrl: photographerUrl,
          photographerId: photographerId,
          avgColor: avgColor,
          src: src,
          liked: liked,
          alt: alt,
        );

  factory PhotosModel.fromJson(Map<String, dynamic> json) {
    return PhotosModel(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
      photographerId: json['photographer_id'],
      avgColor: json['avg_color'],
      src: SrcModel.fromJson(json['src']),  
      liked: json['liked'],
      alt: json['alt'] ?? "", 
    );
  }
}
