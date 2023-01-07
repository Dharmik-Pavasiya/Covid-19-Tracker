import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:covid19tracker/utils/api_url.dart';
import '../../model/word_status_model.dart';

class StateServices {
  Future<WorldStatusModel> fetchWorldStatusData() async {
    final response = await http.get(Uri.parse(ApiUrls().worldStatusUrl));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // print('Data SuccessFully Get');
      return WorldStatusModel.fromJson(data);
    } else {
      throw Exception('Error from fetchWorldStatusData');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(ApiUrls().coutryUrl));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      // print('Countries SuccessFully Get');
      return data;
    } else {
      throw Exception('Error from fetchWorldStatusData');
    }
  }
}
