class Chat {
  final String name, bio, image, time;
  final bool isBot;

  Chat({
    required this.name,
    required this.bio,
    required this.image,
    required this.time,
    required this.isBot,
  });
}

List chatsData = [
  Chat(
    name: "Frame",
    bio: "เศร้าจัง",
    image: "assets/image/Frame.png",
    time: "3m ago",
    isBot: false,
  ),
  Chat(
    name: "Levi",
    bio: "สู้ๆนะ",
    image: "assets/image/Bot.png",
    time: "8m ago",
    isBot: true,
  ),
];
