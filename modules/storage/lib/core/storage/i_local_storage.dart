abstract class ILocalStorage {
  Future<ILocalStorage> init();

  void clearData();

  Future<T?> getData<T>(String param, {T? defValue});

  Future<List<T>> getListData<T>(String param, {List<T> defValue = const []});

  Future<void> putData<T>(String key, T? data);
  
  Future<void> deteleData<T>(String key);
}