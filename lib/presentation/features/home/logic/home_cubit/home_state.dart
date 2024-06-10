import 'package:equatable/equatable.dart';
import '../../../../../domain/models/get_todos_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeStateInitial extends HomeState {
  const HomeStateInitial();
}

class GetAllTodosLoading extends HomeState with EquatableMixin {
  const GetAllTodosLoading();
  @override
  List<Object?> get props => [];
}

class GetAllTodosError extends HomeState with EquatableMixin{
  final String error;
  GetAllTodosError({required this.error});
  
  @override
  List<Object?> get props =>[error];
}

class GetAllTodosSuccess extends HomeState with EquatableMixin{
  final GetAllTodosModel data;
  GetAllTodosSuccess({required this.data});
  
  @override
  List<Object?> get props => [data];
}


class DeleteTheLocalDataBaseLoading extends HomeState with EquatableMixin{
  const DeleteTheLocalDataBaseLoading();
  @override
  List<Object?> get props => [];
}

class DeleteTheLocalDataBaseSuccess extends HomeState with EquatableMixin{
  const DeleteTheLocalDataBaseSuccess();
  @override
  List<Object?> get props => [];
}

class DeleteTheLocalDataBaseError extends HomeState with EquatableMixin{
  final String error;
  DeleteTheLocalDataBaseError({required this.error});
  @override
  List<Object?> get props => [error];
}