import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/shared_ui/authentication/views/login/login_otp_screen.dart';
import 'package:my_daktari/presentations/client_side/appointments/client_appointment_screen.dart';
import 'package:my_daktari/presentations/client_side/doctorsTab/views/booking_Screen.dart';
import 'package:my_daktari/presentations/client_side/homeTab/views/symptomChecker/doctor_by_symptoms_screen.dart';

import 'package:my_daktari/models/appointment.dart';
import 'package:my_daktari/models/blog.dart';
import 'package:my_daktari/presentations/shared_ui/authentication/views/sign_up/sign_up_otp_screen.dart';

import 'package:my_daktari/presentations/client_side/homeTab/views/ambulance/ambulance_screen.dart';
import 'package:my_daktari/presentations/client_side/homeTab/views/symptomChecker/symptoms_samples.dart';
import 'package:my_daktari/presentations/client_side/payment/payment_screen.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/schedule_screen.dart';
import 'package:my_daktari/presentations/shared_ui/welcome_screen/welcome_message_screen.dart';
import 'package:my_daktari/presentations/supplier_side/home_screen/s_home_screen.dart';

import '../models/blood_sugar.dart';
import '../models/doctor_profile_model.dart';
import '../models/product.dart';
import '../presentations/shared_ui/ayaTab/views/chat_page.dart';
import '../presentations/shared_ui/profileTab/views/health/blood_sugar/blood_sugar_history_screen.dart';
import '../presentations/shared_ui/profileTab/views/health/blood_sugar/blood_sugar_screen.dart';
import '../presentations/shared_ui/profileTab/views/health/blood_sugar/record_sugar_screen.dart';
import '../presentations/shared_ui/profileTab/views/health/medication/medication_screen.dart';
import '../presentations/shared_ui/profileTab/views/health/medication/record_medication_screen.dart';
import '../presentations/shared_ui/shop/cart/cart_screen.dart';
import '../presentations/shared_ui/shop/delivery_address/deliver_details_screen.dart';
import '../presentations/shared_ui/shop/my_orders_screen.dart';
import '../presentations/shared_ui/shop/payment/product_payment_screen.dart';
import '../presentations/shared_ui/shop/product_details.dart';
import '../presentations/shared_ui/shop/shop_screen.dart';
import '../presentations/shared_ui/authentication/views/forgot_password/forgot_password.dart';
import '../presentations/shared_ui/authentication/views/login/login_screen.dart';
import '../presentations/shared_ui/authentication/views/sign_up/sign_up_screen.dart';
import '../presentations/doctor_side/appointments/appointment_details.dart';
import '../presentations/client_side/doctorsTab/views/doctor_profile_summary_Screen.dart';
import '../presentations/client_side/homeTab/views/blog_screen.dart';
import '../presentations/client_side/homeTab/views/pharmacy/pharmacy_screen.dart';
import '../presentations/client_side/homeTab/views/symptomChecker/symptom_checker_Screen.dart';
import '../presentations/doctor_side/charges/charges_screen.dart';
import '../presentations/doctor_side/personnal_info/information_screen.dart';
import '../presentations/shared_ui/landing_screen.dart';

import '../presentations/shared_ui/profileTab/views/pages/articles_page.dart';
import '../presentations/shared_ui/profileTab/views/pages/profile_page.dart';
import '../presentations/shared_ui/welcome_screen/welcome_screen.dart';
import '../presentations/supplier_side/upload_product/upload_product_screen.dart';
import '../presentations/supplier_side/product_catalog/supplier_product_catalog.dart';

//authentication routes
const String signUpScreen = 'authPage';
const String loginScreen = 'loginPage';
const String signUpOtpScreen = 'signUpOtpScreen';
const String loginOtpScreen = 'loginOtpScreen';
const String passwordOtpScreen = 'passwordOtpPage';
const String welcomeScreen = 'welcome';
const String welcomeMessageScreen = 'welcomeMessage';

//doctor routes
const String charges = 'charges';
const String personalInfo = 'personalInfo';
const String schedule = 'schedule';

//client routes
const String doctorBySymptomsScreen = 'doctorBySymptomsScreen';
const String ambulanceScreen = 'ambulance';
const String pharmacyScreen = 'pharmacy';
const String doctorProfile = 'doctorProfile';
const String symptomCheckerScreen = 'symptomChecker';
const String symptomSamples = 'symptomSamples';
const String appointmentDetails = 'appointmentDetails';
const String bookingScreen = "booking";
const String paymentScreen = "payment";
const String resetPassword = "resetPassword";
const String clientAppointments = "clientAppointments";

//supplier routes
const String supplierHomeScreen = "supplierHomeScreen";
const String supplierProductCatalogueScreen = "supplierProductCatalogue";
const String uploadProductScreen = "supplierAddProduct";
const String supplierOrderScreen = "supplierOrderScreen";

