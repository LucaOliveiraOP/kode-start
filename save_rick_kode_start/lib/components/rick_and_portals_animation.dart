import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_bloc.dart';
import 'package:save_rick_kode_start/blocs/rick_scene_bloc/rick_scene_event.dart';
import 'package:save_rick_kode_start/theme/app_images.dart';

/// Widget de animação do portal do Rick.
///
/// Exibe duas animações de portais (esquerdo e direito) e o Rick animado
/// atravessando da esquerda para a direita com rotações.
/// - O portal esquerdo abre e fecha com uma animação suave.
/// - Quando o Rick alcança aproximadamente 65% do caminho,
///   o portal direito se abre e fecha.
/// - Quando Rick chega a 90% da animação, ele desaparece.
/// - A animação reinicia automaticamente após a conclusão.
///
/// O Rick pode ser tocado, disparando o evento [HelpedPickleRick]
/// no [RickSceneBloc], que pode disparar ações como sons ou transições.
///
/// A posição vertical dos portais é sorteada aleatoriamente entre 250 e 800
/// para variação visual.
///
/// Utiliza [TickerProviderStateMixin] para controlar animações.
class RickPortalAnimation extends StatefulWidget {
  const RickPortalAnimation({super.key});

  @override
  State<RickPortalAnimation> createState() => _RickPortalAnimationState();
}

class _RickPortalAnimationState extends State<RickPortalAnimation>
    with TickerProviderStateMixin {
  // Controladores e animações para Rick e portais
  late final AnimationController _rickController;
  late final Animation<double> _rickAnimation;

  late final AnimationController _leftPortalController;
  late final Animation<double> _leftPortalOpen;

  late final AnimationController _rightPortalController;
  late final Animation<double> _rightPortalOpen;

  static const _animationDuration = Duration(seconds: 4);

  final double portalPadding = 10;
  final double rickSize = 40;

  bool _rightPortalOpened = false;
  bool _rickVisible = true;

  // Posição vertical dinâmica dos portais
  double _portalTop = 100;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _initPortals();
    _initRickAnimation();
    _startAnimations();
  }

  /// Inicializa animações dos portais esquerdo e direito.
  void _initPortals() {
    _leftPortalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _leftPortalOpen = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _leftPortalController, curve: Curves.easeIn),
    );

    _rightPortalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _rightPortalOpen = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _rightPortalController, curve: Curves.easeOut),
    );
  }

  /// Inicializa a animação do Rick com duração fixa e
  /// controla quando abrir o portal direito e esconder Rick.
  void _initRickAnimation() {
    _rickController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _rickAnimation = CurvedAnimation(
      parent: _rickController,
      curve: Curves.linear,
    );

    _rickController.addListener(() {
      if (_rickController.value > 0.65 && !_rightPortalOpened) {
        _rightPortalOpened = true;
        _openRightPortal();
      }

      if (_rickController.value > 0.9 && _rickVisible) {
        setState(() {
          _rickVisible = false;
        });
      }
    });
  }

  /// Inicia e controla a sequência de animações para os portais e Rick,
  /// reiniciando o ciclo continuamente.
  Future<void> _startAnimations() async {
    _rightPortalOpened = false;

    // Define posição vertical aleatória para os portais
    _portalTop = 250 + _random.nextDouble() * (800 - 160);

    // Abre o portal esquerdo e após 300ms inicia animação do Rick
    _leftPortalController.forward();
    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      setState(() {
        _rickVisible = true;
      });
      _rickController.forward();
    });

    // Fecha o portal esquerdo após 2 segundos
    await Future.delayed(const Duration(seconds: 2));
    await _leftPortalController.reverse();

    // Aguarda Rick chegar a 90% da animação para desaparecer
    await Future.delayed(_animationDuration * 0.9);

    if (_rightPortalOpened) {
      // Mantém o portal direito aberto por 2.8 segundos (2s + 800ms)
      await Future.delayed(
        const Duration(seconds: 2) + const Duration(milliseconds: 800),
      );
    }

    await Future.delayed(const Duration(milliseconds: 500));

    // Reseta animações para novo ciclo
    _rickController.reset();
    _leftPortalController.reset();
    _rightPortalController.reset();

    setState(() {});

    // Reinicia animações continuamente
    _startAnimations();
  }

  /// Abre e fecha o portal direito com animação.
  Future<void> _openRightPortal() async {
    await _rightPortalController.forward();
    await Future.delayed(const Duration(seconds: 2));
    await _rightPortalController.reverse();
  }

  @override
  void dispose() {
    _rickController.dispose();
    _leftPortalController.dispose();
    _rightPortalController.dispose();
    super.dispose();
  }

  void stopAnimations() {
    _rickController.stop();
    _leftPortalController.stop();
    _rightPortalController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double startX = portalPadding;
        final double endX = screenWidth - portalPadding - rickSize;

        return Stack(
          children: [
            if (_rickVisible)
              AnimatedBuilder(
                animation: _rickAnimation,
                builder: (_, __) {
                  final positionX =
                      startX + (endX - startX) * _rickAnimation.value;
                  final rotationAngle =
                      _rickAnimation.value *
                      6 *
                      2 *
                      3.14159265359; // 6 voltas completas

                  return Positioned(
                    left: positionX,
                    top: _portalTop + 15,
                    child: GestureDetector(
                      onTap: () async {
                        context.read<RickSceneBloc>().add(HelpedPickleRick());

                        await Future.delayed(const Duration(seconds: 1));

                        stopAnimations();
                      },

                      child: Transform.rotate(
                        angle: rotationAngle,
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: Image.asset(AppImages.pickle, width: 75),
                        ),
                      ),
                    ),
                  );
                },
              ),

            // Portal esquerdo com animação de abertura/fechamento
            Positioned(
              top: _portalTop,
              child: AnimatedBuilder(
                animation: _leftPortalOpen,
                builder: (_, __) {
                  return Opacity(
                    opacity: _leftPortalOpen.value,
                    child: Transform.scale(
                      scale: 0.8 + 0.4 * _leftPortalOpen.value,
                      child: Image.asset(AppImages.portal, width: 75),
                    ),
                  );
                },
              ),
            ),

            // Portal direito com animação de abertura/fechamento e espelhamento horizontal
            Positioned(
              right: portalPadding,
              top: _portalTop,
              child: AnimatedBuilder(
                animation: _rightPortalOpen,
                builder: (_, __) {
                  return Opacity(
                    opacity: _rightPortalOpen.value,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14159265359),
                      child: Transform.scale(
                        scale: 0.8 + 0.4 * _rightPortalOpen.value,
                        child: Image.asset(AppImages.portal, width: 75),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
