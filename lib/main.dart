import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/core/storage/storage.dart';
import 'package:turismo_upala/features/attraction/bloc/attraction_bloc.dart';
import 'package:turismo_upala/features/lodge/bloc/lodge_bloc.dart';
import 'package:turismo_upala/features/image/bloc/image_bloc.dart';
import 'package:turismo_upala/features/index.dart';
import 'package:turismo_upala/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    injection(),
    Storage().init(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageBloc>(
          create: (context) => sl()..add(LoadImages()),
        ),
        BlocProvider<LodgeBloc>(
          create: (context) => sl()..add(LoadLodgeEvent()),
        ),
        BlocProvider<AttractionBloc>(
          create: (context) => sl()..add(LoadAttractionEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const Index(),
      ),
    );
  }
}
