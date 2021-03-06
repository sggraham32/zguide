-- |
-- Hello World server in Haskell
-- Binds REP socket to tcp://*:5555
-- Expects "Hello" from client, replies with "World"
-- 
-- Translated to Haskell by ERDI Gergo http://gergo.erdi.hu/

module Main where

import System.ZMQ3.Monadic
import Control.Monad (forever)
import Data.ByteString.Char8 (pack, unpack)
import Control.Concurrent (threadDelay)

main :: IO ()
main =
    runZMQ $ do  
        liftIO $ putStrLn "Starting Hello World server"
        repSocket <- socket Rep
        bind repSocket "tcp://*:5555"
  
        liftIO $ putStrLn "Entering main loop"
        forever $ do
            message <- receive repSocket 
            liftIO $ putStrLn $ unwords ["Received request:", unpack message]    

            -- Simulate doing some 'work' for 1 second
            liftIO $ threadDelay (1 * 1000 * 1000)

            send repSocket [] (pack "World") 
