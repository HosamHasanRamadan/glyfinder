import '../../configure_dependencies.dart';
import '../../data/font_icon.dart';
import '../../local_storage/liked_icons_storage.dart';

class LikeIcon {
  late final LikedIconsStorage _likedIconsStorage;
  LikeIcon() {
    _likedIconsStorage = getIt<LikedIconsStorage>();
  }
  Future<bool> call(FontIcon fontIcon) async {
    await _likedIconsStorage.add(fontIcon.copyWith(isLiked: true));
    return true;
  }
}
