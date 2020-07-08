{-# OPTIONS_GHC -Wall #-}

foreign import javascript "console.log($1)" print_int :: Int -> IO ()

main :: IO ()
main = print_int $ head []
