part of 'city_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();
  
  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoadFailed extends CityState {
  final Exception exception;
  const CityLoadFailed({
    required this.exception,
  });
}

class CityDoneLoad extends CityState {
  final List<MalaysianCity> cities;
  final List<MalaysianCity> selectedCities;
  
 const CityDoneLoad({
    required this.cities,
    required this.selectedCities,
  });
}
