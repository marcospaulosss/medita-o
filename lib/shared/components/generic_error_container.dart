import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';

/// Widget que representa o container de erro genérico do app.
class GenericErrorContainer extends StatefulWidget {
  /// O que será executado ao selecionar o botão de retentativa.
  final void Function()? onRetry;

  /// Mensagem de erro.
  final String? message;

  /// Cria o widget que representa o container de erro genérico do app.
  ///
  /// [onRetry] representa o que será executado ao selecionar botão de retentativa.
  ///
  /// Se [onRetry] não for informado, o botão não será exibido.
  /// Se [message] não for informado, a mensagem padrão será exibida.
  ///
  const GenericErrorContainer({super.key, this.onRetry, this.message});

  @override
  State<GenericErrorContainer> createState() => _GenericErrorContainerState();
}

class _GenericErrorContainerState extends State<GenericErrorContainer> {
  @override
  Widget build(BuildContext context) {
    final hasRetry = widget.onRetry != null;

    return Material(
      child: Padding(
        padding: _contentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildIcon,
            buildTitle,
            buildSubTitle,
            buildButton(hasRetry),
          ],
        ),
      ),
    );
  }

  Visibility buildButton(bool hasRetry) {
    return Visibility(
      visible: hasRetry,
      child: Padding(
        padding: _retryButtonPadding,
        child: GestureDetector(
          onTap: () => widget.onRetry?.call(),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset.zero,
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  blurStyle: BlurStyle.solid,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              SharedStrings.of(context).genericErrorRetry,
              style: buildTextStyleDefault,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox get buildSubTitle {
    return SizedBox(
      width: 311,
      child: Column(
        children: [
          Text(
            SharedStrings.of(context).genericErrorSubTitle,
            textAlign: TextAlign.center,
            style: buildTextStyleDefault.copyWith(fontWeight: FontWeight.w500),
          ),
          Visibility(
            visible: widget.message != null,
            child: const SizedBox(height: 8),
          ),
          Text(
            "( ${widget.message ?? ''} ) ",
            textAlign: TextAlign.center,
            style: buildTextStyleDefault.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Container get buildTitle {
    return Container(
      width: 311,
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        SharedStrings.of(context).genericErrorTitle,
        textAlign: TextAlign.center,
        style: buildTextStyleDefault.copyWith(fontSize: 20),
      ),
    );
  }

  Container get buildIcon {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset.zero,
            blurRadius: 4.0,
            spreadRadius: 2.0,
            blurStyle: BlurStyle.solid,
          ),
        ],
      ),
      child: const Icon(
        Icons.close,
        size: 28,
      ),
    );
  }

  TextStyle get buildTextStyleDefault {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }
}

//region - Dimens

const _contentPadding = EdgeInsets.symmetric(horizontal: 30);
const _retryButtonPadding = EdgeInsets.only(top: 28);

//endregion
