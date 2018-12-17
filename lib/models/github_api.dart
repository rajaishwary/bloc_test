import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'package:bloc_test/models/model.dart';

class GithubApi {
  final Client _client = Client();
  static const String _url =
      'http://api.github.com/repos/rajaishwary/bloc_test/releases?client_id=4170279dc20b206feb75&client_secret=afc047c3be05ffba7c510dbfd0d89270880c4ffe';

  Future<GithubModel> getReleases() async {
    String resBody =
        await _client.get(Uri.parse(_url)).then((Response res) => res.body);
    List ghJson = json.decode(resBody);
    var x = ghJson.map((gh) => GithubModel.fromJson(gh)).toList();
    print(x);
    return x.first;
  }
}

//{
//url: "https://api.github.com/repos/rajaishwary/bloc_test/releases/14564588",
//assets_url: "https://api.github.com/repos/rajaishwary/bloc_test/releases/14564588/assets",
//upload_url: "https://uploads.github.com/repos/rajaishwary/bloc_test/releases/14564588/assets{?name,label}",
//html_url: "https://github.com/rajaishwary/bloc_test/releases/tag/rel",
//id: 14564588,
//node_id: "MDc6UmVsZWFzZTE0NTY0NTg4",
//tag_name: "rel",
//target_commitish: "master",
//name: "Test release",
//draft: false,
//author: {
//login: "rajaishwary",
//id: 7762321,
//node_id: "MDQ6VXNlcjc3NjIzMjE=",
//avatar_url: "https://avatars0.githubusercontent.com/u/7762321?v=4",
//gravatar_id: "",
//url: "https://api.github.com/users/rajaishwary",
//html_url: "https://github.com/rajaishwary",
//followers_url: "https://api.github.com/users/rajaishwary/followers",
//following_url: "https://api.github.com/users/rajaishwary/following{/other_user}",
//gists_url: "https://api.github.com/users/rajaishwary/gists{/gist_id}",
//starred_url: "https://api.github.com/users/rajaishwary/starred{/owner}{/repo}",
//subscriptions_url: "https://api.github.com/users/rajaishwary/subscriptions",
//organizations_url: "https://api.github.com/users/rajaishwary/orgs",
//repos_url: "https://api.github.com/users/rajaishwary/repos",
//events_url: "https://api.github.com/users/rajaishwary/events{/privacy}",
//received_events_url: "https://api.github.com/users/rajaishwary/received_events",
//type: "User",
//site_admin: false
//},
//prerelease: false,
//created_at: "2018-12-13T16:25:27Z",
//published_at: "2018-12-17T08:28:17Z",
//assets: [ ],
//tarball_url: "https://api.github.com/repos/rajaishwary/bloc_test/tarball/rel",
//zipball_url: "https://api.github.com/repos/rajaishwary/bloc_test/zipball/rel",
//body: ""
//}
