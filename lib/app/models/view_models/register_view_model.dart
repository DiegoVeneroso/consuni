class RegisterViewModel {
  final int? id;
  final String? name;
  final String? email;
  final String? celular;
  final String? password;
  final String? instituicao;
  final String? classe;
  final String? cargo;
  final String? funcao;
  final bool? representante;
  final String? tokenPush;
  final String? imageAvatar;
  RegisterViewModel({
    this.id,
    this.name,
    this.email,
    this.celular,
    this.password,
    this.instituicao,
    this.classe,
    this.cargo,
    this.funcao,
    this.representante,
    this.tokenPush,
    this.imageAvatar,
  });

  RegisterViewModel copyWith({
    int? id,
    String? name,
    String? email,
    String? celular,
    String? password,
    String? instituicao,
    String? classe,
    String? cargo,
    String? funcao,
    bool? representante,
    String? tokenPush,
    String? imageAvatar,
  }) {
    return RegisterViewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      celular: celular ?? this.celular,
      password: password ?? this.password,
      instituicao: instituicao ?? this.instituicao,
      classe: classe ?? this.classe,
      cargo: cargo ?? this.cargo,
      funcao: funcao ?? this.funcao,
      representante: representante ?? this.representante,
      tokenPush: tokenPush ?? this.tokenPush,
      imageAvatar: imageAvatar ?? this.imageAvatar,
    );
  }

  @override
  String toString() {
    return 'RegisterViewModel(id: $id, name: $name, email: $email, celular: $celular, password: $password, instituicao: $instituicao, classe: $classe, cargo: $cargo, funcao: $funcao, representante: $representante, tokenPush: $tokenPush, imageAvatar: $imageAvatar)';
  }
}
