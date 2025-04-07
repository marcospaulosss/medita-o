import 'dart:async';

import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/progressPainter.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/// Widget que representa um player de áudio personalizado com timer regressivo.
///
/// Este componente oferece as seguintes funcionalidades:
/// * Exibição de um botão de play/pause
/// * Timer regressivo que mostra o tempo restante do áudio
/// * Anel de progresso circular que indica o progresso da reprodução
/// * Controle de reprodução com gestos de toque
///
/// O player alterna entre dois estados visuais:
/// 1. Quando pausado: exibe um ícone de play
/// 2. Quando em reprodução: exibe um timer regressivo no formato MM:SS
class Player extends StatefulWidget {
  /// Instância do AudioPlayer responsável pela reprodução do áudio
  final AudioPlayer player;

  /// Callback executado quando a reprodução do áudio é finalizada
  final Function onStop;

  /// Cria um novo Player
  /// 
  /// [player] é a instância do AudioPlayer que será controlada
  /// [onStop] é a função chamada quando o áudio termina de tocar
  const Player({
    required this.player,
    required this.onStop,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerState();
  }
}

class _PlayerState extends State<Player> {
  AudioPlayer get _player => widget.player;
  Duration? _duration;
  Duration? _position;

  /// Indica se o áudio está atualmente em reprodução
  bool get _isPlaying => _player.playing;

  /// Formata uma duração para o formato MM:SS
  /// 
  /// Retorna uma string no formato "00:00" se a duração for nula
  String _formatDuration(Duration? duration) {
    if (duration == null) return "00:00";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  /// Calcula o tempo restante do áudio
  /// 
  /// Retorna a diferença entre a duração total e a posição atual
  Duration _getRemainingTime() {
    if (_duration == null || _position == null) return Duration.zero;
    return _duration! - _position!;
  }

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  /// Inicializa os listeners do player para monitorar:
  /// * Duração total do áudio
  /// * Posição atual da reprodução
  /// * Estado do player (completo, em reprodução, etc)
  Future<void> _initPlayer() async {
    _player.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          _duration = duration;
        });
      }
    });

    _player.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });

    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _onAudioComplete();
      }
    });
  }

  /// Manipula o evento de conclusão do áudio
  /// 
  /// Reseta a posição para zero, para o player e executa o callback [onStop]
  Future<void> _onAudioComplete() async {
    if (mounted) {
      setState(() {
        _position = Duration.zero;
      });
    }
    await _player.stop();
    widget.onStop();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_position != null &&
            _duration != null &&
            _duration!.inMilliseconds > 0)
        ? _position!.inMilliseconds / _duration!.inMilliseconds
        : 0.0;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.vividCerulean,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.freshAir,
                  width: 2.0,
                ),
              ),
              child: GestureDetector(
                onTap: _isPlaying ? _pause : _play,
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _isPlaying
                        ? Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 100,
                            child: Text(
                              _formatDuration(_getRemainingTime()),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: AppColors.vividCerulean,
                                fontFamily: 'Heebo',
                              ),
                            ),
                          )
                        : Icon(
                            Icons.play_arrow,
                            size: 100,
                            color: AppColors.vividCerulean,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 3),
                                blurRadius: 6.0,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              width: 177,
              height: 177,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: AppColors.white,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: SizedBox(
              width: 184,
              height: 184,
              child: CustomPaint(
                painter: ProgressPainter(progress),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Inicia a reprodução do áudio
  Future<void> _play() async {
    await _player.play();
  }

  /// Pausa a reprodução do áudio
  Future<void> _pause() async {
    await _player.pause();
  }
}
