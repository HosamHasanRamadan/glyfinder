import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import 'package:glyfinder/data/font_icon.dart';
import 'package:glyfinder/data/font_icons_package.dart';

final fontIconsApiProvider = Provider((ref) => FontIconsApi());

class FontIconsApi {
  final _dio = Dio();

  Future<List<FontIconsPackage>> getAllFontIconsPackages() async {
    final url = Uri.parse(
        'https://raw.githubusercontent.com/HosamHasanRamadan/icons_fonts/main/icons_fonts.json');
    final fontIconsPackagesResponse = await _getFontIconsPackgesResponse(url);

    final fontIconsPackages = <FontIconsPackage>[];

    for (final fontIconsPackageResponse in fontIconsPackagesResponse) {
      fontIconsPackages.add(FontIconsPackage(
        packageName: fontIconsPackageResponse.name,
        fontUrl: Uri.parse(fontIconsPackageResponse.fontUrl),
        imageUrl: Uri.parse(fontIconsPackageResponse.imageUrl),
      ));
    }
    return fontIconsPackages;
  }

  Future<List<FontIcon>> getIconsMatch(String value) async {
    final url = Uri.parse(
        'https://raw.githubusercontent.com/HosamHasanRamadan/icons_fonts/main/icons_fonts.json');
    final fontIconsPackagesResponse = await _getFontIconsPackgesResponse(url);

    final fontIcons = <FontIcon>[];

    for (final fontIconsPackageResponse in fontIconsPackagesResponse) {
      final fontIconsUrl = Uri.parse(fontIconsPackageResponse.iconsFontUrl);

      final fontIconsResponse = await _getFontIconsResponse(fontIconsUrl);

      for (final fontIcon in fontIconsResponse.icons) {
        if (fontIcon.name.contains(value)) {
          fontIcons.add(FontIcon(
            fontFamily: fontIconsResponse.fontFamily,
            name: fontIcon.name,
            svgUrl: Uri.parse(fontIcon.svgUrl),
            codePoint: fontIcon.codepoint,
          ));
        }
      }
    }
    return fontIcons;
  }

  Future<List<FontIconsPackageResponse>> _getFontIconsPackgesResponse(
      Uri url) async {
    final response = await _dio.getUri<String>(url);
    final responseData = jsonDecode(response.data!) as List;

    final fontIconsPackagesResponse = <FontIconsPackageResponse>[];

    for (final item in responseData.cast<Map<String, dynamic>>()) {
      fontIconsPackagesResponse.add(FontIconsPackageResponse.fromMap(item));
    }
    return fontIconsPackagesResponse;
  }

  Future<FontIconsResponse> _getFontIconsResponse(Uri url) async {
    final response = await _dio.getUri<String>(url);
    final responseData = FontIconsResponse.fromJson(response.data!);
    return responseData;
  }
}

class FontIconsPackageResponse {
  FontIconsPackageResponse({
    required this.name,
    required this.imageUrl,
    required this.repoUrl,
    required this.fontUrl,
    required this.iconsFontUrl,
  });

  final String name;
  final String imageUrl;
  final String repoUrl;
  final String fontUrl;
  final String iconsFontUrl;

  factory FontIconsPackageResponse.fromJson(String str) =>
      FontIconsPackageResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FontIconsPackageResponse.fromMap(Map<String, dynamic> json) =>
      FontIconsPackageResponse(
        name: json["name"],
        imageUrl: json["image_url"],
        repoUrl: json["repo_url"],
        fontUrl: json["font_url"],
        iconsFontUrl: json["icons_font_url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "image_url": imageUrl,
        "repo_url": repoUrl,
        "font_url": fontUrl,
        "icons_font_url": iconsFontUrl,
      };
}

class FontIconsResponse {
  FontIconsResponse({
    required this.repoUrl,
    required this.fontUrl,
    required this.fontFamily,
    required this.icons,
  });

  final String repoUrl;
  final String fontUrl;
  final String fontFamily;
  final List<IconResponse> icons;

  factory FontIconsResponse.fromJson(String str) =>
      FontIconsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FontIconsResponse.fromMap(Map<String, dynamic> json) =>
      FontIconsResponse(
        repoUrl: json["repo_url"],
        fontUrl: json["font_url"],
        fontFamily: json["font_family"],
        icons: List<IconResponse>.from(
            json["icons"].map((x) => IconResponse.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "repo_url": repoUrl,
        "font_url": fontUrl,
        "font_family": fontFamily,
        "icons": List<dynamic>.from(icons.map((x) => x.toMap())),
      };
}

class IconResponse {
  IconResponse({
    required this.name,
    required this.codepoint,
    required this.svgUrl,
  });

  final String name;
  final int codepoint;
  final String svgUrl;

  factory IconResponse.fromJson(String str) =>
      IconResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IconResponse.fromMap(Map<String, dynamic> json) => IconResponse(
        name: json["name"],
        codepoint: json["codepoint"],
        svgUrl: json["svg_url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "codepoint": codepoint,
        "svg_url": svgUrl,
      };
}
