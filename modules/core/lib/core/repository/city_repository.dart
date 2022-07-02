import 'dart:developer';

import 'package:core/core/api/i_city_api_provider.dart';
import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/repository/i_city_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:storage/config/storage_config.dart';
import 'package:storage/core/storage/i_local_storage.dart';

class CityRepository implements ICityRepository {
  final ICityApiProvider cityApiProvider;
  final ILocalStorage localStorage;

  CityRepository({
    required this.cityApiProvider,
    required this.localStorage,
  });
  @override
  Future<Either<Exception, List<MalaysianCity>>> getCityList(
      {bool shouldRefresh = false}) async {
    try {
      if (!shouldRefresh) {
             log("fff");
        final cachedCityList = await localStorage.getListData<MalaysianCity>(
                StorageKey.allCities,
                defValue: []) ;

                   log("fff $cachedCityList");
        if (cachedCityList.isNotEmpty) {
          return right(cachedCityList);
        }
      }
      final data = await cityApiProvider.getMalaysianCityList();
      log("online $data");
      await localStorage.putData<List<MalaysianCity>>(
          StorageKey.allCities, data);
      return right(data);
    } catch (e) {
      log("fff $e");
      return left(e is Exception ? e : UnknownException());
    }
  }

  @override
  Future<Either<Exception, List<MalaysianCity>>> addSelectedCity(
      MalaysianCity city) async {
    try {
      final cityList = [...await getSelectedCityList(), city];
      await localStorage.putData<List<MalaysianCity>>(
          StorageKey.selectedCities, cityList);
      return right(await getSelectedCityList());
    } catch (e) {
      return left(e is Exception ? e : UnknownException());
    }
  }

  @override
  Future<Either<Exception, List<MalaysianCity>>> removeSelectedCity(
      MalaysianCity city) async {
    try {
      final cityList = (await getSelectedCityList())
          .where((element) => element != city)
          .toList();
      await localStorage.putData<List<MalaysianCity>>(
          StorageKey.selectedCities, cityList);
      return right(await getSelectedCityList());
    } catch (e) {
      return left(e is Exception ? e : UnknownException());
    }
  }

  @override
  Future<List<MalaysianCity>> getSelectedCityList() async {
    try {
  return await localStorage.getListData<MalaysianCity>(
          StorageKey.selectedCities,
          defValue: []);
}  catch (e) {
   log("anc $e");
  return [];
}
  }
}
