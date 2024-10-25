part of 'image_bloc.dart';

abstract class ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final List<ImageModel> images;
  ImageLoaded(this.images);
}

class ImageError extends ImageState {
  final String message;

  ImageError(this.message);
}

class ImageUploadSuccess extends ImageState {
  final String imageUrl;

  ImageUploadSuccess(this.imageUrl);
}

class ImageUploadFailure extends ImageState {}
