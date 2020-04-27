class FlashCard {
  final String front;
  final String back;

  FlashCard({this.front, this.back});

  FlashCard.fromJson(Map<String, dynamic> json)
      : front = json['front'],
        back = json['back'];

  Map<String, dynamic> toJson() => {
        'front': front,
        'back': back,
      };
}
