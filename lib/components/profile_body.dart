import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sappyapp/mockup/mp.dart';
import 'package:sappyapp/screen/message_screen.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: chatsData.length,
                itemBuilder: (context, index) =>
                    ProfileCard(chat: chatsData[index])))
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final Chat chat;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide())),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0 * 0.75),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(chat.image),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    chat.bio,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )),
            if (chat.isBot)
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageScreen(),
                        ));
                  },
                  icon: Icon(Icons.chat_bubble)),
            IconButton(onPressed: () {}, icon: Icon(Icons.settings))
          ],
        ),
      ),
    );
  }
}
