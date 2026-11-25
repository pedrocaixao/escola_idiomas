# Escola de Idiomas — Flutter

Aplicativo Flutter para gerenciar registros de alunos de uma escola de idiomas, mantidos **em memória** (sem banco de dados, API ou persistência).

Cada registro possui três campos de texto obrigatórios: **Aluno**, **Idioma** e **Nível**.

## Funcionalidades

| Requisito | Implementação |
|---|---|
| **Listagem** | `ListView.builder` com `ListTile`: Aluno como título; Idioma e Nível como subtítulo. |
| **Cadastro** | Botão flutuante `+` abre a tela de formulário (`Navigator.push`); o registro retornado é adicionado à lista. |
| **Edição** | Tocar em um registro abre o formulário preenchido; ao salvar, o item é substituído na mesma posição (`_registros[index] = editado`), sem duplicar. |
| **Exclusão** | Ícone de lixeira em cada item, com diálogo de confirmação, remove o registro (`removeAt`). |
| **Validação** | `TextFormField` com validator que rejeita valores vazios ou só com espaços (`trim().isEmpty`). |
| **Atualização** | Todas as operações usam `setState`, atualizando a lista imediatamente. |

Recursos utilizados: lista em memória, `StatefulWidget`, `setState` e navegação entre telas.

## Estrutura

```
lib/
├── main.dart                     # MaterialApp e tema
├── models/registro.dart          # Classe Registro (aluno, idioma, nivel)
└── screens/
    ├── lista_screen.dart         # Tela de listagem (StatefulWidget com a lista em memória)
    └── formulario_screen.dart    # Formulário de cadastro/edição com validação
test/widget_test.dart             # Teste do fluxo: cadastro, validação, edição e exclusão
```

## Como executar

```bash
flutter create .      # gera as pastas de plataforma (android, ios, web...) se não existirem
flutter pub get
flutter run
```

Testes: `flutter test`

### Exemplo para teste

Aluno: **Carla** · Idioma: **Inglês** · Nível: **Básico**
