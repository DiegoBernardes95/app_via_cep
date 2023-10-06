import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Container(
                color: Colors.green,
                height: 200,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("lib/images/map.png", height: 110),
                    const SizedBox(height: 20),
                    const Text("APP ViaCep", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                  ],
                ),
              ),

              const SizedBox(height: 20),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Text("Consultar CEP"),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                  // Verifique se a tela de destino atual é diferente da que você deseja navegar.
                  if (Navigator.of(context).canPop()) {
                    final currentRoute = ModalRoute.of(context);
                    if (currentRoute != null && currentRoute.settings.name != 'Consultar_Cep') {
                      Navigator.of(context).pushNamed('Consultar_Cep');
                    }
                  } else {
                    Navigator.of(context).pushNamed('Consultar_Cep');
                  }
                },
              ),

              const SizedBox(height: 1E0),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.view_list_rounded),
                      SizedBox(width: 10),
                      Text("CEPs armazenados"),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                  // Verifique se a tela de destino atual é diferente da que você deseja navegar.
                  if (Navigator.of(context).canPop()) {
                    final currentRoute = ModalRoute.of(context);
                    if (currentRoute != null && currentRoute.settings.name != 'Ceps_Armazenados') {
                      Navigator.of(context).pushNamed('Ceps_Armazenados');
                    }
                  } else {
                    Navigator.of(context).pushNamed('Ceps_Armazenados');
                  }
                },
              )
            ],
          ),
      )),
    );
  }
}