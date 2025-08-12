import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_bloc.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_state.dart';
import 'package:save_rick_kode_start/components/app_bar_component.dart';
import 'package:save_rick_kode_start/components/character_card.dart';
import 'package:save_rick_kode_start/components/loading_card.dart';
import 'package:save_rick_kode_start/components/rick_and_portals_animation.dart';
import 'package:save_rick_kode_start/theme/app_colors.dart';
import '../blocs/character_bloc/character_bloc.dart';
import '../blocs/character_bloc/character_event.dart';
import '../blocs/character_bloc/character_state.dart';
import 'details_page.dart';

/// Página inicial que exibe uma lista de personagens, e animações dos portais e do Rick.
///
/// Esta página utiliza o padrão BLoC para gerenciar o estado dos personagens,
/// exibindo um efeito de carregamento (shimmer) enquanto busca os dados e
/// suportando o gesto de "puxar para atualizar" (pull-to-refresh) para recarregar a lista.
///
/// Os personagens carregados são exibidos em uma lista rolável.
/// Ao tocar em um personagem, navega para a página de detalhes com uma transição suave.
///
/// Caso nenhum personagem seja carregado, uma mensagem informativa é exibida.
///
/// Também expõe um método privado para recarregar os personagens via BLoC.
class HomePage extends StatelessWidget {
  /// Construtor padrão.
  const HomePage({super.key});

  /// Dispara o evento de recarregamento de personagens no BLoC.
  ///
  /// Dispara o evento [LoadCharacters] para buscar novos dados.
  Future<void> _refreshCharacters(BuildContext context) async {
    context.read<CharacterBloc>().add(LoadCharacters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: appBarComponent(context),
      body: Stack(
        children: [
          BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state) {
              if (state is CharactersEmpty) {
                return Center(
                  child: Text(
                    'Nenhum personagem encontrado.',
                    style: TextStyle(color: AppColors.white, fontSize: 18),
                  ),
                );
              }
              if (state is CharactersLoading) {
                // Exibe cards de loading enquanto aguarda a resposta
                return ListView.builder(
                  itemCount: 3,
                  itemBuilder: (_, __) => const LoadingCard(),
                );
              }

              if (state is CharactersLoaded) {
                final characters = state.characters;

                // Lista rolável com pull-to-refresh ativado
                return RefreshIndicator(
                  onRefresh: () => _refreshCharacters(context),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
                      return CharacterCard(
                        character: character,
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                milliseconds: 300,
                              ),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      DetailsPage(character: character),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: Text("Não encontramos nenhum personagem."),
              );
            },
          ),

          // Animação dos portais Rick visível quando o estado é LockedInPortals
          BlocBuilder<RickSceneBloc, RickSceneState>(
            builder: (context, state) {
              final isVisible = state is LockedInPortals;

              return AnimatedOpacity(
                opacity: isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: RickPortalAnimation(),
              );
            },
          ),
        ],
      ),
    );
  }
}
