import 'package:flutter/material.dart';
import 'package:bloc_test/models/rocks_api.dart';
import 'package:bloc_test/models/model.dart';
import 'package:bloc_test/blocs/contribution_bloc.dart';
import 'package:bloc_test/providers/contribution_provider.dart';

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
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;

  ListPage(this.pageName, this.bloc);

  @override
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);
    return StreamBuilder(
      stream: bloc.results,
      builder: (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
        if(!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => ListTile(
          title: Text('${snapshot.data[index].title}'),
        ));
      },
    );
  }
}
