import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:escola_idiomas/main.dart';

void main() {
  testWidgets('cadastra, valida, edita e exclui registro', (tester) async {
    await tester.pumpWidget(const EscolaIdiomasApp());
    expect(find.byType(ListTile), findsNothing);

    // Cadastro
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Validação: campo só com espaços não é aceito
    await tester.enterText(find.byType(TextFormField).at(0), '   ');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Informe o campo Aluno.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Carla');
    await tester.enterText(find.byType(TextFormField).at(1), 'Inglês');
    await tester.enterText(find.byType(TextFormField).at(2), 'Básico');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Carla'), findsOneWidget);
    expect(find.text('Idioma: Inglês\nNível: Básico'), findsOneWidget);

    // Edição (sem duplicar)
    await tester.tap(find.text('Carla'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(2), 'Intermediário');
    await tester.tap(find.text('Salvar alterações'));
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Idioma: Inglês\nNível: Intermediário'), findsOneWidget);

    // Exclusão
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Excluir'));
    await tester.pumpAndSettle();
    expect(find.text('Carla'), findsNothing);
  });
}
