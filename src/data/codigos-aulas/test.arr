use context starter2024

include reactors


fun test(x):
  y = 2 + 2
  x
end

data Bola:
  | bola(
      x :: Number, 
      y :: Number,
      raio :: Number,
      dx :: Number,
      dy :: Number,
      color :: String)
end

data World:
  | world(l :: List<Bola>)
end

BOLA = bola(50, 50, 10, 10, 20, "red")
BOLA2 = bola(50, 50, 5, 5, 5, "blue")

w1 = world([list: BOLA, BOLA2])

fun atualiza(w) -> World:
  world(map(move-bola, w.l))
end

fun move-bola(b :: Bola) -> Bola:
  doc: "Atualiza a bola."
  bola(b.x + b.dx, b.y + b.dy, b.raio, b.dx, b.dy, b.color)
end

fun draw-bolas(l :: List<Bola>) -> Image:
  cases (List) l:
    | empty => empty-scene(300, 400)
    | link(f, r) => put-image(
        circle(f.raio, "solid", f.color),
        f.x, 
        f.y, 
        draw-bolas(r))
  end
end

fun draw-world(w :: World) -> Image:
  draw-bolas(w.l)
end

fun para(w :: World) -> Boolean:
  false
end

r = reactor:
  init: w1,
  to-draw: draw-world,
  on-tick: atualiza,
  stop-when: para,
  close-when-stop: true,
  seconds-per-tick: 0.1,
end

interact(r)
      
      