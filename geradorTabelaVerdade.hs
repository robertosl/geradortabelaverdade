import Data.List

type Tokens = [String]

type LinhaTabela = [(String, Bool)]

type SubStrings = [[String]]

geraSubStrings :: Tokens -> (SubStrings, Tokens)
geraSubStrings (x : xs)
  | x `elem` ["->", "&", "|", "<->"] =
    let res1 = geraSubStrings xs
        res2 = geraSubStrings (snd res1)
        primeira_lista = head (fst res1)
        segunda_lista = head (fst res2)
        primeiro_elemento = [x] ++ primeira_lista ++ segunda_lista
        result = ([primeiro_elemento] ++ fst res1 ++ fst res2, snd res2)
     in result
  | x == "~" =
    let res1 = geraSubStrings xs
        primeira_lista = head (fst res1)
        primeiro_elemento = [x] ++ primeira_lista
        result = ([primeiro_elemento] ++ fst res1, snd res1)
     in result
  | otherwise = ([[x]], xs)

calculaLinha :: Tokens -> LinhaTabela -> (Bool, Tokens)
calculaLinha (x : xs) y
  | x `elem` ["->", "&", "|", "<->"] =
    let res1 = calculaLinha xs y
        res2 = calculaLinha (snd res1) y
        var1 = fst res1
        var2 = fst res2
        result = (interpretaExpressao x var1 var2, snd res2)
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

interpretaExpressao :: String -> Bool -> Bool -> Bool
interpretaExpressao operacao var1 var2
  | operacao == "->" = not var1 || var2
  | operacao == "&" = var1 && var2
  | operacao == "|" = var1 || var2
  | operacao == "<->" = (not var1 || var2) && (var1 || not var2)

denominacaoFuncao :: [[Bool]] -> String
denominacaoFuncao x
  | all (== True) resultados = "Tautologia"
  | any (== True) resultados = "Formula satisfativel"
  | otherwise = "Formula insatisfativel"
  where
    resultados = map last x

entrada :: [Char] -> IO ()
entrada expressao =
  let operadores = ["&", "|", "~", "->", "<->"]
      tokens = words expressao
      variaveis = sort $ nub tokens \\ operadores
      tabelaVerdade = mapM (const [True, False]) variaveis
      tabela = zip variaveis <$> tabelaVerdade
      subExpressions = fst $ geraSubStrings tokens
      onlyExpressions = reverse $ filter (\x -> length x >= 2) subExpressions
      onlyVars = [[var] | var <- variaveis]
      compareStr a b
        | length a < length b = LT
        | otherwise = GT
      finalStrings = onlyVars ++ sortBy compareStr onlyExpressions
      resultado = [[fst $ calculaLinha tokens variaveis | tokens <- finalStrings] | variaveis <- tabela]
      printableResults = [intercalate " | " $ map (\x -> if x then "V" else "F") linha | linha <- resultado]
      tables = intercalate " | " $ map unwords finalStrings
      denominacao = denominacaoFuncao resultado
      resultadoFinal = [tables] ++ printableResults ++ [denominacao]
   in mapM_ print resultadoFinal

main :: IO ()
main = do
  m <- getLine
  entrada m