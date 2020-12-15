{-# LANGUAGE DeriveLift      #-}
{-# LANGUAGE TemplateHaskell #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

module Provenance where

import Language.Haskell.TH
import Language.Haskell.TH.Syntax (Lift)


data Provenance a = Provenance
  { getProvenance :: Loc
  , getData :: a
  }
  deriving (Eq, Ord, Show, Functor)

deriving instance Lift Loc


track :: TExpQ (a -> Provenance a)
track = do
  loc <- location
  [||Provenance loc||]

