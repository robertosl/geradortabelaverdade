import Data.List

type [String] = [String]
type [(String, Bool)] = [(String, Bool)]

-- pilha
push :: String -> [String] -> [String]
push x pilha = pilha ++ [x]

elemTop :: [String] -> String
elem_top [x] = x
elem_top (x:xs) = elem_top xs

pop :: [String] -> [String]
pop [] = error "Pilha vazia"
pop (x:xs) | x == (elem_top (x:xs)) = xs
           | otherwise = x:(pop xs)

isEmpty :: [String] -> Bool
isEmpty [] = True
isEmpty _ = False
-- fim pilha

operadores = ["&", "||", "~", "=>", "<=>"]

inverteLista :: [String] -> [String]
inverteLista [] = []
inverteLista (x:xs) = inverteLista xs ++ [x]

opera :: String -> [String] -> Bool

calculaLinha :: [String] -> [(String, Bool)] -> Bool
caculaLinha tokens linhaTabela = map token tokens where
  token x | x ==  "!"    = putStrLn x
          | otherwise = tokens

-- calcula :: [String] -> [[(String, Bool)]] -> [Bool]


entrada expressao  = let
  tokens = words expressao
  variaveis = (nub tokens) \\ operadores
  tabelaVerdade = mapM (const [True,False]) variaveis
  tabela = zip variaveis <$> tabelaVerdade 
  -- resultado = calcula (inverteLista tokens) [("a", True), ("b", True), ("c", False)]
  in print $ inverteLista tokens

main :: IO()
main = do 
  m <- getLine
  entrada m