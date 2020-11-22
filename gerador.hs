import Data.List

entrada expressao  = let
  operadores = ["&", "||", "~", "=>", "<=>"]
  tokens = words expressao
  variaveis = (nub tokens) \\ operadores
  tabelaVerdade = mapM (const [True,False]) variaveis
  tabela = zip variaveis <$> tabelaVerdade 
  in print $ tabela

main :: IO()
main = do 
  m <- getLine
  entrada m