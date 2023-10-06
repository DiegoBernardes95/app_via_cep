class DataFormatada{
  static String dataFormatada(DateTime data){
    var dia = data.day;
    var mes = data.month;
    var ano = data.year;

    late String mesFormatado;
    switch(mes){
      case 1:
        mesFormatado = "janeiro";
        break;
      case 2:
        mesFormatado = "fevereiro";
        break;
      case 3:
        mesFormatado = 'março';
        break;
      case 4:
        mesFormatado = 'abril';
        break;
      case 5:
        mesFormatado = 'maio';
        break;
      case 6:
        mesFormatado = 'junho';
        break;
      case 7:
        mesFormatado = 'julho';
        break;
      case 8:
        mesFormatado = 'agosto';
        break;
      case 9:
        mesFormatado = 'setembro';
        break;
      case 10:
        mesFormatado = 'outubro';
        break;
      case 11:
        mesFormatado = 'novembro';
        break;
      case 12:
        mesFormatado = 'dezembro';
        break;
      default:
        mesFormatado = 'mês inválido';
        break;
    }

    var dataFormatada = "$dia de $mesFormatado de $ano";

    return dataFormatada;
  }
}