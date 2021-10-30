{
module Sygus.ParseSygus ( module Sygus.Syntax 
                        , parse
                        , parseCmd
                        , parseIndex
                        , parseBfTerm
                        , parseSortedVars
                        , parseSortedVars1
                        , parseSort
                        , parseMaybeGrammarDef
                        , parseGroupedRuleLists1 ) where

import Sygus.LexSygus
import Sygus.Syntax
}

%name parse sygus
%name parseCmd cmd
%name parseIndex index
%name parseBfTerm bfterm
%name parseSortedVars sorted_vars
%name parseSortedVars1 sorted_vars1
%name parseSort sort
%name parseMaybeGrammarDef maybe_grammar_def
%name parseGroupedRuleLists1 grouped_rule_lists1

%tokentype { Token }
%error { parseError }

%token
    num                 { TLit (LitNum $$) }
    bool                { TLit (LitBool $$) }
    other_lit           { TLit $$ }
    '_'                 { TUnderscore }
    '('                 { TOpenBracket }
    ')'                 { TCloseBracket }
    ':'                 { TColon }

    -- terms
    exists              { TSymbol "exists" }
    forall              { TSymbol "forall" }
    tlet                { TSymbol "let" }

    -- features
    grammars            { TSymbol "grammars" }
    fwdDecls            { TSymbol "fwd-decls" }
    recursion           { TSymbol "recursion" }

    -- cmds 
    checkSynth          { TSymbol "check-synth" }
    constraint          { TSymbol "constraint" }
    declareVar          { TSymbol "declare-var" }
    invConstraint       { TSymbol "inv-constraint" }
    setFeature          { TSymbol "set-feature" }
    synthFun            { TSymbol "synth-fun" }
    synthInv            { TSymbol "synth-inv" }

    -- smt cmds
    declareDatatype     { TSymbol "declare-datatype" }
    declareDatatypes    { TSymbol "declare-datatypes" }
    declareSort         { TSymbol "declare-sort" }
    defineFun           { TSymbol "define-fun" }
    defineSort          { TSymbol "define-sort" }
    setLogic            { TSymbol "set-logic" }
    setOption           { TSymbol "set-option" }

    -- gterm
    constant            { TSymbol "Constant" }
    variable            { TSymbol "Variable" }

    symb                { TSymbol $$ }
%%

sygus :: { [Cmd] }
       : sygus_rev { reverse $1 }

sygus_rev :: { [Cmd] }
           : sygus_rev cmd { $2:$1 }
           | {- empty -}   { [] }

cmd :: { Cmd }
     : '(' checkSynth ')'                                               { CheckSynth }
     | '(' constraint term ')'                                          { Constraint $3 }
     | '(' declareVar symb sort ')'                                     { DeclareVar $3 $4 }
     | '(' invConstraint symb symb symb symb ')'                        { InvConstraint $3 $4 $5 $6 }
     | '(' setFeature ':' feature bool ')'                              { SetFeature $4 $5 }
     | '(' synthFun symb '(' sorted_vars ')' sort maybe_grammar_def ')' { SynthFun $3 $5 $7 $8 }
     | '(' synthInv symb '(' sorted_vars ')' maybe_grammar_def  ')'     { SynthInv $3 $5 $7 }
     | smtCmd                                                           { SmtCmd $1 } 

lit :: { Lit }
     : num       { LitNum $1 }
     | bool      { LitBool $1}
     | other_lit { $1 }

identifier :: { Identifier }
            : symb                      { ISymb $1 }
            | '(' '_' symb indexes1 ')' { Indexed $3 $4 }

indexes1 :: { [Index] }
          : indexes_rev1 { reverse $1 }

indexes_rev1 :: { [Index] }
              : indexes_rev1 index { $2:$1 }
              | index              { [$1] }

index :: { Index }
       : num  {IndNumeral $1 }
       | symb {IndSymb $1 }

sorts1 :: { [Sort] }
          : sorts_rev1 { reverse $1 }

sorts_rev1 :: { [Sort] }
            : sorts_rev1 sort { $2:$1 }
            | sort            { [$1] }

sort :: { Sort }
      : identifier                { IdentSort $1 }
      | '(' identifier sorts1 ')' { IdentSortSort $2 $3 }

terms1 :: { [Term] }
        : terms_rev1 { reverse $1 }

terms_rev1 :: { [Term] }
            : terms_rev1 term { $2:$1 }
            | term           { [$1] }

term :: { Term }
      : identifier                               { TermIdent $1 }
      | lit                                      { TermLit $1 }
      | '(' identifier terms1 ')'                { TermCall $2 $3}
      | '(' exists '(' sorted_vars1 ')' term ')' { TermExists $4 $6 }
      | '(' forall '(' sorted_vars1 ')' term ')' { TermForAll $4 $6 }
      | '(' tlet '(' var_bindings1 ')' term ')'  { TermLet $4 $6 }

