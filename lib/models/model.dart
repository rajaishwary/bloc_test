class Contribution {
  final String author;
  final String category;
  final String moderator;
  final String repository;
  final String created;
  final String reviewDate;
  final String title;
  final double totalPayout;
  final String url;
  final String status;

  Contribution({
    this.author,
    this.category,
    this.moderator,
    this.repository,
    this.created,
    this.reviewDate,
    this.title,
    this.totalPayout,
    this.url,
    this.status,
  });

  Contribution.fromJson(Map json)
      : author = json['author'],
        category = (json['category'] as String)
            .replaceFirst('-task', '')
            .replaceFirst("task-", ''),
        moderator = json['moderator'],
        repository = (json['repository'] as String)
            .replaceFirst('https://github.com/', ''),
        title = json['title'],
        totalPayout = json['totalPayout'] as double,
        url = json['title'],
        created = json['created'],
        reviewDate = json['reviewDate'],
        status = json['status'];
}

//{
//author: "zularizal",
//beneficiaries_set: false,
//category: "graphics",
//comment_url: "re-zularizal-logo-for-timetable-20181213t103733564z",
//created: "2018-12-09 00:50:54",
//is_vipo: false,
//moderator: "oups",
//picked_by: "",
//repository: "https://github.com/ulan17/TimeTable",
//review_date: "2018-12-13 10:38:09",
//review_status: "pending",
//score: 78,
//staff_picked: false,
//status: "pending",
//title: "Logo For TimeTable",
//total_comments: 3,
//total_payout: 1.512,
//total_votes: 61,
//url: "https://steemit.com/utopian-io/@zularizal/logo-for-timetable",
//utopian_vote: 0,
//valid_age: true,
//voted_on: false,
//voting_weight: 29.379302971278484
//}
