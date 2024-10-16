import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';
import '../widgets/tree_view.dart';

class AssetPage extends StatelessWidget {
  final String companyName;

  const AssetPage({super.key, required this.companyName});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$companyName - Asset Hierarchy'),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.grey[200],
        child: TreeView(
          locations: dataProvider.locations,
          assets: dataProvider.assets,
        ),
      ),
    );
  }
}
