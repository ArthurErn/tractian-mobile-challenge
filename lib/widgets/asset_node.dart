import 'package:flutter/material.dart';
import '../models/asset.dart';

class AssetNode extends StatelessWidget {
  final Asset asset;
  final int level;
  final String searchText;
  final bool showEnergySensorsOnly;
  final bool showCriticalSensorsOnly;

  AssetNode({
    required this.asset,
    required this.level,
    required this.searchText,
    required this.showEnergySensorsOnly,
    required this.showCriticalSensorsOnly,
  });

  @override
  Widget build(BuildContext context) {
    final isComponent = asset.sensorId != null;

    // Aplicar filtros e busca
    if (searchText.isNotEmpty && !asset.name.toLowerCase().contains(searchText.toLowerCase())) {
      return SizedBox.shrink();
    }
    if (showEnergySensorsOnly && (!isComponent || asset.sensorType != "energy")) {
      return SizedBox.shrink();
    }
    if (showCriticalSensorsOnly && (asset.status != "alert")) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(left: level * 16.0), // Padding dinâmico para sub-itens
      child: ListTile(
        leading: Image.asset(
          isComponent ? 'assets/icons/component_icon.png' : 'assets/icons/asset_icon.png',
          width: 24,
          height: 24,
          color: isComponent ? Colors.green : Colors.orange,
        ),
        title: Text(asset.name),
        subtitle: isComponent ? Text('Component - ${asset.sensorType}') : null,
        trailing: isComponent && asset.status == "alert"
            ? Icon(Icons.warning, color: Colors.red)  // Ícone de status crítico
            : null,  // Exibe ícone de alerta para status crítico
        tileColor: isComponent ? Colors.green[50] : Colors.orange[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: () {
          // Mostrar detalhes ou status do componente/ativo, se necessário
        },
      ),
    );
  }
}
