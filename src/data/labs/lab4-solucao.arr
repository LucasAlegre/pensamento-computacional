use context dcic2024

include image
# Importa funções e constantes da biblioteca de pokemon
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib4.arr")


# Constantes:

BLA = extrai-pokemon-tabela(POKE-DATA, 34)
TIME1 = cria-time(POKE-DATA, [list: 34, 45, 45])

#| 
  Exercício 1
|#

fun my-filter(t :: Time, f :: (Pokemon -> Boolean)) -> Time:
    doc: "Dado um time e uma função que recebe um pokemon e devolve um booleano, devolve um time com apenas os pokemons deste time para os quais esta função devolve true."
    cases (Time) t:
        | t-empty => t-empty
        | t-link(first, rest) =>
            ask:
                | f(first) then: t-link(first, my-filter(rest, f))
                | otherwise: my-filter(rest, f)
            end
    end
end


#| 
  Exercício 2
|#

fun my-map(t :: Time, f :: (Pokemon -> Any)) -> List<Any>:
    doc: "Dado um time e uma função que recebe um pokemon e devolve um pokemon, devolve um time com os pokemons deste time transformados por esta função."
    cases (Time) t:
        | t-empty => empty
        | t-link(first, rest) => link(f(first), my-map(rest, f))
    end
end


#| 
  Exercício 3
|#

fun my-fold(t :: Time, f :: (Pokemon, Any -> Any), acc :: Any) -> Any:
    doc: "Dado um time, uma função que recebe um pokemon e um acumulador e devolve um novo acumulador, e um valor inicial para o acumulador, devolve o resultado de aplicar esta função a todos os pokemons deste time, usando o valor inicial dado como acumulador."
    cases (Time) t:
        | t-empty => acc
        | t-link(first, rest) => my-fold(rest, f, f(first, acc))
    end
end


#| 
  Exercício 4
|#

fun aplica-movimento-time2(t :: Time, m :: Movimento) -> Time:
    doc: "Aplica o movimento a todos os pokemons do time."
    my-map(t, lam(p): aplica-movimento(m, p) end)
end

fun lista-eletrico(t :: Time) -> Time:
    doc: "Dado um time, devolve um time com apenas os pokemons do tipo elétrico deste time."
    my-filter(t, lam(p): p.tipo == ELECTRIC end)
end

fun nomes-pokemon-eletricos(t :: Time) -> List<String>:
    doc: "Dado um time, devolve uma lista com os nomes dos pokemons do tipo elétrico deste time."
    my-map(lista-eletrico(t), lam(p): p.nome end)
where:
    nomes-pokemon-eletricos(time1) is empty
    nomes-pokemon-eletricos(time3) is [list: "Pikachu", "Voltorb"]
end

fun desenha-pokemons-eletricos(t :: Time) -> Image:
    doc: "Dado um time, gera uma imagem com as cartas dos pokemons do tipo elétrico deste time empilhadas (colocar a carta do primeiro pokemon do time em cima)."
    my-fold(
      lista-eletrico(t),
      lam(p, acc): beside(desenha-carta(p), acc) end,
      empty-image)
end
