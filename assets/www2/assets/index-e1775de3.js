import{av as le,f as W,al as A,c as G,d as J,n as B,T as M,Y as F,r as N,aj as oe,k as ie,W as Q,aK as ue,b as m,ak as X,m as _,t as ce,S as se,u as re,l as x,aL as de,V as p,aM as U,ah as me,ag as K,aN as ve,w as fe}from"./index-2f00049f.js";const Z=e=>e.find(l=>!l.disabled)||e[0];function he(e,l){const n=e[0];if(n){if(Array.isArray(n))return"multiple";if(l.children in n)return"cascade"}return"default"}function Y(e,l){l=A(l,0,e.length);for(let n=l;n<e.length;n++)if(!e[n].disabled)return n;for(let n=l-1;n>=0;n--)if(!e[n].disabled)return n;return 0}const L=(e,l,n)=>l!==void 0&&!!e.find(o=>o[n.value]===l);function R(e,l,n){const o=e.findIndex(v=>v[n.value]===l),r=Y(e,o);return e[r]}function ge(e,l,n){const o=[];let r={[l.children]:e},v=0;for(;r&&r[l.children];){const c=r[l.children],d=n.value[v];if(r=le(d)?R(c,d,l):void 0,!r&&c.length){const T=Z(c)[l.value];r=R(c,T,l)}v++,o.push(c)}return o}function be(e){const{transform:l}=window.getComputedStyle(e),n=l.slice(7,l.length-1).split(", ")[5];return Number(n)}function Te(e){return W({text:"text",value:"value",children:"children"},e)}const j=200,q=300,Oe=15,[ee,$]=G("picker-column"),te=Symbol(ee);var ye=J({name:ee,props:{value:B,fields:M(Object),options:F(),readonly:Boolean,allowHtml:Boolean,optionHeight:M(Number),swipeDuration:M(B),visibleOptionNum:M(B)},emits:["change"],setup(e,{emit:l,slots:n}){let o,r,v,c,d;const T=N(),s=N(0),f=N(0),h=oe(),O=()=>e.options.length,C=()=>e.optionHeight*(+e.visibleOptionNum-1)/2,y=i=>{const t=Y(e.options,i),a=-t*e.optionHeight,u=()=>{const b=e.options[t][e.fields.value];b!==e.value&&l("change",b)};o&&a!==s.value?d=u:u(),s.value=a},D=i=>{o||e.readonly||(d=null,f.value=j,y(i))},E=i=>A(Math.round(-i/e.optionHeight),0,O()-1),P=(i,t)=>{const a=Math.abs(i/t);i=s.value+a/.003*(i<0?-1:1);const u=E(i);f.value=+e.swipeDuration,y(u)},S=()=>{o=!1,f.value=0,d&&(d(),d=null)},k=i=>{if(!e.readonly){if(h.start(i),o){const t=be(T.value);s.value=Math.min(0,t-C())}f.value=0,r=s.value,v=Date.now(),c=r,d=null}},V=i=>{if(e.readonly)return;h.move(i),h.isVertical()&&(o=!0,X(i,!0)),s.value=A(r+h.deltaY.value,-(O()*e.optionHeight),e.optionHeight);const t=Date.now();t-v>q&&(v=t,c=s.value)},H=()=>{if(e.readonly)return;const i=s.value-c,t=Date.now()-v;if(t<q&&Math.abs(i)>Oe){P(i,t);return}const u=E(s.value);f.value=j,y(u),setTimeout(()=>{o=!1},0)},I=()=>{const i={height:`${e.optionHeight}px`};return e.options.map((t,a)=>{const u=t[e.fields.text],{disabled:b}=t,w=t[e.fields.value],ne={role:"button",style:i,tabindex:b?-1:0,class:[$("item",{disabled:b,selected:w===e.value}),t.className],onClick:()=>D(a)},ae={class:"van-ellipsis",[e.allowHtml?"innerHTML":"textContent"]:u};return m("li",ne,[n.option?n.option(t):m("div",ae,null)])})};return ie(te),Q({stopMomentum:S}),ue(()=>{const i=e.options.findIndex(u=>u[e.fields.value]===e.value),a=-Y(e.options,i)*e.optionHeight;s.value=a}),()=>m("div",{class:$(),onTouchstart:k,onTouchmove:V,onTouchend:H,onTouchcancel:H},[m("ul",{ref:T,style:{transform:`translate3d(0, ${s.value+C()}px, 0)`,transitionDuration:`${f.value}ms`,transitionProperty:f.value?"all":"none"},class:$("wrapper"),onTransitionend:S},[I()])])}});const[xe,g,z]=G("picker"),we={title:String,loading:Boolean,readonly:Boolean,allowHtml:Boolean,optionHeight:_(44),showToolbar:ce,swipeDuration:_(1e3),visibleOptionNum:_(6),cancelButtonText:String,confirmButtonText:String},Ce=W({},we,{columns:F(),modelValue:F(),toolbarPosition:se("top"),columnsFieldNames:Object});var Ee=J({name:xe,props:Ce,emits:["confirm","cancel","change","update:modelValue"],setup(e,{emit:l,slots:n}){const o=N(e.modelValue),{children:r,linkChildren:v}=re(te);v();const c=x(()=>Te(e.columnsFieldNames)),d=x(()=>de(e.optionHeight)),T=x(()=>he(e.columns,c.value)),s=x(()=>{const{columns:t}=e;switch(T.value){case"multiple":return t;case"cascade":return ge(t,c.value,o);default:return[t]}}),f=x(()=>s.value.some(t=>t.length)),h=x(()=>s.value.map((t,a)=>R(t,o.value[a],c.value))),O=(t,a)=>{if(o.value[t]!==a){const u=o.value.slice(0);u[t]=a,o.value=u}},C=(t,a)=>{O(a,t),T.value==="cascade"&&o.value.forEach((u,b)=>{const w=s.value[b];L(w,u,c.value)||O(b,w.length?w[0][c.value.value]:void 0)}),l("change",{columnIndex:a,selectedValues:o.value,selectedOptions:h.value})},y=()=>{r.forEach(t=>t.stopMomentum()),l("confirm",{selectedValues:o.value,selectedOptions:h.value})},D=()=>l("cancel",{selectedValues:o.value,selectedOptions:h.value}),E=()=>{if(n.title)return n.title();if(e.title)return m("div",{class:[g("title"),"van-ellipsis"]},[e.title])},P=()=>{const t=e.cancelButtonText||z("cancel");return m("button",{type:"button",class:[g("cancel"),K],onClick:D},[n.cancel?n.cancel():t])},S=()=>{const t=e.confirmButtonText||z("confirm");return m("button",{type:"button",class:[g("confirm"),K],onClick:y},[n.confirm?n.confirm():t])},k=()=>{if(e.showToolbar)return m("div",{class:g("toolbar")},[n.toolbar?n.toolbar():[P(),E(),S()]])},V=()=>s.value.map((t,a)=>m(ye,{value:o.value[a],fields:c.value,options:t,readonly:e.readonly,allowHtml:e.allowHtml,optionHeight:d.value,swipeDuration:e.swipeDuration,visibleOptionNum:e.visibleOptionNum,onChange:u=>C(u,a)},{option:n.option})),H=t=>{if(f.value){const a={height:`${d.value}px`},u={backgroundSize:`100% ${(t-d.value)/2}px`};return[m("div",{class:g("mask"),style:u},null),m("div",{class:[ve,g("frame")],style:a},null)]}},I=()=>{const t=d.value*+e.visibleOptionNum,a={height:`${t}px`};return m("div",{class:g("columns"),style:a,onTouchmove:X},[V(),H(t)])};return p(s,t=>{t.forEach((a,u)=>{a.length&&!L(a,o.value[u],c.value)&&O(u,Z(a)[c.value.value])})},{immediate:!0}),p(()=>e.modelValue,t=>{U(t,o.value)||(o.value=t)},{deep:!0}),p(o,t=>{U(t,e.modelValue)||l("update:modelValue",t)},{immediate:!0}),Q({confirm:y,getSelectedOptions:()=>h.value}),()=>{var t,a;return m("div",{class:g()},[e.toolbarPosition==="top"?k():null,e.loading?m(me,{class:g("loading")},null):null,(t=n["columns-top"])==null?void 0:t.call(n),I(),(a=n["columns-bottom"])==null?void 0:a.call(n),e.toolbarPosition==="bottom"?k():null])}}});const ke=fe(Ee);export{ke as P};
