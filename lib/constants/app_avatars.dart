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
  AppAvatars._();

  static const String _basePath = 'assets/images/avatars_icons/';

  static const List<AvatarModel> list = [
    // 01 to 39
    AvatarModel(id: 'cat', name: 'Cat', assetPath: '${_basePath}01_cat.svg'),
    AvatarModel(id: 'dog', name: 'Dog', assetPath: '${_basePath}02_dog.svg'),
    AvatarModel(
      id: 'panda',
      name: 'Panda',
      assetPath: '${_basePath}03_panda.svg',
    ),
    AvatarModel(id: 'bear', name: 'Bear', assetPath: '${_basePath}04_bear.svg'),
    AvatarModel(
      id: 'bunny',
      name: 'Bunny',
      assetPath: '${_basePath}05_bunny.svg',
    ),
    AvatarModel(id: 'fox', name: 'Fox', assetPath: '${_basePath}06_fox.svg'),
    AvatarModel(id: 'frog', name: 'Frog', assetPath: '${_basePath}07_frog.svg'),
    AvatarModel(id: 'lion', name: 'Lion', assetPath: '${_basePath}08_lion.svg'),
    AvatarModel(
      id: 'koala',
      name: 'Koala',
      assetPath: '${_basePath}09_koala.svg',
    ),
    AvatarModel(id: 'owl', name: 'Owl', assetPath: '${_basePath}10_owl.svg'),
    AvatarModel(
      id: 'tiger',
      name: 'Tiger',
      assetPath: '${_basePath}11_tiger.svg',
    ),
    AvatarModel(
      id: 'monkey',
      name: 'Monkey',
      assetPath: '${_basePath}12_monkey.svg',
    ),
    AvatarModel(
      id: 'penguin',
      name: 'Penguin',
      assetPath: '${_basePath}13_penguin.svg',
    ),
    AvatarModel(
      id: 'chick',
      name: 'Chick',
      assetPath: '${_basePath}14_chick.svg',
    ),
    AvatarModel(id: 'duck', name: 'Duck', assetPath: '${_basePath}15_duck.svg'),
    AvatarModel(
      id: 'goose',
      name: 'Goose',
      assetPath: '${_basePath}16_goose.svg',
    ),
    AvatarModel(
      id: 'flamingo',
      name: 'Flamingo',
      assetPath: '${_basePath}17_flamingo.svg',
    ),
    AvatarModel(
      id: 'parrot',
      name: 'Parrot',
      assetPath: '${_basePath}18_parrot.svg',
    ),
    AvatarModel(
      id: 'toucan',
      name: 'Toucan',
      assetPath: '${_basePath}19_toucan.svg',
    ),

    AvatarModel(
      id: 'giraffe',
      name: 'Giraffe',
      assetPath: '${_basePath}21_giraffe.svg',
    ),
    AvatarModel(
      id: 'zebra',
      name: 'Zebra',
      assetPath: '${_basePath}22_zebra.svg',
    ),
    AvatarModel(
      id: 'hippo',
      name: 'Hippo',
      assetPath: '${_basePath}23_hippo.svg',
    ),
    AvatarModel(
      id: 'rhino',
      name: 'Rhino',
      assetPath: '${_basePath}24_rhino.svg',
    ),

    AvatarModel(
      id: 'octopus',
      name: 'Octopus',
      assetPath: '${_basePath}31_octopus.svg',
    ),
    AvatarModel(id: 'crab', name: 'Crab', assetPath: '${_basePath}32_crab.svg'),
    AvatarModel(id: 'bee', name: 'Bee', assetPath: '${_basePath}33_bee.svg'),
    AvatarModel(
      id: 'butterfly',
      name: 'Butterfly',
      assetPath: '${_basePath}34_butterfly.svg',
    ),
    AvatarModel(
      id: 'ladybug',
      name: 'Ladybug',
      assetPath: '${_basePath}35_ladybug.svg',
    ),
    AvatarModel(
      id: 'snail',
      name: 'Snail',
      assetPath: '${_basePath}36_snail.svg',
    ),
    AvatarModel(
      id: 'hedgehog',
      name: 'Hedgehog',
      assetPath: '${_basePath}37_hedgehog.svg',
    ),
    AvatarModel(
      id: 'squirrel',
      name: 'Squirrel',
      assetPath: '${_basePath}38_squirrel.svg',
    ),
    AvatarModel(
      id: 'raccoon',
      name: 'Raccoon',
      assetPath: '${_basePath}39_raccoon.svg',
    ),

    // 40 to 59
    AvatarModel(id: 'deer', name: 'Deer', assetPath: '${_basePath}40_deer.svg'),

    AvatarModel(id: 'cow', name: 'Cow', assetPath: '${_basePath}43_cow.svg'),

    AvatarModel(
      id: 'beaver',
      name: 'Beaver',
      assetPath: '${_basePath}46_beaver.svg',
    ),
    AvatarModel(
      id: 'otter',
      name: 'Otter',
      assetPath: '${_basePath}47_otter.svg',
    ),
    AvatarModel(
      id: 'sloth',
      name: 'Sloth',
      assetPath: '${_basePath}48_sloth.svg',
    ),
    AvatarModel(id: 'bat', name: 'Bat', assetPath: '${_basePath}49_bat.svg'),

    AvatarModel(
      id: 'walrus',
      name: 'Walrus',
      assetPath: '${_basePath}51_walrus.svg',
    ),
    AvatarModel(id: 'seal', name: 'Seal', assetPath: '${_basePath}52_seal.svg'),
  ];
  static AvatarModel getAvatarById(String id) {
    return list.firstWhere((avatar) => avatar.id == id);
  }

  static AvatarModel getRandomAvatar() {
    return list[Random().nextInt(list.length)];
  }
}
