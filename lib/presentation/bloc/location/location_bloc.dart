import 'package:bloc/bloc.dart';
import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  Either<Coord, MalaysianCity> _location;
  final ILocationService _locationService;
  final IForecastRepository _forecastRepository;

  LocationBloc(this._location, this._locationService, this._forecastRepository)
      : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

    Future<Either<LocationException, Coord>> _getUserCurrentLocation() async {
    final location = await _locationService.getLocation();
    //await _cityRepository.setCurrentWeatherCitySetting(null);
    return right(Coord(lon: location.longitude!, lat: location.latitude!));
  }
}
