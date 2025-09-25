import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final double saldo;
  final double gastos;

  const DashboardPage({
    Key? key,
    required this.saldo,
    required this.gastos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.green[600],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Resumo financeiro',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Card de Saldo
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet, color: Colors.green[600]),
                title: const Text('Saldo disponível'),
                subtitle: Text(
                  'R\$ ${saldo.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card de Gastos
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.money_off, color: Colors.red[400]),
                title: const Text('Total de gastos'),
                subtitle: Text(
                  'R\$ ${gastos.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Gráfico simples (placeholder)
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Text(
                  '📈 Gráfico de gastos aqui',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green[600],
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
