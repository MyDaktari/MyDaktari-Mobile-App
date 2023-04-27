import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_page_provider.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthPageProvider>(builder: (context, authPageProvider, _) {
      return Visibility(
        visible: authPageProvider.isRegister,
        replacement: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: RichText(
              text: TextSpan(
                  text: 'Forgot password?',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 1, 84, 186), fontSize: 14),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  children: const []),
            ),
          ),
        ),
        child: Row(
          children: [
            Checkbox(
                value: authPageProvider.termsAccepted,
                onChanged: (value) {
                  authPageProvider.updateTerms(value ?? false);
                }),
            RichText(
              text: TextSpan(
                  text: 'I have Read and agree to abide to the MyDaktari',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                  children: [
                    TextSpan(
                        text: ' \nTerms & Conditions',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 1, 84, 186),
                            fontSize: 14),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                    const TextSpan(
                      text: ' and ',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 1, 84, 186),
                            fontSize: 14),
                        recognizer: TapGestureRecognizer()..onTap = () {})
                  ]),
            ),
          ],
        ),
      );
    });
  }
}
