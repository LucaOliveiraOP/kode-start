import 'package:flutter/material.dart';
import 'package:save_rick_kode_start/components/app_bar_component.dart';
import 'package:save_rick_kode_start/theme/app_colors.dart';
import '../models/character.dart';

/// Página de detalhes que exibe informações detalhadas sobre um personagem específico.
///
/// Mostra a imagem do personagem com animação Hero,
/// o nome em destaque e outros detalhes como status, espécie,
/// tipo, gênero, origem, localização atual e número de episódios.
///
/// Esta página espera receber um objeto [Character] no construtor.
///
/// A AppBar é personalizada como uma página secundária com botão de voltar.
class DetailsPage extends StatelessWidget {
  /// Identificador de rota usado para navegação.
  static const routeId = 'details';

  /// O personagem cujos detalhes serão exibidos nesta página.
  final Character character;

  /// Cria a página de detalhes para o [character] fornecido.
  const DetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

      // AppBar com botão de voltar
      appBar: appBarComponent(context, isSecondPage: true),

      // Conteúdo rolável com padding
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: 'character-image-${character.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                character.image,
                height: 300,
                width: 200,
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.4),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Nome do personagem
          Center(
            child: Text(
              character.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),

          // Informações do personagem
          StatusInfoText(status: character.status),
          InfoText(label: "Espécie", value: character.species),
          InfoText(label: "Gênero", value: character.gender),
          InfoText(label: "Origem", value: character.originName),
          InfoText(label: "Localização Atual", value: character.locationName),
          InfoText(
            label: "Episódios",
            value: character.episode.isNotEmpty
                ? "Episódio ${character.episode.first.split('/').last}"
                : "Desconhecido",
          ),
        ],
      ),
    );
  }
}

/// Widget reutilizável para exibir uma linha de informação com rótulo e valor.
///
/// Exibe um rótulo seguido de um valor, ambos estilizados em branco.
class InfoText extends StatelessWidget {
  /// Rótulo da informação (ex: "Espécie").
  final String label;

  /// Valor da informação (ex: "Humano").
  final String value;

  /// Cria um widget [InfoText] com um [label] e [value].
  const InfoText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

/// Widget que exibe o status com um ícone de círculo colorido ao lado.
///
/// - Verde para `"Alive"`
/// - Vermelho para `"Dead"`
/// - Cinza para qualquer outro status (ex: `"unknown"`)
class StatusInfoText extends StatelessWidget {
  /// Status atual do personagem (ex: "Alive", "Dead").
  final String status;

  /// Cria um [StatusInfoText] com o [status] fornecido.
  const StatusInfoText({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color iconColor;

    switch (status.toLowerCase()) {
      case 'alive':
        iconColor = Colors.green;
        break;
      case 'dead':
        iconColor = Colors.red;
        break;
      default:
        iconColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Text(
            'Status: ',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Icon(Icons.circle, color: iconColor, size: 14),
          const SizedBox(width: 6),
          Text(
            status,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
