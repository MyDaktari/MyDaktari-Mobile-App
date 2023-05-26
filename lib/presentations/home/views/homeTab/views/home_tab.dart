import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/cubit/page_update/page_update_cubit.dart';
import 'package:my_daktari/presentations/home/widgets/scroll_behavior.dart';

import '../../../../../logic/bloc/blog/blog_bloc.dart';
import '../../../widgets/tab_header_bar.dart';
import '../widgets/blog_card.dart';
import '../widgets/grid_item.dart';
import '/constants/constants.dart' as constants;

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});
  final List<Map<String, dynamic>> grids = [
    {
      'image': 'assets/images/reminder.png',
      'title': 'Symptom Checker',
      'route': 'symptomChecker'
    },
    {'image': 'assets/images/reminder.png', 'title': 'reminder', 'route': ''},
    // {
    //   'image': 'assets/images/virus.png',
    //   'title': 'Allergy Tracker',
    //   'route': 'allergyTracker'
    // },
    {
      'image': 'assets/images/graph-report.png',
      'title': 'Call an Ambulance',
      'route': 'CallanAmbulance'
    },
    // {
    //   'image': 'assets/images/pharmacist.png',
    //   'title': 'Prescription Discounts',
    //   'route': 'prescriptionDiscounts'
    // },
    {
      'image': 'assets/images/engage.png',
      'title': 'Pharmarcies',
      'route': 'Pharmarcies'
    },
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
            title: Text(
              'Talk to Aya,',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text('Your virtual assistant.',
                style: Theme.of(context).textTheme.titleMedium),
            button: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21)),
                    backgroundColor: constants.greenish),
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
                }),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Top News',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(child: BlocBuilder<BlogBloc, BlogState>(
            builder: (context, state) {
              if (state is BlogLoading) {
                return Center(child: const CircularProgressIndicator());
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
                        icon: Icon(Icons.refresh_rounded))
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
