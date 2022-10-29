import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/core/repository/setting_repository.dart';
import 'package:equatable/equatable.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SettingRepository settingRepository;
  SessionBloc(
    this.settingRepository,
  ) : super(SessionInitial()) {
    on<InitSession>((event, emit) async {
      final error = await settingRepository.login();
      if (error != null) {
        emit(SessionError(exception: error));
      } else {
        emit(SessionLoaded());
      }
    }, transformer: sequential());
  }
}
