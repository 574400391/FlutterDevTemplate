import{u as c,a as u,o as l,b as r,c as d,d as o}from"./index-84de147d.js";const i=o("div",null,[o("input",{value:"请输入用户名"}),o("input",{value:"请输入密码"})],-1),m={__name:"index",setup(_){const n=c(),s=u();l(()=>{const{id:e,data:t}=n.params;e&&console.log(e),t&&console.log(t)});const a=()=>{s.go(-1)};return(e,t)=>(r(),d("div",null,[i,o("button",{onClick:a},"登录")]))}};export{m as default};