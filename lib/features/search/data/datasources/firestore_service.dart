import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //シングルトンの作成。instanceでインスタンスを作成。
  static final FireStoreService _instance = FireStoreService._();
  FireStoreService._();
  static FireStoreService get instance => _instance;

  Future<void> create() async {
    final db = FirebaseFirestore.instance;

    // await db.collection('users').doc('2022').collection('users').add({
    //   'email': 'goto.aoi.516@gmail.com',
    //   'name': '後藤碧生',
    // });
    // await db.collection('users').doc('2024').collection('users').add({
    //   'email': 'aoi-goto@kenryo.ed.jp',
    //   'name': '後藤碧生',
    // });

    await db.collection('works').doc('11111111').set({
      'title': 'あなたの探究、サポートします！',
      'category1': 'life',
      'subCategory1': 'schoolLife',
      'category2': 'education',
      'subCategory2': 'education',
      'enterYear': 2020,
      'eventName': 'individualTankyu',
      'course': 'tankyu',
      'existsSlide': true,
      'existsReport': true,
      'existsThesis': true,
      'existsPoster': true,
      'author': '縣陵太郎',
      'vagueLikes': 1921,
      'exactLikes': 1921,
    });
    // await db.collection('works').doc('20202290').set({
    //   'title': 'みんなのぶしつ 〜高校生の放課後の居場所に挑む〜',
    //   'category1': '地域・社会',
    //   'subCategory1': 'コミュニティ',
    //   'category2': 'くらし',
    //   'subCategory2': '学校生活',
    //   'enterYear': 2020,
    //   'eventName': '個人探究',
    //   'course': '探究科',
    //   'existsSlide': false,
    //   'existsReport': true,
    //   'existsThesis': false,
    //   'existsPoster': false,
    //   'author': '田口壱星',
    //   'vagueLikes': 0,
    //   'exactLikes': 0,
    // });
    // await db.collection('works').doc('22201290').set({
    //   'title': 'そのWikipedia記事、信頼できそうですか︖〜Pythonを⽤いた信頼度評価〜',
    //   'category1': 'テクノロジー・工学',
    //   'subCategory1': 'プログラミング',
    //   'category2': '社会・地域 ',
    //   'subCategory2': '法律',
    //   'enterYear': 2022,
    //   'eventName': '個人探究',
    //   'course': '探究科',
    //   'existsSlide': true,
    //   'existsReport': false,
    //   'existsThesis': false,
    //   'existsPoster': true,
    //   'author': '橋本昂賢',
    //   'vagueLikes': 0,
    //   'exactLikes': 0,
    // });
    // await db.collection('works').doc('22202360').set({
    //   'title': 'リップ大革命！〜不要なリップからマーカーペンを作成する〜！',
    //   'category1': '科学・数学',
    //   'category2': '自然環境',
    //   'subCategory1': '化学',
    //   'subCategory2': 'エシカル',
    //   'enterYear': 2022,
    //   'eventName': '個人探究',
    //   'course': '探究科',
    //   'existsSlide': false,
    //   'existsReport': false,
    //   'existsThesis': false,
    //   'existsPoster': true,
    //   'author': '升田陽美',
    //   'vagueLikes': 0,
    //   'exactLikes': 0,
    // });
  }

  Future<void> createNotification() async {
    final db = FirebaseFirestore.instance;

    await db.collection('notification').doc('11111111').set({
      'title': 'あなたの探究、サポートします！',
      'category1': 'life',
      'subCategory1': 'schoolLife',
      'category2': 'education',
      'subCategory2': 'education',
      'enterYear': 2020,
      'eventName': 'individualTankyu',
      'course': 'tankyu',
      'existsSlide': true,
      'existsReport': true,
      'existsThesis': true,
      'existsPoster': true,
      'author': '縣陵太郎',
      'vagueLikes': 1921,
      'exactLikes': 1921,
    });
    // await db.collection('works').doc('20202290').set({
    //   'title': 'みんなのぶしつ 〜高校生の放課後の居場所に挑む〜',
    //   'category1': '地域・社会',
    //   'subCategory1': 'コミュニティ',
    //   'category2': 'くらし',
    //   'subCategory2': '学校生活',
    //   'enterYear': 2020,
    //   'eventName': '個人探究',
    //   'course': '探究科',
    //   'existsSlide': false,
    //   'existsReport': true,
    //   'existsThesis': false,
    //   'existsPoster': false,
    //   'author': '田口壱星',
    //   'vagueLikes': 0,
    //   'exactLikes': 0,
    // });
    // await db.collection('works').doc('22201290').set({
    //   'title': 'そのWikipedia記事、信頼できそうですか︖〜Pythonを⽤いた信頼度評価〜',
    //   'category1': 'テクノロジー・工学',
    //   'subCategory1': 'プログラミング',
    //   'category2': '社会・地域 ',
    //   'subCategory2': '法律',
    //   'enterYear': 2022,
    //   'eventName': '個人探究',
    //   'course': '探究科',
    //   'existsSlide': true,
    //   'existsReport': false,
    //   'existsThesis': false,
    //   'existsPoster': true,
    //   'author': '橋本昂賢',
    //   'vagueLikes': 0,
    //   'exactLikes': 0,
    // });
    // await db.collection('works').doc('22202360').set({
    //   'title': 'リップ大革命！〜不要なリップからマーカーペンを作成する〜！',
    //   'category1': '科学・数学',
    //   'category2': '自然環境',
    //   'subCategory1': '化学',
    //   'subCategory2': 'エシカル',
    //   'enterYear': 2022,
    //   'eventName': '個人探究',
    //   'course': '探究科',
    //   'existsSlide': false,
    //   'existsReport': false,
    //   'existsThesis': false,
    //   'existsPoster': true,
    //   'author': '升田陽美',
    //   'vagueLikes': 0,
    //   'exactLikes': 0,
    // });
  }
}
