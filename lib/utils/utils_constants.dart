

const String TB_USER = "users";

const int REG_PASSWORD = 0;
const int REG_NAME = 1;
const int REG_BIRTHDAY = 2;

bool needToCreateAuth = false;

List<String> names = [
  'Donovan Mitchel',
  'Don Toliver',
  'Landon Donovan',
  'Donovan Myth',
  'Donald Glover',
  'Donald Duck',
  'Ronald McDonald',
  'Donny P',
  'Donovan Mitchel',
  'Don Toliver',
  'Landon Donovan',
  'Donovan Myth',
  'Donald Glover',
  'Donald Duck',
  'Ronald McDonald',
  'Donny P',
  'Donald Glover',
  'Donald Duck',
  'Ronald McDonald',
  'Donny P',
];

List<String> detectIds = [
  '@spidadmitchell',
  '@dontoliver',
  '@realdonald',
  '@ldonovant',
  '@themyththelegend',
  '@childishgambino',
  '@realdonaldduck',
  '@mclovin',
  '@donnyp',
  '@spidadmitchell',
  '@dontoliver',
  '@realdonald',
  '@ldonovant',
  '@themyththelegend',
  '@childishgambino',
  '@realdonaldduck',
  '@mclovin',
  '@donnyp',
  '@mclovin',
  '@donnyp',
];

List<String> avatarImgs = [
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_1.png?alt=media&token=cc438ebb-8e4f-4f07-9413-75f67095c6c5',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_2.png?alt=media&token=5a4e2007-6b29-468d-aafb-a20505300c6d',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_3.png?alt=media&token=55cd9103-4b3c-4d20-83f5-e3eb8ebfcdac',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_4.png?alt=media&token=1d543436-5da7-494d-a978-ac52512e317f',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_5.png?alt=media&token=fce128c4-1b12-4171-a583-ee9913dcf3e2',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_6.png?alt=media&token=e957bae0-199e-4e55-8655-c5b657583ca4',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_1.png?alt=media&token=cc438ebb-8e4f-4f07-9413-75f67095c6c5',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_2.png?alt=media&token=5a4e2007-6b29-468d-aafb-a20505300c6d',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_3.png?alt=media&token=55cd9103-4b3c-4d20-83f5-e3eb8ebfcdac',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_4.png?alt=media&token=1d543436-5da7-494d-a978-ac52512e317f',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_5.png?alt=media&token=fce128c4-1b12-4171-a583-ee9913dcf3e2',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_6.png?alt=media&token=e957bae0-199e-4e55-8655-c5b657583ca4',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_1.png?alt=media&token=cc438ebb-8e4f-4f07-9413-75f67095c6c5',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_2.png?alt=media&token=5a4e2007-6b29-468d-aafb-a20505300c6d',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_3.png?alt=media&token=55cd9103-4b3c-4d20-83f5-e3eb8ebfcdac',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_4.png?alt=media&token=1d543436-5da7-494d-a978-ac52512e317f',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_5.png?alt=media&token=fce128c4-1b12-4171-a583-ee9913dcf3e2',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_6.png?alt=media&token=e957bae0-199e-4e55-8655-c5b657583ca4',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_5.png?alt=media&token=fce128c4-1b12-4171-a583-ee9913dcf3e2',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/avatars%2Fic_profile_6.png?alt=media&token=e957bae0-199e-4e55-8655-c5b657583ca4',
];

List<String> backImages = [
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_1.png?alt=media&token=c18e0af3-5010-48a7-ae51-77f1c5dcccba',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_0.png?alt=media&token=2340bb2b-415c-4ca4-8019-600c85756211',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_2.png?alt=media&token=cd505181-2392-4b8d-bdc9-954cd5f5da56',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_1.png?alt=media&token=c18e0af3-5010-48a7-ae51-77f1c5dcccba',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_0.png?alt=media&token=2340bb2b-415c-4ca4-8019-600c85756211',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_2.png?alt=media&token=cd505181-2392-4b8d-bdc9-954cd5f5da56',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_1.png?alt=media&token=c18e0af3-5010-48a7-ae51-77f1c5dcccba',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_0.png?alt=media&token=2340bb2b-415c-4ca4-8019-600c85756211',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_2.png?alt=media&token=cd505181-2392-4b8d-bdc9-954cd5f5da56',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_1.png?alt=media&token=c18e0af3-5010-48a7-ae51-77f1c5dcccba',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_0.png?alt=media&token=2340bb2b-415c-4ca4-8019-600c85756211',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_2.png?alt=media&token=cd505181-2392-4b8d-bdc9-954cd5f5da56',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_1.png?alt=media&token=c18e0af3-5010-48a7-ae51-77f1c5dcccba',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_0.png?alt=media&token=2340bb2b-415c-4ca4-8019-600c85756211',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_2.png?alt=media&token=cd505181-2392-4b8d-bdc9-954cd5f5da56',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_1.png?alt=media&token=c18e0af3-5010-48a7-ae51-77f1c5dcccba',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_0.png?alt=media&token=2340bb2b-415c-4ca4-8019-600c85756211',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_2.png?alt=media&token=cd505181-2392-4b8d-bdc9-954cd5f5da56',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_0.png?alt=media&token=2340bb2b-415c-4ca4-8019-600c85756211',
  'https://firebasestorage.googleapis.com/v0/b/cashtime-app.appspot.com/o/backImages%2Fic_back_2.png?alt=media&token=cd505181-2392-4b8d-bdc9-954cd5f5da56',
];