import 'package:flutter/material.dart';
import 'package:up_api/style/up_api_spacing.dart';
import 'package:up_api/widgets/input_widget.dart';
import 'package:up_api/widgets/loading_button_widget.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({required this.resetHandler, super.key, this.onSearch, this.title});

  final void Function(String? query)? onSearch;
  final ValueNotifier<int> resetHandler;
  final String? title;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    widget.resetHandler.addListener(() {
      _searchController.clear();
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title ?? ''),
            UpApiSpacing.medium,
            Row(
              children: [
                Expanded(child: InputWidget(controller: _searchController, clearable: true,)),
                UpApiSpacing.largeHorizontal,
                SizedBox(
                  height: 55.5,
                  width: 55.5,
                  child: LoadingButtonWidget(
                    overrideStyle: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                    child: const Icon(Icons.search, size: 30),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      widget.onSearch?.call(_searchController.text);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
