class VideoData {
  String? kind;
  String? nextPageToken;
  PageInfo? pageInfo;
  List<Items>? items;

  VideoData({this.kind, this.nextPageToken, this.pageInfo, this.items});

  VideoData.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    nextPageToken = json['nextPageToken'];
    pageInfo = json['pageInfo'] != null ? new PageInfo.fromJson(json['pageInfo']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) { items!.add(new Items.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['nextPageToken'] = this.nextPageToken;
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({this.totalResults, this.resultsPerPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['resultsPerPage'] = this.resultsPerPage;
    return data;
  }
}

class Items {
  String? kind;
  Id? id;
  Snippet? snippet;

  Items({this.kind, this.id, this.snippet});

  Items.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    snippet = json['snippet'] != null ? new Snippet.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    if (this.snippet != null) {
      data['snippet'] = this.snippet!.toJson();
    }
    return data;
  }
}

class Id {
  String? kind;
  String? videoId;

  Id({this.kind, this.videoId});

  Id.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['videoId'] = this.videoId;
    return data;
  }
}

class Snippet {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  ThumbnailsData? thumbnails;
  String? channelTitle;
  String? liveBroadcastContent;
  String? publishTime;

  Snippet({this.publishedAt, this.channelId, this.title, this.description, this.thumbnails, this.channelTitle, this.liveBroadcastContent, this.publishTime});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null ? new ThumbnailsData.fromJson(json['thumbnails']) : null;
    channelTitle = json['channelTitle'];
    liveBroadcastContent = json['liveBroadcastContent'];
    publishTime = json['publishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishedAt'] = this.publishedAt;
    data['channelId'] = this.channelId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails!.toJson();
    }
    data['channelTitle'] = this.channelTitle;
    data['liveBroadcastContent'] = this.liveBroadcastContent;
    data['publishTime'] = this.publishTime;
    return data;
  }
}

class ThumbnailsData {
  Default? videoData;
  Default? medium;
  Default? high;

  ThumbnailsData({this.videoData, this.medium, this.high});

ThumbnailsData.fromJson(Map<String, dynamic> json) {
videoData = json['default'] != null ? new Default.fromJson(json['default']) : null;
medium = json['medium'] != null ? new Default.fromJson(json['medium']) : null;
high = json['high'] != null ? new Default.fromJson(json['high']) : null;
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
if (this.videoData != null) {
data['default'] = this.videoData!.toJson();
}
if (this.medium != null) {
data['medium'] = this.medium!.toJson();
}
if (this.high != null) {
data['high'] = this.high!.toJson();
}
return data;
}
}

class Default {
String? url;
int? width;
int? height;

Default({this.url, this.width, this.height});

Default.fromJson(Map<String, dynamic> json) {
url = json['url'];
width = json['width'];
height = json['height'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['url'] = this.url;
data['width'] = this.width;
data['height'] = this.height;
return data;
}
}

class ThumbnailsList {
Default? videoData;
Default? medium;
Default? high;

ThumbnailsList({this.videoData, this.medium, this.high});

ThumbnailsList.fromJson(Map<String, dynamic> json) {
videoData = json['default'] != null ? new Default.fromJson(json['default']) : null;
medium = json['medium'] != null ? new Default.fromJson(json['medium']) : null;
high = json['high'] != null ? new Default.fromJson(json['high']) : null;
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
if (this.videoData != null) {
data['default'] = this.videoData!.toJson();
}
if (this.medium != null) {
data['medium'] = this.medium!.toJson();
}
if (this.high != null) {
data['high'] = this.high!.toJson();
}
return data;
}
}
