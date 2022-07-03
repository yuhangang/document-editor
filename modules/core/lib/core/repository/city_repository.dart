import 'dart:developer';

import 'package:core/core/api/i_city_api_provider.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/repository/i_city_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:storage/config/pref_config.dart';
import 'package:storage/config/storage_config.dart';
import 'package:storage/core/storage/i_local_storage.dart';
import 'package:collection/collection.dart';

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
        final cachedCityList = await localStorage
            .getListData<MalaysianCity>(StorageKey.allCities, defValue: []);
        if (cachedCityList.isNotEmpty) {
          return right(cachedCityList);
        }
      }
      final data = await cityApiProvider.getMalaysianCityList();
      await localStorage.putData<List<MalaysianCity>>(
          StorageKey.allCities, data);
      await _handleCityBlocSetup(data);
      return right(data);
    } catch (e) {
      if (shouldRefresh) return getCityList(shouldRefresh: false);
      return left(e is Exception ? e : UnknownException());
    }
  }

  Future<void> _handleCityBlocSetup(List<MalaysianCity> data) async {
    if (await localStorage.getData<bool>(PreferenceKeys.doneSetupCityBloc,
            defValue: false) !=
        true) {
            final envDefaultSelectedForecastCity = sl
              .get<AppEnv>()
              .defaultSelectedForecastCity;
      final defaultSelectedCity = data
          .where((element) {
          
            return envDefaultSelectedForecastCity
              .map((e) => e.toLowerCase())
              .contains(element.city.toLowerCase());
          })
          .toList();
      if (defaultSelectedCity.length < envDefaultSelectedForecastCity.length) {
        defaultSelectedCity.addAll(data
            .where((element) => !defaultSelectedCity.contains(element))
            .take(3 - envDefaultSelectedForecastCity.length));
      }
      await localStorage.putData<List<MalaysianCity>>(
          StorageKey.selectedCities, defaultSelectedCity);
      final defaultForecastCity = data.firstWhereOrNull((element) =>
          element.city.toLowerCase() ==
          sl.get<AppEnv>().defaultCurrentWeatherCity.toLowerCase());
      if (defaultForecastCity != null) {
        await setCurrentWeatherCitySetting(defaultForecastCity);
      }
      await localStorage.putData<bool>(PreferenceKeys.doneSetupCityBloc, true);
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
    log("yolo here");
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
      return await localStorage
          .getListData<MalaysianCity>(StorageKey.selectedCities, defValue: []);
    } catch (e) {
      return [];
    }
  }

  @override
  Future<MalaysianCity?> getCurrentWeatherCitySetting() async {
    try {
      return await localStorage.getData<MalaysianCity>(
          PreferenceKeys.currentWeatherCity,
          defValue: null);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setCurrentWeatherCitySetting(MalaysianCity? city) async {
    try {
      if (city != null) {
        await localStorage.putData<MalaysianCity>(
            PreferenceKeys.currentWeatherCity, city);
      } else {
        await localStorage.deteleData(PreferenceKeys.currentWeatherCity);
      }
      // ignore: empty_catches
    } catch (e) {}
  }
}
