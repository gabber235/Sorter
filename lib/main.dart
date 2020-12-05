import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sorter/sort.dart';

void main() {
  runApp(ProviderScope(child: SorterApp()));
}

class SorterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: SorterPage(),
    );
  }
}

class SorterPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final index = useProvider(sorting.select((value) => value.index));
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          Container(),
          Container(),
          Container(),

          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

class InputPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sort a list!'),
        Text('Fill in a list so you can sort it easily! Space the text with either , or enters to divide the words'),

        TextField(
          controller: controller,
        ),

        ElevatedButton(
          onPressed: () => context.read(sorting).startSortByString(controller.text),
          child: Text('Start Sorting!'),
        ),
      ],
    );
  }
}

