class TravelModel {
  late  var totalCount;
  late  List<ResultList> resultList;

  TravelModel({required this.totalCount, required this.resultList});

  TravelModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      resultList =  [];
      json['resultList'].forEach((v) {
        resultList.add( ResultList.fromJson(v));
      });
    }
  }

}

class ResultList {
  late  var type;
  late  Article article;

  ResultList({required this.type, required this.article});

  ResultList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    article = (json['article'] != null
        ?  Article.fromJson(json['article'])
        : null)!;
  }

}

class Article {
  late  var articleId;
  late  var productType;
  late  var sourceType;
  late  String articleTitle;
  late  String content;
  late  String contentWithoutCtag;
  late  Author author;
  late  List<Images> images;
  late  CoverGIF coverGIF;
  late  bool hasVideo;
  late  Video video;
  late  var readCount;
  late  var likeCount;
  late  var commentCount;
  late  var shareCount;
  late  List<Urls> urls;
  late  List<Tags> tags;
  late  List<Topics> topics;
  late  List<RelatedTopics> relatedTopics;
  late  List<Pois> pois;
  late  String publishTime;
  late  String publishTimeDisplay;
  late  String shootTime;
  late  String shootTimeDisplay;
  late  var level;
  late  String distanceText;
  late  bool isLike;
  late  var imageCounts;
  late  bool isCollected;
  late  var collectCount;
  late  var articleStatus;
  late  String poiName;
  late  ShareInfo shareInfo;
  late  String currentDate;
  late  var sourceId;
  late  String videoAutoplayNet;
  late  String combinateContent;

