import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  bool notificacoesAtivas = true;
  bool temaEscuro = false;
  String idiomaSelecionado = 'Português';

  final List<String> idiomas = ['Português', 'Inglês', 'Espanhol'];

  void mostrarSnackBar(String mensagem, {Color cor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void confirmarRedefinicao() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar redefinição'),
        content: const Text('Tem certeza que deseja apagar todos os dados?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Confirmar'),
            onPressed: () {
              Navigator.pop(context);
              mostrarSnackBar('Dados redefinidos com sucesso!');
              // Aqui você pode adicionar lógica para limpar dados persistentes
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: temaEscuro ? Colors.grey[900] : const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Notificações'),
              subtitle: Text(notificacoesAtivas ? 'Ativadas' : 'Desativadas'),
              value: notificacoesAtivas,
              onChanged: (value) {
                setState(() {
                  notificacoesAtivas = value;
                });
              },
              secondary: const Icon(Icons.notifications),
            ),
            const Divider(),

            SwitchListTile(
              title: const Text('Tema escuro'),
              subtitle: Text(temaEscuro ? 'Ativo' : 'Desativado'),
              value: temaEscuro,
              onChanged: (value) {
                setState(() {
                  temaEscuro = value;
                });
              },
              secondary: const Icon(Icons.dark_mode),
            ),
            const Divider(),

            DropdownButtonFormField<String>(
              initialValue: idiomaSelecionado,
              items: idiomas.map((idioma) {
                return DropdownMenuItem<String>(
                  value: idioma,
                  child: Text(idioma),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Idioma',
                prefixIcon: const Icon(Icons.language),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (novoIdioma) {
                setState(() {
                  idiomaSelecionado = novoIdioma!;
                });
              },
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              icon: const Icon(Icons.restore),
              label: const Text('Redefinir dados'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
              ),
              onPressed: confirmarRedefinicao,
            ),
          ],
        ),
      ),
    );
  }
}
void mostrarSnackBar(BuildContext context, String mensagem, {Color cor = Colors.green}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensagem),
      backgroundColor: cor,
      duration: const Duration(seconds: 2),
    ),
  );
}