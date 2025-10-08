import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_rick_kode_start/components/character_card.dart';
import 'package:save_rick_kode_start/models/character.dart';

void main() {
  // Personagem fictício para testes
  final testCharacter = Character(
    id: 999,
    name: 'Fictício Morty',
    status: 'Unknown',
    species: 'Alien',
    type: 'Test Type',
    gender: 'Other',
    image: 'https://rickandmortyapi.com/api/character/avatar/999.jpeg',
    episode: ['https://rickandmortyapi.com/api/episode/1'],
    originName: 'Fictício Terra',
    originUrl: 'https://rickandmortyapi.com/api/location/1',
    locationName: 'Fictício Local',
    locationUrl: 'https://rickandmortyapi.com/api/location/2',
  );

  testWidgets('CharacterCard mostra imagem, nome e responde ao toque', (
    tester,
  ) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CharacterCard(
            character: testCharacter,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    // Verifica Hero tag
    expect(find.byType(Hero), findsOneWidget);
    expect(
      find.byWidgetPredicate((widget) {
        if (widget is Hero) {
          return widget.tag == 'character-image-${testCharacter.id}';
        }
        return false;
      }),
      findsOneWidget,
    );

    // Verifica URL da imagem
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
    final Image imageWidget = tester.widget(imageFinder);
    expect((imageWidget.image as NetworkImage).url, testCharacter.image);

    // Verifica texto em maiúsculas
    expect(find.text(testCharacter.name.toUpperCase()), findsOneWidget);

    // Testa o clique
    await tester.tap(find.byType(CharacterCard));
    expect(tapped, isFalse);

    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });
}
