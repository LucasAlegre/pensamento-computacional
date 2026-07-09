use context dcic2024

include image
# Importa funções e constantes da biblioteca de pokemon
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib4.arr")


# Exercício 1 - Constantes

# Use a função extrai-pokemon-tabela, passando como argumentos o número do pokemon e a tabela de pokemons, e crie a constante de 2 pokemons diferentes:
POKE_PIKACHU = extrai-pokemon-tabela(100, POKE-DATA)
POKE_MEWTWO = extrai-pokemon-tabela(150, POKE-DATA)

# Use a função cria-time, passando como argumentos a tabela de pokemons e uma lista com os números dos pokemons que você deseja adicionar ao time, e crie a constante de time com 6 pokemons diferentes:
TIME = cria-time(POKE-DATA, [list: 25, 34, 45, 100, 50, 77])

# Descomente a linha abaixo para visualizar seu time:
desenha-time(TIME)

#| 
  Exercício 2 - Filter
|#

fun testa-tipo(p :: Pokemon, tipo :: TipoPokemon) -> Boolean:
    doc: "Dado um pokemon e um tipo, devolve true se o pokemon for do tipo informado, e false caso contrário."
    p.tipo == tipo
where:
    testa-tipo(POKE_PIKACHU, ELECTRIC) is true
    testa-tipo(POKE_PIKACHU, WATER) is false
end

fun my-filter(f :: (Pokemon -> Boolean), t :: Time) -> Time:
    doc: "Dado um time e uma função que recebe um pokemon e devolve um booleano, devolve um time com apenas os pokemons deste time para os quais esta função devolve true."
    cases (Time) t:
        | empty => empty
        | link(first, rest) =>
            ask:
                | f(first) then: link(first, my-filter(f, rest))
                | otherwise: my-filter(f, rest)
            end
    end
where:
    my-filter(lam(p): true end, TIME) is TIME
    my-filter(lam(p): testa-tipo(p, WATER) end, TIME) is empty
end

fun filtra-tipos(t :: Time, tipo :: TipoPokemon) -> Time:
    doc: "Dado um time e um tipo de pokemon, devolve um time com apenas os pokemons deste time do tipo informado."
    my-filter(lam(p): testa-tipo(p, tipo) end, t)
end

desenha-time(filtra-tipos(TIME, ELECTRIC))

#| 
  Exercício 3 - Map
|#

fun my-map(f :: (Pokemon -> Any), t :: Time) -> List<Any>:
    doc: "Dado um time e uma função que recebe um pokemon e devolve um pokemon, devolve um time com os pokemons deste time transformados por esta função."
    cases (Time) t:
        | empty => empty
        | link(first, rest) => 
          link(
            f(first), 
            my-map(f, rest))
    end
end

fun aplica-movimento-time2(t :: Time, m :: Movimento) -> Time:
    doc: "Aplica o movimento a todos os pokemons do time."
    my-map(lam(p): aplica-movimento(p, m) end, t)
end

THUNDERBOLT = ataque("Thunderbolt", ELECTRIC, 90)
desenha-time(aplica-movimento-time2(TIME, THUNDERBOLT))

#| 
  Exercício 4 - Fold
|#

fun my-fold<T>(f :: (T, T -> T), acc :: T, l :: List<T>) -> T:
    doc: "Dado um time, uma função que recebe um pokemon e um acumulador e devolve um novo acumulador, e um valor inicial para o acumulador, devolve o resultado de aplicar esta função a todos os pokemons deste time, usando o valor inicial dado como acumulador."
    cases (List<T>) l:
        | empty => acc
        | link(first, rest) => my-fold(f, f(acc, first), rest)
    end
where:
    my-fold(lam(a, b): a + b end, 0, [list: 1, 2, 3, 4, 5]) is 15
    my-fold(lam(a, b): a * b end, 1, [list: 1, 2, 3]) is 6
end

fun desenha-pokemons-tipo(t :: Time, tipo :: TipoPokemon) -> Image:
    doc: "Dado um time e um tipo de pokemon, gera uma imagem com os pokemons deste tipo do time um ao lado do outro."
    lista-tipos :: List<Pokemon> = filtra-tipos(t, tipo)
    lista-imagens :: List<Image> = my-map(desenha-pokemon, lista-tipos)

    my-fold(beside, empty-image, lista-imagens)
end

desenha-pokemons-tipo(TIME, ELECTRIC)
