import 'package:app_via_cep/model/viacep_back4app_model.dart';
import 'package:app_via_cep/pages/cep_page.dart';
import 'package:app_via_cep/repositories/viacep_repository.dart';
import 'package:app_via_cep/shared/data_formatada.dart';
import 'package:app_via_cep/shared/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class CepsSalvosPage extends StatefulWidget {
  const CepsSalvosPage({super.key});

  @override
  State<CepsSalvosPage> createState() => _CepsSalvosPageState();
}

class _CepsSalvosPageState extends State<CepsSalvosPage> {
  var viaCepBack4AppRepository = ViaCepRepository();
  var _resultados = ViaCepBack4AppModel([]);
  bool carregando = false;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async {
    setState(() {carregando = true;});
    _resultados = await viaCepBack4AppRepository.obterCeps();
    setState(() {carregando = false;});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("CEPs Cadastrados", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            foregroundColor: Colors.green,
            toolbarHeight: 75,
            elevation: 10,
          ),
        drawer: const CustomDrawer(),
      body: Container(
        color: Colors.green,
        child: 
        
        carregando ? 

        const SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white)
            ],
          ),
        )

        :

        _resultados.results.isEmpty ?

        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/images/box.png', width: 400),
              const SizedBox(height: 50),
              const Text("Nenhum registro encontrado!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))
            ],
          ),
        )

        :

        ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          itemCount: _resultados.results.length,
          itemBuilder: (_, index) {
              var resultado = _resultados.results[index];

              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CEPPage(cepId: resultado.objectId)));
                    },
                    child: Dismissible(
                      key: Key(resultado.objectId),
                      onDismissed: (_) async{
                        showDialog(
                          context: context, 
                          builder: (_){
                            return AlertDialog(
                              title: const Text("Excluir"),
                              content: Wrap(
                                children: [
                                    const Text("Tem certeza que deseja excluir o CEP "),
                                    Text(resultado.cep, style: const TextStyle(color: Colors.green)),
                                    const Text("?")
                                ]
                              ),
                              actions: [
                                TextButton(
                                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                                  onPressed: () async {
                                    await viaCepBack4AppRepository.remover(resultado.objectId);
                                    carregarDados();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("CEP EXCLUÍDO!")));
                                  }, 
                                  child: const Text("Sim", style: TextStyle(color: Colors.white))
                                ),
                                TextButton(
                                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                                  onPressed: (){
                                    carregarDados();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Não", style: TextStyle(color: Colors.white))
                                ),
                              ],
                            );
                          }
                        ); 
                      },
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text("CEP: ", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                      Text(resultado.cep),
                                    ],
                                  ),
                            
                                  Row(
                                    children: [
                                      const Text("Salvo em: ", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                      Text(DataFormatada.dataFormatada(DateTime.parse(resultado.createdAt))),
                                  ],
                              )
                                  
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                    children: [
                                      const Text("Cidade: ", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                      Text(resultado.localidade),
                                    ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Estado: ", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                      Text(resultado.uf),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Bairro: ", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                      Text(resultado.bairro),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(color: Colors.black)
                ],
              );
            }),
      ),
    ));
  }
}
