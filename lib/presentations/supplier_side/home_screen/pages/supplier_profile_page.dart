import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/supplier_side/home_screen/widget/supplier_profile_header.dart';

import '../../../../logic/bloc/shared_bloc/auth_status/auth_status_bloc.dart';
import '../../../client_side/homeTab/widgets/authentication_dialog.dart';
import '../../../client_side/homeTab/widgets/divice_dialog.dart';
import '../../../shared_ui/profileTab/widgets/log_out_dialog.dart';

class SupplierProfilePage extends StatelessWidget {
  const SupplierProfilePage({super.key});
  static const List<Map<String, dynamic>> pages = [
    {"profile": "Basic info"},
    {"articles": "Articles"},
    {"health": "Health Tracking "},
    {"divice": "Add devices"},
    {"myOrders": "My orders"},
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SupplierProfileHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: pages.length,
              itemBuilder: (context, index) {
                final route = pages[index].keys.first;
                final title = pages[index].values.first;
                return Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.1))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<AuthStatusBloc, AuthStatusState>(
                      builder: (context, state) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                  index == 0
                                      ? Icons.person_outline
                                      : index == 1
                                          ? Icons.article_outlined
                                          : index == 2
                                              ? Icons.favorite_border_outlined
                                              : index == 3
                                                  ? Icons.devices
                                                  : Icons
                                                      .shopping_cart_outlined,
                                  color: Colors.blue)),
                          title: Text(title,
                              style: const TextStyle(color: Colors.black)),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Handle list item tap
                            // You can navigate to the corresponding route using Navigator
                            if (route == 'divice') {
                              diviceDialog(context);
                            }
                            if (state is UserAuthenticated) {
                              if (route == 'divice') {
                                diviceDialog(context);
                              } else {
                                Navigator.pushNamed(context, route);
                              }
                            } else if (state is UserUnauthenticated) {
                              loginDialog(context);
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          BlocBuilder<AuthStatusBloc, AuthStatusState>(
            builder: (context, state) {
              return Visibility(
                visible: state is UserAuthenticated,
                child: TextButton(
                  onPressed: () => logOutDialog(context),
                  child: const Text('Logout',
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                ),
              );
            },
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