  Article(
      {required this.articleId,
      required this.productType,
      required this.sourceType,
      required this.articleTitle,
      required this.content,
      required this.contentWithoutCtag,
      required this.author,
      required this.images,
      required this.coverGIF,
      required this.hasVideo,
      required this.video,
      required this.readCount,
      required this.likeCount,
      required this.commentCount,
      required this.shareCount,
      required this.urls,
      required this.tags,
      required this.topics,
      required this.relatedTopics,
      required this.pois,
      required this.publishTime,
      required this.publishTimeDisplay,
      required this.shootTime,
      required this.shootTimeDisplay,
      required this.level,
      required this.distanceText,
      required this.isLike,
      required this.imageCounts,
      required this.isCollected,
      required this.collectCount,
      required this.articleStatus,
      required this.poiName,
      required this.shareInfo,
      required this.currentDate,
      required this.sourceId,
      required this.videoAutoplayNet,
      required this.combinateContent});

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    productType = json['productType'];
    sourceType = json['sourceType'];
    articleTitle = json['articleTitle'];
    content = json['content'];
    contentWithoutCtag = json['contentWithoutCtag'];
    author =
        (json['author'] != null ?  Author.fromJson(json['author']) : null)!;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add( Images.fromJson(v));
      });
    }
    coverGIF = (json['coverGIF'] != null
        ?  CoverGIF.fromJson(json['coverGIF'])
        : null)!;
    hasVideo = json['hasVideo'];
    video = (json['video'] != null ?  Video.fromJson(json['video']) : null)!;
    readCount = json['readCount'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    shareCount = json['shareCount'];
    if (json['urls'] != null) {
      urls = [];
      json['urls'].forEach((v) {
        urls.add( Urls.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags.add( Tags.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = [];
      json['topics'].forEach((v) {
        topics.add( Topics.fromJson(v));
      });
    }
    if (json['relatedTopics'] != null) {
      relatedTopics = [];
      json['relatedTopics'].forEach((v) {
        relatedTopics.add( RelatedTopics.fromJson(v));
      });
    }
    if (json['pois'] != null) {
      pois = [];
      json['pois'].forEach((v) {
        pois.add( Pois.fromJson(v));
      });
    }
    publishTime = json['publishTime'];
    publishTimeDisplay = json['publishTimeDisplay'];
    shootTime = json['shootTime'];
    shootTimeDisplay = json['shootTimeDisplay'];
    level = json['level'];
    distanceText = json['distanceText'];
    isLike = json['isLike'];
    imageCounts = json['imageCounts'];
    isCollected = json['isCollected'];
    collectCount = json['collectCount'];
    articleStatus = json['articleStatus'];
    poiName = json['poiName'];
    shareInfo = (json['shareInfo'] != null
        ?  ShareInfo.fromJson(json['shareInfo'])
        : null)!;
    currentDate = json['currentDate'];
    sourceId = json['sourceId'];
    videoAutoplayNet = json['videoAutoplayNet'];
    combinateContent = json['combinateContent'];
  }

}

class Author {
  late  var authorId;
  late  String nickName;
  late  String clientAuth;
  late  String userUrl;
  late  String jumpUrl;
  late  CoverImage coverImage;
  late  String qualification;
  late  var identityType;
  late  String identityTypeName;
  late  String tag;
  late  var followCount;
  late  String vIcon;
  late  var levelValue;
  late  String levelValueText;
  late  String identityDesc;
  late  bool isStarAccount;
  late  List<ShowTagList> showTagList;
  late  String describe;
  late  List<UserTags> userTags;

  Author(
      {required this.authorId,
      required this.nickName,
      required this.clientAuth,
      required this.userUrl,
      required this.jumpUrl,
      required this.coverImage,
      required this.qualification,
      required this.identityType,
      required this.identityTypeName,
      required this.tag,
      required this.followCount,
      required this.vIcon,
      required this.levelValue,
      required this.levelValueText,
      required this.identityDesc,
      required this.isStarAccount,
      required this.showTagList,
      required this.describe,
      required this.userTags});

  Author.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
    nickName = json['nickName'];
    clientAuth = json['clientAuth'];
    userUrl = json['userUrl'];
    jumpUrl = json['jumpUrl'];
    coverImage = (json['coverImage'] != null
        ?  CoverImage.fromJson(json['coverImage'])
        : null)!;
    qualification = json['qualification'];
    identityType = json['identityType'];
    identityTypeName = json['identityTypeName'];
    tag = json['tag'];
    followCount = json['followCount'];
    vIcon = json['vIcon'];
    levelValue = json['levelValue'];
    levelValueText = json['levelValueText'];
    identityDesc = json['identityDesc'];
    isStarAccount = json['isStarAccount'];
    if (json['showTagList'] != null) {
      showTagList = [];
      json['showTagList'].forEach((v) {
        showTagList.add( ShowTagList.fromJson(v));
      });
    }
    describe = json['describe'];
    if (json['userTags'] != null) {
      userTags = [];
      json['userTags'].forEach((v) {
        userTags.add( UserTags.fromJson(v));
      });
    }
  }

}

class CoverImage {
  late  String dynamicUrl;
  late  String originalUrl;

  CoverImage({required this.dynamicUrl, required this.originalUrl});

  CoverImage.fromJson(Map<String, dynamic> json) {
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
  }

}

class ShowTagList {
  late  var tagStyle;
  late  var tagType;
  late  String tagName;
  late  String tagShortName;
  late  TagStyleMap tagStyleMap;

  ShowTagList(
      {required this.tagStyle,
      required this.tagType,
      required this.tagName,
      required this.tagShortName,
      required this.tagStyleMap});

  ShowTagList.fromJson(Map<String, dynamic> json) {
    tagStyle = json['tagStyle'];
    tagType = json['tagType'];
    tagName = json['tagName'];
    tagShortName = json['tagShortName'];
    tagStyleMap = (json['tagStyleMap'] != null
        ?  TagStyleMap.fromJson(json['tagStyleMap'])
        : null)!;
  }

}

class TagStyleMap {
  late  White white;
  late  White black;

  TagStyleMap({required this.white, required this.black});

  TagStyleMap.fromJson(Map<String, dynamic> json) {
    white = (json['white'] != null ?  White.fromJson(json['white']) : null)!;
    black = (json['black'] != null ? White.fromJson(json['black']) : null)!;
  }

}

class White {
  late  var tagStyleId;
  late  String tagStyleFont;
  late  String tagStyleBack;
  late  String tagStyleBackARGB;

  White(
      {required this.tagStyleId,
      required this.tagStyleFont,
      required this.tagStyleBack,
      required this.tagStyleBackARGB});

  White.fromJson(Map<String, dynamic> json) {
    tagStyleId = json['tagStyleId'];
    tagStyleFont = json['tagStyleFont'];
    tagStyleBack = json['tagStyleBack'];
    tagStyleBackARGB = json['tagStyleBackARGB'];
  }

}

class UserTags {
  late  var tagType;
  late  String tagName;
  late  String tagDesc;
  late  String appUrl;
  late  String h5Url;
  late  String wxUrl;

  UserTags(
      {required this.tagType,
      required this.tagName,
      required this.tagDesc,
      required this.appUrl,
      required this.h5Url,
      required this.wxUrl});

  UserTags.fromJson(Map<String, dynamic> json) {
    tagType = json['tagType'];
    tagName = json['tagName'];
    tagDesc = json['tagDesc'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

}

class Images {
  late  var imageId;
  late  String dynamicUrl;
  late  String originalUrl;
  late  var width;
  late  var height;
  late  var mediaType;
  late  var lat;
  late  var lon;

  Images(
      {required this.imageId,
      required this.dynamicUrl,
      required this.originalUrl,
      required this.width,
      required this.height,
      required this.mediaType,
      required this.lat,
      required this.lon});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
    lat = json['lat'];
    lon = json['lon'];
  }

}

class CoverGIF {
  late  String originalUrl;

  CoverGIF({required this.originalUrl});

  CoverGIF.fromJson(Map<String, dynamic> json) {
    originalUrl = json['originalUrl'];
  }

}

class Video {
  late  var videoId;
  late  String coverImageUrl;
  late  String videoUrl;
  late  var mediaType;
  late  var width;
  late  var height;
  late  var durationSeconds;

  Video(
      {required this.videoId,
      required this.coverImageUrl,
      required this.videoUrl,
      required this.mediaType,
      required this.width,
      required this.height,
      required this.durationSeconds});

  Video.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    coverImageUrl = json['coverImageUrl'];
    videoUrl = json['videoUrl'];
    mediaType = json['mediaType'];
    width = json['width'];
    height = json['height'];
    durationSeconds = json['durationSeconds'];
  }

}

class Urls {
  late  String version;
  late  String appUrl;
  late  String h5Url;
  late  String wxUrl;

  Urls(
      {required this.version,
      required this.appUrl,
      required this.h5Url,
      required this.wxUrl});

  Urls.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

}

class Tags {
  late  var tagId;
  late  String tagName;
  late  var tagLevel;
  late  var parentTagId;
  late  var source;
  late  var sortIndex;

  Tags(
      {required this.tagId,
      required this.tagName,
      required this.tagLevel,
      required this.parentTagId,
      required this.source,
      required this.sortIndex});

  Tags.fromJson(Map<String, dynamic> json) {
    tagId = json['tagId'];
    tagName = json['tagName'];
    tagLevel = json['tagLevel'];
    parentTagId = json['parentTagId'];
    source = json['source'];
    sortIndex = json['sortIndex'];
  }

}

class Topics {
  late  var topicId;
  late  String topicName;
  late  var level;
  late  Image image;
  late  Image iconImage;

  Topics(
      {required this.topicId,
      required this.topicName,
      required this.level,
      required this.image,
      required this.iconImage});

  Topics.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'];
    topicName = json['topicName'];
    level = json['level'];
    image = (json['image'] != null ?  Image.fromJson(json['image']) : null)!;
    iconImage = (json['iconImage'] != null
        ?  Image.fromJson(json['iconImage'])
        : null)!;
  }

}

class Image {
  late  var imageId;
  late  String dynamicUrl;
  late  String originalUrl;
  late  var width;
  late  var height;
  late  var mediaType;
  late  var lat;
  late  var lon;

  Image(
      {required this.imageId,
      required this.dynamicUrl,
      required this.originalUrl,
      required this.width,
      required this.height,
      required this.mediaType,
      required this.lat,
      required this.lon});

  Image.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
    lat = json['lat'];
    lon = json['lon'];
  }

}

