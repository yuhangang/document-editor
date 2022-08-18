part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();
  @override
  List<Object> get props => [];
}

class OnLoadCity extends CityEvent {
  bool get isRefresh => false;
}

class OnRefreshCity extends OnLoadCity {
  @override
  bool get isRefresh => true;
}

class OnAddSelectedCity extends CityEvent {
  final MalaysianCity city;

  const OnAddSelectedCity({
    required this.city,
  });
}

class OnRemoveSelectedCity extends CityEvent {
  final MalaysianCity city;

  const OnRemoveSelectedCity({
    required this.city,
  });
}
