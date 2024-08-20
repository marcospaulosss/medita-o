import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class ComboBox extends StatefulWidget {
  /// Função para trocar a faixa
  Function getTrack;

  /// - [getTrack] Função para trocar a faixa
  /// Construtor
  ComboBox({
    super.key,
    required this.getTrack,
  });

  @override
  State<ComboBox> createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  int _currentValue = 5;

  void _incrementValue() {
    setState(() {
      if (_currentValue < 30) {
        _currentValue += 5;
      }
    });

    widget.getTrack(_currentValue);
  }

  void _decrementValue() {
    setState(() {
      if (_currentValue > 5) {
        _currentValue -= 5;
      }
    });

    widget.getTrack(_currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24.0, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$_currentValue minutos',
            style: const TextStyle(
              fontSize: 16.0,
              color: AppColors.germanderSpeedwell,
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: _incrementValue,
                child: const Icon(
                  Icons.arrow_drop_up,
                  color: AppColors.germanderSpeedwell,
                ),
              ),
              GestureDetector(
                onTap: _decrementValue,
                child: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.germanderSpeedwell,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
