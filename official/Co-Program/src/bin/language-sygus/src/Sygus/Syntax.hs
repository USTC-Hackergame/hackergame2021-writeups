{-# LANGUAGE DeriveGeneric #-}

module Sygus.Syntax where

import Data.Hashable
import GHC.Generics (Generic)

data Lit = LitNum Integer 
         | LitDec Integer Integer
         | LitBool Bool
         | Hexidecimal String
         | Binary String
         | LitStr String deriving (Eq, Show, Read, Generic)

instance Hashable Lit

type Symbol = String

data Cmd = CheckSynth
         | Constraint Term
         | DeclareVar Symbol Sort
         | InvConstraint Symbol Symbol Symbol Symbol
         | SetFeature Feature Bool
         | SynthFun Symbol [SortedVar] Sort (Maybe GrammarDef)
         | SynthInv Symbol [SortedVar] (Maybe GrammarDef)
         | SmtCmd SmtCmd
         deriving (Eq, Show, Read, Generic)

instance Hashable Cmd

data Identifier = ISymb Symbol
                | Indexed Symbol [Index]
                deriving (Eq, Show, Read, Generic)

instance Hashable Identifier

data Index = IndNumeral Integer
           | IndSymb Symbol
           deriving (Eq, Show, Read, Generic)

instance Hashable Index

data Sort = IdentSort Identifier
          | IdentSortSort Identifier [Sort]
          deriving (Eq, Show, Read, Generic)

instance Hashable Sort

data Term = TermIdent Identifier
          | TermLit Lit
          | TermCall Identifier [Term]
          | TermExists [SortedVar] Term
          | TermForAll [SortedVar] Term
          | TermLet [VarBinding] Term
          deriving (Eq, Show, Read, Generic)

instance Hashable Term

data BfTerm = BfIdentifier Identifier
            | BfLiteral Lit
            | BfIdentifierBfs Identifier [BfTerm]
            deriving (Eq, Show, Read, Generic)

instance Hashable BfTerm

data SortedVar = SortedVar Symbol Sort deriving (Eq, Show, Read, Generic)

instance Hashable SortedVar

data VarBinding = VarBinding Symbol Term deriving (Eq, Show, Read, Generic)

instance Hashable VarBinding

data Feature = Grammars
             | FwdDecls
             | Recursion
             deriving (Eq, Show, Read, Generic)

instance Hashable Feature

data SmtCmd = DeclareDatatype Symbol DTDec
            | DeclareDatatypes [SortDecl] [DTDec]
            | DeclareSort Symbol Integer
            | DefineFun Symbol [SortedVar] Sort Term
            | DefineSort Symbol Sort
            | SetLogic Symbol
            | SetOption Symbol Lit
            deriving (Eq, Show, Read, Generic)

instance Hashable SmtCmd

data SortDecl = SortDecl Symbol Integer deriving (Eq, Show, Read, Generic)

instance Hashable SortDecl

data DTDec = DTDec [DTConsDec] deriving (Eq, Show, Read, Generic)

instance Hashable DTDec

data DTConsDec = DTConsDec Symbol [SortedVar] deriving (Eq, Show, Read, Generic)

instance Hashable DTConsDec

data GrammarDef = GrammarDef [SortedVar] [GroupedRuleList] deriving (Eq, Show, Read, Generic)

instance Hashable GrammarDef

data GroupedRuleList = GroupedRuleList Symbol Sort [GTerm] deriving (Eq, Show, Read, Generic)

instance Hashable GroupedRuleList

data GTerm = GConstant Sort
           | GVariable Sort
           | GBfTerm BfTerm
           deriving (Eq, Show, Read, Generic)

instance Hashable GTerm
