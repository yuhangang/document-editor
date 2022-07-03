

import 'package:bloc/bloc.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/repository/i_city_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
 final ICityRepository _cityRepository;

  CityBloc(
    this._cityRepository,
  ) : super(CityInitial()) {
    on<OnLoadCity>((event, emit) async {
      emit(CityLoading());
      final newState = await _loadCityData(shouldRefresh: event.isRefresh);
     
      emit(newState.fold((l) => l, (r) => r));
    });

    on<OnRemoveSelectedCity>((event, emit) async {
      final newState = await _removeSelectedCity(event.city);
      emit(newState.fold((l) => l, (r) => r));
    });
    on<OnAddSelectedCity>((event, emit) async {
      final newState = await _addSelectedCity(event.city);
      emit(newState.fold((l) => l, (r) => r));
    });
  }

  Future<Either<CityLoadFailed, CityDoneLoad>> _loadCityData({bool shouldRefresh = false}) async {
    final response = await _cityRepository.getCityList(shouldRefresh: shouldRefresh);
    final selectedCityResponse = await _cityRepository.getSelectedCityList();

    return response.fold(
        (exception) => left(CityLoadFailed(selectedCities: selectedCityResponse,exception: exception)),
        (cityList) => right(CityDoneLoad(
            cities: cityList, selectedCities: selectedCityResponse)));
  }

  Future<Either<CityLoadFailed, CityDoneLoad>> _removeSelectedCity(
      MalaysianCity city) async {
    return _mergeCityList(() => _cityRepository.removeSelectedCity(city));
  }

  Future<Either<CityLoadFailed, CityDoneLoad>> _addSelectedCity(
      MalaysianCity city) async {
    return _mergeCityList(() => _cityRepository.addSelectedCity(city));
  }

  Future<Either<CityLoadFailed, CityDoneLoad>> _mergeCityList(
      Future<Either<Exception, List<MalaysianCity>>> Function()
          fetchSelectedCityFunction) async {
    final selectedCityListResponse = await fetchSelectedCityFunction();

    final selectedCities =  (selectedCityListResponse.isLeft())? await _cityRepository.getSelectedCityList(): <MalaysianCity>[];
    return selectedCityListResponse
        .fold((exception) => left(CityLoadFailed(selectedCities: selectedCityListResponse.fold((l)=> selectedCities, (r) => r),exception: exception)),
            (selectedCities) async {
      final cityListResponse = await _cityRepository.getCityList();
      return cityListResponse.fold(
          (exception) => left(CityLoadFailed(selectedCities: selectedCities,exception: exception)),
          (cities) => right(
              CityDoneLoad(cities: cities, selectedCities: selectedCities)));
    });
  }
}
