import 'dart:async';

import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/progressPainter.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Player extends StatefulWidget {
  /// Player de áudio
  final AudioPlayer player;

  /// Função de parar
  final Function onStop;

  /// - [player] Player de áudio
  /// - [onStop] Função de parar
  /// Construtor
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

  bool get _isPlaying => _player.playing;

  String _formatDuration(Duration? duration) {
    if (duration == null) return "00:00";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Duration _getRemainingTime() {
    if (_duration == null || _position == null) return Duration.zero;
    return _duration! - _position!;
  }

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _player.durationStream.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _player.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _onAudioComplete();
      }
    });
  }

  Future<void> _onAudioComplete() async {
    setState(() {
      _position = Duration.zero;
    });
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

  Future<void> _play() async {
    await _player.play();
  }

  Future<void> _pause() async {
    await _player.pause();
  }
}
