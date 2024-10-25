import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/features/image/models/image_model.dart';
import 'package:turismo_upala/features/image/repository/image_repository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository repository;

  ImageBloc(this.repository) : super(ImageLoading()) {
    on<LoadImages>((event, emit) async {
      emit(ImageLoading());
      try {
        final images = await repository.fetchImages();
        emit(ImageLoaded(images));
      } catch (e) {
        emit(ImageError('Error al cargar las imágenes'));
      }
    });

    on<UploadImage>((event, emit) async {
      emit(ImageLoading());
      try {
        final imageUrl =
            await repository.uploadImage(event.imagePath, event.footer);
        emit(ImageUploadSuccess(imageUrl));
        final images = await repository.fetchImages();
        emit(ImageLoaded(images));
      } catch (e) {
        emit(ImageUploadFailure());
      }
    });
  }
}
