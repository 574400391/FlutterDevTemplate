import{c as L,f as S,h as I,d as y,i as B,b as a,n as o,t as D,R as s,av as u,I as b,w as V}from"./index-2f00049f.js";const[R,t]=L("cell"),_={icon:String,size:String,title:o,value:o,label:o,center:Boolean,isLink:Boolean,border:D,required:Boolean,iconPrefix:String,valueClass:s,labelClass:s,titleClass:s,titleStyle:null,arrowDirection:String,clickable:{type:Boolean,default:null}},q=S({},_,I);var z=y({name:R,props:q,setup(e,{slots:l}){const f=B(),v=()=>{if(l.label||u(e.label))return a("div",{class:[t("label"),e.labelClass]},[l.label?l.label():e.label])},h=()=>{if(l.title||u(e.title))return a("div",{class:[t("title"),e.titleClass],style:e.titleStyle},[l.title?l.title():a("span",null,[e.title]),v()])},m=()=>{const n=l.value||l.default;if(n||u(e.value))return a("div",{class:[t("value"),e.valueClass]},[n?n():a("span",null,[e.value])])},w=()=>{if(l.icon)return l.icon();if(e.icon)return a(b,{name:e.icon,class:t("left-icon"),classPrefix:e.iconPrefix},null)},C=()=>{if(l["right-icon"])return l["right-icon"]();if(e.isLink){const n=e.arrowDirection?`arrow-${e.arrowDirection}`:"arrow";return a(b,{name:n,class:t("right-icon")},null)}};return()=>{var n,i;const{size:r,center:P,border:g,isLink:k,required:x}=e,c=(n=e.clickable)!=null?n:k,d={center:P,required:x,clickable:c,borderless:!g};return r&&(d[r]=!!r),a("div",{class:t(d),role:c?"button":void 0,tabindex:c?0:void 0,onClick:f},[w(),h(),m(),C(),(i=l.extra)==null?void 0:i.call(l)])}}});const T=V(z);export{T as C,_ as c};