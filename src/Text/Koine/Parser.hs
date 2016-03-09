{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Text.Koine.Parser where

import Text.Parsec
import Text.Parsec.Text

import Text.Koine.Types

parseValue :: Text -> Parser Value
parseValue
    = (VString <$> parseString)
  <|> (VNumber <$> parseNumber)
  <|> (VObject <$> parseObject)
  <|> (VArray  <$> parseArray)
  <|> (VTrue   <$> string "true")
  <|> (VFalse  <$> string "false")
  <|> (VNull   <$> string "null")

parseString :: Text -> Parser String
parseString = undefined

parseNumber :: Text -> Parser Number
parseNumber = do
  mminus <- optionMaybe $ char '-'
  int <- (string "0") <|> $ do
    d  <- oneOf ['1'..'9']
    ds <- many digit
    return $ d:ds
  mfrac <- optionMaybe $ do
    dot <- char '.' 
    ds  <- many1 digit
    return $ dot:ds 
  mexp <- do
    e <- (char 'e') <|> (char 'E')
    msign <- optionMaybe $ (string "+") <|> (string "-")
    ds <- many1 digit
    return $ e:((fromMaybe "" msign) <> ds)


parseObject :: Text -> Parser Object
parseObject = do
  string "{"
  ps <- flip sepBy (string ",") $ do
    s <- parseString
    string ":"
    v <- parseValue
    return (s,v)
  string "}"
  return $ Object $ Map.fromList ps

parseArray :: Text -> Parser Array
parseArray = do
  string "["
  v <- parseValue `sepBy` (string ",") 
  string "]"
  return v
