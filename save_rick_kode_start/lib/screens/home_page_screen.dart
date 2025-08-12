import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_rick_kode_start/blocs/character_bloc/character_bloc.dart';
import 'package:save_rick_kode_start/blocs/character_bloc/character_event.dart';
import 'package:save_rick_kode_start/data/repository.dart';
import 'package:save_rick_kode_start/pages/home_page.dart';

/// Widget responsável por fornecer o [CharacterBloc]
/// e injetar a dependência do [CharacterRepository].
///
/// Este widget geralmente funciona como ponto de entrada para a home (tela inicial),
/// lidando com a inicialização do BLoC e disparando o evento inicial [LoadCharacters].
///
/// Ele envolve o widget [HomePage], que contém a interface gráfica da aplicação.
class HomePageScreen extends StatelessWidget {
  /// Identificador de rota usado pelo GoRouter ou Navigator.
  static const routeId = '/home';

  /// Instância do repositório responsável por buscar os dados dos personagens.
  ///
  /// É usada internamente para fornecer a dependência ao [CharacterBloc].
  final CharacterRepository repository = CharacterRepository();

  /// Cria um widget [HomePageScreen].
  ///
  /// Este construtor inicializa o repositório e configura o
  /// provedor do BLoC com o evento inicial [LoadCharacters].
  HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CharacterBloc(repository: repository)..add(LoadCharacters()),
      child: const HomePage(),
    );
  }
}
