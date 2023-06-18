part of 'welcome_message_cubit.dart';

class WelcomeMessageState extends Equatable {
  final bool showMessage;
  final UserType userType;

  const WelcomeMessageState(
      {required this.showMessage, required this.userType});

  @override
  List<Object> get props => [showMessage, userType];
}
