import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_rick_kode_start/components/search_bar.dart';
import 'package:save_rick_kode_start/theme/app_colors.dart';
import 'package:save_rick_kode_start/theme/app_images.dart';

/// Cria um widget personalizado [AppBar] para o app.
///
/// Parâmetros:
/// - [context]: BuildContext para navegação e tema.
/// - [isSecondPage] (opcional): Se verdadeiro, exibe um botão de voltar; caso contrário, um menu. Padrão: false.
///
/// O app bar inclui:
/// - Ícone principal (voltar ou menu dependendo de [isSecondPage]).
/// - Espaço flexível contendo as logos.
/// - Altura do toolbar maior que o padrão para destaque visual.
PreferredSizeWidget appBarComponent(
  BuildContext context, {
  bool isSecondPage = false,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight * 2.2,
    backgroundColor: AppColors.appBarColor,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    flexibleSpace: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.logo, height: 75),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        isSecondPage ? Icons.arrow_back : Icons.menu,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        if (!isSecondPage) return;
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    SvgPicture.asset(AppImages.logorick, height: 40),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
                const Positioned(right: 0, top: 0, child: SearchIconButton()),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
