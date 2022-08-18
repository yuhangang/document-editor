import 'package:bloc/bloc.dart';
import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/model/model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final ILocationService _locationService;

  LocationBloc(this._locationService) : super(LocationInitial()) {
    on<OnSetUserCurrentLocation>((event, emit) {
      _getUserCurrentLocation();
    });
  }

  Future<Either<LocationException, Coord>> _getUserCurrentLocation() async {
    final location = await _locationService.getLocation();
    //await _cityRepository.setCurrentWeatherCitySetting(null);
    return right(Coord(lon: location.longitude!, lat: location.latitude!));
  }
}
