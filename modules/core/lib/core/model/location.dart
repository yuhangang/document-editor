import 'package:core/core/model/model.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherLocation extends Equatable{
  const WeatherLocation();

  Coord get coord;
  
}


class CoordLocation extends WeatherLocation {
  final Coord _coord;

  const CoordLocation(
this._coord,
  );

  
  @override
  List<Object?> get props => [coord];
  
  @override
  Coord get coord => _coord;

}
