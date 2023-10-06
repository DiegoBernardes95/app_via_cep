import 'package:app_via_cep/model/viacep_back4app_model.dart';
import 'package:app_via_cep/model/viacep_model.dart';
import 'package:app_via_cep/repositories/viacep_repository.dart';
import 'package:app_via_cep/shared/cep_formatado.dart';
import 'package:app_via_cep/shared/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cep = TextEditingController(text: "");
  var cepRepository = ViaCepRepository();
  var cepModel = ViaCepModel();
  bool carregando = false;
  var ceps = ViaCepBack4AppModel([]);
  var cepFormatado = '';

  @override
  initState(){
    carregarCeps();
    super.initState();
  }

  carregarCeps() async{
    ceps = await cepRepository.obterCeps();
    setState(() {});
  }

  carregarDados() async{
    FocusManager.instance.primaryFocus?.unfocus();
    try {
        if (cep.text.isEmpty || cep.text.length < 8) {
        cepModel = ViaCepModel.vazio();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("CEP INVÁLIDO!")));
      } else {
        cepModel = await cepRepository.obterViaCep(cep.text);
        cepFormatado = CEPFormatado.cepFormatado(cepModel);
      }
    } catch (e) {
      cepModel = ViaCepModel.vazio();
    } 
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Consultar CEPs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            foregroundColor: Colors.green,
            toolbarHeight: 75,
            elevation: 10,
          ),
      drawer: const CustomDrawer(),
      body: Container(
        color: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 70),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.greenAccent, width: 3)),
              elevation: 10,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        cursorColor: Colors.black38,
                        decoration: const InputDecoration(
                            label: Text("Informe o CEP",
                                style: TextStyle(fontSize: 18)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            floatingLabelStyle: TextStyle(color: Colors.black)),
                        controller: cep,
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                      ),
                      TextButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green)),
                        onPressed: () async {
                          setState(() {
                            carregando = true;
                          });

                          await carregarDados();

                          setState(() {
                            carregando = false;
                          });
                        },
                        child: const Text("Pesquisar CEP",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ]),
              ),
            ),

            const SizedBox(height: 50),

            carregando ? 

              const Column(
                children: [
                  CircularProgressIndicator(color: Colors.white)
                ],
              )

            :
            cepModel.cep == "" || cep.text == "" ? 
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: 
                  cep.text == "" ? 
                  [
                    Image.asset("lib/images/map.png", height: 360),
                    const SizedBox(height: 30),
                    Text("Informe um CEP!".toUpperCase(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))
                  ]
                  :
                [
                  Image.asset("lib/images/box.png", height: 360),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("O CEP ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(cep.text),
                      const Text(" não foi encontrado!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ],
              ) 
            )
            :
            Card(
              shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.greenAccent, width: 3), borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Text("CEP: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                          Text(cepModel.cep ?? ""),
                        ]),
                        Row(children: [
                          const Text("IBGE: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                          Text(cepModel.ibge ?? ""),
                        ]),
                    ]),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Text("Cidade: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                          Text(cepModel.localidade ?? ""),
                        ]),
                        Row(children: [
                          const Text("Estado: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                          Text(cepModel.uf ?? ""),
                        ]),
                    ]),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const Text("Rua: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                        Text(cepModel.logradouro ?? ""),
                    ]),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                          const Text("Bairro: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                          Text(cepModel.bairro ?? ""),
                    ]),
                    const SizedBox(height: 20),
                      
                    Row(
                      children: [
                        const Text("Complemento: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                        Text(cepModel.complemento ?? ""),
                    ]),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Text("Gia: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                          Text(cepModel.gia ?? ""),
                        ]),
                        Row(children: [
                          const Text("DDD: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                          Text(cepModel.ddd ?? ""),
                        ]),
                        Row(children: [
                          const Text("Siafi: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                          Text(cepModel.siafi ?? ""),
                        ]),
                    ]),
                    const SizedBox(height: 20),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                          child: const Row(
                            children: [
                              Icon(Icons.add),
                              Text("Salvar CEP", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          onPressed: () async{
                            await carregarCeps();
                            if(ceps.results.any((cep) => cep.cep == cepFormatado)){
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("CEP já cadastrado!")));
                              
                            } else{
                              await cepRepository.salvar(cepModel);
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("CEP salvo com sucesso!")));
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushNamed('Ceps_Armazenados');
                            }
                          }
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
