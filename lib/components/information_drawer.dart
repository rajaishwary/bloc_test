import 'package:flutter/material.dart';
import 'package:bloc_test/providers/information_provider.dart';

class InformationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Information Drawer',
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          _buildInfoPanel(context),
          Center(),
        ],
      ),
    );
  }
}

Widget _buildInfoPanel(BuildContext context) {
  final informationBloc = InformationProvider.of(context);
  return Flex(
    direction: Axis.vertical,
    children: [
      Container(
        padding: EdgeInsets.only(top: 30.0),
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Information',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      StreamBuilder(
          stream: informationBloc.infoStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Flex(
              direction: Axis.vertical,
              children: <Widget>[
                _buildInfoTile(
                  '${snapshot.data.appName}',
                  subtitle:
                      "Pre-release Version Number: ${snapshot.data.version}",
                ),
                _buildInfoTile(
                  'Instructions: ',
                  subtitle:
                      'Double tab on a contribution to open it in a Browser',
                ),
                _buildInfoTile(
                  'Author & Application Info',
                  subtitle: 'Developed by @rajaishwary',
                ),
                RaisedButton(
                  child: Text('Check for Update'),
                  onPressed: () => _getNewRelease(context, snapshot),
                ),
              ],
            );
          }),
    ],
  );
}

Widget _buildInfoTile(String title, {String subtitle}) {
  return ListTile(
    title: Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      subtitle ?? '',
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
    ),
  );
}

void _getNewRelease(BuildContext context, AsyncSnapshot snapshot) {
  final informationBloc = InformationProvider.of(context);

  informationBloc.releases.listen((releases) {
    print(snapshot);
    if (snapshot.data.version.toString() != releases.tagName) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('${snapshot.data.appName}'),
                content: Container(
                  child: Text(
                      'A new version of this application is available to download. The current version is ${snapshot.data.version} and the new version is ${releases.tagName}'),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Download'),
                    onPressed: () => null,
                  ),
                  FlatButton(
                    child: Text('Close'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('${snapshot.data.appName}'),
                content: Container(
                  child: Text('There is no new version at this time'),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ));
    }
  });
}
