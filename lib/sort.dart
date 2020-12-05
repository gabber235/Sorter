import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class Sort extends ChangeNotifier {

  Completer<String> _completer;
  List<String> _comparing = [];
  List<String> _request;
  List<String> _result;

  List<String> get comparing => _comparing;
  List<String> get request => _request;
  List<String> get result => _result;

  int get index => result != null ? 2 : comparing.isNotEmpty ? 1 : _request != null ? 3 : 0;

  void startSortByString(String string) {
    final list = string.split('\n').expand((s) => s.split(' ,'));
    startSort(list);
  }

  void startSort(List<String> list) async {
    _request = list;
    _comparing = [];
    _result = null;
    _completer = null;
    _result = await _sort(list);
    notifyListeners();
  }

  void giveResult(String string) {
    _completer?.complete(string);
  }

  Future<List<String>> _sort(List<String> list) async {
    if (list.length == 1) return list;
    final middle = (list.length / 2).floor();
    final lists = await Future.wait([
      _sort(list.sublist(0, middle)),
      _sort(list.sublist(middle)),
    ]);

    final newList = <String>[];
    var it1 = lists[0];
    var it2 = lists[1];
    while(it1.isNotEmpty && it2.isNotEmpty) {
      final result = await _compare(it1[0], it2[0]);
      newList.add(result);
      if(result == it1[0]) it1 = it1.sublist(1);
      else it2 = it2.sublist(1);
    }

    return [...newList, ...it1, ...it2];
  }

  Future<String> _compare(String s1, String s2) async {
    _comparing = [s1, s2];
    _completer = Completer();
    notifyListeners();
    return _completer.future;
  }
}

final sorting = ChangeNotifierProvider((_) => Sort());
