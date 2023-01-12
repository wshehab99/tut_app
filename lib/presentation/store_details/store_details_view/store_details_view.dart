import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';
import 'package:tut_app/presentation/store_details/store_details_view_model/store_details_view_model.dart';

import '../../resources/string_manger.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _storeDetailsViewModel =
      instance<StoreDetailsViewModel>();
  @override
  void initState() {
    _storeDetailsViewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    _storeDetailsViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store details"),
      ),
      body: StreamBuilder<FlowState>(
          stream: _storeDetailsViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getWidget(context, _getContent(), () {}) ??
                _getContent();
          }),
    );
  }

  Widget _getContent() {
    return StreamBuilder<StoreDetails>(
        stream: _storeDetailsViewModel.outputStoreDetails,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Image.network(snapshot.data!.image),
                      const SizedBox(
                        height: SizeValuesManager.s10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SizeValuesManager.s10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getSection(StringManger.services),
                            const SizedBox(
                              height: SizeValuesManager.s10,
                            ),
                            _getText(snapshot.data!.services),
                            const SizedBox(
                              height: SizeValuesManager.s10,
                            ),
                            _getSection(snapshot.data!.title),
                            const SizedBox(
                              height: SizeValuesManager.s10,
                            ),
                            _getText(snapshot.data!.about),
                            const SizedBox(
                              height: SizeValuesManager.s10,
                            ),
                            _getSection(StringManger.description),
                            const SizedBox(
                              height: SizeValuesManager.s10,
                            ),
                            _getText(snapshot.data!.details),
                          ],
                        ),
                      ),
                    ],
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

  Widget _getText(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
