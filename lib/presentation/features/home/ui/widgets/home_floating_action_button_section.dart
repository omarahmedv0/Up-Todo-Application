import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/injections.dart';
import '../../logic/add_todo/add_todo_cubit.dart';
import 'add_todo_bottom_sheet.dart';
import '../../../../resources/colors_manager.dart';

class HomeFloatingActionButtonSection extends StatefulWidget {
  const HomeFloatingActionButtonSection({
    super.key,
  });

  @override
  State<HomeFloatingActionButtonSection> createState() => _HomeFloatingActionButtonSectionState();
}

class _HomeFloatingActionButtonSectionState extends State<HomeFloatingActionButtonSection> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: ColorsManager.primary,
      onPressed: () {
        showModalBottomSheet(
          enableDrag: false,
          backgroundColor: Colors.white,
          context: context,
          builder: (context) => BlocProvider(
            create: (context) => AddTodoCubit(getit.get()),
            child: const AddTodoBottomSheet(),
          ),
        ).then((value) {
          setState(() {
            
          });
        });
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
