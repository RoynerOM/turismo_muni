import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_upala/core/storage/storage.dart';
import 'package:turismo_upala/features/experience/pages/experience_home_page.dart';
import 'package:turismo_upala/features/home/pages/home_page.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Index(),
      ),
    );
  }
}
