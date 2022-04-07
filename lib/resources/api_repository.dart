import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future fetchCovidList() {
    return _provider.fetchCovidList();
  }
}

class NetworkError extends Error {}