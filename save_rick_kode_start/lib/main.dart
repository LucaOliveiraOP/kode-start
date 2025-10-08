import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:save_rick_kode_start/models/character.dart';
import 'package:save_rick_kode_start/pages/details_page.dart';
import 'package:save_rick_kode_start/screens/home_page_screen.dart';
import 'package:save_rick_kode_start/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Restringe o aplicativo apenas ao modo retrato (vertical)
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

/// Configura as rotas usando GoRouter para navegação entre
/// a página inicial e a página de detalhes.
///
/// Rotas:
/// - '/' carrega a [HomePageScreen].
/// - '/details' carrega a [DetailsPage] com um [Character]
///   passado via o parâmetro 'extra'.
///
/// Utiliza [MaterialApp.router] para integrar o GoRouter
/// com a navegação do Flutter.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => SplashScreen()),
        GoRoute(
          path: '/home',
          name: HomePageScreen.routeId,
          builder: (context, state) => HomePageScreen(),
        ),
        GoRoute(
          path: '/details',
          name: DetailsPage.routeId,
          builder: (context, state) {
            final character = state.extra as Character;
            return DetailsPage(character: character);
          },
        ),
      ],
    );

    return BlocProvider(
      create: (_) => RickSceneBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          textTheme: ThemeData.dark().textTheme.apply(
            fontFamily: 'GetSchwifty',
          ),
          fontFamily: 'GetSchwifty',
        ),
      ),
    );
  }
}
