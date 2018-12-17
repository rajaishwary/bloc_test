import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'package:bloc_test/models/rocks_api.dart';
import 'package:bloc_test/models/github_api.dart';
import 'package:bloc_test/models/model.dart';

import 'package:bloc_test/blocs/contribution_bloc.dart';
import 'package:bloc_test/blocs/information_bloc.dart';
import 'package:bloc_test/providers/contribution_provider.dart';
import 'package:bloc_test/providers/information_provider.dart';

import 'package:bloc_test/components/list_page.dart';
import 'package:bloc_test/components/information_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContributionProvider(
      contributionBloc: ContributionBloc(
        RocksApi(),
      ),
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contributionBloc = ContributionProvider.of(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc_test',
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("bloc_test"),
              bottom: TabBar(tabs: <Widget>[
                Tab(
                  text: 'Waiting for review',
                ),
                Tab(
                  text: 'Waiting for upvote',
                )
              ]),
            ),
            body: TabBarView(children: <Widget>[
              ListPage('unreviewed', contributionBloc),
              ListPage('pending', contributionBloc)
            ]),
            endDrawer: InformationProvider(
              informationBloc: InformationBloc(
                PackageInfo.fromPlatform(),
                GithubApi(),
              ),
              child: InformationDrawer(),
            ),
          ),
        ));
  }
}
