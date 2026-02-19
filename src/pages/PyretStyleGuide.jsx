import React from 'react';
import PyretEmbed from '../components/PyretEmbed';
import { Link } from 'react-router-dom';

const PyretStyleGuide = () => {
    return (
        <div className="page-content">
            <Link to="/topics" className="back-link" style={{ display: 'inline-block', marginBottom: '1rem', textDecoration: 'none', color: '#666' }}>
                ← Voltar para Tópicos
            </Link>

            <h1>Guia de Estilo Pyret (Testes, Design e Clareza)</h1>
            <p className="intro">
                Adaptado de <a href="https://cs111-docs.cs.brown.edu/s/pyret-guide" target="_blank" rel="noopener noreferrer">Pyret Style Guide - Brown University</a>.
            </p>

            <div className="section">
                <h2>Exemplos (Testes Automatizados)</h2>
                <p>
                    1. <strong>Todas as funções, incluindo funções auxiliares, requerem exemplos</strong> (exceto funções que retornam imagens).
                    Eles servem como uma forma de documentação. Exemplos são escritos em blocos `where`.
                </p>
                <br />
                <p>
                    2. Exemplos devem ser escritos <strong>antes</strong> de você começar a escrever sua função.
                    Escrever bons exemplos ajuda você a entender como sua função deve se comportar com diferentes entradas.
                </p>
                <br />
                <p>
                    3. Exemplos devem ilustrar variações interessantes nas entradas ou no comportamento da função.
                    Você não precisa testar todas as combinações (o que seria impossível!), mas deve cobrir diferentes cenários.
                </p>

            </div>

            <div className="section">
                <h2>Diretrizes para desenvolver exemplos</h2>

                <h4>Cubra Casos Extremos (Edge Cases)</h4>
                <p>
                    Casos extremos são entradas nos limites do espaço de entradas.
                    Por exemplo, para uma função que testa "números entre 4 e 8", os limites são importantes.
                    Outros limites comuns são strings vazias, zero, ou listas vazias.
                </p>
                <br />

                <h4>Exemplo Prático</h4>
                <p>
                    Como exemplo, considere uma função `compare` que recebe dois números `x` e `y` e retorna uma string. Ela deve retornar "muito menor" se `x` for menor que `y - 2`, "quase igual" se `x` estiver entre `y - 2` e `y + 2` (inclusive) e "muito maior" se `x` for maior que `y + 2`. Aqui está um conjunto de bons exemplos para esta função.
                </p>
                <PyretEmbed code={`fun compare(x :: Number, y :: Number) -> String:
  doc: "descreve a relação entre os números x e y"
  if x < (y - 2):
    "muito menor"
  else if (x >= (y - 2)) and (x <= (y + 2)):
    "quase igual"
  else:
    "muito maior"
  end
where:
  compare(1, 40) is "muito menor"
  compare(0, 3) is "muito menor"
  compare(8, 10) is "quase igual"
  compare(1, 1) is "quase igual"
  compare(0, 1) is "quase igual"
  compare(20, 17) is "muito maior"
end`} />

                <p>
                    Note que esses exemplos cobrem cada "caso" relevante do programa. Eles também incluem casos extremos testando os limites - por exemplo, `compare(8, 10)` é um caso extremo, pois está no limite entre os casos "muito menor" e "quase igual".
                </p>
            </div>

            <div className="section">
                <h2>Design</h2>
                <p>
                    1. <strong>Use constantes</strong> para capturar relacionamentos entre valores. Evite "números mágicos" espalhados pelo código.
                </p>
                <pre><code>
                    {`# Ruim
rectangle(500, 300, "solid", "green") # O que é 500?

# Bom
width = 500
height = 300
rectangle(width, height, "solid", "green")`}
                </code></pre>

                <p>
                    2. <strong>Use funções auxiliares</strong> para evitar repetição de código. Se você tem uma expressão que aparece várias vezes com pequenas alterações, crie uma função. Por exemplo:
                </p>
                <pre><code>{`stairs = beside-align("bottom", rectangle(50, 50, "solid", "gray"),
 beside-align("bottom", rectangle(50, 100, "solid", "gray"),
   beside-align("bottom", rectangle(50, 150, "solid", "gray"),
     rectangle(50, 200, "solid", "gray"))))`}
                </code></pre>
                Pode ser escrito como:
                <pre><code>{`stair-width = 50
fun stair(height :: Number) -> Image:
  doc: "make an individual stair given its height"
  rectangle(stair-width, height, "solid", "gray")
end

stairs = beside-align("bottom", stair(50),
  beside-align("bottom", stair(100),
    beside-align("bottom", stair(150), stair(200))))
                `}
                </code></pre>
            </div>

            <div className="section">
                <h2>Clareza</h2>
                <p>
                    1. <strong>Escreva docstrings</strong> para todas as funções. Uma boa docstring descreve o que a função faz, suas entradas e saídas. Idealmente, olhando para a docstring você sabe o que a função faz e como usá-la sem precisar olhar para o corpo da função.
                </p>

                <pre><code>{`fun three-stripes(bot-col :: String, mid-col :: String, top-col :: String) -> Image:
  doc: "Cria uma bandeira retangular com três listras. As entradas descrevem as cores de baixo para cima."
  # ... implementação ...
end`}</code></pre>

                <p>
                    2. <strong>Dê nomes úteis</strong> para constantes e funções.
                </p>
                <pre><code>
                    {`# Ruim
n1 = 3.1415
n2 = 500
n3 = 30
fun helper(x):
  x + 3
end

# Bom
pi = 3.1415
flag-width = 500
circle-radius = 30
fun add-3(x):
  doc: "adds three to its input x"
  x + 3
end`}
                </code></pre>

                <p>
                    3. <strong>Todas as funções requerem anotações de tipo</strong> nas entradas e na saída.
                </p>
                <br />
                <p>
                    4. Nomes de constantes e funções devem ser em minúsculas e separados por hífens (kebab-case).
                </p>
                <pre><code>
                    {`# Bom Estilo Pyret:
flag-width = 500
width-to-height-ratio = 3/5
CHARACTER-HEIGHT = 40 # Constantes de configuração podem ser UPPER-CASE

# Mau Estilo Pyret:
flag_width = 500
widthHeightRatio = 3/5
CharacterHeight = 40`}
                </code></pre>
                <br />
                <p>
                    5. <strong>Mantenha as linhas abaixo de 80 caracteres</strong>. Se a linha for muito longa, quebre-a. Docstrings muito grandes podem ser escritas usando (`):
                </p>
                <pre><code>{`fun f(x :: Number) -> Number
  doc: \`\`\`return 2; ignore inputs, always outputs 2 no matter what, 
          this function is going to return 2\`\`\`
  2
end`}
                </code></pre>
                <br />
                <p>
                    6. <strong>Indente seu código corretamente</strong>. Use `Ctrl-A` (ou `Cmd-A`) e `Tab` para auto-indentar.
                </p>
                <pre><code>{`# Ruim
fun f(x :: Number) -> Number:
ask:
    | x < 2 then: 2
| otherwise: 4
end
end

# Bom
fun f(x :: Number) -> Number:
  ask:
  | x < 2 then: 2
  | otherwise: 4
  end
end`}</code></pre>
            </div>
        </div>
    );
};

export default PyretStyleGuide;
