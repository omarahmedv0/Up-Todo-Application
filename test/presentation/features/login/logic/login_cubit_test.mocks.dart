// Mocks generated by Mockito 5.4.4 from annotations
// in up_todo_app/test/presentation/features/login/logic/login_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import 'package:up_todo_app/app/app_prefs.dart' as _i10;
import 'package:up_todo_app/data/networking/api_error_model.dart' as _i7;
import 'package:up_todo_app/data/requests/requests.dart' as _i9;
import 'package:up_todo_app/domain/models/login_model.dart' as _i8;
import 'package:up_todo_app/domain/repository/repository.dart' as _i2;
import 'package:up_todo_app/domain/use_case/login_use_case.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRepository_0 extends _i1.SmartFake implements _i2.Repository {
  _FakeRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSharedPreferences_2 extends _i1.SmartFake
    implements _i4.SharedPreferences {
  _FakeSharedPreferences_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginUseCase extends _i1.Mock implements _i5.LoginUseCase {
  MockLoginUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Repository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.Repository);

  @override
  set repository(_i2.Repository? _repository) => super.noSuchMethod(
        Invocation.setter(
          #repository,
          _repository,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<_i3.Either<_i7.ApiErrorModel, _i8.LoginModel>> execute(
          _i9.LoginRequestBody? loginRequestBody) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [loginRequestBody],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.ApiErrorModel, _i8.LoginModel>>.value(
                _FakeEither_1<_i7.ApiErrorModel, _i8.LoginModel>(
          this,
          Invocation.method(
            #execute,
            [loginRequestBody],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.ApiErrorModel, _i8.LoginModel>>);
}

/// A class which mocks [AppPreferences].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppPreferences extends _i1.Mock implements _i10.AppPreferences {
  MockAppPreferences() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.SharedPreferences get preferences => (super.noSuchMethod(
        Invocation.getter(#preferences),
        returnValue: _FakeSharedPreferences_2(
          this,
          Invocation.getter(#preferences),
        ),
      ) as _i4.SharedPreferences);

  @override
  set preferences(_i4.SharedPreferences? _preferences) => super.noSuchMethod(
        Invocation.setter(
          #preferences,
          _preferences,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<void> setLoggedIn(bool? value) => (super.noSuchMethod(
        Invocation.method(
          #setLoggedIn,
          [value],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  bool isLoggedIn() => (super.noSuchMethod(
        Invocation.method(
          #isLoggedIn,
          [],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i6.Future<void> setLocalDbCreated(bool? value) => (super.noSuchMethod(
        Invocation.method(
          #setLocalDbCreated,
          [value],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  bool isLocalDbCreated() => (super.noSuchMethod(
        Invocation.method(
          #isLocalDbCreated,
          [],
        ),
        returnValue: false,
      ) as bool);

  @override
  bool isRemoteTodosStored() => (super.noSuchMethod(
        Invocation.method(
          #isRemoteTodosStored,
          [],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i6.Future<void> setRemoteTodosStored(bool? value) => (super.noSuchMethod(
        Invocation.method(
          #setRemoteTodosStored,
          [value],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> saveUserId(int? userId) => (super.noSuchMethod(
        Invocation.method(
          #saveUserId,
          [userId],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  int getUserId() => (super.noSuchMethod(
        Invocation.method(
          #getUserId,
          [],
        ),
        returnValue: 0,
      ) as int);
}
