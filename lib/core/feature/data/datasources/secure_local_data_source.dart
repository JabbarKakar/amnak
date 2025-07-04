import 'dart:convert';

import 'package:amnak/export.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalDataSourceImpl implements LocalDataSource {
  final FlutterSecureStorage box;

  SecureLocalDataSourceImpl({required this.box});

  @override
  Future<dynamic> read(String key) async =>
      jsonDecode(await box.read(key: key) ?? '');

  @override
  Future<void> write(String key, Map<String, dynamic> value) async =>
      box.write(key: key, value: jsonEncode(value));

  @override
  Future<void> remove(String key) async {
    return await box.delete(key: key);
  }

  @override
  Future<bool> containsKey(String key) {
    return box.containsKey(key: key);
  }
}
