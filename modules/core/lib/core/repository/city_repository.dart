import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:core/core/api/i_city_api_provider.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/model/country/continent.dart';
import 'package:core/core/model/country/country.dart';
import 'package:core/core/model/country/world_city.dart';
import 'package:core/core/model/db_tables/city_table.dart';
import 'package:core/core/model/db_tables/continent_table.dart';
import 'package:core/core/model/db_tables/country_table.dart';
import 'package:core/core/repository/i_city_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:storage/config/pref_config.dart';
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
    await getContinentList();
    await getCountryList();
    await getCityJsonList();
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
      final envDefaultSelectedForecastCity =
          sl.get<AppEnv>().defaultSelectedForecastCity;
      final defaultSelectedCity = data.where((element) {
        return envDefaultSelectedForecastCity
            .map((e) => e.toLowerCase())
            .contains(element.city.toLowerCase());
      }).toList();
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

  Future<Either<Exception, List<Continent>>> getContinentList() async {
    try {
      String data = await rootBundle
          .loadString("modules/core/assets/json/continents.json");

      final Map<String, dynamic> json = jsonDecode(data);
      final continentList = json.entries
          .map((e) => Continent.fromJson({'code': e.key, 'name': e.value}))
          .toList();
      await sl.get<ContinentTable>().insertBulk(continentList);
      //final data = await sl.get<ContinentTable>().readList();
      return Right(continentList);
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }

  Future<Either<Exception, List<Country>>> getCountryList() async {
    try {
      String data = await rootBundle
          .loadString("modules/core/assets/json/countries.json");

      final Map<String, dynamic> json = jsonDecode(data);
      final countryList = json.entries
          .map((e) => Country.fromJson({'code': e.key, ...(e.value as Map)}))
          .toList();
      await sl.get<CountryTable>().insertBulk(countryList);
      //final data = await sl.get<ContinentTable>().readList();
      return Right(countryList);
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }

  Future<Either<Exception, List<WorldCity>>> getCityJsonList() async {
    try {
      final continents = await cityApiProvider.getLocationData();
      sl.get<ContinentTable>().insertBulk(continents);
      String data =
          await rootBundle.loadString("modules/core/assets/json/cities.json");

      final List<dynamic> json = jsonDecode(data);
      final cityList = json
          .whereType<Map<String, dynamic>>()
          .map((e) => WorldCity.fromJson(e))
          .toList();
      await sl.get<CityTable>().insertBulk(cityList);
      // final city = sl.get<CityTable>().readList();
      //final data = await sl.get<ContinentTable>().readList();
      return Right(cityList);
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }
}
