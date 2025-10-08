import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:save_rick_kode_start/blocs/character_bloc/character_bloc.dart';
import 'package:save_rick_kode_start/blocs/character_bloc/character_event.dart';
import 'package:save_rick_kode_start/blocs/character_bloc/character_state.dart';
import 'package:save_rick_kode_start/components/search_icon_button.dart';

/// Classe mock do CharacterBloc, criada para simular
/// o comportamento do BLoC real sem depender da implementação.
class MockCharacterBloc extends Mock implements CharacterBloc {}

void main() {
  // Instância do mock do CharacterBloc para uso nos testes
  late MockCharacterBloc mockCharacterBloc;

  setUp(() {
    // Inicializa o mock antes de cada teste
    mockCharacterBloc = MockCharacterBloc();

    // Define o estado inicial do bloc para o teste,
    // simulando que o bloco está no estado inicial CharactersInitial
    when(() => mockCharacterBloc.state).thenReturn(CharactersInitial());
  });

  /// Teste widget para o SearchIconButton que verifica o fluxo principal:
  /// 1. Inicialmente exibe apenas o ícone de busca.
  /// 2. Ao clicar no ícone, abre o campo de texto de busca e mostra o botão de fechar.
  /// 3. Ao digitar no campo de texto, dispara evento SearchCharacters para o bloc.
  /// 4. Ao clicar no botão fechar, limpa a busca, dispara evento ClearSearch e retorna para o estado inicial.
  testWidgets('SearchIconButton: abre campo, dispara eventos e fecha', (
    WidgetTester tester,
  ) async {
    // Monta o widget SearchIconButton dentro de um MaterialApp e
    // fornece o mockCharacterBloc via BlocProvider
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CharacterBloc>.value(
          value: mockCharacterBloc,
          child: const Scaffold(body: SearchIconButton()),
        ),
      ),
    );

    // Verifica que inicialmente só o ícone de busca está visível
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byType(TextField), findsNothing);

    // Simula o toque no ícone de busca para abrir o campo de texto
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Verifica que o campo de texto e o botão de fechar estão visíveis
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);

    // Simula a digitação de texto no campo de busca
    const searchText = 'rick';
    await tester.enterText(find.byType(TextField), searchText);

    // Verifica se o evento SearchCharacters foi adicionado ao bloc
    verify(() => mockCharacterBloc.add(SearchCharacters(searchText))).called(1);

    // Simula o toque no botão fechar para encerrar a busca
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Verifica que o campo de texto desapareceu e o ícone de busca reapareceu
    expect(find.byType(TextField), findsNothing);
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Verifica se o evento ClearSearch foi adicionado ao bloc
    verify(() => mockCharacterBloc.add(ClearSearch())).called(1);
  });
}
