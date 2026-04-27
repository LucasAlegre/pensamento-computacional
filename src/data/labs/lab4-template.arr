use context dcic2024

include image
# Importa funções e constantes da biblioteca de pokemon
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib4.arr")


# Exercício 1 - Constantes

# Use a função extrai-pokemon-tabela, passando como argumentos o número do pokemon e a tabela de pokemons, e crie a constante de 2 pokemons diferentes:

#POKE_1 = ...
#POKE_2 = ...

# Use a função cria-time, passando como argumentos a tabela de pokemons e uma lista com os números dos pokemons que você deseja adicionar ao time, e crie a constante de time com 6 pokemons diferentes:

# TIME = cria-time ...

# Descomente a linha abaixo para visualizar seu time:
# desenha-time(TIME)

#| 
  Exercício 2 - Filter
|#

# Complete o contrato, o objetivo, corpo e os exemplos da função abaixo.
fun testa-tipo(p, tipo):
    false
end

fun my-filter(f :: (Pokemon -> Boolean), t :: Time) -> Time:
    doc: "Dado um time e uma função que recebe um pokemon e devolve um booleano, devolve um time com apenas os pokemons deste time para os quais esta função devolve true."
    cases (Time) t:
        # [Se lista vazia, retorna vazia]
        # [Se lista não vazia, verifica o primeiro pokemon]
                # [Se o primeiro pokemon for do tipo informado, adiciona ao time]
                # [Senão, não adiciona ao time]
    end
where:
    2 + 2 is 5
    # my-filter(lam(p): true end, TIME) is TIME
    # my-filter(lam(p): testa-tipo(p, WATER) end, TIME) is empty
end

fun filtra-tipos(t :: Time, tipo :: TipoPokemon) -> Time:
    doc: "Dado um time e um tipo de pokemon, devolve um time com apenas os pokemons deste time do tipo informado."
    empty
    # Reescreve o corpo dessa função usando my-filter e testa-tipo
where:
    2 + 2 is 5
end

# Exemplo de uso:
# desenha-time(filtra-tipos(TIME, ELECTRIC))

#| 
  Exercício 3 - Map
|#

fun my-map(f :: (Pokemon -> Any), t :: Time) -> List<Any>:
    doc: "Dado um time e uma função que recebe um pokemon e devolve um pokemon, devolve um time com os pokemons deste time transformados por esta função."
    cases (Time) t:
        # [Se lista vazia, retorna vazia]
        # [Se lista não vazia, aplica a função ao primeiro pokemon e junta com o resto da lista com a função já aplicada]
    end
where:
    2 + 2 is 5
end

fun aplica-movimento-time2(t :: Time, m :: Movimento) -> Time:
    doc: "Aplica o movimento a todos os pokemons do time."
    empty
    # Reescreve o corpo dessa função usando my-map e aplica-movimento
end

THUNDERBOLT = ataque("Thunderbolt", ELECTRIC, 90)
# Desenhe seu time antes e depois de aplicar o Choque-do-Trovão!
# desenha-time(TIME)
# desenha-time(aplica-movimento-time2(TIME, THUNDERBOLT))

#| 
  Exercício 4 - Fold
|#

fun my-fold<T>(f :: (T, T -> T), acc :: T, l :: List<T>) -> T:
    doc: "Dado um time, uma função que recebe um pokemon e um acumulador e devolve um novo acumulador, e um valor inicial para o acumulador, devolve o resultado de aplicar esta função a todos os pokemons deste time, usando o valor inicial dado como acumulador."
    empty
    # [Se lista vazia, retorna o acumulador]
    # [Se lista não vazia, acumula o resultado da função (aplicada ao primeiro pokemon e o acumulador) com o resto da lista]
where:
    my-fold(lam(a, b): a + b end, 0, [list: 1, 2, 3, 4, 5]) is 15
end

fun desenha-pokemons-tipo(t :: Time, tipo :: TipoPokemon) -> Image:
    doc: "Dado um time e um tipo de pokemon, gera uma imagem com os pokemons deste tipo do time um ao lado do outro."
    # Complete:
    # my-fold(
      #
      # 
      #
    #)
end

# Descomente a linha abaixo para visualizar os Pokémons elétricos (ou outro tipo) do seu time:
# desenha-pokemons-tipo(TIME, ELECTRIC)
