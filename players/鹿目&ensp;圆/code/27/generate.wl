(* ::Package:: *)

(* ::Input:: *)
(*raw=Import/@{"1++"};*)
(*raw=Import/@{"2-1","2-2"};*)


(* ::Input:: *)
(*rawData=Characters/@StringSplit[raw,"\n"];*)
(*data=Map[Join[#,ConstantArray[" ",200]]&,rawData,{2}];*)
(*{a,b,c}={Length@rawData,Length@rawData[[1]],Length/@rawData[[1]]//Max};*)
(*ans=Flatten@Table[If[data[[i,j,k]]!=" ",*)
(*{k-1,j-1,i-1}->data[[i,j,k]],Nothing],{i,a},{j,b},{k,c}];*)


(* ::Input:: *)
(*result=EchoFunction[Short]@StringJoin[*)
(*StringJoin["(",StringRiffle[ToString/@#1,","],")->",ToString@ToCharacterCode[#2][[1]],""]&@@@ans," END"];*)
(*CopyToClipboard@result*)


(* ::Input:: *)
(*StringLength@result*)


(* ::Subsection:: *)
(*other*)


(* ::Input:: *)
(*ToCharacterCode@"+*^x|<"-43-17*)
