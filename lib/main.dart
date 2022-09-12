import 'package:carimangan/api/api_service.dart';
import 'package:carimangan/provider/resto_provider.dart';
import 'package:carimangan/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RestoProvider(apiService: ApiService(), type: 'list', id: ''),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
