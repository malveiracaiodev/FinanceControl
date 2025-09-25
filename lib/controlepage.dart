import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'metaspage.dart';
import 'resumomensal.dart';
import 'exportacaopage.dart';
import 'helpers/database_helper.dart';
import 'models/gasto.dart';

class ControlePage extends StatefulWidget {
  final String nome;

  const ControlePage({super.key, required this.nome});

  @override
  State<ControlePage> createState() => _ControlePageState();
}

class _ControlePageState extends State<ControlePage> {
  final descricaoController = TextEditingController();
  final valorController = TextEditingController();
  final saldoController = TextEditingController();
  final metaController = TextEditingController();

  List<Gasto> gastos = [];
  double meta = 0.0;

  @override
  void initState() {
    super.initState();
    carregarGastos();
    carregarMeta();
  }

  void mostrarSnackBar(String mensagem, {Color cor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> carregarGastos() async {
    final lista = await DatabaseHelper().getGastos();
    if (mounted) {
      setState(() => gastos = lista);
    }
  }

  Future<void> carregarMeta() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        meta = prefs.getDouble('metaGasto') ?? 0.0;
        metaController.text = meta.toStringAsFixed(2);
      });
    }
  }

  Future<void> salvarMeta() async {
    final prefs = await SharedPreferences.getInstance();
    final valor = double.tryParse(metaController.text);
    if (valor == null || valor <= 0) {
      mostrarSnackBar('Insira um valor válido para a meta.', cor: Colors.red);
      return;
    }
    await prefs.setDouble('metaGasto', valor);
    setState(() => meta = valor);
    mostrarSnackBar('Meta atualizada para R\$ ${meta.toStringAsFixed(2)}');
  }

  Future<void> adicionarGasto() async {
    final descricao = descricaoController.text.trim();
    final valor = double.tryParse(valorController.text);

    if (descricao.isEmpty || valor == null || valor <= 0) {
      mostrarSnackBar('Preencha os campos corretamente.', cor: Colors.red);
      return;
    }

    final novoGasto = Gasto(descricao: descricao, valor: valor);
    await DatabaseHelper().insertGasto(novoGasto);
    descricaoController.clear();
    valorController.clear();
    await carregarGastos();
    mostrarSnackBar('Gasto adicionado com sucesso!');
  }

  double calcularTotalGastos() {
    return gastos.fold(0.0, (total, item) => total + item.valor);
  }

  void navegar(String destino) {
    late Widget pagina;

    switch (destino) {
      case 'Dashboard':
        final saldo = double.tryParse(saldoController.text) ?? 0.0;
        final total = calcularTotalGastos();
        pagina = DashboardPage(saldo: saldo, gastos: total);
        break;
      case 'Metas':
        pagina = const MetasPage();
        break;
      case 'Resumo':
        pagina = const ResumoMensalPage();
        break;
      case 'Exportar':
        pagina = const ExportacaoPage();
        break;
      default:
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => pagina));
  }

  @override
  Widget build(BuildContext context) {
    final totalGastos = calcularTotalGastos();
    final metaBatida = meta > 0 && totalGastos >= meta;

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Controle de Gastos'),
        backgroundColor: Colors.green[600],
        actions: [
          PopupMenuButton<String>(
            onSelected: navegar,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'Dashboard', child: Text('Dashboard')),
              PopupMenuItem(value: 'Metas', child: Text('Definir Metas')),
              PopupMenuItem(value: 'Resumo', child: Text('Resumo Mensal')),
              PopupMenuItem(value: 'Exportar', child: Text('Exportar Relatório')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Olá, ${widget.nome} 👋',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            const Text('Saldo disponível', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: saldoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite seu saldo (R\$)',
                prefixIcon: Icon(Icons.account_balance_wallet),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            const Text('Meta de gastos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: metaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Defina sua meta (R\$)',
                prefixIcon: Icon(Icons.flag),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: salvarMeta,
              icon: const Icon(Icons.save),
              label: const Text('Salvar meta'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
            ),
            const SizedBox(height: 16),
            Text(
              metaBatida
                  ? '⚠️ Meta batida! Gastos ultrapassaram R\$ ${meta.toStringAsFixed(2)}'
                  : '🟢 Dentro da meta: R\$ ${meta.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: metaBatida ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 32),

            const Text('Adicionar novo gasto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: adicionarGasto,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar gasto'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
            ),
            const SizedBox(height: 32),

            const Text('Gastos registrados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            gastos.isEmpty
                ? const Center(child: Text('Nenhum gasto adicionado ainda.'))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: gastos.length,
                    itemBuilder: (context, index) {
                      final gasto = gastos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.money_off),
                          title: Text(gasto.descricao),
                          trailing: Text('R\$ ${gasto.valor.toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 24),
            const Divider(),
            Text(
              'Total acumulado: R\$ ${totalGastos.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
