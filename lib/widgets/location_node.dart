import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/asset.dart';
import 'asset_node.dart';

class LocationNode extends StatelessWidget {
  final Location location;
  final Map<String, Location> locationMap;
  final Map<String, Asset> assetMap;
  final int level;
  final String searchText;
  final bool showEnergySensorsOnly;
  final bool showCriticalSensorsOnly;
  final Map<String, bool> expandedMap;
  final Function(String, bool) onExpandToggle;

  LocationNode({
    required this.location,
    required this.locationMap,
    required this.assetMap,
    required this.level,
    required this.searchText,
    required this.showEnergySensorsOnly,
    required this.showCriticalSensorsOnly,
    required this.expandedMap,
    required this.onExpandToggle,
  });

  @override
  Widget build(BuildContext context) {
    final subLocations = locationMap.values.where((loc) => loc.parentId == location.id);
    final relatedAssets = assetMap.values.where((asset) => asset.locationId == location.id);

    bool isExpanded = expandedMap[location.id] ?? false;

    // Filtrar com base na busca de texto
    bool locationMatches = location.name.toLowerCase().contains(searchText.toLowerCase());
    bool hasMatchingAssets = relatedAssets.any((asset) => asset.name.toLowerCase().contains(searchText.toLowerCase()));

    if (!locationMatches && !hasMatchingAssets && searchText.isNotEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(left: level * 16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      onExpandToggle(location.id, !isExpanded);
                    },
                    child: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(width: 8),
                  Image.asset(
                    'assets/icons/location_icon.png',
                    width: 24,
                    height: 24,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              title: Text(location.name, style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                onExpandToggle(location.id, !isExpanded);
              },
            ),
            if (isExpanded)
              Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Column(
                  children: [
                    ...subLocations.map((subLoc) => LocationNode(
                      location: subLoc,
                      locationMap: locationMap,
                      assetMap: assetMap,
                      level: level + 1,
                      searchText: searchText,
                      showEnergySensorsOnly: showEnergySensorsOnly,
                      showCriticalSensorsOnly: showCriticalSensorsOnly,
                      expandedMap: expandedMap,
                      onExpandToggle: onExpandToggle,
                    )),
                    ...relatedAssets.map((asset) => AssetNode(
                      asset: asset,
                      level: level + 1,
                      searchText: searchText,
                      showEnergySensorsOnly: showEnergySensorsOnly,
                      showCriticalSensorsOnly: showCriticalSensorsOnly,
                    )),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
