
import color from color
import color as C
include image
include csv
include data-source
include reactors

POKE-URL = "https://gist.githubusercontent.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6/raw/92200bc0a673d5ce2110aaad4544ed6c4010f687/pokemon.csv"

POKE-DATA =
  load-table: id, name, type1, type2, total, hp, attack, defense, spatck, spdef, speed, generation, legendary
    source: csv-table-url(POKE-URL, default-options)
    sanitize id using num-sanitizer
    sanitize name using string-sanitizer
    sanitize type1 using string-sanitizer
    sanitize type2 using string-sanitizer
    sanitize hp using num-sanitizer
  end


CARTA-ALT = 175
CARTA-LAR = 125

MESA = circle(20 + CARTA-ALT, "solid", "lightgray")
BORDA = rectangle(CARTA-LAR + 10, CARTA-ALT + 10, "outline", "black")
FUNDO-NORMAL = rectangle(CARTA-LAR, CARTA-ALT, "solid", "darkgray")
FUNDO-FIRE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "red")
FUNDO-WATER = rectangle(CARTA-LAR, CARTA-ALT, "solid", "blue")
FUNDO-ELECTRIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "yellow")
FUNDO-GRASS = rectangle(CARTA-LAR, CARTA-ALT, "solid", "green")
FUNDO-ICE = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightblue")
FUNDO-FIGHTING = rectangle(CARTA-LAR, CARTA-ALT, "solid", "brown")
FUNDO-POISON = rectangle(CARTA-LAR, CARTA-ALT, "solid", "mediumorchid")
FUNDO-PSYCHIC = rectangle(CARTA-LAR, CARTA-ALT, "solid", "magenta")
FUNDO-BUG = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightgreen")
FUNDO-GROUND = rectangle(CARTA-LAR, CARTA-ALT, "solid", "sienna")
FUNDO-FAIRY = rectangle(CARTA-LAR, CARTA-ALT, "solid", "pink")
FUNDO-ROCK = rectangle(CARTA-LAR, CARTA-ALT, "solid", "gray")
FUNDO-GHOST = rectangle(CARTA-LAR, CARTA-ALT, "solid", "purple")
FUNDO-DRAGON = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightsteelblue")
FUNDO-STEEL = rectangle(CARTA-LAR, CARTA-ALT, "solid", "lightgray")
FUNDO-FLYING = rectangle(CARTA-LAR, CARTA-ALT, "solid", "skyblue")
FUNDO-DARK = rectangle(CARTA-LAR, CARTA-ALT, "solid", "black")

ATAQUE = "Attack"
DEFESA = "Defense"
EFEITO-SEMEFEITO = "No effect"
EFEITO-NAOEFETIVO = "Not very effective"
EFEITO-EFETIVO = "Effective"
EFEITO-SUPEREFETIVO = "Super-effective!"
