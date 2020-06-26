import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Avatars { amie, astro, boss, boy, brenda, jsutin, nadie, rj, uncle, uncle2 }

final avatarData = {
  Avatars.amie: 'assets/images/boss.PNG',
  Avatars.astro: 'assets/images/astro.PNG',
  Avatars.boss: 'assets/images/boss.PNG',
  Avatars.boy: 'assets/images/boy.PNG',
  Avatars.brenda: 'assets/images/brenda.PNG',
  Avatars.jsutin: 'assets/images/jsutin.PNG',
  Avatars.nadie: 'assets/images/nadie.PNG',
  Avatars.rj: 'assets/images/rj.PNG',
  Avatars.uncle: 'assets/images/uncle.PNG',
  Avatars.uncle2: 'assets/images/uncle2.PNG',
};

class AvatarChanger with ChangeNotifier {
  String _avatar;

  AvatarChanger(this._avatar);

  getAvatar() => _avatar;

  setAvatar(String avatar) {
    _avatar = avatar;
    notifyListeners();
  }
}
