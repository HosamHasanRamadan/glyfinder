import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:equatable/equatable.dart';

class FontIcon extends Equatable {
  final String fontFamily;
  final String name;
  final Uri svgUrl;
  final int codePoint;
  final bool isLiked;

  const FontIcon({
    required this.fontFamily,
    required this.name,
    required this.svgUrl,
    required this.codePoint,
    this.isLiked = false,
  });

  String get id => fontFamily + name;

  Map<String, dynamic> toMap() {
    return {
      'fontFamily': fontFamily,
      'name': name,
      'svgUrl': svgUrl.toString(),
      'codePoint': codePoint,
      'isLiked': isLiked,
    };
  }

  factory FontIcon.fromMap(Map<String, dynamic> map) {
    return FontIcon(
      fontFamily: map['fontFamily'],
      name: map['name'],
      svgUrl: Uri.parse(map['svgUrl']),
      codePoint: map['codePoint'],
      isLiked: map['isLiked'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FontIcon.fromJson(String source) =>
      FontIcon.fromMap(json.decode(source));

  FontIcon copyWith({
    String? fontFamily,
    String? name,
    Uri? svgUrl,
    int? codePoint,
    bool? isLiked,
  }) {
    return FontIcon(
      fontFamily: fontFamily ?? this.fontFamily,
      name: name ?? this.name,
      svgUrl: svgUrl ?? this.svgUrl,
      codePoint: codePoint ?? this.codePoint,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object?> get props => [id];
}

class FontIconData extends IconData {
  final FontIcon fontIcon;
  FontIconData(this.fontIcon)
      : super(
          fontIcon.codePoint,
          fontFamily: fontIcon.fontFamily,
        );
}
