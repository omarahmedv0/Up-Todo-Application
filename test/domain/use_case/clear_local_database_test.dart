import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:up_todo_app/domain/repository/repository.dart';
import 'package:up_todo_app/domain/use_case/add_todo_use_case.dart';
import 'package:up_todo_app/domain/use_case/clear_local_database.dart';

import 'clear_local_database_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  late Repository repository;
  late ClearLocalDatabaseUseCase clearLocalDatabaseUseCase;

  setUp(() {
    repository = MockRepository();
    clearLocalDatabaseUseCase =
        ClearLocalDatabaseUseCase(repository: repository);
  });

  test(
    "ClearLocalDatabaseUseCase should return successMessage when called without error",
    () async {
      //arrange

      String expectValue = "successMessage";
      when(repository.deleteLocalDatabase()).thenAnswer((_) async {
        return expectValue;
      });

      //act
      final result = await clearLocalDatabaseUseCase.deleteLocalDatabase();

      //assert
      expect(result, expectValue);
    },
  );
}
