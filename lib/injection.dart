import 'package:get_it/get_it.dart';
import 'package:turismo_upala/features/attraction/bloc/attraction_bloc.dart';
import 'package:turismo_upala/features/image/bloc/image_bloc.dart';
import 'package:turismo_upala/features/image/repository/image_repository.dart';
import 'package:turismo_upala/features/lodge/bloc/lodge_bloc.dart';

final sl = GetIt.instance;

Future<void> injection() async {
  sl.registerSingleton<ImageRepository>(ImageRepository());
  sl.registerFactory<ImageBloc>(() => ImageBloc(sl()));
  sl.registerFactory<LodgeBloc>(() => LodgeBloc());
  sl.registerFactory<AttractionBloc>(() => AttractionBloc());
}
