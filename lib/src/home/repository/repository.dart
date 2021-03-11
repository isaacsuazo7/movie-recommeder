import 'package:dio/dio.dart';
import 'package:movie_recommender/src/home/models/country.dart';

class Repository {
  final _dio = Dio();

  Future getCountryByName(String name) async {
    try {
      final url = "https://restcountries.eu/rest/v2/name/$name";

      final resp = await _dio.get(url);

      final List<dynamic> countryList = resp.data;
      return countryList.map((e) => Country.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
