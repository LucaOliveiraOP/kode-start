import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_bloc.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_state.dart';
import 'package:save_rick_kode_start/components/search_icon_button.dart';
import 'package:save_rick_kode_start/theme/app_colors.dart';
import 'package:save_rick_kode_start/theme/app_images.dart';

/// Cria um [AppBar] customizado para o aplicativo.
///
/// Este [AppBar] possui:
/// - Altura aumentada (aproximadamente 2.2 vezes a altura padrão).
/// - Fundo com cor definida em [AppColors.appBarColor].
/// - Ícone à esquerda que varia conforme a página:
///   - Na página principal, exibe um ícone de portal clicável.
///   - Na segunda página, exibe um botão de voltar.
/// - Logo principal centralizado na parte superior.
/// - Ícone do Rick centralizado horizontalmente.
/// - Botão de busca no canto superior direito (apenas na página principal).
/// - Ícone de portal exibido pelo estado [LockedInPortals] do [RickSceneBloc].
///
/// Parâmetros:
/// - [context]: contexto de build para navegação e acesso ao BLoC.
/// - [isSecondPage]: indica se a barra está em uma segunda página (padrão: false).
///
/// Retorna:
/// - Um widget [PreferredSizeWidget] configurado conforme descrito.
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
                    isSecondPage
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppColors.white,
                            ),
                            iconSize: 24,
                            onPressed: () => Navigator.pop(context),
                          )
                        : IconButton(
                            icon: Image.asset(
                              AppImages.portal,
                              width: 48,
                              height: 48,
                            ),
                            iconSize: 48,
                            constraints: const BoxConstraints(
                              minWidth: 48,
                              minHeight: 48,
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                          ),

                    const Spacer(),
                    SvgPicture.asset(AppImages.logorick, height: 40),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!isSecondPage) SearchIconButton(),
                      BlocBuilder<RickSceneBloc, RickSceneState>(
                        builder: (context, state) {
                          if (state is LockedInPortals) {
                            return SizedBox(
                              width: 48,
                              height: 48,
                              child: Image.asset(AppImages.portal, width: 75),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
