import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({Key? key}) : super(key: key);

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  List<Map<String, String>> historico = [];

  @override
  void initState() {
    super.initState();
    carregarHistorico();
  }

  Future<void> carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = prefs.getStringList('historico') ?? [];

    final listaConvertida = dados.map((linha) {
      final partes = linha.split('|');
      return {'data': partes[0], 'acao': partes[1]};
    }).toList();

    setState(() {
      historico = listaConvertida.reversed.toList(); // mais recente primeiro
    });
  }

  void mostrarSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.green[600],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Histórico de Alterações'),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: historico.isEmpty
            ? const Center(
                child: Text(
                  'Nenhuma alteração registrada.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.separated(
                itemCount: historico.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = historico[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.history, color: Colors.green),
                      title: Text(item['acao']!),
                      subtitle: Text(item['data']!),
                      onTap: () => mostrarSnackBar('Ação registrada em ${item['data']}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
