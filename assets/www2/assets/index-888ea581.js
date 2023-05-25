import{c as y,f as A,ad as B,t as g,Y as H,S as M,ae as D,d,b as e,p as T,Z as V,af as L,I as O,ag as U,ah as N,ac as E,w as F,D as _,v as p,M as s,$ as K,r as J,l as Y,a9 as Z,x as c,J as I,A as r,ai as j}from"./index-2f00049f.js";import{C as q}from"./index-d01ffe12.js";import{D as G}from"./index-753ee8e2.js";import{I as Q}from"./index-9d11b80c.js";import{I as f}from"./Icon-293a71c6.js";import{_ as R}from"./_plugin-vue_export-helper-c27b6911.js";const[W,l]=y("action-sheet"),X=A({},B,{title:String,round:g,actions:H(),closeIcon:M("cross"),closeable:g,cancelText:String,description:String,closeOnPopstate:g,closeOnClickAction:Boolean,safeAreaInsetBottom:g}),ee=[...D,"round","closeOnPopstate","safeAreaInsetBottom"];var te=d({name:W,props:X,emits:["select","cancel","update:show"],setup(o,{slots:n,emit:a}){const h=t=>a("update:show",t),m=()=>{h(!1),a("cancel")},w=()=>{if(o.title)return e("div",{class:l("header")},[o.title,o.closeable&&e(O,{name:o.closeIcon,class:[l("close"),U],onClick:m},null)])},k=()=>{if(n.cancel||o.cancelText)return[e("div",{class:l("gap")},null),e("button",{type:"button",class:l("cancel"),onClick:m},[n.cancel?n.cancel():o.cancelText])]},C=(t,u)=>t.loading?e(N,{class:l("loading-icon")},null):n.action?n.action({action:t,index:u}):[e("span",{class:l("name")},[t.name]),t.subname&&e("div",{class:l("subname")},[t.subname])],b=(t,u)=>{const{color:$,loading:i,callback:v,disabled:x,className:S}=t,P=()=>{x||i||(v&&v(t),o.closeOnClickAction&&h(!1),E(()=>a("select",t,u)))};return e("button",{type:"button",style:{color:$},class:[l("item",{loading:i,disabled:x}),S],onClick:P},[C(t,u)])},z=()=>{if(o.description||n.description){const t=n.description?n.description():o.description;return e("div",{class:l("description")},[t])}};return()=>e(L,T({class:l(),position:"bottom","onUpdate:show":h},V(o,ee)),{default:()=>{var t;return[w(),z(),e("div",{class:l("content")},[o.actions.map(b),(t=n.default)==null?void 0:t.call(n)]),k()]}})}});const ne=F(te),oe={xmlns:"http://www.w3.org/2000/svg","xmlns:xlink":"http://www.w3.org/1999/xlink",viewBox:"0 0 1024 1024"},ce=s("path",{d:"M373 411c-28.5 0-51.7 23.3-51.7 52s23.2 52 51.7 52s51.7-23.3 51.7-52s-23.2-52-51.7-52zm555-251H96c-17.7 0-32 14.3-32 32v640c0 17.7 14.3 32 32 32h832c17.7 0 32-14.3 32-32V192c0-17.7-14.3-32-32-32zM608 420c0-4.4 1-8 2.3-8h123.4c1.3 0 2.3 3.6 2.3 8v48c0 4.4-1 8-2.3 8H610.3c-1.3 0-2.3-3.6-2.3-8v-48zm-86 253h-43.9c-4.2 0-7.6-3.3-7.9-7.5c-3.8-50.5-46-90.5-97.2-90.5s-93.4 40-97.2 90.5c-.3 4.2-3.7 7.5-7.9 7.5H224a8 8 0 0 1-8-8.4c2.8-53.3 32-99.7 74.6-126.1a111.8 111.8 0 0 1-29.1-75.5c0-61.9 49.9-112 111.4-112s111.4 50.1 111.4 112c0 29.1-11 55.5-29.1 75.5c42.7 26.5 71.8 72.8 74.6 126.1c.4 4.6-3.2 8.4-7.8 8.4zm278.9-53H615.1c-3.9 0-7.1-3.6-7.1-8v-48c0-4.4 3.2-8 7.1-8h185.7c3.9 0 7.1 3.6 7.1 8v48h.1c0 4.4-3.2 8-7.1 8z",fill:"currentColor"},null,-1),se=[ce],ae=d({name:"IdcardFilled",render:function(n,a){return _(),p("svg",oe,se)}});const le={xmlns:"http://www.w3.org/2000/svg","xmlns:xlink":"http://www.w3.org/1999/xlink",viewBox:"0 0 512 512"},re=s("path",{d:"M441 336.2l-.06-.05c-9.93-9.18-22.78-11.34-32.16-12.92l-.69-.12c-9.05-1.49-10.48-2.5-14.58-6.17c-2.44-2.17-5.35-5.65-5.35-9.94s2.91-7.77 5.34-9.94l30.28-26.87c25.92-22.91 40.2-53.66 40.2-86.59s-14.25-63.68-40.2-86.6c-35.89-31.59-85-49-138.37-49C223.72 48 162 71.37 116 112.11c-43.87 38.77-68 90.71-68 146.24s24.16 107.47 68 146.23c21.75 19.24 47.49 34.18 76.52 44.42a266.17 266.17 0 0 0 86.87 15h1.81c61 0 119.09-20.57 159.39-56.4c9.7-8.56 15.15-20.83 15.34-34.56c.21-14.17-5.37-27.95-14.93-36.84zM112 208a32 32 0 1 1 32 32a32 32 0 0 1-32-32zm40 135a32 32 0 1 1 32-32a32 32 0 0 1-32 32zm40-199a32 32 0 1 1 32 32a32 32 0 0 1-32-32zm64 271a48 48 0 1 1 48-48a48 48 0 0 1-48 48zm72-239a32 32 0 1 1 32-32a32 32 0 0 1-32 32z",fill:"currentColor"},null,-1),ie=[re],de=d({name:"ColorPalette",render:function(n,a){return _(),p("svg",le,ie)}}),ue={xmlns:"http://www.w3.org/2000/svg","xmlns:xlink":"http://www.w3.org/1999/xlink",viewBox:"0 0 512 512"},_e=s("path",{d:"M428 224H288a48 48 0 0 1-48-48V36a4 4 0 0 0-4-4h-92a64 64 0 0 0-64 64v320a64 64 0 0 0 64 64h224a64 64 0 0 0 64-64V228a4 4 0 0 0-4-4zm-92 160H176a16 16 0 0 1 0-32h160a16 16 0 0 1 0 32zm0-80H176a16 16 0 0 1 0-32h160a16 16 0 0 1 0 32z",fill:"currentColor"},null,-1),pe=s("path",{d:"M419.22 188.59L275.41 44.78a2 2 0 0 0-3.41 1.41V176a16 16 0 0 0 16 16h129.81a2 2 0 0 0 1.41-3.41z",fill:"currentColor"},null,-1),he=[_e,pe],me=d({name:"DocumentText",render:function(n,a){return _(),p("svg",ue,he)}}),xe={xmlns:"http://www.w3.org/2000/svg","xmlns:xlink":"http://www.w3.org/1999/xlink",viewBox:"0 0 512 512"},fe=s("path",{d:"M160 256a16 16 0 0 1 16-16h144V136c0-32-33.79-56-64-56H104a56.06 56.06 0 0 0-56 56v240a56.06 56.06 0 0 0 56 56h160a56.06 56.06 0 0 0 56-56V272H176a16 16 0 0 1-16-16z",fill:"currentColor"},null,-1),we=s("path",{d:"M459.31 244.69l-80-80a16 16 0 0 0-22.62 22.62L409.37 240H320v32h89.37l-52.68 52.69a16 16 0 1 0 22.62 22.62l80-80a16 16 0 0 0 0-22.62z",fill:"currentColor"},null,-1),ve=[fe,we],ge=d({name:"LogOut",render:function(n,a){return _(),p("svg",xe,ve)}}),ke={xmlns:"http://www.w3.org/2000/svg","xmlns:xlink":"http://www.w3.org/1999/xlink",viewBox:"0 0 512 512"},Ce=s("path",{d:"M332.64 64.58C313.18 43.57 286 32 256 32c-30.16 0-57.43 11.5-76.8 32.38c-19.58 21.11-29.12 49.8-26.88 80.78C156.76 206.28 203.27 256 256 256s99.16-49.71 103.67-110.82c2.27-30.7-7.33-59.33-27.03-80.6z",fill:"currentColor"},null,-1),be=s("path",{d:"M432 480H80a31 31 0 0 1-24.2-11.13c-6.5-7.77-9.12-18.38-7.18-29.11C57.06 392.94 83.4 353.61 124.8 326c36.78-24.51 83.37-38 131.2-38s94.42 13.5 131.2 38c41.4 27.6 67.74 66.93 76.18 113.75c1.94 10.73-.68 21.34-7.18 29.11A31 31 0 0 1 432 480z",fill:"currentColor"},null,-1),$e=[Ce,be],ze=d({name:"Person",render:function(n,a){return _(),p("svg",ke,$e)}}),Ie={class:"my-card shadow-xl relative -top-150px mx-40px rounded-2xl flex flex-col items-center pb-20px"},Se={class:"flex flex-col items-center mt-90px"},Pe={class:"font-black text-40px mb-20px"},ye={class:"text-30px px-36px"},Ae=d({__name:"index",setup(o){const n=K(),a=J(!1),{nickname:h,avatar:m,cover:w,sign:k}=n.getUserInfo,C=[{name:"退出登录",color:"#ee0a24",callback:()=>{n.Logout(),j("退出成功")}}],b=Y(()=>({backgroundImage:`url(${w||m})`}));return(z,t)=>{const u=Q,$=G,i=q,v=ne;return _(),p("div",null,[s("div",{style:Z(c(b)),class:"my-bg h-550px -z-19"},null,4),s("div",Ie,[e(u,{class:"border-4 !absolute -top-90px h-170px w-170px",round:"",fit:"cover",src:c(m)},null,8,["src"]),s("div",Se,[s("p",Pe,I(c(h)),1),s("p",ye,I(c(k)),1)]),e($,{class:"w-full"}),e(i,{border:!1,title:"个人信息","is-link":"",to:"/editUserInfo"},{icon:r(()=>[e(c(f),null,{default:r(()=>[e(c(ae))]),_:1})]),_:1}),e(i,{border:!1,title:"账号与安全","is-link":"",to:"/accountSetting"},{icon:r(()=>[e(c(f),null,{default:r(()=>[e(c(ze))]),_:1})]),_:1}),e(i,{border:!1,title:"主题设置","is-link":"",to:"/themeSetting"},{icon:r(()=>[e(c(f),null,{default:r(()=>[e(c(de))]),_:1})]),_:1}),e(i,{border:!1,title:"隐私政策","is-link":""},{icon:r(()=>[e(c(f),null,{default:r(()=>[e(c(me))]),_:1})]),_:1}),e(i,{border:!1,title:"退出登录","is-link":"",onClick:t[0]||(t[0]=x=>a.value=!0)},{icon:r(()=>[e(c(f),null,{default:r(()=>[e(c(ge))]),_:1})]),_:1}),e(v,{teleport:"body",show:a.value,"onUpdate:show":t[1]||(t[1]=x=>a.value=x),actions:C,"cancel-text":"取消",description:"确认退出登录吗","close-on-click-action":""},null,8,["show"])])])}}});const Le=R(Ae,[["__scopeId","data-v-561ab2e7"]]);export{Le as default};