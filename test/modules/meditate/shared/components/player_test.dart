import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'dart:async';
import 'player_test.mocks.dart';

@GenerateMocks([AudioPlayer])
void main() {
  late MockAudioPlayer player;

  setUp(() {
    player = MockAudioPlayer();
    when(player.playing).thenReturn(false);
    when(player.playerStateStream).thenAnswer((_) => Stream.value(PlayerState(false, ProcessingState.ready)));
    when(player.positionStream).thenAnswer((_) => Stream.value(Duration.zero));
    when(player.durationStream).thenAnswer((_) => Stream.value(const Duration(minutes: 3)));
  });

  tearDown(() async {
    await player.dispose();
  });

  testWidgets('Player deve mostrar ícone de play quando pausado', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Player(
            player: player,
            onStop: () {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });

  testWidgets('Player deve chamar onStop quando o áudio termina', (tester) async {
    bool onStopCalled = false;
    final stateController = StreamController<PlayerState>.broadcast();
    
    when(player.playerStateStream).thenAnswer((_) => stateController.stream);
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Player(
            player: player,
            onStop: () {
              onStopCalled = true;
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    stateController.add(PlayerState(false, ProcessingState.completed));
    await tester.pumpAndSettle();

    expect(onStopCalled, isTrue);
    await stateController.close();
  });

  testWidgets('Player deve mostrar timer quando tocando', (tester) async {
    final stateController = StreamController<PlayerState>.broadcast();
    when(player.playerStateStream).thenAnswer((_) => stateController.stream);
    when(player.playing).thenReturn(true);
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Player(
            player: player,
            onStop: () {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    stateController.add(PlayerState(true, ProcessingState.ready));
    await tester.pumpAndSettle();

    expect(find.text('03:00'), findsOneWidget);
    await stateController.close();
  });
} 