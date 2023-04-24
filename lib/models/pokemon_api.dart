class PokemonApi {
  final List<Abilities>? abilities;
  final String? name;
  final Sprites? sprites;

  PokemonApi({
    this.abilities,
    this.name,
    this.sprites,
  });

  PokemonApi.fromJson(Map<String, dynamic> json)
      : abilities = (json['abilities'] as List?)
            ?.map((dynamic e) => Abilities.fromJson(e as Map<String, dynamic>))
            .toList(),
        name = json['name'] as String?,
        sprites = (json['sprites'] as Map<String, dynamic>?) != null
            ? Sprites.fromJson(json['sprites'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'abilities': abilities?.map((e) => e.toJson()).toList(),
        'name': name,
        'sprites': sprites?.toJson()
      };
}

class Abilities {
  final Ability? ability;
  final bool? isHidden;
  final int? slot;

  Abilities({
    this.ability,
    this.isHidden,
    this.slot,
  });

  Abilities.fromJson(Map<String, dynamic> json)
      : ability = (json['ability'] as Map<String, dynamic>?) != null
            ? Ability.fromJson(json['ability'] as Map<String, dynamic>)
            : null,
        isHidden = json['is_hidden'] as bool?,
        slot = json['slot'] as int?;

  Map<String, dynamic> toJson() =>
      {'ability': ability?.toJson(), 'is_hidden': isHidden, 'slot': slot};
}

class Ability {
  final String? name;
  final String? url;

  Ability({
    this.name,
    this.url,
  });

  Ability.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

class Sprites {
  final String? frontDefault;

  Sprites({
    this.frontDefault,
  });

  Sprites.fromJson(Map<String, dynamic> json)
      : frontDefault = json['front_default'] as String?;

  Map<String, dynamic> toJson() => {'front_default': frontDefault};
}
