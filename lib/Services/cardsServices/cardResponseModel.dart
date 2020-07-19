class CardsResponse {
  int count;
  String next;
  String previous;
  List<CardsResults> results;

  CardsResponse({this.count, this.next, this.previous, this.results});

  CardsResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<CardsResults>();
      json['results'].forEach((v) {
        results.add(new CardsResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardsResults {
  String question;
  String hint;
  String company;
  String tags;

  CardsResults({this.question, this.hint, this.company, this.tags});

  CardsResults.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    hint = json['hint'];
    company = json['company'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['hint'] = this.hint;
    data['company'] = this.company;
    data['tags'] = this.tags;
    return data;
  }
}