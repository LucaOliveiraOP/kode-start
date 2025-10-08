import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:save_rick_kode_start/theme/app_colors.dart';

/// Um cartão placeholders de carregamento com efeito shimmer.
///
/// Este widget imita o layout de um cartão de personagem com dois blocos shimmer:
/// um bloco maior representando um placeholder de imagem,
/// e um bloco menor representando um placeholder de texto.
///
/// A animação shimmer usa tons de cinza mais escuros para indicar o estado de carregamento.
///
/// Uso:
/// Geralmente utilizado como placeholder enquanto os dados dos personagens estão sendo buscados.
class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey[700]!;
    final highlightColor = Colors.grey[500]!;

    return Card(
      color: AppColors.backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            period: const Duration(milliseconds: 1500),
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            period: const Duration(milliseconds: 1500),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(6),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Container(width: 150, height: 16, color: baseColor),
            ),
          ),
        ],
      ),
    );
  }
}
