import 'package:flutter/material.dart';

class ExportacaoPage extends StatelessWidget {
  final double saldoFinal = 2300.00;
  final double totalGastos = 950.00;
  final int metasConcluidas = 3;

  const ExportacaoPage({Key? key}) : super(key: key);

  void mostrarSnackBar(BuildContext context, String mensagem, {Color cor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
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
              'Resumo do mês',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: const Text('Saldo final'),
                    trailing: Text('R\$ ${saldoFinal.toStringAsFixed(2)}'),
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.money_off),
                    title: const Text('Total de gastos'),
                    trailing: Text('R\$ ${totalGastos.toStringAsFixed(2)}'),
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.flag),
                    title: const Text('Metas concluídas'),
                    trailing: Text('$metasConcluidas'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Exportar como PDF'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
              onPressed: () {
                mostrarSnackBar(context, 'Relatório exportado como PDF!');
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Compartilhar relatório'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[600]),
              onPressed: () {
                mostrarSnackBar(context, 'Relatório pronto para compartilhamento!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
