enum HttpMethod {
  GET,
  POST,
  PUT,
  DELETE;

  String get name {
    switch (this) {
      case HttpMethod.GET:
        return 'GET';
      case HttpMethod.POST:
        return 'POST';
      case HttpMethod.PUT:
        return 'PUT';
      case HttpMethod.DELETE:
        return 'DELETE';
    }
  }
}