import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/main/pages/home/home_view_model/home_view_model.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();
  @override
  void initState() {
    _homeViewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _homeViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getWidget(
                context,
                _getContent(),
                () {},
              ) ??
              _getContent();
        });
  }

  Widget _getContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _getBanners(),
          const SizedBox(height: SizeValuesManager.s10),
          _getSection(StringManger.services),
          const SizedBox(height: SizeValuesManager.s10),
          _getServices(),
          const SizedBox(height: SizeValuesManager.s10),
          _getSection(StringManger.stores),
          const SizedBox(height: SizeValuesManager.s10),
          _getStores()
        ]),
      ),
    );
  }

  Widget _getBanners() {
    return StreamBuilder<List<BannerAd>>(
        stream: _homeViewModel.outputBanners,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? CarouselSlider(
                  items: snapshot.data
                      ?.map((banner) => Card(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(SizeValuesManager.s10),
                              child: Image.network(
                                banner.image,
                                height: SizeValuesManager.s150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    height: SizeValuesManager.s190,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                  ),
                )
              : const SizedBox();
        });
  }

  Widget _getSection(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _getServices() {
    return StreamBuilder<List<Services>>(
        stream: _homeViewModel.outputServices,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? SizedBox(
                  height: SizeValuesManager.s190,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Card(
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    SizeValuesManager.s10),
                                child: Image.network(
                                  snapshot.data![index].image,
                                  height: SizeValuesManager.s140,
                                  width: SizeValuesManager.s150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: SizeValuesManager.s10,
                              ),
                              Text(
                                snapshot.data![index].title,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ]),
                          ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: SizeValuesManager.s10),
                      itemCount: snapshot.data?.length ?? 0),
                )
              : const SizedBox();
        });
  }

  Widget _getStores() {
    return StreamBuilder<List<Store>>(
        stream: _homeViewModel.outputStores,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return GridView.count(
              crossAxisCount: SizeValuesManager.s2,
              physics: const ScrollPhysics(),
              mainAxisSpacing: SizeValuesManager.s10,
              crossAxisSpacing: SizeValuesManager.s10,
              shrinkWrap: true,
              children: snapshot.data!
                  .map((store) => InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RoutesManager.storeDetailsRoute);
                        },
                        child: Card(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    SizeValuesManager.s10),
                                child: Image.network(
                                  store.image,
                                  height: SizeValuesManager.s150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: SizeValuesManager.s4,
                              ),
                              Text(
                                store.title,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
