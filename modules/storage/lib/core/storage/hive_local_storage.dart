
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:storage/core/storage/i_local_storage.dart';

class HiveLocalStorage implements ILocalStorage {
  late Box _hiveBox;
  final VoidCallback onRegisterAdapter;
  HiveLocalStorage(this.onRegisterAdapter);

  @override
  Future<ILocalStorage> init() async {
     onRegisterAdapter.call();
    await Hive.initFlutter();
    
    _hiveBox = await Hive.openBox<Object>('HiveDB');

    return this;
  }

  @override
  void clearData() {
    _hiveBox.clear();
  }

  @override
  Future<T?> getData<T>(String param, {T? defValue}) async {
    return ((await _hiveBox.get(param, defaultValue: defValue)) as T?);
  }

   @override
  Future<List<T>> getListData<T>(String param, {List<T> defValue = const []}) async {
    final item =  _hiveBox.get(param, defaultValue: defValue);
    return tryCast<List>(item, fallback: <dynamic>[]).whereType<T>().toList();
    
  }

  @override
  Future<void> putData<T>(String key, T? data) async {
    return await _hiveBox.put(key, data);
  }
  
  @override
  Future<void> deteleData<T>(String key) async{
    return await _hiveBox.delete(key);
  }
}

T tryCast<T>(dynamic x, {required T fallback}) => x is T ? x : fallback;

