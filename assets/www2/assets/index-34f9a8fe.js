import{c as V,d as y,u as A,W as T,b as C,n as M,t as g,ak as N,aH as _,w as k}from"./index-2f00049f.js";const[x,I]=V("form"),O={colon:Boolean,disabled:Boolean,readonly:Boolean,showError:Boolean,labelWidth:M,labelAlign:String,inputAlign:String,scrollToError:Boolean,validateFirst:Boolean,submitOnEnter:g,showErrorMessage:g,errorMessageAlign:String,validateTrigger:{type:[String,Array],default:"onBlur"}};var W=y({name:x,props:O,emits:["submit","failed"],setup(i,{emit:r,slots:u}){const{children:s,linkChildren:v}=A(_),o=e=>e?s.filter(t=>e.includes(t.name)):s,p=e=>new Promise((t,n)=>{const l=[];o(e).reduce((E,F)=>E.then(()=>{if(!l.length)return F.validate().then(h=>{h&&l.push(h)})}),Promise.resolve()).then(()=>{l.length?n(l):t()})}),b=e=>new Promise((t,n)=>{const l=o(e);Promise.all(l.map(a=>a.validate())).then(a=>{a=a.filter(Boolean),a.length?n(a):t()})}),B=e=>{const t=s.find(n=>n.name===e);return t?new Promise((n,l)=>{t.validate().then(a=>{a?l(a):n()})}):Promise.reject()},c=e=>typeof e=="string"?B(e):i.validateFirst?p(e):b(e),P=e=>{typeof e=="string"&&(e=[e]),o(e).forEach(n=>{n.resetValidation()})},S=()=>s.reduce((e,t)=>(e[t.name]=t.getValidationStatus(),e),{}),d=(e,t)=>{s.some(n=>n.name===e?(n.$el.scrollIntoView(t),!0):!1)},f=()=>s.reduce((e,t)=>(e[t.name]=t.formValue.value,e),{}),m=()=>{const e=f();c().then(()=>r("submit",e)).catch(t=>{r("failed",{values:e,errors:t}),i.scrollToError&&t[0].name&&d(t[0].name)})},w=e=>{N(e),m()};return v({props:i}),T({submit:m,validate:c,getValues:f,scrollToField:d,resetValidation:P,getValidationStatus:S}),()=>{var e;return C("form",{class:I(),onSubmit:w},[(e=u.default)==null?void 0:e.call(u)])}}});const q=k(W);export{q as F};