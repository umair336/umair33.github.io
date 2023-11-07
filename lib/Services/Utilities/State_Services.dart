
import 'dart:convert';
import 'package:api_check/Model/api.dart';
import 'package:api_check/countries_list.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStateModel> fetchWorldStateRecord() async {
    final response = await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldStateModel.fromJson(data);
    } else {
                 throw Exception(response.reasonPhrase);
                // print(response.statusCode);
    }
  }
  Future<List<dynamic>> CountriesListApi() async {
    final response = await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
                 throw Exception(response.reasonPhrase);
    }
  }
}



// import 'dart:convert';

// import 'package:api_check/Model/api.dart';
// import 'package:api_check/Services/Utilities/App_url.dart';
// import 'package:http/http.dart'as http;

// class StateServices{

//   Future <WorldStateModel> fectchWorldStateRecord() async{
//     final response =await http.get(Uri.parse(AppUrl.worldStateRecord));

//     if(response.statusCode==200){
//       var data =jsonDecode(response.body);
//     return WorldStateModel.fromJson(data);
//     }
//     else{
//      throw Exception("error");
//     }
//   }
// }