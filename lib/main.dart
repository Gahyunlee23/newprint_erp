import 'package:flutter/widgets.dart';
import 'package:newprint_erp/app.dart';
import 'package:newprint_erp/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: App(),
    ),
  );
}