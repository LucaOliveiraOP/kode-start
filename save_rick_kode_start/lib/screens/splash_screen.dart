import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_bloc.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_event.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_state.dart';
import 'package:save_rick_kode_start/theme/app_colors.dart';
import 'package:save_rick_kode_start/controllers/rick_audio_controller.dart';
import 'package:save_rick_kode_start/theme/app_images.dart';

/// Tela de splash responsável por exibir a logo e uma mensagem inicial.
/// Também inicia o BLoC responsável pelos áudios e mostra um alerta sobre o som.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String dialogText =
      "SÓ um lembrete, é necessário estar com o som alto para uma melhor experiência de usuário!";

  final RickAudioController _audioController = RickAudioController();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () {
      _showWelcomeDialog();
    });
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "AVISO!",
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.volume_up, color: Colors.green),
              ],
            ),
          ),
          content: Text(
            dialogText,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/home');
                context.read<RickSceneBloc>().add(PlayLockedInPortals());

                log('123');
              },
              child: const Text(
                "OK",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RickSceneBloc()..add(PlayRequiredSound()),
      child: BlocListener<RickSceneBloc, RickSceneState>(
        listener: (context, state) {
          if (state is RickSpeaking) {
            _audioController.play(state.message);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.logorick,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              const Text(
                'KODE START #3 EDITION',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
