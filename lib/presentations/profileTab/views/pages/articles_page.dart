import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/bloc/client_bloc/blog/blog_bloc.dart';
import '../../../client_side/homeTab/widgets/blog_card.dart';
import '../../../widgets/custom_loading.dart';
import '../../../widgets/scroll_behavior.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Articles',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            elevation: 0),
        body: BlocBuilder<BlogBloc, BlogState>(
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
        ));
  }
}
