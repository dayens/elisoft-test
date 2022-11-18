import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_elisoft/model/article_model.dart';
import 'package:flutter_test_elisoft/presentation/bloc/user_cubit.dart';
import 'package:flutter_test_elisoft/service/api_service.dart';
import 'package:shimmer/shimmer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SafeArea(
            child: Column(
              children: [
                FutureBuilder<ListArticles?>(
                  future: ApiService().getListArticles(),
                  builder: (context, state) {
                    if (state.hasData) {
                      final data = state.data?.articles;
                      return Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Welcome, ',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                user?.name ?? '-',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: height * 25 / 100,
                            width: width * 90 / 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data?.length,
                                itemBuilder: (context, index) {
                                  return topCard(context, data![index]);
                                }),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: height * 60 / 100,
                            width: width * 90 / 100,
                            child: ListView.builder(
                                itemCount: data?.length,
                                itemBuilder: (context, index) {
                                  return bottomCard(context, data![index]);
                                }),
                          ),
                        ],
                      );
                    }

                    return shimmerDashboard(context, height, width);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget topCard(BuildContext context, ArticleModel? articleModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 31.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(36, 120, 129, 1)),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 350,
            width: 210,
            child: Column(
              children: [
                Text(articleModel?.title ?? ''),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  articleModel?.content ?? '',
                  maxLines: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomCard(BuildContext context, ArticleModel? articleModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(36, 120, 129, 0.15),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 200,
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            articleModel?.image ?? '',
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                  title: Text(
                    articleModel?.title ?? '',
                    maxLines: 3,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  articleModel?.content ?? '',
                  maxLines: 6,
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(articleModel?.created?['date']
                      .toString()
                      .substring(0, 19) ??
                      '-'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget shimmerDashboard(BuildContext context, double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 160,
                height: 28,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: height * 25 / 100,
            width: width * 90 / 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 31.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(36, 120, 129, 1)),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 350,
                          width: 210,
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                              BorderRadius.all(Radius.circular(6))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 18,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                width: 200,
                                height: 18,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: height * 60 / 100,
            width: width * 90 / 100,
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(36, 120, 129, 0.15),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 200,
                          color: Colors.grey.withAlpha(70),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.black45,
                                  ),
                                ),
                                title: Container(
                                  width: 200,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                width: 200,
                                height: 80,
                                decoration: const BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 180,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}


