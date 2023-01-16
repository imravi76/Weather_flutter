class Rain{
double? ih;

Rain({this.ih});

factory Rain.fromJson(Map<String, dynamic> json) => Rain(
  ih: (json['1h'] as num?)?.toDouble(),
);

Map<String, dynamic> toJson() => {
  '1h': ih,
};

}