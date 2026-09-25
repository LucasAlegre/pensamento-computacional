use context starter2024
data Forma:
  | retangulo(lado1 :: Number, lado2 :: Number, cor :: String, nome :: String)
  | triangulo(lado :: Number, cor :: String, nome :: String)
  | circulo(raio :: Number, cor :: String, nome :: String)
end

C1 = circulo(20, "pink", "C1")
T1 = triangulo(30, "blue", "T1")
R1 = retangulo(30, 60, "red", "R1")

L1 :: List<Forma> = empty
L2 :: List<Forma> = link(C1, link(T1, link(R1, empty)))

fun desenha(f :: Forma) -> Image:
  cases (Forma) f:
    | retangulo(l1, l2, c, n) => rectangle(l1, l2, "solid", c)
    | triangulo(l, c, n) => triangle(l, "solid", c)
    | circulo(r, c, n) => circle(r, "solid", c)
  end
where:
  desenha(R1) is rectangle(30, 60, "solid", "red")
end

desenha(R1)

fun lista-retangulos(lf :: List<Forma>) -> List<Forma>:
  cases (List) lf:
    | empty => empty
    | link(f, r) => cases (Forma) f:
        | retangulo(l1,l2,c,n) => link(f, lista-retangulos(r))
        | else => lista-retangulos(r)
      end
  end
where:
  lista-retangulos(L1) is empty
  lista-retangulos(L2) is link(R1, empty)
end

fun lista-retangulos2(lf :: List<Forma>) -> List<Forma>:
  filter(is-retangulo, lf)
where:
  lista-retangulos2(L1) is empty
  lista-retangulos2(L2) is link(R1, empty)
end

fun lista-nomes-retangulos(lf :: List<Forma>) -> List<String>:
  map(lam(f): f.nome end, filter(is-retangulo, lf))
where:
  lista-nomes-retangulos(L2) is [list: "R1"]
end