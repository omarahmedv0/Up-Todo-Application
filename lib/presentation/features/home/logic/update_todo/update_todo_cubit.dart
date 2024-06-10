import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/extensions.dart';
import '../../../../../data/requests/requests.dart';
import '../../../../../domain/use_case/edit_todo_use_case.dart';
import 'update_todo_state.dart';

class UpdateTodoCubit extends Cubit<UpdateTodoState> {
  UpdateTodoCubit(this._editTodoUseCase)
      : super(const UpdateTodoInitial());
  final EditTodoUseCase _editTodoUseCase;

  static UpdateTodoCubit get(context) => BlocProvider.of(context);
  Future<void> editTodo(UpdateTodoRequestBody updateTodoRequestBody) async {
    emit(const UpdateTodoLoading());
    final result = await _editTodoUseCase.execute(updateTodoRequestBody);
    result.fold(
      (error) {
        emit(UpdateTodoError(error.message.orEmpty()));
      },
      (data) {
        emit(UpdateTodoSuccess(data));
      },
    );
  }
}
