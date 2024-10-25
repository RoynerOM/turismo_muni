part of 'image_bloc.dart';

abstract class ImageEvent {}

class LoadImages extends ImageEvent {}

class UploadImage extends ImageEvent {
  final String imagePath;
  final String footer;

  UploadImage(this.imagePath, this.footer);
}
