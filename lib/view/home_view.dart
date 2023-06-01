import 'package:flutter/material.dart';
import 'package:nado_giza/view/feed_view.dart';
import 'package:nado_giza/viewModel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue[50], // 앱의 기본 색상을 밝은 하늘색으로 설정
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('나도기자'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  //
                },
              ),
              // 로그아웃 버튼
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('로그아웃 확인'),
                        content: const Text('로그아웃 하시겠습니까?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('취소'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('로그아웃'),
                            onPressed: () async {
                              final loginViewModel =
                                  Provider.of<LoginViewmodel>(
                                context,
                                listen: false,
                              );
                              await loginViewModel.signOut();
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacementNamed(context, '/');
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              // 이곳에 각 탭에서 보여줄 페이지를 추가합니다.
              // 예를 들어, FeedPage(), RealTimePage(), StatsPage(), ProfilePage() 등
              Center(
                child: FeedView(),
              ),
              Center(child: Text('Real Time Page')),
              Center(child: Text('Stats Page')),
              Center(child: Text('Profile Page')),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.home), text: 'Feed'),
              Tab(icon: Icon(Icons.trending_up), text: 'Real Time'),
              Tab(icon: Icon(Icons.insert_chart), text: 'Stats'),
              Tab(icon: Icon(Icons.account_circle), text: 'Profile'),
            ],
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: const EdgeInsets.all(5.0),
            indicatorColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
