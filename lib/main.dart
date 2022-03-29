import 'package:dynamic_link_demo/item_post_widget.dart';
import 'package:dynamic_link_demo/post_model.dart';
import 'package:dynamic_link_demo/post_screen.dart';
import 'package:dynamic_link_demo/utils.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

List<Post> listPost = [
  Post(
      id: 0,
      image: 'https://picsum.photos/id/237/200/300',
      content:
          '''Trạng thái trung lập của Ukraine có thể giúp chấm dứt xung đột và kiến tạo hòa bình, 
    song cần được đảm bảo bằng một hiệp ước quốc tế, theo đại tá Nguyễn Minh Tâm.''',
      title: 'Title 0'),
  Post(
      id: 1,
      image: 'https://picsum.photos/seed/picsum/200/300',
      content:
          '''Hai hộp đen chứa những manh mối quan trọng nhất, có thể giúp điều 
      tra viên Trung Quốc tìm hiểu điều gì xảy ra trước khi máy bay MU5735 rơi.''',
      title: 'Title 1'),
  Post(
      id: 2,
      image: 'https://picsum.photos/200/300?grayscale',
      content:
          '''Các tỉnh thành đã dùng học bạ điện tử, nhưng khi chuyển trường, học sinh vẫn phải trình học bạ giấy.''',
      title: 'Title 2'),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "";

  @override
  void initState() {
    initDynamicLinks();
    super.initState();
  }

  ///Receive dynamic link firebase.
  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      handleDynamicLink(deepLink);
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        handleDynamicLink(deepLink);
      }
    }, onError: (OnLinkErrorException e) async {
      print(e.message);
    });
  }

  handleDynamicLink(Uri url) {
    List<String> separatedString = [];
    separatedString.addAll(url.path.split('/'));
    if (separatedString[1] == "post") {
      final Post post = listPost[int.parse(separatedString[2])];
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostScreen(post)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: listPost
                .map((e) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(child: InkWell(
                            onTap: (){
                              Get.to(PostScreen(e));
                            },
                              child: ItemPostWidget(e))),
                          IconButton(
                              onPressed: () async {
                                String url = await AppUtils.buildDynamicLink(e);
                                Share.share(url);
                              },
                              icon: Icon(
                                Icons.share,
                                size: 32,
                              ))
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
