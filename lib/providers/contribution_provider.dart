import 'package:flutter/widgets.dart';

import 'package:bloc_test/models/rocks_api.dart';
import 'package:bloc_test/blocs/contribution_bloc.dart';

class ContributionProvider extends InheritedWidget {
  final ContributionBloc contributionBloc;

  @override
  bool updateShouldNotify(ContributionProvider old) => true;

  static ContributionBloc of(BuildContext context) => (context.inheritFromWidgetOfExactType(ContributionProvider) as ContributionProvider).contributionBloc;

  ContributionProvider({
    Key key,
    ContributionBloc contributionBloc,
    @required Widget child,
  }) : this.contributionBloc = contributionBloc ?? ContributionBloc(RocksApi(),),
        super(key: key, child: child);

}
