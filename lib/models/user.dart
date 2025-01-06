class User {
  final String token;
  final String? name;
  final String? avatar;

  User(
    this.token,
    {
      this.name,
      this.avatar,
    }
  );
}