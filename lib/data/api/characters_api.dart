import 'package:dio/dio.dart';
import 'package:state_management/helpers/constants/strings.dart';

class CharactersApi {
  late Dio dio;

  CharactersApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20), // 20 seconds
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      /// Fetches character data from the API using a GET request.
      /// 
      /// This function uses the Dio package to send an HTTP GET request to the 
      /// 'character' endpoint. The response from the server is stored in the 
      /// [response] variable.
      /// 
      /// Example:
      /// ```dart
      /// Response response = await dio.get('character');
      /// ```
      /// 
      /// The above line sends a GET request to the 'character' endpoint and 
      /// waits for the server's response. The response is then assigned to 
      /// the [response] variable.
      Response response = await dio.get('character');//! this is the endpoint to get all characters baseurl/character/ , so we use dio.get('character') to get all characters and add it to the response variable
      // Ensure we are returning only the results part of the response
      return (response.data['results'] as List<dynamic>); // Cast to List
    } catch (e) {
      // print(e.toString());
      return []; // Return an empty list on error
    }
  }
}
