import 'package:chat_project/domains/usecase/user/get_relationship.dart';
import 'package:chat_project/models/group.dart';
import 'package:chat_project/models/relationship.dart';
import 'package:chat_project/screens/bloc/get_friend_cubit.dart';
import 'package:chat_project/screens/bloc/get_group_cubit.dart';
import 'package:chat_project/screens/bloc/get_group_state.dart';
import 'package:chat_project/screens/chat_group_screen.dart';
import 'package:chat_project/screens/chat_screen.dart';
import 'package:chat_project/screens/profile_page.dart';
import 'package:chat_project/screens/searching.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configuation/app_vectors_and_images.dart';
import '../models/user.dart';
import '../service_locator.dart';
import 'bloc/get_friend_state.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomepageContent(), // Giả sử bạn đã có HomepageContent là Widget của bạn
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B202D),
      body: _pages[_currentIndex], // Hiển thị trang hiện tại
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff1B202D),
        currentIndex: _currentIndex,
          selectedItemColor: Colors.white, // Màu cho item đang được chọn
          unselectedItemColor: Colors.white24,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo_outlined),
            label: 'Social',
          ),
        ],
      ),
    );
  }
}





class HomepageContent extends StatefulWidget {
  const HomepageContent({super.key});

  @override
  State<HomepageContent> createState() => _HomepageContentState();
}

class _HomepageContentState extends State<HomepageContent> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  late int userIdOwner;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getAccount();
  }
  void getAccount() async{
    final prefs = await SharedPreferences.getInstance();
    userIdOwner = prefs.getInt('userId') ?? 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B202D),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Messages',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  print('Search bar tapped'); // Debugging line
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Searching()),
                  );
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[800], // Background color to make it visible
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Search...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocProvider(
                create: (_) => GetFriendCubit()..getFriend(),
                child: SizedBox(
                  height: 100,
                  child: BlocBuilder<GetFriendCubit, GetFriendState>(
                    builder: (context, state){
                      if(state is GetFriendLoading){
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      }
                      if(state is GetFriendLoaded){
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.friends.length,
                          itemBuilder: (context, index) {
                            User friend = state.friends[index];
                            String imageName = 'user${index + 1}';
                            return buildCard(imageName, friend.userName!);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 16.0); // Space between items
                          },
                        );
                      }
                      if (state is GetFriendFailure) {
                        return const Text('Error load play song');
                      }
                      return Container();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              tabBar(),
              SizedBox(
                height:MediaQuery.sizeOf(context).height / 1.75,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    //Friend
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: BlocProvider(
                        create: (_) => GetFriendCubit()..getFriend(),
                        child: SizedBox(
                          height:  MediaQuery.sizeOf(context).height / 1.7,
                          child: BlocBuilder<GetFriendCubit, GetFriendState>(
                            builder: (context, state){
                              if(state is GetFriendLoading){
                                return Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                );
                              }
                              if(state is GetFriendLoaded){
                                return ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.friends.length,
                                  itemBuilder: (context, index) {
                                    User friend = state.friends[index];
                                    String imageName = 'user${index + 1}'; // Ensure the correct file extension
                                    return messCard(imageName, friend.userName!, friend.userId!, false);
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const SizedBox(height: 16.0); // Space between items
                                  },
                                );
                              }
                              if (state is GetFriendFailure) {
                                return const Text('Error load play song');
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ),
                    //group
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: BlocProvider(
                        create: (_) => GetGroupCubit()..getGroup(),
                        child: SizedBox(
                          height:  MediaQuery.sizeOf(context).height / 1.7,
                          child: BlocBuilder<GetGroupCubit, GetGroupState>(
                            builder: (context, state){
                              if(state is GetGroupLoading){
                                return Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                );
                              }
                              if(state is GetGroupLoaded){
                                return ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.groups.length,
                                  itemBuilder: (context, index) {
                                    Group group = state.groups[index];
                                    String imageName = 'user${index + 1}'; // Ensure the correct file extension
                                    return messCard(imageName, group.groupName!, group.id!, true);
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const SizedBox(height: 16.0); // Space between items
                                  },
                                );
                              }
                              if (state is GetGroupFailure) {
                                return const Text('Error load group');
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String url, String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: Image.asset(
            AppVectorsAndImages.getLinkImage(url), // Runtime method invocation
          ).image,
        ),

        Text(name, style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),)
      ],
    );
  }

  Widget messCard(String url, String username, int id, bool isGroup) {
    return
      GestureDetector(
      onTap: () => isGroup ? _getChatGroup(context, id, username) : _getChatFriend(context, id, username) ,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: Image.asset(
              AppVectorsAndImages.getLinkImage(url),
            ).image,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "You: ${url}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabBar() {
    return TabBar(
      controller: _tabController,
      dividerColor: Colors.transparent,
      tabs: const [
        Text(
          'Friend',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white24,
          ),
        ),
        Text(
          'Group',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white24,
          ),
        ),
      ],
    );
  }


  void _getChatFriend(BuildContext context, int id2, String name) async {
    Map<String, int> params = {
      'id1': userIdOwner,
      'id2': id2,
    };


    Relationship result = await sl<GetRelationship>().call(params: params);


    print(result.id!);
    if (result != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            idGroup: result.id!,
            userName: name,
            userId: id2,
          ),
        ),
      );
    }
  }


  void _getChatGroup(BuildContext context, int idGroup, String nameGroup) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChatGroupScreen(idGroup: idGroup, nameGroup: nameGroup)
      ),
    );
  }


}
