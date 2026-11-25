import 'package:flutter/material.dart';

import 'screens/lista_screen.dart';

void main() {
  runApp(const EscolaIdiomasApp());
}

class EscolaIdiomasApp extends StatelessWidget {
  const EscolaIdiomasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escola de Idiomas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ListaScreen(),
    );
  }
}
