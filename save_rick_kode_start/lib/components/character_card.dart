import 'package:flutter/material.dart';
import 'package:save_rick_kode_start/models/character.dart';
import 'package:save_rick_kode_start/theme/app_colors.dart';

/// Um widget de cartão que exibe a imagem e o nome de um personagem.
///
/// Exibe a imagem do personagem com uma animação [Hero] para transições suaves.
/// O nome do personagem é exibido abaixo da imagem em letras maiúsculas sobre um fundo colorido.
///
/// O cartão é clicável e aciona o callback [onTap] quando pressionado.
///
/// Parâmetros:
/// - [character]: Os dados do personagem a ser exibido.
/// - [onTap]: Função callback executada quando o cartão é tocado.
class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'character-image-${character.id}',
                child: Image.network(
                  character.image,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.7),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF82E6EB), Color(0xFF567BCC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    character.name.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
