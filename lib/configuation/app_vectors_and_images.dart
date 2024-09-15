const linkAssets = 'assets/vectors/';
const linkImageAssets = 'assets/images/';
class AppVectorsAndImages{
  static String getLinkImage(String name) => '$linkImageAssets${name.replaceAll(' ', '').toLowerCase()}.png';
  static String getLinkVector(String name) => '$linkAssets${name.replaceAll(' ', '').toLowerCase()}.svg';
}