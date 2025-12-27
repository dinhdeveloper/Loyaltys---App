import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'base_viewmodel.dart';

abstract class BaseScreen<T extends BaseViewModel> extends StatefulWidget {
  const BaseScreen({super.key});

  /// Nếu muốn, có thể override để truyền arguments
  Object? get arguments => null;

  /// Lấy provider từ GetIt
  T get provider => GetIt.instance<T>();
}

/// BaseScreenState
abstract class BaseScreenState<T extends BaseViewModel, S extends BaseScreen<T>>
    extends State<S> {
  late final T provider;

  @override
  void initState() {
    super.initState();
    provider = widget.provider;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Gán context cho ViewModel
    provider.context = context;

    // Lấy arguments ưu tiên widget.arguments, nếu null thì lấy từ ModalRoute
    provider.arguments =
        widget.arguments ?? ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{};

    // Chỉ init lần đầu
    if (!provider.isInit) {
      provider.isInit = true;
      provider.initBaseData();
      initFunction();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initWithPostFrameCallback();
      });
    }
  }

  /// Override để init dữ liệu trước build UI
  void initFunction() {}

  /// Override nếu cần chạy sau khi widget build xong
  void initWithPostFrameCallback() {}

  /// Build UI
  Widget buildChild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: provider,
      child: Consumer<T>(
        builder: (context, vm, _) => buildChild(context),
      ),
    );
  }
}
