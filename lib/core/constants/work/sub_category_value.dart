import 'package:freezed_annotation/freezed_annotation.dart';

enum SubCategory {
  // 地域
  disasterPrevention('防災', ['防災', 'ぼうさい']),
  sightseeing('観光', ['観光', 'かんこう']),
  traffic('交通', ['交通', 'こうつう']),
  communication('場づくり', ['場づくり', 'ばづくり']),
  regionalRevitalization('地域おこし', ['地域おこし', 'ちいきおこし', 'コミュニケーション']),

  // 人文・歴史
  history('歴史', ['歴史', 'れきし']),
  foreignLanguage('外国語', ['外国語', 'がいこくご']),
  religion('宗教', ['宗教', 'しゅうきょう']),
  psychology('心理・意識', ['心理', '意識', 'しんり', 'いしき']),
  philosophy('哲学', ['哲学', 'てつがく']),
  culture('文化・伝統', ['文化', '伝統', 'ぶんか', 'でんとう']),
  literature('映像・文学', ['映像', '文学', 'えいぞう', 'ぶんがく']),
  subculture('サブカル', ['サブカル', 'さぶかる']),
  words('ことば', ['ことば', '言葉']),

  // 人権・社会福祉
  gender('ジェンダー', ['ジェンダー', 'じぇんだー']),
  rights('人権', ['人権', 'じんけん']),
  poverty('貧困', ['貧困', 'ひんこん']),
  peace('平和', ['平和', 'へいわ']),
  diversity('多様性', ['多様性', 'たようせい']),
  difficulties('障がい', ['障がい', 'しょうがい']),
  nursing('介護', ['介護', 'かいご']),

  // 国際
  international('国際関連', ['国際', 'こくさい']),
  compareOtherCountries('海外比較', ['海外', 'かいがい']),

  // 社会・経済
  marketing('商学', ['商学', 'しょうがく']),
  business('経済', ['経済', 'けいざい']),
  administration('市政・行政', ['市政', '行政', 'しせい', 'ぎょうせい']),
  law('司法・立法', ['司法', '立法', 'しほう', 'りっぽう']),

  // 産業
  agriculture('農業', ['農業', 'のうぎょう']),
  aquaCulture('水産業', ['水産業', 'すいさんぎょう']),
  forestry('林業', ['林業', 'りんぎょう']),
  secondaryIndustry('二次産業', ['二次産業', 'にじさんぎょう', '卸売', '小売']),

  // スポーツ・教育
  sports('スポーツ', ['スポーツ', 'すぽーつ']),
  childCare('保育', ['保育', 'ほいく']),
  education('教育', ['教育', 'きょういく', '先生', '教師', 'せんせい', 'きょうし']),
  studies('学習・勉強', ['学習', '勉強', 'がくしゅう', 'べんきょう']),

  // 環境問題
  ecosystem('生態系', ['生態系', 'せいたいけい']),
  climateChange('気候変動', ['気候', 'きこう', '温暖化', 'おんだんか']),
  pollution('環境汚染', ['環境汚染', 'かんきょうおせん']),
  recycle('再利用・リサイクル', ['再利用', 'リサイクル', 'さいりよう']),
  otherProblem('その他環境問題', []),

  // 数学・理科
  mathematics('数学', ['数学', 'すうがく']),
  chemistry('化学', ['化学', 'かがく']),
  physics('物理', ['物理', 'ぶつり']),
  ecology('生物', ['生物', 'せいぶつ', '生き物', 'いきもの']),
  geology('地学', ['地学', 'ちがく']),

  // テクノロジー・工学
  app('SNS・ゲーム', ['SNS', 'ゲーム']),
  architecture('建築', ['建築', 'けんちく']),
  manufacturing('ものづくり', ['ものづくり', 'もの作り']),
  ictAndAI('ICT・AI', ['ICT', 'AI']),
  energy('エネルギー', ['エネルギー']),

  // 健康・医療
  health('健康', ['健康', 'けんこう']),
  beauty('美容', ['美容', 'びよう']),
  medicalCare('医療', ['医療', 'いりょう']),
  sleep('睡眠', ['睡眠', 'すいみん']),
  mentalHealth('こころの健康', ['こころ', '精神', 'こころの健康', '心']),

  // デザイン・アート
  art('アート', ['アート', '芸術', 'げいじゅつ']),
  industryDesign('産業デザイン', ['デザイン']),
  music('音楽・音', ['音楽', '音', 'おんがく', 'おと']),
  fashion('ファッション', ['ファッション', 'ファッションデザイン']),

  // くらし
  food('食・料理', ['食', '料理', 'たべもの', 'りょうり']),
  schoolLife('学校生活', ['学校', 'がっこう']),
  book('本・書籍', ['本', '書籍', 'ほん', 'しょせき']),
  lifeHack('ライフハック', ['ライフハック', '生活']),
  fragrance('匂い・香り', ['匂い', '香り', 'におい', 'かおり']),
  pet('ペット', ['ペット', '動物', 'どうぶつ']),
  love('恋愛', ['恋愛', '恋', '恋愛心理', 'こい', 'こいしんり']),

  // その他
  enlightenment('啓発・啓蒙', ['啓発', '啓蒙', 'けいはつ', 'けいもう']),

  //その他
  other('その他', []),
  none('未分類', []),
  ;

  const SubCategory(this.displayName, this.suggestNameList);

  final String displayName;
  final List<String> suggestNameList;
}

class SubCategoryEnumConverter implements JsonConverter<SubCategory, String> {
  const SubCategoryEnumConverter();

  @override
  SubCategory fromJson(String json) {
    final subCategory = SubCategory.values.firstWhere(
      (element) => element.name == json,
      orElse: () => SubCategory.none,
    );
    return subCategory;
  }

  @override
  String toJson(SubCategory object) {
    return object.name;
  }
}
