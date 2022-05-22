import 'package:flutter/material.dart';
import 'package:sappyapp/screen/message_screen.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 20.0 * 0.75),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/image/Bot.png"),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 250, 107, 96),
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Color(0xFFFFFFFF), width: 1)),
                        child: Text("2",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Levi",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 6),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          "เป็นยังไงบ้างวันนี้",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )),
                Opacity(opacity: 0.5, child: Text("2m ago"))
              ],
            ),
          ),
        )
      ],
    );
  }
}
