import '../../../../export.dart';

abstract class LocalDataSource {
  Future<dynamic> read(String key);
  Future<void> write(String key, Map<String, dynamic> value);
  Future<void> remove(String key);
  Future<bool> containsKey(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  final GetStorage box;

  LocalDataSourceImpl({required this.box});

  @override
  Future<dynamic> read(String key) async => await box.read(key);

  @override
  Future<void> write(String key, Map<String, dynamic> value) async =>
      await box.write(key, value);

  @override
  Future<void> remove(String key) async {
    return await box.remove(key);
  }

  @override
  Future<bool> containsKey(String key) async {
    return await box.hasData(key);
  }
}
