import Data.List

type Tokens = [String]

type LinhaTabela = [(String, Bool)]

calculaLinha :: Tokens -> LinhaTabela -> (Bool, Tokens)
calculaLinha (x : xs) y
  | x == "->" =
    let res1 = calculaLinha xs y
        res2 = calculaLinha (snd res1) y
        result = (not (fst res1) || (fst res2), snd res2)
     in result
  | x == "&" =
    let res1 = calculaLinha xs y
        res2 = calculaLinha (snd res1) y
        result = (fst res1 && fst res2, snd res2)
     in result
  | x == "|" =
    let res1 = calculaLinha xs y
        res2 = calculaLinha (snd res1) y
        result = (fst res1 || fst res2, snd res2)
     in result
  | x == "<->" =
    let res1 = calculaLinha xs y
        res2 = calculaLinha (snd res1) y
        var1 = fst res1
        var2 = fst res2
        res = (not var1 || var2) && (var1 || not var2)
        result = (res, snd res2)
     in result
  | x == "~" =
    let res1 = calculaLinha xs y
        result = (not $ fst res1, snd res1)
     in result
  | otherwise =
    let filtered = filter ((== x) . fst) y
        firstElem = filtered !! 0
        letterValue = snd firstElem
        result = (letterValue, xs)
     in result

-- calcula :: Tokens -> [LinhaTabela] -> [Bool]

subexpr :: [Int] -> [String] -> [[String]]
subexpr [] _ = []
subexpr (x:xs) tokens = [(take (x+1) tokens)] ++ subexpr xs (drop (x+1) tokens)

entrada expressao =
  let operadores = ["&", "|", "~", "->", "<->"]
      tokens = words expressao
      variaveis = (nub tokens) \\ operadores
      tabelaVerdade = mapM (const [True, False]) variaveis
      tabela = zip variaveis <$> tabelaVerdade
      resultados = [calculaLinha tokens table | table <- tabela]
      resultados_verdade = [linha ++ [item] | (linha, item) <- zip tabelaVerdade (map fst resultados)]
      teste = subexpr (findIndices (`elem` ["&", "|", "->", "<->"]) tokens) tokens 
   in print teste

main :: IO ()
main = do
  m <- getLine
  entrada m