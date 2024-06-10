import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/login_cubit.dart';
import '../../../../shared/helpers/spacing.dart';
import '../../../../shared/widgets/app_text_form_field.dart';


class UserNameAndPasswordSection extends StatefulWidget {
  const UserNameAndPasswordSection({
    super.key,
  });

  @override
  State<UserNameAndPasswordSection> createState() => _UserNameAndPasswordSectionState();
}

class _UserNameAndPasswordSectionState extends State<UserNameAndPasswordSection> {
    bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Username',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid username';
              }
            },
            controller:context.read<LoginCubit>().usernameController ,
          ),
          verticalSpace(18),
          AppTextFormField(
            hintText: 'Password',
            isObscureText: isObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                 setState(() {
                  isObscureText = !isObscureText;
                });
              },
              child:  Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
            controller: context.read<LoginCubit>().passwordController ,
          ),
        ],
      ),
    );
  }
}