//shared routes
const String articles = "articles";
const String profile = "profile";
const String homeScreen = 'homePage';
const String blogScreen = 'blogScreen';
const String shopScreen = 'shopScreen';
const String cartScreen = 'cartScreen';
const String checkoutScreen = 'checkoutScreen';
const String myOrders = 'myOrders';
const String orderDetailsScreen = 'orderDetailsScreen';
const String productDetailsScreen = 'productDetailsScreen';
const String productScreen = 'productReviewsScreen';
const String deliveryAddressScreen = 'deliveryAddressScreen';
const String productPaymentScreen = 'productPaymentScreen';
const String bloodGlucoseScreen = 'bloodGlucoseScreen';
const String bloodGlucoseHistoryScreen = 'bloodGlucoseHistoryScreen';
const String recordSugarScreen = 'recordSugarScreen';
const String medicationScreen = 'medicationScreen';
const String recordMedicationScreen = 'recordMedicationScreen';
const String chatBotScreen = 'chatBotScreen';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case welcomeMessageScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeMessageScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case loginOtpScreen:
        return MaterialPageRoute(builder: (_) => LoginOtpScreen());
      case signUpOtpScreen:
        return MaterialPageRoute(builder: (_) => SignUpOtpScreen());
      case clientAppointments:
        return MaterialPageRoute(builder: (_) => ClientAppointmentsScreen());
      case ambulanceScreen:
        return MaterialPageRoute(builder: (_) => AmbulanceScreen());
      case paymentScreen:
        return MaterialPageRoute(builder: (_) => PaymentScreen());
      case bookingScreen:
        return MaterialPageRoute(builder: (_) => BookingScreen());
      case pharmacyScreen:
        return MaterialPageRoute(builder: (_) => PharmacyScreen());
      case schedule:
        return MaterialPageRoute(builder: (_) => ScheduleScreen());

      case charges:
        return MaterialPageRoute(builder: (_) => ChargesScreen());
      case personalInfo:
        return MaterialPageRoute(builder: (_) => PersonalDetailsScreen());
      case doctorBySymptomsScreen:
        return MaterialPageRoute(builder: (_) => DoctorBySymptomsScreen());
      case blogScreen:
        return MaterialPageRoute(
            builder: (_) => BlogScreen(blog: settings.arguments as BlogModel));
      case appointmentDetails:
        return MaterialPageRoute(
            builder: (_) => AppointmentDetailsScreen(
                appointment: settings.arguments as AppointmentModel));
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomePage());
      case doctorProfile:
        return MaterialPageRoute(
            builder: (_) => DoctorProfileSummaryPage(
                doctor: settings.arguments as DoctorProfileModel));
      case symptomCheckerScreen:
        return MaterialPageRoute(builder: (_) => SymptomChecker());
      case symptomSamples:
        return MaterialPageRoute(
            builder: (_) => SymptomSamples(
                bodyPartNotifier: settings.arguments as BodyPartNotifier));
      case profile:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case articles:
        return MaterialPageRoute(builder: (context) => ArticlesPage());
      //shop
      case shopScreen:
        return MaterialPageRoute(builder: (context) => ShopScreen());
      case productScreen:
        return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
                  product: settings.arguments as ProductModel,
                ));
      case cartScreen:
        return MaterialPageRoute(builder: (context) => CartScreen());
      case myOrders:
        return MaterialPageRoute(builder: (context) => MyOrdersScreen());
      case deliveryAddressScreen:
        return MaterialPageRoute(builder: (context) => DeliveryAddressScreen());
      case productPaymentScreen:
        return MaterialPageRoute(builder: (context) => ProductPaymentScreen());

      //supplier routes
      case supplierHomeScreen:
        return MaterialPageRoute(builder: (context) => SupplierHomeScreen());
      case supplierProductCatalogueScreen:
        return MaterialPageRoute(
            builder: (context) => SupplierProductCatalogScreen());
      case uploadProductScreen:
        return MaterialPageRoute(builder: (context) => UploadProductScreen());

      //Profile routes
      case bloodGlucoseScreen:
        return MaterialPageRoute(builder: (context) => BoodSugarScreen());
      case recordSugarScreen:
        return MaterialPageRoute(builder: (context) => RecordBloodScreen());
      case bloodGlucoseHistoryScreen:
        return MaterialPageRoute(
            builder: (context) => DetailedRecordsScreen(
                records: settings.arguments as List<BloodSugarModel>));
      case medicationScreen:
        return MaterialPageRoute(builder: (context) => MedicationScreen());
      case recordMedicationScreen:
        return MaterialPageRoute(
            builder: (context) => RecordMedicationScreen());
      case chatBotScreen:
        return MaterialPageRoute(builder: (context) => ChatBotScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(child: Text('${settings.name} coming soon!'))));
    }
  }
}
