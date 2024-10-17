import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';
import '../widgets/tree_view.dart';

class AssetPage extends StatefulWidget {
  final String companyName;

  const AssetPage({super.key, required this.companyName});

  @override
  AssetPageState createState() => AssetPageState();
}

class AssetPageState extends State<AssetPage> {
  String searchText = '';
  bool showEnergySensorsOnly = false;
  bool showCriticalSensorsOnly = false;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.companyName} - Asset Hierarchy'),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Filtros de busca e botão
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Campo de busca por texto
                SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Buscar Ativo ou Local',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                // Botões de filtro (Sensor de Energia e Crítico)
                SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Botão de filtro "Sensor de Energia"
                      SizedBox(
                        height: 40,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.bolt, color: showEnergySensorsOnly ?Colors.white:Colors.black),
                          label: const Text('Sensor de Energia'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: showEnergySensorsOnly
                                ? Colors.blue  // Azul se selecionado
                                : Colors.grey[200],  // Branco se não selecionado
                            foregroundColor: showEnergySensorsOnly
                                ? Colors.white  // Texto branco se selecionado
                                : Colors.black,  // Texto preto se não selecionado
                            side: BorderSide(
                              color: showEnergySensorsOnly ? Colors.blue : Colors.grey,  // Borda conforme o estado
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            elevation: showEnergySensorsOnly ? 5 : 0,  // Elevação se selecionado
                          ),
                          onPressed: () {
                            setState(() {
                              showEnergySensorsOnly = !showEnergySensorsOnly;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Botão de filtro "Crítico"
                      SizedBox(
                        height: 40,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.warning, color: showCriticalSensorsOnly?Colors.white:Colors.black),
                          label: const Text('Crítico'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: showCriticalSensorsOnly
                                ? Colors.blue
                                : Colors.grey[200],
                            foregroundColor: showCriticalSensorsOnly
                                ? Colors.white
                                : Colors.black,
                            side: BorderSide(
                              color: showCriticalSensorsOnly ? Colors.blue : Colors.grey,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            elevation: showCriticalSensorsOnly ? 5 : 0,
                          ),
                          onPressed: () {
                            setState(() {
                              showCriticalSensorsOnly = !showCriticalSensorsOnly;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tree View
          Expanded(
            child: TreeView(
              locations: dataProvider.locations,
              assets: dataProvider.assets,
              searchText: searchText,
              showEnergySensorsOnly: showEnergySensorsOnly,
              showCriticalSensorsOnly: showCriticalSensorsOnly,
            ),
          ),
        ],
      ),
    );
  }
}
