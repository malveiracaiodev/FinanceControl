import 'package:flutter/material.dart';

class ResumoMensalPage extends StatelessWidget {
  final double saldoFinal = 2300.00;
  final double totalGastos = 950.00;
  final double economia = 1350.00;
  final int metasConcluidas = 3;

  const ResumoMensalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Resumo Mensal'),
        backgroundColor: Colors.green[600],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seu desempenho financeiro',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Colors.green),
                title: const Text('Saldo final'),
                trailing: Text('R\$ ${saldoFinal.toStringAsFixed(2)}'),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.money_off, color: Colors.red),
                title: const Text('Total de gastos'),
                trailing: Text('R\$ ${totalGastos.toStringAsFixed(2)}'),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.savings, color: Colors.blue),
                title: const Text('Economia do mês'),
                trailing: Text('R\$ ${economia.toStringAsFixed(2)}'),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.flag, color: Colors.orange),
                title: const Text('Metas concluídas'),
                trailing: Text('$metasConcluidas'),
              ),
            ),
            const SizedBox(height: 32),

            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Text(
                  '📊 Gráfico de desempenho aqui',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
