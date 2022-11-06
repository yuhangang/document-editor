import 'package:bloc/bloc.dart';
import 'package:core/core/repository/setting_repository.dart';
import 'package:equatable/equatable.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SettingRepository _settingRepository;
  SettingBloc(
    this._settingRepository,
  ) : super(SettingInitial()) {
    on<InitSettingEvent>((event, emit) async {
      final deviceInfoResponse = await _settingRepository.submitDeviceInfo();
      if (deviceInfoResponse.isRight()) {
        emit(DoneSettingConfigureState());
      }
    });
  }
}
