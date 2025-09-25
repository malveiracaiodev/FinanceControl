import 'package:flutter/material.dart';

class ExportacaoPage extends StatefulWidget {
  const ExportacaoPage({super.key});

  @override
  State<ExportacaoPage> createState() => _ExportacaoPageState();
}

class _ExportacaoPageState extends State<ExportacaoPage> {
  final saldoController = TextEditingController();
  final gastosController = TextEditingController();
  final metasController = TextEditingController();

  void mostrarSnackBar(String mensagem, {Color cor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void exportarRelatorio() {
    final saldo = double.tryParse(saldoController.text);
    final gastos = double.tryParse(gastosController.text);
    final metas = int.tryParse(metasController.text);

    if (saldo == null || gastos == null || metas == null) {
      mostrarSnackBar('Preencha todos os campos corretamente.', cor: Colors.red);
      return;
    }

    mostrarSnackBar('Relatório exportado com sucesso!');
    // Aqui você pode adicionar lógica real de exportação
  }

  void compartilharRelatorio() {
    mostrarSnackBar('Relatório pronto para compartilhamento!');
    // Aqui você pode adicionar lógica real de compartilhamento
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Exportar Relatório'),
        backgroundColor: Colors.green[600],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Preencha os dados do mês',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: saldoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Saldo final (R\$)',
                prefixIcon: Icon(Icons.account_balance_wallet),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: gastosController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total de gastos (R\$)',
                prefixIcon: Icon(Icons.money_off),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: metasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Metas concluídas',
                prefixIcon: Icon(Icons.flag),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Exportar como PDF'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
              onPressed: exportarRelatorio,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Compartilhar relatório'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[600]),
              onPressed: compartilharRelatorio,
            ),
          ],
        ),
      ),
    );
  }
}
