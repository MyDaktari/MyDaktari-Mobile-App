import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/cubit/page_update/page_update_cubit.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';
import 'package:my_daktari/presentations/widgets/scroll_behavior.dart';

import '../../../../constants/route.dart' as route;
import '../../../../constants/colors.dart';
import '../../../../logic/bloc/client_bloc/blog/blog_bloc.dart';
import '../../../widgets/tab_header_bar.dart';
import '../widgets/blog_card.dart';
import '../widgets/grid_item.dart';

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});
  final List<Map<String, dynamic>> grids = [
    {
      'image': 'assets/images/reminder.png',
      'title': 'Symptom Checker',
      'route': 'symptomChecker'
    },
    {'image': 'assets/images/reminder.png', 'title': 'reminder', 'route': ''},
    {
      'image': 'assets/images/graph-report.png',
      'title': 'Call an Ambulance',
      'route': 'ambulance'
    },
    {
      'image': 'assets/images/engage.png',
      'title': 'Pharmacies',
      'route': 'pharmacy'
    },

    // {
    //   'image': 'assets/images/virus.png',
    //   'title': 'Allergy Tracker',
    //   'route': 'allergyTracker'
    // },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          TabHeader(
            size: size,
            title: Text('Talk to Aya,',
                style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text('Your virtual assistant.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.lightgreen, fontWeight: FontWeight.w700)),
            button: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21)),
                    backgroundColor: AppColor.lightgreen),
                onPressed: () {
                  context.read<PageUpdateCubit>().setPageIndex(2);
                },
                child: const Text('Get Started')),
            image: Image.asset('assets/images/aya-half.png'),
          ),
          SizedBox(
              height: size.height * .18,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: grids.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> grid = grids[index];
                    return HomeGridItem(grid: grid);
                  })),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, route.shopScreen),
            child: Container(
              height: 80,
              width: size.width,
              padding: const EdgeInsets.all(8),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColor.lightGrey)),
              child: Column(
                children: [
                  Image.asset('assets/images/shop.png'),
                  Text('See Our Catalogue',
                      style: Theme.of(context).textTheme.titleMedium)
                ],
              ),
            ),
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Top Articles',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              )),
          Expanded(child: BlocBuilder<BlogBloc, BlogState>(
            builder: (context, state) {
              if (state is BlogLoading) {
                return Center(child: const CustomLoading());
              } else if (state is BlogLoaded) {
                return ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        context.read<BlogBloc>().add(LoadBlogs()),
                    child: ListView.builder(
                      itemCount: state.blogs.length,
                      itemBuilder: (context, index) {
                        return BlogCard(blog: state.blogs.elementAt(index));
                      },
                    ),
                  ),
                );
              } else if (state is BlogLoadingError) {
                return Center(
                    child: Column(
                  children: [
                    Text(state.message),
                    SizedBox(height: 15),
                    IconButton(
                        onPressed: () =>
                            context.read<BlogBloc>().add(LoadBlogs()),
                        icon: Icon(Icons.refresh_rounded)),
                  ],
                ));
              } else {
                return Center(
                    child: Column(
                  children: [
                    Text('An internal Error Occured'),
                    SizedBox(height: 15),
                    IconButton(
                        onPressed: () =>
                            context.read<BlogBloc>().add(LoadBlogs()),
                        icon: Icon(Icons.refresh_rounded))
                  ],
                ));
              }
            },
          ))
        ],
      ),
    );
  }
}
