part of 'city_bloc.dart';

abstract class CityState extends Equatable {
   final List<MalaysianCity> selectedCities;
  const CityState({
    required this.selectedCities,
  }
  );
  
  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {
  CityInitial():super(selectedCities:[]);
}

class CityLoading extends CityState {
    CityLoading():super(selectedCities:[]);
}

class CityLoadFailed extends CityState {
 
  final Exception exception;
  const CityLoadFailed({
    required this.exception,
    required super.selectedCities
  });
}

class CityDoneLoad extends CityState {
  final List<MalaysianCity> cities;

  
 const CityDoneLoad({
    required this.cities,
    required super.selectedCities,
  });
  @override
  List<Object> get props => [selectedCities,selectedCities];
}
