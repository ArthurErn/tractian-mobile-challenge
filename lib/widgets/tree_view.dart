import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/asset.dart';
import 'location_node.dart';

class TreeView extends StatefulWidget {
  final List<Location> locations;
  final List<Asset> assets;
  final String searchText;
  final bool showEnergySensorsOnly;
  final bool showCriticalSensorsOnly;

  TreeView({
    required this.locations,
    required this.assets,
    required this.searchText,
    required this.showEnergySensorsOnly,
    required this.showCriticalSensorsOnly,
  });

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  Map<String, bool> _expandedMap = {}; // Para controlar o estado de expansão

  @override
  Widget build(BuildContext context) {
    final locationMap = {for (var loc in widget.locations) loc.id: loc};
    final assetMap = {for (var asset in widget.assets) asset.id: asset};

    List<Widget> buildTree() {
      List<Widget> tree = [];
      
      // Aplicar filtro de busca nos locais principais
      for (var loc in widget.locations.where((loc) => loc.parentId == null)) {
        // Verifica se o local ou algum ativo contém o texto buscado
        bool locationMatches = loc.name.toLowerCase().contains(widget.searchText.toLowerCase());
        bool assetMatches = widget.assets.any((asset) => 
            asset.name.toLowerCase().contains(widget.searchText.toLowerCase()) && 
            asset.locationId == loc.id);
        
        if (locationMatches || assetMatches || widget.searchText.isEmpty) {
          tree.add(
            LocationNode(
              location: loc,
              locationMap: locationMap,
              assetMap: assetMap,
              level: 0,
              searchText: widget.searchText,
              showEnergySensorsOnly: widget.showEnergySensorsOnly,
              showCriticalSensorsOnly: widget.showCriticalSensorsOnly,
              expandedMap: _expandedMap,
              onExpandToggle: (String id, bool isExpanded) {
                setState(() {
                  _expandedMap[id] = isExpanded;
                });
              },
            ),
          );
        }
      }
      return tree;
    }

    return ListView(
      padding: const EdgeInsets.all(10),
      children: buildTree(),
    );
  }
}
