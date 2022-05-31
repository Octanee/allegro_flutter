import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import '../../home/home.dart';
import '../loading.dart';

class LoadingFlow extends StatelessWidget {
  const LoadingFlow({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: LoadingFlow());

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<LoadingStatus>(
      state: LoadingStatus.token,
      onGeneratePages: _onGenerateLoadingFlow,
    );
  }

  List<Page> _onGenerateLoadingFlow(
    LoadingStatus status,
    List<Page<dynamic>> pages,
  ) {
    switch (status) {
      case LoadingStatus.token:
        return [TokenPage.page()];
      case LoadingStatus.synchronization:
        return [SynchronizationPage.page()];
      case LoadingStatus.complete:
        return [HomePage.page()];
    }
  }
}
