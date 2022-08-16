{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# LANGUAGE OverloadedStrings #-}

module Demo where

import Project
import Reporting

someProject :: Project
someProject =  ProjectGroup "Brasil" [beloHorizonte, recife, saoPaulo]
    where
      beloHorizonte = Project 1 "BH"
      recife = Project 2 "Recife"
      saoPaulo = ProjectGroup "SP" [braganca, campinas]
      braganca = Project 3 "Bragança"
      campinas = Project 4 "Campinas"



