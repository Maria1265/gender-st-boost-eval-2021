# Repositorio com o resultado do experimento de esterotipo e gamificação na experiência de fluxo e autoeficácia 

## Dataset

O dataset dos dados coletados durante o experimênto estão disponiveis nos arquivos:

- [`responses.csv`](responses.csv) (Arquivo em formato CSV - separado por virgulas - e encoding UTF-8)
- [`responses.xlsx`](responses.xlsx) (Arquivo em formato Excel - e encoding UTF-8)

Descrição da informação disponível no dataset, columnas das tabelas:

- `ID`: identificador único do participante 
- `dfs`: média aritmética dos 09 items (dfs.iX) da disposição de fluxo (experiência de fluxo medida no preteste)
- `fss`: média aritmética dos 09 items (fss.iX) do estado de fluxo (experiência de fluxo medida no pósteste)
- `points`: pontos acumulados na atividade (diretamente proporcional ao numero de respostas corretas durante o experimento)
- `autoeficacia.pre`: média aritmética dos 06 items (pre.cX) do senso de autoeficácia dos participantes antes do experimento (medido no preteste)
- `autoeficacia.pre`: média aritmética dos 06 items (pos.cX) do senso de autoeficácia dos participantes depóis do experimento (medido no pósteste)
- `stType`: tipo de cenário gamificado no qual o participante foi atribuido, sendo assim, os valores possíveis `stMale`: cenário gamificado com um mensagem explícito de impulso masculino, `stFemale`: cenário gamificado com mensagem explícito de impulso femenino, e `default`: cenário gamificado sem mensagens de impulso
- `gender`: genero do participante
- `condicao`: condição de estereótipo que pode ser experiênciado pelo participante, sendo assim, os valores possíveis `stBoost`: impulso de estereótipo (quando o participante receve uma mensagem de impulso alinhado com seu genero), `stThreat`: ameaça de estereótipo (quando o participante receve uma mensagem de impulso contraria com seu genero), `neutro`: sem estereótipo
- `boostId`: mensagem de esterótipo recebido pelo participante, sendo eles: ...
- ...


## Hipóteses nulas avaliadas

- **H1(nula)**: Em cenários gamificados, não há diferença significativa na experiência de fluxo dos participantes que receberam mensagens alinhadas com seu genero (`stBoost`: impulso de estereótipo), participantes que receveram mensagens opostas com seu genero (`stThreat`: ameaça de estereótipo), e participantes sem mensagems (`neutro`: sem estereótipo), levando em consideração a disposição no fluxo dos participantes. 
  - Resultado do teste de hipóteses: [H1-fss-ancova/results/ancova.md](H1-fss-ancova/results/ancova.md)
   
- **H2(nula)**: Não há diferença significativa na experiência de fluxo dos participantes entre os fatores tipo de cenário (`stMale`: cenário gamificado com um mensagem explícito de impulso masculino, `stFemale`: cenário gamificado com mensagem explícito de impulso femenino, e `default`: cenário gamificado sem mensagens de impulso) e o sexo (masculino e femenino) dos participantes, levando em consideração a disposição no fluxo dos participantes.
  - Resultado do teste de hipóteses: [H2-fss-ancova/results/ancova.md](H2-fss-ancova/results/ancova.md)
  
- **H3(nula)**: Em cenários gamificados, não há diferença significativa na autoeficâcia em logica dos participantes que receberam mensagens alinhadas com seu genero (`stBoost`: impulso de estereótipo), participantes que receveram mensagens opostas com seu genero (`stThreat`: ameaça de estereótipo), e participantes sem mensagems (`neutro`: sem estereótipo), levando em consideração a autoeficâcia em logica antes da participção no estudo.
  - Resultado do teste de hipóteses: [H3-autoeficacia-ancova/results/ancova.md](H3-autoeficacia-ancova/results/ancova.md)

- **H4(nula)**: Não há diferença significativa na autoeficácia em logica dos participantes entre os fatores tipo de cenário (`stMale`: cenário gamificado com um mensagem explícito de impulso masculino, `stFemale`: cenário gamificado com mensagem explícito de impulso femenino, e `default`: cenário gamificado sem mensagens de impulso) e o sexo (masculino e femenino) dos participantes, levando em consideração a autoeficâcia em logica antes da participação no estudo.
  - Resultado do teste de hipóteses: [H4-autoeficacia-ancova/results/ancova.md](H4-autoeficacia-ancova/results/ancova.md)

- **H5(nula)**: Em cenários gamificados, não há diferença significativa no desempenho acadêmico dos participantes que receberam mensagens alinhadas com seu genero (`stBoost`: impulso de estereótipo), participantes que receveram mensagens opostas com seu genero (`stThreat`: ameaça de estereótipo), e participantes sem mensagems (`neutro`: sem estereótipo), levando em consideração a disposição no fluxo dos participantes
  - Resultado do teste de hipóteses: 
 
- **H6(nula)**: Não há diferença significativa no desempenho acadêmico dos participantes entre os fatores tipo de cenário (`stMale`: cenário gamificado com um mensagem explícito de impulso masculino, `stFemale`: cenário gamificado com mensagem explícito de impulso femenino, e `default`: cenário gamificado sem mensagens de impulso) e o sexo (masculino e femenino) dos participantes.
  - Resultado do teste de hipóteses: 


## 


