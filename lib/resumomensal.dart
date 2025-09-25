import 'package:flutter/material.dart';

class ResumoMensalPage extends StatelessWidget {
  final double saldoFinal = 2300.00;
  final double totalGastos = 950.00;
  final double economia = 1350.00;
  final int metasConcluidas = 3;

  const ResumoMensalPage({super.key});

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

            _buildResumoCard(
              icon: Icons.account_balance_wallet,
              corIcone: Colors.green,
              titulo: 'Saldo final',
              valor: 'R\$ ${saldoFinal.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 12),

            _buildResumoCard(
              icon: Icons.money_off,
              corIcone: Colors.red,
              titulo: 'Total de gastos',
              valor: 'R\$ ${totalGastos.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 12),

            _buildResumoCard(
              icon: Icons.savings,
              corIcone: Colors.blue,
              titulo: 'Economia do mês',
              valor: 'R\$ ${economia.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 12),

            _buildResumoCard(
              icon: Icons.flag,
              corIcone: Colors.orange,
              titulo: 'Metas concluídas',
              valor: '$metasConcluidas',
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

  Widget _buildResumoCard({
    required IconData icon,
    required Color corIcone,
    required String titulo,
    required String valor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: corIcone),
        title: Text(titulo),
        trailing: Text(valor),
      ),
    );
  }
}
