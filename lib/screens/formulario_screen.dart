import 'package:flutter/material.dart';

import '../models/registro.dart';

/// Formulário usado tanto para cadastro quanto para edição.
/// Se [registro] for informado, os campos vêm preenchidos (modo edição).
class FormularioScreen extends StatefulWidget {
  final Registro? registro;

  const FormularioScreen({super.key, this.registro});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _alunoController;
  late final TextEditingController _idiomaController;
  late final TextEditingController _nivelController;

  bool get _editando => widget.registro != null;

  @override
  void initState() {
    super.initState();
    _alunoController =
        TextEditingController(text: widget.registro?.aluno ?? '');
    _idiomaController =
        TextEditingController(text: widget.registro?.idioma ?? '');
    _nivelController =
        TextEditingController(text: widget.registro?.nivel ?? '');
  }

  @override
  void dispose() {
    _alunoController.dispose();
    _idiomaController.dispose();
    _nivelController.dispose();
    super.dispose();
  }

  /// Validação: rejeita campos vazios ou contendo apenas espaços.
  String? _validarCampo(String? valor, String nomeCampo) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o campo $nomeCampo.';
    }
    return null;
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    final registro = Registro(
      aluno: _alunoController.text.trim(),
      idioma: _idiomaController.text.trim(),
      nivel: _nivelController.text.trim(),
    );
    Navigator.pop(context, registro);
  }

  Widget _campo(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputAction acao = TextInputAction.next,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        textInputAction: acao,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (v) => _validarCampo(v, label),
        onFieldSubmitted:
            acao == TextInputAction.done ? (_) => _salvar() : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar registro' : 'Novo registro'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _campo(_alunoController, 'Aluno', Icons.person),
              _campo(_idiomaController, 'Idioma', Icons.language),
              _campo(_nivelController, 'Nível', Icons.bar_chart,
                  acao: TextInputAction.done),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.save),
                label: Text(_editando ? 'Salvar alterações' : 'Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
