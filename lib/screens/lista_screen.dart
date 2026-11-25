import 'package:flutter/material.dart';

import '../models/registro.dart';
import 'formulario_screen.dart';

/// Tela principal: lista os registros mantidos em memória.
class ListaScreen extends StatefulWidget {
  const ListaScreen({super.key});

  @override
  State<ListaScreen> createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  // Lista em memória (não persiste após fechar o app).
  final List<Registro> _registros = [];

  /// Cadastro: abre o formulário vazio e adiciona o registro retornado.
  Future<void> _adicionar() async {
    final novo = await Navigator.push<Registro>(
      context,
      MaterialPageRoute(builder: (_) => const FormularioScreen()),
    );
    if (novo != null) {
      setState(() => _registros.add(novo));
      _mensagem('Registro cadastrado.');
    }
  }

  /// Edição: abre o formulário preenchido e substitui o registro
  /// na mesma posição (sem criar duplicata).
  Future<void> _editar(int index) async {
    final editado = await Navigator.push<Registro>(
      context,
      MaterialPageRoute(
        builder: (_) => FormularioScreen(registro: _registros[index]),
      ),
    );
    if (editado != null) {
      setState(() => _registros[index] = editado);
      _mensagem('Registro atualizado.');
    }
  }

  /// Exclusão: confirma e remove o registro selecionado.
  Future<void> _excluir(int index) async {
    final registro = _registros[index];
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir registro'),
        content: Text('Deseja remover o registro de "${registro.aluno}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmar == true) {
      setState(() => _registros.removeAt(index));
      _mensagem('Registro excluído.');
    }
  }

  void _mensagem(String texto) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escola de Idiomas'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _registros.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Nenhum registro cadastrado.\nToque em + para adicionar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _registros.length,
              itemBuilder: (context, index) {
                final r = _registros[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(r.aluno[0].toUpperCase()),
                    ),
                    title: Text(
                      r.aluno,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Idioma: ${r.idioma}\nNível: ${r.nivel}'),
                    isThreeLine: true,
                    onTap: () => _editar(index),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Excluir',
                      onPressed: () => _excluir(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionar,
        tooltip: 'Novo registro',
        child: const Icon(Icons.add),
      ),
    );
  }
}
