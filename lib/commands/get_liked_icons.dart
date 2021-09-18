import '../configure_dependencies.dart';
import '../data/font_icon.dart';
import '../local_storage/liked_icons_storage.dart';

class GetLikedIcons {
  late final LikedIconsStorage _likedIconsStorage;
  GetLikedIcons() {
    _likedIconsStorage = getIt<LikedIconsStorage>();
  }
  List<FontIcon> call() {
    final likedIcons = _likedIconsStorage.getAll();
    return likedIcons.toList();
  }
}
