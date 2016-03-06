{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Text.Koine.Printer where

import Prelude (($), flip, fmap, mconcat, show)

import qualified Data.Map as Map
import Data.Text (Text)
import qualified Data.Text as Text

import Text.Koine.Types

pprintValue :: Value -> Text
pprintValue (VString string) = pprintString string
pprintValue (VNumber number) = pprintNumber number
pprintValue (VObject object) = pprintObject object
pprintValue (VArray  array)  = pprintArray array
pprintValue VTrue            = "true"
pprintValue VFalse           = "false"
pprintValue VNull            = "null"

pprintString :: String -> Text
pprintString (String string) = string

pprintNumber :: Number -> Text
pprintNumber (Number number) = Text.pack $ show number

pprintObject :: Object -> Text
pprintObject (Object object) =
  mconcat
    [ "{"
    , Text.intercalate ", " $
        flip fmap (Map.toList object) $ \(string, value) ->
          mconcat
            [ unString string
            , ": "
            , pprintValue value
            ]
    , "}"
    ]

pprintArray :: Array -> Text
pprintArray (Array array) =
  mconcat
    [ "["
    , Text.intercalate ", " $
        fmap pprintValue array
    , "]"
    ]
