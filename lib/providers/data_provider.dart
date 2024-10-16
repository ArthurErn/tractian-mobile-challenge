import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/location.dart';
import '../models/asset.dart';
import '../models/company.dart';

class DataProvider with ChangeNotifier {
  List<Company> _companies = [];
  List<Location> _locations = [];
  List<Asset> _assets = [];

  List<Company> get companies => _companies;
  List<Location> get locations => _locations;
  List<Asset> get assets => _assets;

  Future<void> fetchCompanies() async {
    final response = await http.get(Uri.parse('https://fake-api.tractian.com/companies'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _companies = data.map((json) => Company.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> fetchLocations(String companyId) async {
    final response = await http.get(Uri.parse('https://fake-api.tractian.com/companies/$companyId/locations'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _locations = data.map((json) => Location.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> fetchAssets(String companyId) async {
    final response = await http.get(Uri.parse('https://fake-api.tractian.com/companies/$companyId/assets'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _assets = data.map((json) => Asset.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
