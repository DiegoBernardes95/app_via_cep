import 'package:app_via_cep/pages/ceps_salvos_page.dart';
import 'package:app_via_cep/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const AppViaCep());
}

class AppViaCep extends StatelessWidget {
  const AppViaCep({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black)
        )
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        'Consultar_Cep': (context) => const HomePage(),
        'Ceps_Armazenados': (context) => const CepsSalvosPage(),
      },
      home: const HomePage(),
    );
  }
}