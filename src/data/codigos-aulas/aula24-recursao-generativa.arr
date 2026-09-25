use context dcic2024

include reactors
import image as I



fun quicksort(l :: List<Number>) -> List<Number>:
    doc: ```Dado uma lista de números, ordena a lista em ordem crescente.

    Terminação: As definições locais menores e maiores-igual sempre são listas com tamanhos menores que o da lista original (porque pelo menos o primeiro elemento da lista é retirado). Portanto, cada chamada recursiva de quicksort é realizada sobre uma lista estritamente menor que a lista original. Como a lista original é finita, este processo gerará um dia uma chamada sobre a lista vazia, que é o caso trivial deste programa (não envolve recursão). Assim, assumindo que as funções/expressões "+", "filter", "cases", e "link" terminam, qualquer chamada de quicksort sempre terminará.
    ```
    cases (List<Number>) l:
        # Se a lista l for vazia, retornar a lista vazia.
        | empty => empty
        # Senão,
        | link(f, r) =>
            menores = filter(lam(x): x < f end, r)
            maiores-igual = filter(lam(x): x >= f end, r)
            # Juntar as seguintes listas:
                # 1. A lista ordenada dos elementos menores que o primeiro.
                # 2. A lista contendo apenas o primeiro elemento.
                # 3. A lista ordenada dos elementos maiores ou iguais ao primeiro.
            # spy: menores, f, maiores-igual end
            quicksort(menores) + [list: f] + quicksort(maiores-igual)
    end
where:
    quicksort(empty) is empty
    quicksort([list: 4, 3, 1, 5, 2, 1]) is [list: 1, 1, 2, 3, 4, 5]
end




fun img-pokemon(pokemon-id :: String) -> Image:
    doc: "Dado o id de um pokemon (como uma string de quatro dígitos), devolve a imagem deste pokemon."
    url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/" + pokemon-id + ".png"
    img = image-url(url)

    scale(0.75, img)
end

type ListaDeCenas = List<Image>
# ListaDeCenas é:
# | empty
# | link(first :: Image, rest :: List<Image>)
# end

data Pokemon:
    | pokemon(
        id :: String,    # Id do pokemon
        name :: String,  # Nome do pokemon
        x :: Number,     # coordenada x
        y :: Number,     # coordenada y
        dx :: Number,    # variação da coordenada x
        dy :: Number,    # variação da coordenada y
        img :: Image     # Imagem do pokemon
    )
end

LARG = 500
ALT = 500
CENARIO = rectangle(LARG, ALT, "solid", "forest-green")


PIKACHU = pokemon("0025", "Pikachu", 0, 0, 50, 50, flip-horizontal(img-pokemon("0025")))
EEVEE = pokemon("0133", "Eevee", 0, 0, 10, 10, img-pokemon("0133"))
BULBASAUR = pokemon("0001", "Bulbasaur", 0, 0, 2, 1, img-pokemon("0001"))


fun fora-dos-limites(p :: Pokemon) -> Boolean:
    doc: "Dado um pokemon, verifica se o pokemon está fora dos limites do cenário."
    not(
        (p.x >= 0) and (p.x <= LARG) and (p.y >= 0) and (p.y <= ALT)
    )
where:
    fora-dos-limites(pokemon("0133", "Eevee", 0, 0, 10, 10, img-pokemon("0133"))) is false
    fora-dos-limites(pokemon("0133", "Eevee", -10, -10, 10, 10, img-pokemon("0133"))) is true
end

fun desenha-cena(p :: Pokemon) -> Image:
    doc: "Dado um pokemon, devolve uma imagem do pokemon desenhada na posição (p.x, p.y) sobre o cenário."
    place-image(p.img, p.x, p.y, CENARIO)
end

fun move-pokemon(p :: Pokemon) -> Pokemon:
    doc: "Dado um pokemon, devolve um novo pokemon com a posição atualizada de acordo com as variações dx e dy."
    pokemon(
        p.id, 
        p.name, 
        p.x + p.dx, 
        p.y + p.dy, 
        p.dx, 
        p.dy, 
        p.img
    )
where:
    move-pokemon(pokemon("0133", "Eevee", 0, 0, 10, 10, img-pokemon("0133"))) is pokemon("0133", "Eevee", 10, 10, 10, 10, img-pokemon("0133"))
end

fun move-ate-que-fora(p :: Pokemon) -> ListaDeCenas:
    doc: ```Dado um pokemon, gera uma lista de cenas do pokemon se movendo a partir da posição (p.x, p.y) até que o pokemon esteja fora dos limites do cenário.
    
    Terminação: A função move-pokemon sempre retorna um pokemon com posição mais próxima dos limites do cenário que o pokemon original (considerando o vetor de deslocamento do pokemon). Portanto, cada chamada recursiva de move-ate-que-fora é realizada sobre um pokemon mais próximo dos limites. Como o cenário tem tamanho finito, este processo gerará um dia uma chamada sobre um pokemon que está fora dos limites do cenário, que é o caso trivial deste programa (não envolve recursão). Assim, assumindo que as funções fora-dos-limites, link, desenha-pokemon e move-pokemon terminam, qualquer chamada de move-ate-que-fora sempre terminará.
    ```
    ask:
        # Se o pokemon estiver fora dos limites do cenário, retornar a lista vazia.
        | fora-dos-limites(p) then: empty
        # Senão,
        | otherwise:
            # Montar uma lista com as seguintes cenas
            link(  
                # o primeiro elemento é a cena com o pokemon
                desenha-cena(p),
                # as cenas geradas pela movimentação do pokemon deslocado
                move-ate-que-fora(move-pokemon(p))
            )
    end
end

fun run-movie(fps :: Number, frames :: ListaDeCenas):
    doc: "Dado um valor de quadros por segundo e uma lista de cenas, exibe as imagens como um filme, mostrando cada imagem por 1/fps segundos."
    LEN = length(frames)
    r = reactor:
            init: 0,
            on-tick: lam(i): i + 1 end,
            to-draw: lam(i): frames.get(i) end,
            seconds-per-tick: 1 / fps,
            stop-when: lam(i): i >= (LEN - 1) end,
            close-when-stop: true,
    end

    interact(r)
end

#run-movie(10, move-ate-que-fora(PIKACHU))
#run-movie(10, move-ate-que-fora(EEVEE))
