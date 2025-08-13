import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_rick_kode_start/blocs/character_bloc/character_bloc.dart';
import 'package:save_rick_kode_start/blocs/character_bloc/character_event.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_bloc.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_event.dart';
import 'package:save_rick_kode_start/theme/app_colors.dart';

/// Um botão de ícone de busca que alterna entre o ícone de busca
/// e um campo de texto para realizar pesquisas.
///
/// Ao ativar a busca, o campo de texto é exibido, permitindo que o
/// usuário digite um termo de pesquisa. Conforme o texto muda,
/// eventos são disparados para o BLoC. Ao encerrar a busca,
/// a lista completa de personagens é recarregada.
class SearchIconButton extends StatefulWidget {
  const SearchIconButton({super.key});

  @override
  State<SearchIconButton> createState() => _SearchIconButtonState();
}

class _SearchIconButtonState extends State<SearchIconButton> {
  // Define se o usuário está no modo de busca ou não
  bool _isSearching = false;

  // Controlador do campo de texto
  final TextEditingController _controller = TextEditingController();

  /// Ativa o modo de busca e exibe o campo de texto
  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  /// Encerra o modo de busca, limpa o campo e recarrega os personagens
  void _stopSearch() {
    setState(() {
      _isSearching = false;
    });
    context.read<CharacterBloc>().add(ClearSearch());
  }

  /// Atualiza a busca conforme o texto muda
  void _onSearchChanged(String value) {
    // Dispara o evento para o CharacterBloc com o texto da busca
    context.read<CharacterBloc>().add(SearchCharacters(value));

    // Caso contenha "evil morty", dispara um evento especial no RickSceneBloc
    if (value.toLowerCase().contains("evil morty")) {
      context.read<RickSceneBloc>().add(SpeakEvilMortyRunningAway());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Se estiver buscando, mostra o campo de texto com botão de fechar
    return _isSearching
        ? Row(
            children: [
              // Campo de texto estilizado
              Container(
                height: 36,
                width: 260,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: TextField(
                    controller: _controller,
                    onChanged: _onSearchChanged,
                    autofocus: true,
                    style: TextStyle(color: AppColors.black),
                    decoration: const InputDecoration(
                      hintText: 'Buscar...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Botão para encerrar a busca
              IconButton(
                icon: Icon(Icons.close, color: AppColors.white),
                onPressed: _stopSearch,
              ),
            ],
          )
        :
          // Se não estiver buscando, mostra apenas o ícone de busca
          IconButton(
            icon: Icon(Icons.search, color: AppColors.white),
            onPressed: () {
              _startSearch();
              context.read<RickSceneBloc>().add(RickSpeakAboutEvilMorty());
            },
          );
  }
}
