import Data.List

type Tokens = [String]
type LinhaTabela = [(String, Bool)]

-- pilha
push :: String -> [String] -> [String]
push x pilha = pilha ++ [x]

elem_top :: [String] -> String
elem_top [x] = x
elem_top (x:xs) = elem_top xs

pop :: [String] -> [String]
pop [] = error "Pilha vazia"
pop (x:xs) | x == (elem_top (x:xs)) = xs
           | otherwise = x:(pop xs)

is_empty :: [String] -> Bool
is_empty [] = True
is_empty _ = False

-- fium pilha

inverte_lista :: [String] -> [String]
inverte_lista [] = []
inverte_lista (x:xs) = inverte_lista xs ++ [x]

opera :: String -> [String] -> Bool

calcula_linha :: Tokens -> LinhaTabela -> Bool
cacula_linha = map (\x -> if (even x) then (x `div` 2) else x) [1,2,3,4]

calcula :: Tokens -> [LinhaTabela] -> [Bool]


entrada expressao  = let
  operadores = ["&", "||", "~", "=>", "<=>"]
  tokens = words expressao
  variaveis = (nub tokens) \\ operadores
  tabelaVerdade = mapM (const [True,False]) variaveis
  tabela = zip variaveis <$> tabelaVerdade 
  resultado = calcula (inverte_lista tokens) [("a", True), ("b", True), ("c", False)]
  in print $ inverte_lista tokens

main :: IO()
main = do 
  m <- getLine
  entrada m