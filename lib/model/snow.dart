class Snow{
  double? ih;

  Snow({this.ih});

  factory Snow.fromJson(Map<String, dynamic> json) => Snow(
    ih: (json['1h'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    '1h': ih,
  };

}