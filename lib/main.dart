import 'package:flutter/material.dart';

import 'app.dart';
import 'feature/catalog/registrar.dart';

void main() {
  CatalogRegistrar().register();
  runApp(const OnlineShopApp());
}
