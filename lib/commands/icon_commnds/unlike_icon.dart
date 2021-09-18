import '../../configure_dependencies.dart';
import '../../data/font_icon.dart';
import '../../local_storage/liked_icons_storage.dart';

class UnLikeIcon {
  late final LikedIconsStorage _likedIconsStorage;
  UnLikeIcon() {
    _likedIconsStorage = getIt<LikedIconsStorage>();
  }
  Future<bool> call(FontIcon fontIcon) async {
    await _likedIconsStorage.delete(fontIcon.copyWith(isLiked: false));
    return true;
  }
}
