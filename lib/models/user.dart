class User {
  final String _token;
  final String? name;
  final String? avatar;

  User(
    this._token,
    {
      this.name,
      this.avatar,
    }
  );
}