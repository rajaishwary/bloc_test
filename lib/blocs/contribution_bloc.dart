import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bloc_test/models/model.dart';
import 'package:bloc_test/models/rocks_api.dart';

class ContributionBloc {
  final RocksApi rocksApi;

  Stream<List<Contribution>> _results = Stream.empty();

  BehaviorSubject<String> _pageName =
      BehaviorSubject<String>(seedValue: 'unreviewed');

  Stream<List<Contribution>> get results => _results;

  Sink<String> get pageName => _pageName;

  ContributionBloc(this.rocksApi) {
    _results = _pageName
        .asyncMap((page) => rocksApi.getContributions(pageName: page))
        .asBroadcastStream();
  }

  void dispose(){
    _pageName.close();
  }
}
