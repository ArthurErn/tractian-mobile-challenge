import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/asset.dart';

class TreeView extends StatelessWidget {
  final List<Location> locations;
  final List<Asset> assets;

  const TreeView({super.key, required this.locations, required this.assets});

  @override
  Widget build(BuildContext context) {
    final locationMap = {for (var loc in locations) loc.id: loc};
    final assetMap = {for (var asset in assets) asset.id: asset};

    List<Widget> buildTree() {
      List<Widget> tree = [];
      for (var loc in locations.where((loc) => loc.parentId == null)) {
        tree.add(_buildLocationNode(loc, locationMap, assetMap));
      }
      return tree;
    }

    return ListView(
      padding: const EdgeInsets.all(10),
      children: buildTree(),
    );
  }

  Widget _buildLocationNode(Location location, Map<String, Location> locMap, Map<String, Asset> assetMap) {
    final subLocations = locMap.values.where((loc) => loc.parentId == location.id);
    final relatedAssets = assetMap.values.where((asset) => asset.locationId == location.id);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.blueAccent),
        ),
        child: ExpansionTile(
          leading: const Icon(Icons.location_city, color: Colors.blueAccent), // Localização principal
          title: Text(location.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          children: [
            ...subLocations.map((subLoc) => _buildSubLocationNode(subLoc, locMap, assetMap)), // Usar ícone diferente para sub-localizações
            ...relatedAssets.map((asset) => _buildAssetNode(asset, assetMap)),
          ],
        ),
      ),
    );
  }

  Widget _buildSubLocationNode(Location subLocation, Map<String, Location> locMap, Map<String, Asset> assetMap) {
    final subSubLocations = locMap.values.where((loc) => loc.parentId == subLocation.id);
    final relatedSubAssets = assetMap.values.where((asset) => asset.locationId == subLocation.id);

    return ExpansionTile(
      leading: const Icon(Icons.apartment, color: Colors.deepPurple), // Ícone diferente para sub-localizações
      title: Text(subLocation.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      children: [
        ...subSubLocations.map((subLoc) => _buildSubLocationNode(subLoc, locMap, assetMap)),
        ...relatedSubAssets.map((asset) => _buildAssetNode(asset, assetMap)),
      ],
    );
  }

  Widget _buildAssetNode(Asset asset, Map<String, Asset> assetMap) {
    final isComponent = asset.sensorId != null;

    return ListTile(
      leading: Icon(
        isComponent ? Icons.sensors : Icons.build, // Ícone diferente para componentes e sub-ativos
        color: isComponent ? Colors.green : Colors.orange,
      ),
      title: Text(asset.name),
      subtitle: isComponent ? Text('Component - ${asset.sensorType}') : null,
      tileColor: isComponent ? Colors.green[50] : Colors.orange[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onTap: () {
        // Ação para clique, se necessário
      },
    );
  }
}
