**1.1-1 Cite um exemplo real que exija ordenação ou um exemplo real que exija o cálculo de uma [[envoltória convexa]].** 

**R:** Em um sistema de gerenciamento de senhas de um banco, as senhas precisam ser processadas em ordem crescente para garantir que os clientes sejam atendidos na sequência correta.

**1.1-2 Além da velocidade, que outras medidas de eficiência poderiam ser usadas em uma configuração real?** 

**R:** Além da velocidade, outras medidas de eficiência incluem o uso de memória, escalabilidade, facilidade de implementação e consumo de energia.

**1.1-3 Selecione uma estrutura de dados que você já tenha visto antes e discuta seus pontos fortes e suas limitações.** 

**R:** Uma hash table é uma estrutura de dados eficiente para buscas rápidas, com complexidade média de O(1) para inserção e busca. No entanto, ela não mantém a ordem dos elementos e pode sofrer com colisões, o que pode aumentar o tempo de operação em alguns casos.

**1.1-4 Em que aspectos os problemas anteriores do caminho mais curto e do caixeiro-viajante são semelhantes? Em que aspectos eles são diferentes?**

**R:** Ambos os problemas envolvem encontrar rotas ótimas em grafos, mas enquanto o problema do caminho mais curto foca em encontrar a melhor rota entre dois pontos, o problema do caixeiro-viajante busca a melhor rota que visita todos os pontos e retorna ao início, sendo significativamente mais complexo.

**1.1-5 Mostre um problema real no qual apenas a melhor solução servirá. Em seguida, apresente um problema em que baste uma solução que seja “aproximadamente” a melhor.**

**R:** Um exemplo de problema que exige a melhor solução é o problema do caixeiro-viajante, onde qualquer desvio da rota ótima pode aumentar significativamente os custos de transporte. Já um exemplo de problema que aceita uma solução aproximada é a recomendação de produtos em um site de e-commerce, onde uma aproximação razoável já é suficiente para gerar sugestões úteis.

---
1.2-1 **Cite um exemplo de aplicação que exige conteúdo algorítmico no nível da aplicação e discuta a função dos algoritmos envolvidos.**

**R:** Um exemplo clássico de aplicação que exige conteúdo algorítmico no nível da aplicação é o **roteamento em redes de computadores** .

**Função dos algoritmos envolvidos:**

- Em uma rede de computadores, os pacotes de dados precisam ser enviados do remetente ao destinatário através de várias rotas possíveis. Para determinar a rota mais eficiente, são usados algoritmos como o **[[Algoritmo de Dijkstra]]** ou o **[[Algoritmo de Bellman-Ford]]** .
- Esses algoritmos calculam o caminho mais curto (em termos de distância, tempo ou custo) entre dois pontos na rede, considerando as conexões disponíveis (arestas) e seus pesos (como latência ou largura de banda).
- A escolha do algoritmo depende das características da rede, como se há ciclos negativos ou se a rede é dinâmica (muda com o tempo).

**Importância dos algoritmos:**

- Sem algoritmos eficientes, o roteamento seria ineficiente, levando a congestionamentos, tempos de resposta lentos e perda de pacotes.
- Os algoritmos garantem que os dados cheguem ao destino de forma rápida e confiável, mesmo em redes complexas e dinâmicas.

1.2-2 **Suponha que estamos comparando implementações de ordenação por inserção e ordenação por intercalação na mesma máquina. Para entradas de tamanho n, a ordenação por inserção é executada em 8n2 passos, enquanto a ordenação por intercalação é executada em 64n lg n passos. Para quais valores de n a ordenação por inserção supera a ordenação por intercalação?**

**R:** n < 128

1.2-3 **Qual é o menor valor de n tal que um algoritmo cujo tempo de execução é 100n2 funciona mais rapidamente que um algoritmo cujo tempo de execução é 2n na mesma máquina?**

**R:** n = 15

---




