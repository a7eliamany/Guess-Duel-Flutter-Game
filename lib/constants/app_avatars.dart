import 'dart:math';

class AvatarModel {
  final String id;
  final String name;
  final String assetPath;

  const AvatarModel({
    required this.id,
    required this.name,
    required this.assetPath,
  });
}

class AppAvatars {
  AppAvatars._(); // To prevent instantiation

  static const String _basePath = 'assets/images/avatars_icons/';

  static const List<AvatarModel> list = [
    AvatarModel(id: 'cat', name: 'cat', assetPath: '${_basePath}01_cat.svg'),
    AvatarModel(id: 'dog', name: 'dog', assetPath: '${_basePath}02_dog.svg'),
    AvatarModel(
      id: 'panda',
      name: 'panda',
      assetPath: '${_basePath}03_panda.svg',
    ),
    AvatarModel(id: 'bear', name: 'bear', assetPath: '${_basePath}04_bear.svg'),
    AvatarModel(
      id: 'bunny',
      name: 'bunny',
      assetPath: '${_basePath}05_bunny.svg',
    ),
    AvatarModel(id: 'fox', name: 'fox', assetPath: '${_basePath}06_fox.svg'),
    AvatarModel(id: 'frog', name: 'frog', assetPath: '${_basePath}07_frog.svg'),
    AvatarModel(id: 'lion', name: 'lion', assetPath: '${_basePath}08_lion.svg'),
    AvatarModel(
      id: 'koala',
      name: 'koala',
      assetPath: '${_basePath}09_koala.svg',
    ),
    AvatarModel(id: 'owl', name: 'owl', assetPath: '${_basePath}10_owl.svg'),
    AvatarModel(
      id: 'tiger',
      name: 'tiger',
      assetPath: '${_basePath}11_tiger.svg',
    ),
    AvatarModel(
      id: 'monkey',
      name: 'monkey',
      assetPath: '${_basePath}12_monkey.svg',
    ),
    AvatarModel(
      id: 'penguin',
      name: 'penguin',
      assetPath: '${_basePath}13_penguin.svg',
    ),
    AvatarModel(
      id: 'chick',
      name: 'chick',
      assetPath: '${_basePath}14_chick.svg',
    ),
    AvatarModel(id: 'duck', name: 'duck', assetPath: '${_basePath}15_duck.svg'),
    AvatarModel(
      id: 'goose',
      name: 'goose',
      assetPath: '${_basePath}16_goose.svg',
    ),
    AvatarModel(
      id: 'flamingo',
      name: 'flamingo',
      assetPath: '${_basePath}17_flamingo.svg',
    ),
    AvatarModel(
      id: 'parrot',
      name: 'parrot',
      assetPath: '${_basePath}18_parrot.svg',
    ),
    AvatarModel(
      id: 'toucan',
      name: 'toucan',
      assetPath: '${_basePath}19_toucan.svg',
    ),
  ];

  static AvatarModel getAvatarById(String id) {
    return list.firstWhere((avatar) => avatar.id == id);
  }

  static AvatarModel getRandomAvatar() {
    return list[Random().nextInt(list.length)];
  }
}
