

class ServerException implements Exception{
  String url;
  String exception;
  ServerException({
    required this.url,
    required this.exception
  });
}
