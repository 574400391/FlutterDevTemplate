var _=(c,l,t)=>new Promise((s,a)=>{var i=e=>{try{o(t.next(e))}catch(r){a(r)}},n=e=>{try{o(t.throw(e))}catch(r){a(r)}},o=e=>e.done?s(e.value):Promise.resolve(e.value).then(i,n);o((t=t.apply(c,l)).next())});import{d,$ as u,r as g,a0 as v,a1 as x,v as h,b as m,A as f,D as y,M as V,ai as S}from"./index-2f00049f.js";import"./index-d01ffe12.js";import{F as k}from"./index-b878ca4c.js";import{_ as w}from"./NavBar.vue_vue_type_script_setup_true_lang-ec43c9a4.js";import{F as E}from"./index-34f9a8fe.js";import{_ as F}from"./_plugin-vue_export-helper-c27b6911.js";import"./index-7b17285f.js";import"./Icon-293a71c6.js";const N=d({__name:"EditSign",setup(c){const l=u(),{sign:t}=l.getUserInfo,s=g(),a=v({sign:""});function i(){var n;(n=s.value)==null||n.validate().then(()=>_(this,null,function*(){var o;try{const e=(o=s.value)==null?void 0:o.getValues();S({message:`当前表单值：${JSON.stringify(e)}`})}finally{}})).catch(()=>{console.error("验证失败")})}return x(()=>{a.sign=t!=null?t:""}),(n,o)=>{const e=k,r=E;return y(),h("div",null,[m(w,null,{right:f(()=>[V("span",{class:"text-32px",onClick:i},"保存")]),_:1}),m(r,{ref_key:"formRef",ref:s},{default:f(()=>[m(e,{class:"mt-20px",name:"sign",clearable:"",modelValue:a.sign,"onUpdate:modelValue":o[0]||(o[0]=p=>a.sign=p),rows:"4",autosize:"",label:"签名",type:"textarea",maxlength:"70",placeholder:"介绍一下你自己","show-word-limit":""},null,8,["modelValue"])]),_:1},512)])}}});const A=F(N,[["__scopeId","data-v-16023832"]]);export{A as default};
