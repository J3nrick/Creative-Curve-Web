import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hero_scroll_state.g.dart';

enum ActiveSection {
  hero,
  services,
  crafters,
  contact,
}

@riverpod
class HeroScrollOffset extends _$HeroScrollOffset {
  @override
  double build() {
    return 0;
  }

  void setOffset(double value) {
    state = value;
  }
}

@riverpod
class ActiveScreenSection extends _$ActiveScreenSection {
  @override
  ActiveSection build() {
    return ActiveSection.hero;
  }

  void setSection(ActiveSection section) {
    state = section;
  }
}
