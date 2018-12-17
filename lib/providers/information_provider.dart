import 'package:flutter/widgets.dart';

import 'package:package_info/package_info.dart';

import 'package:bloc_test/models/github_api.dart';
import 'package:bloc_test/blocs/information_bloc.dart';

class InformationProvider extends InheritedWidget {
  final InformationBloc informationBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InformationBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(InformationProvider)
      as InformationProvider)
          .informationBloc;

  InformationProvider({
    Key key,
    InformationBloc informationBloc,
    Widget child,
  })  : this.informationBloc = informationBloc ??
      InformationBloc(
        PackageInfo.fromPlatform(),
        GithubApi(),
      ),
        super(
        key: key,
        child: child,
      );
}