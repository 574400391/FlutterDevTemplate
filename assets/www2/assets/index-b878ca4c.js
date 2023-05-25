import{aO as le,aP as oe,q as se,ax as ce,at as ue,j as de,c as fe,n as E,S,m as ge,f as me,R as he,d as be,a0 as ye,r as N,k as ve,l as I,U as Ie,W as Ce,aQ as Se,V as xe,a1 as Ve,ac as C,b as o,aH as ke,av as w,aR as we,I as T,aS as Te,as as _,ak as F,p as Me,H as Ee,aT as Pe,w as Re}from"./index-2f00049f.js";import{c as Le,C as Ae}from"./index-d01ffe12.js";function Be(e){return Array.isArray(e)?!e.length:e===0?!1:!e}function Oe(e,n){return!(n.required&&Be(e)||n.pattern&&!n.pattern.test(String(e)))}function Ne(e,n){return new Promise(l=>{const s=n.validator(e,n);if(ce(s)){s.then(l);return}l(s)})}function W(e,n){const{message:l}=n;return ue(l)?l(e,n):l||""}function _e({target:e}){e.composing=!0}function z({target:e}){e.composing&&(e.composing=!1,e.dispatchEvent(new Event("input")))}function Fe(e,n){const l=le();e.style.height="auto";let s=e.scrollHeight;if(se(n)){const{maxHeight:i,minHeight:g}=n;i!==void 0&&(s=Math.min(s,i)),g!==void 0&&(s=Math.max(s,g))}s&&(e.style.height=`${s}px`,oe(l))}function We(e){return e==="number"?{type:"text",inputmode:"decimal"}:e==="digit"?{type:"tel",inputmode:"numeric"}:{type:e}}function M(e){return[...e].length}function ze(e,n){return[...e].slice(0,n).join("")}let De=0;function $e(){const e=de(),{name:n="unknown"}=(e==null?void 0:e.type)||{};return`${n}-${++De}`}const[je,u]=fe("field"),He={id:String,name:String,leftIcon:String,rightIcon:String,autofocus:Boolean,clearable:Boolean,maxlength:E,formatter:Function,clearIcon:S("clear"),modelValue:ge(""),inputAlign:String,placeholder:String,autocomplete:String,errorMessage:String,enterkeyhint:String,clearTrigger:S("focus"),formatTrigger:S("onChange"),error:{type:Boolean,default:null},disabled:{type:Boolean,default:null},readonly:{type:Boolean,default:null}},qe=me({},Le,He,{rows:E,type:S("text"),rules:Array,autosize:[Boolean,Object],labelWidth:E,labelClass:he,labelAlign:String,showWordLimit:Boolean,errorMessageAlign:String,colon:{type:Boolean,default:null}});var Ke=be({name:je,props:qe,emits:["blur","focus","clear","keypress","clickInput","endValidate","startValidate","clickLeftIcon","clickRightIcon","update:modelValue"],setup(e,{emit:n,slots:l}){const s=$e(),i=ye({status:"unvalidated",focused:!1,validateMessage:""}),g=N(),x=N(),{parent:d}=ve(ke),h=()=>{var t;return String((t=e.modelValue)!=null?t:"")},f=t=>{if(w(e[t]))return e[t];if(d&&w(d.props[t]))return d.props[t]},D=I(()=>{const t=f("readonly");if(e.clearable&&!t){const a=h()!=="",r=e.clearTrigger==="always"||e.clearTrigger==="focus"&&i.focused;return a&&r}return!1}),P=I(()=>x.value&&l.input?x.value():e.modelValue),$=t=>t.reduce((a,r)=>a.then(()=>{if(i.status==="failed")return;let{value:c}=P;if(r.formatter&&(c=r.formatter(c,r)),!Oe(c,r)){i.status="failed",i.validateMessage=W(c,r);return}if(r.validator)return Ne(c,r).then(m=>{m&&typeof m=="string"?(i.status="failed",i.validateMessage=m):m===!1&&(i.status="failed",i.validateMessage=W(c,r))})}),Promise.resolve()),b=()=>{i.status="unvalidated",i.validateMessage=""},R=()=>n("endValidate",{status:i.status}),L=(t=e.rules)=>new Promise(a=>{b(),t?(n("startValidate"),$(t).then(()=>{i.status==="failed"?(a({name:e.name,message:i.validateMessage}),R()):(i.status="passed",a(),R())})):a()}),V=t=>{if(d&&e.rules){const{validateTrigger:a}=d.props,r=_(a).includes(t),c=e.rules.filter(m=>m.trigger?_(m.trigger).includes(t):r);c.length&&L(c)}},j=t=>{const{maxlength:a}=e;if(w(a)&&M(t)>a){const r=h();return r&&M(r)===+a?r:ze(t,+a)}return t},y=(t,a="onChange")=>{if(t=j(t),e.type==="number"||e.type==="digit"){const r=e.type==="number";t=we(t,r,r)}e.formatter&&a===e.formatTrigger&&(t=e.formatter(t)),g.value&&g.value.value!==t&&(g.value.value=t),t!==e.modelValue&&n("update:modelValue",t)},H=t=>{t.target.composing||y(t.target.value)},k=()=>{var t;return(t=g.value)==null?void 0:t.blur()},q=()=>{var t;return(t=g.value)==null?void 0:t.focus()},v=()=>{const t=g.value;e.type==="textarea"&&e.autosize&&t&&Fe(t,e.autosize)},K=t=>{i.focused=!0,n("focus",t),C(v),f("readonly")&&k()},U=t=>{f("readonly")||(i.focused=!1,y(h(),"onBlur"),n("blur",t),V("onBlur"),C(v),Pe())},A=t=>n("clickInput",t),Y=t=>n("clickLeftIcon",t),J=t=>n("clickRightIcon",t),Q=t=>{F(t),n("update:modelValue",""),n("clear",t)},B=I(()=>{if(typeof e.error=="boolean")return e.error;if(d&&d.props.showError&&i.status==="failed")return!0}),G=I(()=>{const t=f("labelWidth");if(t)return{width:Ie(t)}}),X=t=>{t.keyCode===13&&(!(d&&d.props.submitOnEnter)&&e.type!=="textarea"&&F(t),e.type==="search"&&k()),n("keypress",t)},O=()=>e.id||`${s}-input`,Z=()=>i.status,p=()=>{const t=u("control",[f("inputAlign"),{error:B.value,custom:!!l.input,"min-height":e.type==="textarea"&&!e.autosize}]);if(l.input)return o("div",{class:t,onClick:A},[l.input()]);const a={id:O(),ref:g,name:e.name,rows:e.rows!==void 0?+e.rows:void 0,class:t,disabled:f("disabled"),readonly:f("readonly"),autofocus:e.autofocus,placeholder:e.placeholder,autocomplete:e.autocomplete,enterkeyhint:e.enterkeyhint,"aria-labelledby":e.label?`${s}-label`:void 0,onBlur:U,onFocus:K,onInput:H,onClick:A,onChange:z,onKeypress:X,onCompositionend:z,onCompositionstart:_e};return e.type==="textarea"?o("textarea",a,null):o("input",Me(We(e.type),a),null)},ee=()=>{const t=l["left-icon"];if(e.leftIcon||t)return o("div",{class:u("left-icon"),onClick:Y},[t?t():o(T,{name:e.leftIcon,classPrefix:e.iconPrefix},null)])},te=()=>{const t=l["right-icon"];if(e.rightIcon||t)return o("div",{class:u("right-icon"),onClick:J},[t?t():o(T,{name:e.rightIcon,classPrefix:e.iconPrefix},null)])},ne=()=>{if(e.showWordLimit&&e.maxlength){const t=M(h());return o("div",{class:u("word-limit")},[o("span",{class:u("word-num")},[t]),Ee("/"),e.maxlength])}},ae=()=>{if(d&&d.props.showErrorMessage===!1)return;const t=e.errorMessage||i.validateMessage;if(t){const a=l["error-message"],r=f("errorMessageAlign");return o("div",{class:u("error-message",r)},[a?a({message:t}):t])}},re=()=>{const t=f("colon")?":":"";if(l.label)return[l.label(),t];if(e.label)return o("label",{id:`${s}-label`,for:O()},[e.label+t])},ie=()=>[o("div",{class:u("body")},[p(),D.value&&o(T,{name:e.clearIcon,class:u("clear"),onTouchstart:Q},null),te(),l.button&&o("div",{class:u("button")},[l.button()])]),ne(),ae()];return Ce({blur:k,focus:q,validate:L,formValue:P,resetValidation:b,getValidationStatus:Z}),Se(Te,{customValue:x,resetValidation:b,validateWithTrigger:V}),xe(()=>e.modelValue,()=>{y(h()),b(),V("onChange"),C(v)}),Ve(()=>{y(h(),e.formatTrigger),C(v)}),()=>{const t=f("disabled"),a=f("labelAlign"),r=re(),c=ee();return o(Ae,{size:e.size,icon:e.leftIcon,class:u({error:B.value,disabled:t,[`label-${a}`]:a}),center:e.center,border:e.border,isLink:e.isLink,clickable:e.clickable,titleStyle:G.value,valueClass:u("value"),titleClass:[u("label",[a,{required:e.required}]),e.labelClass],arrowDirection:e.arrowDirection},{icon:c?()=>c:null,title:r?()=>r:null,value:ie,extra:l.extra})}}});const Je=Re(Ke);export{Je as F};
