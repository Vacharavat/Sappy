class Profile {
  String email;
  String password;
  String username;
  String bio;

  Profile(
      {String email = "",
      String password = "",
      String username = "",
      String bio = ""})
      : this.email = email,
        this.password = password,
        this.username = username,
        this.bio = bio;
}
