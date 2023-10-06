import 'package:app_via_cep/model/viacep_back4app_model.dart';
import 'package:app_via_cep/model/viacep_model.dart';
import 'package:app_via_cep/repositories/custom_dio_back4app.dart';
import 'package:dio/dio.dart';

class ViaCepRepository {
  final dio = Dio();
  final _customDio = CustomDioBack4App();

  Future<ViaCepModel> obterViaCep(String cep) async {
    final response = await dio.get("https://viacep.com.br/ws/$cep/json/");

    if (response.statusCode == 200) {
      final responseData = response.data;
      if(responseData["erro"] == true){
        return ViaCepModel.vazio();
      }
      return ViaCepModel.fromJson(response.data);
    }

    return ViaCepModel.vazio();
  }

  // CRUD do Back4App

  Future<ViaCepBack4AppModel> obterCeps() async{
    var result = await _customDio.dio.get("/CEPs");
    return ViaCepBack4AppModel.fromJson(result.data);
  }

  Future<Results> obterCepsId(String id) async{
    var result = await _customDio.dio.get("/CEPs/$id");
    return Results.fromJson(result.data);
  }

  Future<void> salvar(ViaCepModel viaCepModel) async{
    try {
      await _customDio.dio.post("/CEPs", data: viaCepModel);
    } catch (e) {
      rethrow;
    }  
  }

  Future<void> atualizar(ViaCepModel viaCepModel, String id) async{
    try {
      await _customDio.dio.put('/CEPs/$id', data: viaCepModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String id) async{
    try {
      await _customDio.dio.delete('/CEPs/$id');
    } catch (e) {
      rethrow;
    }
    
  }
}
