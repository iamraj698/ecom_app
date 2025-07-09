abstract class BaseApiService {
  Future<dynamic> get(String url);
  Future<dynamic> post(String url, dynamic data);
}