bfterms1 :: { [BfTerm] }
          : bfterms_rev1 { reverse $1 }

bfterms_rev1 :: { [BfTerm] }
              : bfterms_rev1 bfterm { $2:$1 }
              | bfterm              { [$1] }

bfterm :: { BfTerm }
        : identifier { BfIdentifier $1 }
        | lit        { BfLiteral $1 }
        | '(' identifier bfterms1 ')' { BfIdentifierBfs $2 $3 }

sorted_vars1 :: { [SortedVar] }
             : sorted_vars_rev1 { reverse $1 }

sorted_vars_rev1 :: { [SortedVar] }
            : sorted_vars_rev1 sorted_var { $2:$1 }
            | sorted_var                 { [$1] }

sorted_vars :: { [SortedVar] }
             : sorted_vars_rev { reverse $1 }

sorted_vars_rev :: { [SortedVar] }
            : sorted_vars_rev sorted_var { $2:$1 }
            | {- empty -}                 { [] }

sorted_var :: { SortedVar }
            : '(' symb sort ')' { SortedVar $2 $3 }

var_bindings1 :: { [VarBinding] }
               : var_bindings_rev1 { reverse $1 }

var_bindings_rev1 :: { [VarBinding] }
            : var_bindings_rev1 var_binding { $2:$1 }
            | var_binding                   { [$1] }

var_binding :: { VarBinding }
             : '(' symb term ')' { VarBinding $2 $3 }

feature :: { Feature }
         : grammars   { Grammars }
         | fwdDecls   { FwdDecls }
         | recursion  { Recursion }

smtCmd :: { SmtCmd }
        : '(' declareDatatype symb dt_dec ')'                           { DeclareDatatype $3 $4 }
        | '(' declareDatatypes '(' sort_decls1 ')' '(' dt_decs1 ')' ')' { DeclareDatatypes $4 $7 }
        | '(' declareSort symb num ')'                                  { DeclareSort $3 $4 }
        | '(' defineFun symb '(' sorted_vars ')' sort term ')'          { DefineFun $3 $5 $7 $8 }
        | '(' defineSort symb sort ')'                                  { DefineSort $3 $4 }
        | '(' setLogic symb ')'                                         { SetLogic $3 }
        | '(' setOption ':' symb lit ')'                                { SetOption $4 $5 }

sort_decls1 :: { [SortDecl] }
             : sort_decls_rev1 { reverse $1 }

sort_decls_rev1 :: { [SortDecl] }
                 : sort_decls_rev1 sort_decl   { $2:$1 }
                 | sort_decl                   { [$1] }

sort_decl :: { SortDecl }
           : '(' symb num ')' { SortDecl $2 $3 }

dt_decs1 :: { [DTDec] }
          : dt_decs_rev1 { reverse $1 }

dt_decs_rev1 :: { [DTDec] }
              : dt_decs_rev1 dt_dec { $2:$1 }
              | dt_dec              { [$1] }

dt_dec :: { DTDec }
        : '(' dt_cons_decs1 ')' { DTDec $2 }

dt_cons_decs1 :: { [DTConsDec] }
               : dt_cons_decs_rev1 { reverse $1 }

dt_cons_decs_rev1 :: { [DTConsDec] }
                   : dt_cons_decs_rev1 dt_cons_dec { $2:$1 }
                   | dt_cons_dec                   { [$1] }

dt_cons_dec :: { DTConsDec }
             : '(' symb sorted_vars ')' { DTConsDec $2 $3 }

maybe_grammar_def :: { Maybe GrammarDef }
                   : grammar_def { Just $1 }
                   | {- empty -} { Nothing }

grammar_def :: { GrammarDef }
             : '(' sorted_vars1 ')' '(' grouped_rule_lists1 ')' { GrammarDef $2 $5 }

grouped_rule_lists1 :: { [GroupedRuleList] }
                    : grouped_rule_lists_rev1 { reverse $1 }

grouped_rule_lists_rev1 :: { [GroupedRuleList] }
                        : grouped_rule_lists_rev1 grouped_rule_list { $2:$1 }
                        | grouped_rule_list                     { [$1] }

grouped_rule_list :: { GroupedRuleList }
                   : '(' symb sort '(' gterm1 ')' ')' { GroupedRuleList $2 $3 $5 }

gterm1 :: { [GTerm] }
        : gterm_rev1 { reverse $1 }

gterm_rev1 :: { [GTerm] }
            : gterm_rev1 gterm { $2:$1 }
            | gterm            { [$1] }

gterm :: { GTerm }
       : '(' constant sort ')' { GConstant $3 }
       | '(' variable sort ')' { GVariable $3 }
       | bfterm        { GBfTerm $1 }

{
parseError :: [Token] -> a
parseError l = error $ "Parse error." ++ show l
}