class RelatedTopics {
  late  var topicId;
  late  String topicName;
  late  var type;

  RelatedTopics(
      {required this.topicId, required this.topicName, required this.type});

  RelatedTopics.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'];
    topicName = json['topicName'];
    type = json['type'];
  }

}

class Pois {
  late  var poiType;
  late  var poiId;
  late  String poiName;
  late  var districtId;
  late  String districtName;
  late  String districtENName;
  late  PoiExt poiExt;
  late  var source;
  late  var isMain;
  late  bool isInChina;
  late  var businessId;
  late  String countryName;

  Pois(
      {required this.poiType,
      required this.poiId,
      required this.poiName,
      required this.districtId,
      required this.districtName,
      required this.districtENName,
      required this.poiExt,
      required this.source,
      required this.isMain,
      required this.isInChina,
      required this.businessId,
      required this.countryName});

  Pois.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    districtENName = json['districtENName'];
    poiExt =
        (json['poiExt'] != null ?  PoiExt.fromJson(json['poiExt']) : null)!;
    source = json['source'];
    isMain = json['isMain'];
    isInChina = json['isInChina'];
    businessId = json['businessId'];
    countryName = json['countryName'];
  }

}

class PoiExt {
  late  String h5Url;
  late  String appUrl;

  PoiExt({required this.h5Url, required this.appUrl});

  PoiExt.fromJson(Map<String, dynamic> json) {
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

}

class ShareInfo {
  late  String imageUrl;
  late  String shareTitle;
  late  String shareContent;
  late  String platForm;
  late  String token;

  ShareInfo(
      {required this.imageUrl,
      required this.shareTitle,
      required this.shareContent,
      required this.platForm,
      required this.token});

  ShareInfo.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    shareTitle = json['shareTitle'];
    shareContent = json['shareContent'];
    platForm = json['platForm'];
    token = json['token'];
  }

}
