import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/extensions.dart';
import '../../logic/login_cubit.dart';
import '../../logic/login_state.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../routing/routes.dart';
import '../../../../shared/widgets/custom_dialog.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is LoginStateLoading ||
          current is LoginStateError ||
          current is LoginStateSuccess,
      listener: (context, state) {
        if (state is LoginStateError) {
          context.pop();
          showPopup(
            context,
            AnimationsAssets.errorState,
            state.error,
            onButtonTap: () {
              context.pop();
            },
          );
        } else if (state is LoginStateSuccess) {
          context.pop();
          context.pushReplacementNamed(
            Routes.homeScreen,
          );
        } else if (state is LoginStateLoading) {
          showPopup(
            context,
            AnimationsAssets.loadingState,
            "LoggingIn",
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
