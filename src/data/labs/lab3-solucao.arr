use context dcic2024

#|
    Este arquivo contém a solução dos exercícios do Laboratório 3 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre 
|#

# Importa funções e constantes da biblioteca de pokemon
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib3.arr")


#| 
    Exercício 1
|#

data Pokemon:
    # Estrutura para representar um Pokemon
    | pokemon(
        nome :: String,       # Nome do pokemon 
        id :: Number,         # Identificador do pokemon
        tipo :: TipoPokemon,  # Tipo do Pokémon  
        hp :: Number,         # Quantidade de pontos de vida do pokemon
        max-hp :: Number)     # Quantidade máxima de pontos de vida do pokemon
end

bulbasaur = pokemon("Bulbasaur", 1, GRASS, 45, 45)
charmander = pokemon("Charmander", 4, FIRE, 39, 39)
squirtle = pokemon("Squirtle", 7, WATER, 44, 44)
mewtwo = pokemon("Mewtwo", 150, PSYCHIC, 106, 106)
psyduck = pokemon("Psyduck", 54, WATER, 50, 50)


data Movimento:
    # Um movimento pokemon pode ser de ataque ou cura:
    | ataque(
        nome :: String,       # Nome do movimento
        tipo :: TipoPokemon,  # Tipo do movimento
        poder :: Number)      # Poder do movimento
    | cura(
        nome :: String,       # Nome do movimento
        cura :: Number)       # Quantidade de pontos de vida curados
end

# Constantes movimentos
ember = ataque("Ember", FIRE, 40)
tackle = ataque("Tackle", NORMAL, 40)
sleep = cura("Sleep", 50)


#| 
    Exercício 2
|#

data Time:
    | t-empty
    | t-link(first :: Pokemon, rest :: Time)
end

time1 = t-link(bulbasaur, t-link(charmander, t-link(squirtle, t-empty)))
time2 = t-link(pikachu, t-link(voltorb, t-link(gengar, t-empty)))



#|
    Exercício 3
|#

fun pokemon-from-table(id :: Number, table :: Table) -> Pokemon:
    doc: "Dado um id e uma tabela de pokemons, devolve o pokemon correspondente a este id nesta tabela."
    row = filter-with(pokemon-data, lam(row): row["id"] == id end).row-n(0)

    pokemon(row["name"], row["id"], string-to-tipo(row["type1"]), row["hp"])
where:
    pokemon-from-table(1, POKE-DATA) is pokemon("Bulbasaur", 1, GRASS, 45)
end

fun cria-todos-pokemons(tabela :: Table, id-max :: Number) -> Time:
    doc: "Dada uma tabela de pokemons, devolve um time com todos os pokemons desta tabela."
    fun loop(i :: Number) -> Time:
        ask:
            | i > id-max then: t-empty
            | otherwise: 
                t-link(
                    pokemon-from-table(i, tabela), 
                    loop(i + 1))
        end
    end
    loop(1)
where:
    cria-todos-pokemons(POKE-DATA, 3) is t-link(bulbasaur, t-link(charmander, t-link(squirtle, t-empty)))
end


#|
    Exercício 4
|#

fun cura-ou-dano(p :: Pokemon, valor :: Number) -> Pokemon:
    doc: "Dado um pokemon e um valor (positivo ou negativo), atualiza o hp (vida) do pokemon, respeitando os limites de hp mínimo (0) e máximo (hp-max)."
    novo-hp = ask:
        | p.hp + valor < 0 then: 0
        | p.hp + valor > p.max-hp then: p.max-hp
        | otherwise: p.hp + valor
    end
    
    pokemon(p.nome, p.id, p.tipo, novo-hp, p.max-hp)
where:
    cura-ou-dano(bulbasaur, 10) is pokemon("Bulbasaur", 1, GRASS, 35, 45)
    cura-ou-dano(bulbasaur, 50) is pokemon("Bulbasaur", 1, GRASS, 0, 45)
end


#|
    Exercício 5
|#

fun aplica-movimento(p :: Pokemon, m :: Movimento) -> Pokemon:
    doc: "Dado um pokemon e um movimento, devolve o pokemon resultante de aplicar este movimento sobre este pokemon (considerar que o ataque sempre acerta e que a cura não pode aumentar o hp do pokemon para mais do que 100)."
    cases (Movimento) m:
        | ataque(nome, tipo, poder) => 
            ask:
                | verifica-efeito(tipo, p.tipo) == EFEITO-SUPEREFETIVO then: 
                    cura-ou-dano(p, poder * -2)
                | verifica-efeito(tipo, p.tipo) == EFEITO-NAOEFETIVO then: 
                    cura-ou-dano(p, poder * -0.5)
                | otherwise: 
                    cura-ou-dano(p, poder * -1)
            end
        | cura(nome, c) => cura-ou-dano(p, c)
    end
end

#|
    Exercício 6
|#

fun aplica-movimento-time(t :: Time, m :: Movimento) -> Time:
    doc: "Dado um time e um movimento, devolve o time resultante de aplicar este movimento sobre todos os pokemons deste time."
    cases (Time) t:
        | t-empty => t-empty
        | t-link(p, rest) => 
            t-link(
                aplica-movimento(p, m), 
                aplica-movimento-time(rest, m))
    end
where:
    aplica-movimento-time(t-link(bulbasaur, t-link(charmander, t-link(squirtle, t-empty))), ember) is t-link(pokemon("Bulbasaur", 1, GRASS, 45, 45), t-link(pokemon("Charmander", 4, FIRE, 39, 39), t-link(pokemon("Squirtle", 7, WATER, 44, 44), t-empty)))
end