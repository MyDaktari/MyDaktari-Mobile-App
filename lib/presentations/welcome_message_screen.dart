import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/logic/cubit/user_type/user_type_cubit.dart';
import 'package:my_daktari/constants/route.dart' as route;

import '../constants/constants.dart';
import '../logic/bloc/auth_status/auth_status_bloc.dart';

String doctorHtmlContent = '''
          <style>
            
          </style>
           <p>Dear ${doctor.name ?? 'Doctor'},</p>
          <p>We're delighted to have you as part of our medical community. With My Daktari, you now have the power to streamline your practice, enhance patient care, and embrace the future of healthcare.</p>
          <p>Our intuitive platform allows you to effortlessly connect with your patients, access their medical records securely, schedule appointments with ease, and even provide remote consultations through our telehealth feature.</p>
          <p>However, we may encounter occasional bugs or functionality issues as we continue to refine and improve our platform. Rest assured, we are dedicated to delivering the best user experience possible, and our team is working diligently to address any issues that arise. We value your feedback and encourage you to reach out to our support team if you have any questions or encounter any challenges.</p>
          <p>Thank you for your understanding and for partnering with us on our journey to improving patient outcomes and access to care.</p>
          <p>Wishing you a successful and fulfilling experience with My Daktari.</p>
          <p>Best regards,<br>The Dream team,<br>My Daktari</p>
        ''';

String clientHtmlContent = '''
  <style>
    h1 {
     
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 8px;
    }
    p {
      margin-bottom: 8px;
    }
  </style>
  <h1>We care for you!</h1>
  <p>Dear ${client.name ?? 'User'},</p>
  <p>We are delighted to have you join our community of individuals committed to their health and well-being. Congratulations on taking a step towards a healthier and happier life!</p>
  <p>Like you, we understand that your health is your most precious asset, and we are here to support you every step of the way. Whether you're seeking convenient access to healthcare services, tracking your wellness goals, or staying informed about your medical journey, our app is designed to empower you.</p>
  <p>As you explore My Daktari, you'll discover a range of features and resources tailored to meet your needs:</p>
  <ol>
    <li>Personalized Health Insights: Gain valuable insights into your health through personalized data analysis, allowing you to make informed decisions about your well-being.</li>
    <li>Appointment Management: Easily schedule appointments with healthcare providers, track upcoming visits, and receive reminders so that you never miss an important medical check-up.</li>
    <li>Health Tracking: Keep a digital record of your vital signs, medications, and symptoms, enabling you to monitor your progress and share accurate information with your healthcare team.</li>
    <li>Education and Resources: Access a wealth of reliable health information, articles, and resources to stay informed about various conditions, preventive measures, and healthy lifestyle choices.</li>
    <li>Secure Communication: Enjoy secure and convenient messaging features that allow you to communicate with your healthcare providers, ask questions, and receive prompt guidance when you need it most.</li>
  </ol>
  <p>We are committed to continuously enhancing your experience with our app. While we strive to provide a seamless and reliable platform, there may be occasional updates or improvements that temporarily affect certain features. Rest assured, our dedicated team is actively working to ensure your experience is exceptional.</p>
  <p>If you have any questions, feedback, or need assistance, please don't hesitate to reach out to our friendly support team. Thank you for choosing My Daktari.</p>
  <p>Warm regards,</p>
  <p>The Dream team,</p>
  <p>My Daktari</p>
  <p>Email: info@my-daktari.com</p>
''';

class WelcomeMessageScreen extends StatelessWidget {
  const WelcomeMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<UserTypeCubit, UserTypeState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Welcome to My Daktari'),
              leading: SizedBox(),
              leadingWidth: 0,
              centerTitle: true,
              elevation: 0,
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 90,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .83,
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: SingleChildScrollView(
                        child: Html(
                          data: state.userType == UserType.client
                              ? clientHtmlContent
                              : doctorHtmlContent,
                          style: {
                            'body': Style(
                                margin: Margins.all(16),
                                fontSize: FontSize(16),
                                color: Colors.black),
                            'h1': Style(
                              fontSize: FontSize(24),
                              fontWeight: FontWeight.bold,
                              margin: Margins.only(bottom: 8),
                            ),
                            'p': Style(
                              margin: Margins.only(bottom: 8),
                            ),
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 8,
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthStatusBloc>().add(CheckUserStatus());
                        Navigator.pushReplacementNamed(
                            context, route.homeScreen);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width * 0.8, 10),
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.all(15)),
                      child: Text('Continue')),
                ),
                Expanded(flex: 1, child: SizedBox()),
              ],
            ));
      },
    );
  }
}
