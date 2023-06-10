import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tugas_week_1_fic_5/data/models/response/register_response_model.dart';

import '../../data/datasources/auth_datasource.dart';
import '../../data/models/request/register_request_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;
  RegisterBloc(
    this.datasource,
  ) : super(RegisterInitial()) {
    on<DoRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      //kirim register request model -> data source, menunggu response
      final result = await datasource.register(event.model);
      result.fold(
        (error) {
          emit(RegisterError(message: error));
        },
        (data) {
          emit(RegisterLoaded(model: data));
        },
      );
    });
  }
}
