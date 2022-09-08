import 'package:carimangan/ui/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.fastfood,
              size: 100,
              color: Colors.brown,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'CariMangan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
