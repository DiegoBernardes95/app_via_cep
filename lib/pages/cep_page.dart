import 'package:app_via_cep/model/viacep_back4app_model.dart';
import 'package:app_via_cep/model/viacep_model.dart';
import 'package:app_via_cep/repositories/viacep_repository.dart';
import 'package:app_via_cep/shared/data_formatada.dart';
import 'package:app_via_cep/shared/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CEPPage extends StatefulWidget {
  String cepId;
  CEPPage({super.key, required this.cepId});

  @override
  State<CEPPage> createState() => _CEPPageState();
}

class _CEPPageState extends State<CEPPage> {
  var cepRepository = ViaCepRepository();
  var cepModel = Results.vazio();
  var updateCepModel = ViaCepModel();
  bool naoAtualizar = true;
  bool carregando = false;

  // Controllers do TextField

  var cep = TextEditingController(text: '');
  var bairro = TextEditingController(text: '');
  var localidade = TextEditingController(text: '');
  var logradouro = TextEditingController(text: '');
  var complemento = TextEditingController(text: '');
  var uf = TextEditingController(text: '');
  var ddd = TextEditingController(text: '');
  var gia = TextEditingController(text: '');
  var ibge = TextEditingController(text: '');
  var siafi = TextEditingController(text: '');
  var createdAt = TextEditingController(text: '');
  var updatedAt = TextEditingController(text: '');
  
  // FIM dos controllers do TextField

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async{
    setState(() {
      carregando = true;
    });
    
    cepModel = await cepRepository.obterCepsId(widget.cepId);
    atualizarCamposDeTexto();

    setState(() {
      carregando = false;
    });
  }

    void atualizarCamposDeTexto() {
      cep.text = cepModel.cep;
      bairro.text = cepModel.bairro;
      localidade.text = cepModel.localidade;
      logradouro.text = cepModel.logradouro;
      complemento.text = cepModel.complemento;
      uf.text = cepModel.uf; 
      ddd.text = cepModel.ddd;
      gia.text = cepModel.gia;
      ibge.text = cepModel.ibge;
      siafi.text = cepModel.siafi;
      createdAt.text = DataFormatada.dataFormatada(DateTime.parse(cepModel.createdAt));
      updatedAt.text = DataFormatada.dataFormatada(DateTime.parse(cepModel.updatedAt));
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
              title: Row(
                children: [
                  const Text("CEP - ", style: TextStyle(fontSize: 18)),
                  Text(cepModel.cep, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                ]
              ),
              foregroundColor: Colors.green,
              toolbarHeight: 75,
              elevation: 10,
            ),
        drawer: const CustomDrawer(),
        floatingActionButton: naoAtualizar ? FloatingActionButton(
          onPressed: (){
            naoAtualizar = false;
            setState(() {});
          }, 
          child: const Icon(Icons.edit) 
        ) : 
          const SizedBox()
        ,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
          color: Colors.green,
          child:

          carregando ? 

          const SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.white)
            ]),
          )
           
          :

          Card(
            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.greenAccent, width: 3), borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
              children: [
                const SizedBox(height: 50),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("ID: ", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(cepModel.objectId)
                  ],
                ),
          
                const SizedBox(height: 35),
          
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                          controller: cep,                     
                          readOnly: true,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            label: Text("CEP"),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
                          ),
                        ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                          controller: uf,                      
                          readOnly: naoAtualizar,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            label: Text("Estado"),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                          ),
                        ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
          
                Row(
                  children: [
                    Expanded(
                      child: 
                        TextField(
                          controller: ddd,                       
                          readOnly: naoAtualizar,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            label: Text("DDD"),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                          ),
                        ),
                    ), 
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: 
                        TextField(
                          controller: localidade,                     
                          readOnly: naoAtualizar,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            label: Text("Cidade"),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                          ),
                        ),
                    ), 
                  ],
                ),
               
               const SizedBox(height: 20),
          
                TextField(
                  controller: logradouro,            
                  readOnly: naoAtualizar,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                    label: Text("Rua"),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                  ),
                ),
                
                const SizedBox(height: 20),
          
                TextField(
                  controller: bairro,              
                  readOnly: naoAtualizar,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                    label: Text("Bairro"),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                  ),
                ),
                
                const SizedBox(height: 20),
          
                TextField(
                  controller: complemento,              
                  readOnly: naoAtualizar,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                    label: Text("Complemento"),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                  ),
                ),
          
                const SizedBox(height: 20),
          
                Row(
                  children: [
                    Expanded(
                      child:
                        TextField(
                          controller: ibge,                       
                          readOnly: naoAtualizar,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            label: Text("IBGE"),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                          ),
                        ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:
                        TextField(
                          controller: siafi,                       
                          readOnly: naoAtualizar,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            label: Text("SIAFI"),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                          ),
                        ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:
                        TextField(
                          controller: gia,
                          readOnly: naoAtualizar,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            label: Text("GIA"),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                          ),
                        ),
                    ),
                  ],
                ),
          
                const SizedBox(height: 20),
          
                Row(
                  children: [
                    Expanded(
                      child: 
                        TextField(
                          controller: createdAt,
                          readOnly: true,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            label: Text("Salvo em:"),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                          ),
                        ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: 
                        TextField(
                          controller: updatedAt,
                          readOnly: true,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                            label: Text("Atualizado em:"),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))
                          ),
                        ),
                    ),
                  ],
                ),
          
                const SizedBox(height: 40),
          
                !naoAtualizar ?
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15)), fixedSize: MaterialStatePropertyAll(Size.fromWidth(150))),
                      onPressed: () async {
                        updateCepModel.cep = cep.text;
                        updateCepModel.bairro = bairro.text;
                        updateCepModel.localidade = localidade.text;
                        updateCepModel.logradouro = logradouro.text;
                        updateCepModel.complemento = complemento.text;
                        updateCepModel.uf = uf.text;
                        updateCepModel.ddd = ddd.text;
                        updateCepModel.gia = gia.text;
                        updateCepModel.ibge = ibge.text;
                        updateCepModel.siafi = siafi.text;
          
                        await cepRepository.atualizar(updateCepModel, widget.cepId);
                        naoAtualizar = true;
                        await carregarDados();
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('CEP ATUALIZADO!')));
                      }, 
                      child: const Text("Atualizar", style: TextStyle(color: Colors.white))
                    ),
                    const SizedBox(width: 15),
                    TextButton(
                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15)), fixedSize: MaterialStatePropertyAll(Size.fromWidth(100))),
                      onPressed: (){
                        naoAtualizar = true;
                        atualizarCamposDeTexto();
                        setState(() {});
                      }, 
                      child: const Text("Cancelar", style: TextStyle(color: Colors.white))
                    ),
                  ],
                )
                
                : 
          
                const SizedBox()
          
              ],
            ),
          )
        ),
      ),
    );
  }
}