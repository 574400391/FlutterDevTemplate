var y=Object.defineProperty,b=Object.defineProperties;var k=Object.getOwnPropertyDescriptors;var c=Object.getOwnPropertySymbols;var v=Object.prototype.hasOwnProperty,V=Object.prototype.propertyIsEnumerable;var r=(s,t,e)=>t in s?y(s,t,{enumerable:!0,configurable:!0,writable:!0,value:e}):s[t]=e,d=(s,t)=>{for(var e in t||(t={}))v.call(t,e)&&r(s,e,t[e]);if(c)for(var e of c(t))V.call(t,e)&&r(s,e,t[e]);return s},_=(s,t)=>b(s,k(t));import{d as x,a7 as B,_ as D,l as C,v as p,M as a,b as m,J as o,x as i,A as u,D as l,F as T,G as j,y as A}from"./index-2f00049f.js";import{S as E,a as F}from"./index-70f70456.js";import{S as G}from"./SvgIcon-f3b4b071.js";import"./_plugin-vue_export-helper-c27b6911.js";const I={class:"flex flex-col justify-center items-center h-screen p-60px"},M={class:"wel-box flex flex-col items-center justify-between w-full"},N={class:"text-darkBlue dark:text-garyWhite text-2xl font-black mt-12 mb-4 text-center"},z={class:"w-full mt-4 mb-6"},H={class:"text-lg"},J={class:"text-sm"},L=x({name:"DashboardPage"}),U=x(_(d({},L),{setup(s){const t=B(),e=D(),{title:f}=e,g=C(()=>[{title:"💡 最新技术栈",details:"基于Vue3、Vant4、Vite、TypeScript、windiCss等最新技术栈开发"},{title:"⚡️ 轻量快速的热重载",details:"无论应用程序大小如何，都始终极快的模块热重载（HMR）"},{title:"🔩 主题配置",details:"具备主题配置及黑暗主题适配，且持久化保存"},{title:"🛠️ 丰富的 Vite 插件",details:"集成大部分 Vite 插件，无需繁琐配置，开箱即用"},{title:"📊 内置 useEcharts hooks",details:"满足大部分图表展示，只需要写你的 options"},{title:"🥳 完善的登录系统、路由、Axios配置",details:"所有架构已搭建完毕，你可以直接开发你的业务需求"}]);return(P,R)=>{const h=F,S=E;return l(),p("div",I,[a("div",M,[m(G,{class:"logo",size:130,name:"logo"}),a("div",N,"欢迎来到 "+o(i(f)),1),a("div",z,[m(S,{class:"h-30",autoplay:3e3,"indicator-color":i(t).appTheme},{default:u(()=>[(l(!0),p(T,null,j(i(g),(n,w)=>(l(),A(h,{class:"text-gray-700 dark:text-gray-400 leading-relaxed text-center",key:w},{default:u(()=>[a("p",H,o(n.title),1),a("p",J,o(n.details),1)]),_:2},1024))),128))]),_:1},8,["indicator-color"])])])])}}}));export{U as default};