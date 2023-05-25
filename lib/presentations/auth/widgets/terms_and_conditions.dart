import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../logic/cubit/sign_up_helper/sign_up_helper_cubit.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key});

  @override
  Widget build(BuildContext context) {
    final signUpHelperCubit = context.watch<SignUpHelperCubit>();
    return Row(
      children: [
        Checkbox(
            value: signUpHelperCubit.state.termsAccepted,
            onChanged: (value) =>
                signUpHelperCubit.updateTerms(value ?? false)),
        RichText(
          text: TextSpan(
            text: 'I have Read and agree to abide to the MyDaktari',
            style: const TextStyle(color: Colors.grey, fontSize: 13),
            children: [
              TextSpan(
                text: ' \nTerms & Conditions',
                style: const TextStyle(
                  color: Color.fromARGB(255, 1, 84, 186),
                  fontSize: 14,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              const TextSpan(
                text: ' and ',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: const TextStyle(
                  color: Color.fromARGB(255, 1, 84, 186),
                  fontSize: 14,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
