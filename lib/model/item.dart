import 'item_type.dart';

class Item {
  int id;
  bool deleted;
  ItemType type;
  String by;
  int time;
  int score;
  String title;
  String url;

  Item({
    this.id,
    this.deleted,
    this.type,
    this.by,
    this.time,
    this.score,
    this.title,
    this.url,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'] ?? false;
    type = this._typeOf(json['type']);
    by = json['by'];
    time = json['time'];
    score = json['score'];
    title = json['title'];
    url = json['url'];
  }

  ItemType _typeOf(String type) {
    switch (type) {
      case ITEM_TYPE_STORY:
        return ItemType.STORY;
      case ITEM_TYPE_COMMENT:
        return ItemType.COMMENT;
      case ITEM_TYPE_JOB:
        return ItemType.JOB;
      case ITEM_TYPE_POLL:
        return ItemType.POLL;
      case ITEM_TYPE_POLL_OPT:
        return ItemType.POLL_OPT;
      default:
        return ItemType.UNKNOWN;
    }
  }
}
