{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Sygus.Print (printSygus) where

import Sygus.Syntax

import Data.Semigroup
import Data.Text (Text, pack, intercalate)

class PrintSygus sy where
    printSygus :: sy -> Text

instance PrintSygus Lit where
    printSygus (LitNum i)
        | i >= 0 = pack $ show i
        | otherwise = pack $ "(- " ++ show (abs i) ++ ")"
    printSygus (LitDec n d) = pack (show n ++ "." ++ show d) 
    printSygus (LitBool b) = printSygus b
    printSygus (Hexidecimal s) = pack s
    printSygus (Binary s) = pack s
    printSygus (LitStr s) = "\"" <> pack s <> "\""

instance PrintSygus Symbol where
    printSygus s = pack s

instance PrintSygus [Cmd] where
    printSygus = printSygusList

instance PrintSygus Cmd where
    printSygus CheckSynth = "(check-synth)"
    printSygus (Constraint t) = "(constraint " <> printSygus t <> ")"
    printSygus (DeclareVar symb s) =
        "(declare-var " <> printSygus symb <> " " <> printSygus s <> ")"
    printSygus (InvConstraint s1 s2 s3 s4) =
        "(inv-constraint " <> printSygusList [s1, s2, s3, s4] <> ")"
    printSygus (SetFeature f b) =
        "(set-feature :" <> printSygus f <> " " <> printSygus b <> ")"
    printSygus (SynthFun symb sv s gd) =
        "(synth-fun " <> printSygus symb <> " (" <> printSygusList sv <> ") "
            <> printSygus s <> " " <> printSygus gd <> ")"
    printSygus (SynthInv symb sv gd) =
        "(synth-inv " <> printSygus symb <> " (" <> printSygusList sv <> ") " <> printSygus gd <> ")"
    printSygus (SmtCmd smt) = printSygus smt

instance PrintSygus Identifier where
    printSygus (ISymb symb) = printSygus symb
    printSygus (Indexed symb ind) =
        "(_ " <> printSygus symb <> " " <> printSygusList ind <> ")"

instance PrintSygus Index where
    printSygus (IndNumeral i) = pack $ show i
    printSygus (IndSymb s) = printSygus s 

instance PrintSygus Sort where
    printSygus (IdentSort i) = printSygus i
    printSygus (IdentSortSort i xs) =
        "(" <> printSygus i <> " " <> printSygusList xs <> ")"

instance PrintSygus Term where
    printSygus (TermIdent i) = printSygus i
    printSygus (TermLit l) = printSygus l
    printSygus (TermCall i ts) =
        "(" <> printSygus i <> " " <> printSygusList ts <> ")"
    printSygus (TermExists sv t) =
        "(exists " <> "(" <> printSygusList sv <> ")" <> printSygus t <> ")"
    printSygus (TermForAll sv t) =
        "(forall " <> "(" <> printSygusList sv <> ")" <> printSygus t <> ")"
    printSygus (TermLet vb t) =
        "(let (" <> printSygusList vb <> ") " <> printSygus t <> ")"

instance PrintSygus BfTerm where
    printSygus (BfIdentifier i) = printSygus i
    printSygus (BfLiteral l) = printSygus l
    printSygus (BfIdentifierBfs i bfs) =
        "(" <> printSygus i <> " " <> printSygusList bfs <> ")"

instance PrintSygus SortedVar where
    printSygus (SortedVar symb s) =
        "(" <> printSygus symb <> " " <> printSygus s <> ")"

instance PrintSygus VarBinding where
    printSygus (VarBinding symb t) =
        "(" <> printSygus symb <> " " <> printSygus t <> ")"

instance PrintSygus Feature where
    printSygus Grammars = "grammars"
    printSygus FwdDecls = "fwd-decls"
    printSygus Recursion = "recursion"

instance PrintSygus SmtCmd where
    printSygus (DeclareDatatype symb dt) =
        "(declare-datatype " <> printSygus symb <> " " <> printSygus dt <> ")"
    printSygus (DeclareDatatypes sd dt) =
        "(declare-datatypes (" <> printSygusList sd <> ") (" <> printSygusList dt <> "))" 
    printSygus (DeclareSort symb i) =
        "(declare-sort " <> printSygus symb <> " " <> printSygus i <> ")"
    printSygus (DefineFun symb sv s t) =
        "(define-fun " <> printSygus symb <> " (" <> printSygusList sv <> ") "
            <> printSygus s <> " " <> printSygus t <> ")"
    printSygus (DefineSort symb s) =
        "(define-sort " <> printSygus symb <> " " <> printSygus s <> ")"
    printSygus (SetLogic l) = "(set-logic " <> printSygus l <> ")"
    printSygus (SetOption symb l) =
        "(set-option " <> printSygus symb <> " " <> printSygus l <> ")"

instance PrintSygus SortDecl where
    printSygus (SortDecl symb i) =
        "(" <> printSygus symb <> " " <> printSygus i <> ")"

instance PrintSygus DTDec where
    printSygus (DTDec dt) = "(" <> printSygusList dt <> ")"

instance PrintSygus DTConsDec where
    printSygus (DTConsDec symb sv) = "(" <> printSygus symb <> " " <> printSygusList sv <> ")"

instance PrintSygus GrammarDef where
    printSygus (GrammarDef sv grl) =
        "(" <> printSygusList sv <> ") (" <> printSygusList grl <> ")"

instance PrintSygus GroupedRuleList where
    printSygus (GroupedRuleList symb s ts) =
        "(" <> printSygus symb <> " " <> printSygus s <> " (" <> printSygusList ts <> "))"

instance PrintSygus GTerm where
    printSygus (GConstant s) = "(Constant " <> printSygus s <> ")"
    printSygus (GVariable s) = "(Variable " <> printSygus s <> ")"
    printSygus (GBfTerm b) = printSygus b

instance PrintSygus sy => PrintSygus (Maybe sy) where
    printSygus (Just s) = printSygus s
    printSygus Nothing = ""

instance PrintSygus Integer where
    printSygus = pack . show

instance PrintSygus Bool where
    printSygus True = "true"
    printSygus False = "false"

printSygusList :: PrintSygus sy => [sy] -> Text
printSygusList = intercalate " " . map printSygus