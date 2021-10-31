(* ::Package:: *)

(* ::Input:: *)
(*Clear["`*"]*)


(* ::Input:: *)
(*img=Import["pixelated_qrcode.bmp"];*)


(* ::Input:: *)
(*blockSize=11;*)
(*mosaicSize=23;*)
(*mosaicNumber=20;*)
(*startPosition={103,137};*)


(* ::Input:: *)
(*integerQ[x_]:=x==0||x==1*)


(* ::Input:: *)
(*measures[p_]:=SelectFirst[Mean@ImageMeasurements[ImageTake[p,##],"Mean"]&*)
(*@@@{{1,1},{1,-1},{-1,1},{-1,-1}},integerQ,"?"]*)


(* ::Input:: *)
(*raw=Map[measures,ImagePartition[img,11],{2}];*)
(*blockNumber=Dimensions[raw][[1]];*)


(* ::Input:: *)
(*{mark,{allVar}}=Reap@Table[If[raw[[i,j]]=="?",Sow@t[i,j],Round@raw[[i,j]]],{i,blockNumber},{j,blockNumber}];*)


(* ::Input:: *)
(*getValue[i_,j_]:=mark[[Quotient[i+10,11],Quotient[j+10,11]]]*)


(* ::Input:: *)
(*expectValue=Table[Mean@Flatten@*)
(*Table[getValue[startPosition[[1]]+(i-1) mosaicSize+a,startPosition[[2]]+(j-1) mosaicSize+b],{a,mosaicSize},{b,mosaicSize}],{i,mosaicNumber},{j,mosaicNumber}];*)


(* ::Input:: *)
(*mosaicValue=Round[Map[Mean@ImageMeasurements[#,"Mean"]&,*)
(*ImagePartition[ImageTake[img,*)
(*{startPosition[[1]]+1,startPosition[[1]]+mosaicNumber mosaicSize},{startPosition[[2]]+1,startPosition[[2]]+mosaicNumber mosaicSize}],*)
(*mosaicSize],{2}],1/255];*)


(* ::Input:: *)
(*eqns[1]=Simplify@Flatten@Floor[Flatten[expectValue],1/255]==Flatten@mosaicValue//Thread;*)


(* ::Section:: *)
(*inferSolve*)


(* ::Input:: *)
(*inferSolve[eqn_]:=Module[{vars=Cases[eqn,t[a_,b_],Infinity],possible},possible=#1&@@@Select[#[[2]]&]@Table[values->eqn/.Thread[vars->values],*)
(*{values,Tuples[{0,1},Length@vars]}];*)
(*First/@Select[AssociationThread[vars->Transpose@possible],Equal@@#&]//Normal]*)


(* ::Input:: *)
(*Table[ans[i]=inferSolve/@eqns[i]//Flatten//Union;eqns[i+1]=eqns[i]/.Union@Flatten@ans[i]/.True->Nothing,{i,10}];*)


(* ::Input:: *)
(*Table[Length@eqns[i],{i,10}]*)


(* ::Input:: *)
(*Table[Length@ans[i],{i,10}]*)


(* ::Input:: *)
(*answer=Flatten@Table[ans[i],{i,5}];*)


(* ::Input:: *)
(*answerImage=mark/.answer/.t[a_,b_]->.5//Image*)


(* ::Input:: *)
(*ansString=BarcodeRecognize@answerImage*)
