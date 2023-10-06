import 'package:app_via_cep/model/viacep_model.dart';

class CEPFormatado{
  static String cepFormatado(ViaCepModel cep){
    var primeiraParte = cep.cep?.replaceRange(5, null, "-");
    var segundaParte = cep.cep?.replaceRange(0, 6, "");

    return "$primeiraParte$segundaParte";
  }
}