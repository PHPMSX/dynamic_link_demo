import 'package:dynamic_link_demo/post_model.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AppUtils {
  ///Build a dynamic link firebase
  static Future<String> buildDynamicLink(Post post) async {
    String url = "https://devhp.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      navigationInfoParameters: NavigationInfoParameters( forcedRedirectEnabled: true),
      uriPrefix: url,
      link: Uri.parse('$url/post/${post.id}'),
      androidParameters: AndroidParameters(
        packageName: "com.example.dynamic_link_demo",
        minimumVersion: 0,
        fallbackUrl: Uri.parse('https://play.google.com/store/movies/details/Spider_Man_No_Way_Home?id=maWIDS2N4Lk.P&hl=vi&gl=US')
      ),
      iosParameters: IosParameters(
        bundleId: "com.example.dynamicLinkDemo",
        minimumVersion: '0',

      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: post.content,
          imageUrl:
              Uri.parse(post.image),
          title: post.title),
    );
    final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();
    return dynamicUrl.shortUrl.toString();
  }
}
