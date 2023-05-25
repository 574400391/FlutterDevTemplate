import{_ as H,a as J,z as K,j as O,r as m,s as Q,A as W,o as X,f as n,b as Z,c as ee,g as a,d as _,w as s,h as f,F as le,y as V}from"./index-84de147d.js";const ae={class:"page_body"},oe={class:"button-group"},te={__name:"index",props:{disabled:Boolean},setup(h){const C=h,w=J(),{disabled:x}=K(C),o=O({name:"",password:"",gender:"",birth:"2023-4-27",place:"",age:3,description:2,resume:""}),p=m(null);Q(()=>o,(e,l)=>{console.log("formData有更新：",e,l)}),W(()=>{const e=o.name;console.log("watchEffect x1: ",e),console.log("watchEffect 回调")});const k=(e,l)=>{console.log(e,l)},d=m(!1),y=e=>{console.log("change: ",e)},U=e=>{console.log("pick: ",e)},B=()=>{console.log("cancel"),d.value=!1},R=e=>{console.log("confirm: ",e),o.birth=e,d.value=!1},D={areaList:[{label:"北京市",value:"110000",children:[{value:"110100",label:"北京市",children:[{value:"110101",label:"东城区"},{value:"110102",label:"西城区"},{value:"110105",label:"朝阳区"},{value:"110106",label:"丰台区"},{value:"110107",label:"石景山区"},{value:"110108",label:"海淀区"},{value:"110109",label:"门头沟区"},{value:"110111",label:"房山区"},{value:"110112",label:"通州区"},{value:"110113",label:"顺义区"},{value:"110114",label:"昌平区"},{value:"110115",label:"大兴区"},{value:"110116",label:"怀柔区"},{value:"110117",label:"平谷区"},{value:"110118",label:"密云区"},{value:"110119",label:"延庆区"}]}]},{label:"天津市",value:"120000",children:[{value:"120100",label:"天津市",children:[{value:"120101",label:"和平区"},{value:"120102",label:"河东区"},{value:"120103",label:"河西区"},{value:"120104",label:"南开区"},{value:"120105",label:"河北区"},{value:"120106",label:"红桥区"},{value:"120110",label:"东丽区"},{value:"120111",label:"西青区"},{value:"120112",label:"津南区"},{value:"120113",label:"北辰区"},{value:"120114",label:"武清区"},{value:"120115",label:"宝坻区"},{value:"120116",label:"滨海新区"},{value:"120117",label:"宁河区"},{value:"120118",label:"静海区"},{value:"120119",label:"蓟州区"}]}]}]}.areaList,E=m("120119"),u=m(!1),M=(e,l)=>{console.log("onChangeCascader-value: ",e),console.log("onChangeCascader-options: ",l),o.place=l==null?void 0:l.map(c=>c.label).join("/"),u.value=!1},S=()=>{u.value=!0},Y=e=>{o.age=e},z=8,F=()=>{console.log("===onReset")},L=e=>{console.log("===onSubmit",e)},b={name:[{validator:e=>e>8,message:"只能输入8个字符英文"}],password:[{validator:e=>e>6,message:"长度大于6个字符"}],gender:[{validator:e=>e!=="",message:"不能为空"}],birth:[{validator:e=>e!=="",message:"不能为空"}],description:[{validator:e=>e>3,message:"分数过低会影响整体评价"}],resume:[{validator:e=>e!=="",message:"不能为空"}]};X(()=>{p.value.setValidateMessage(b)});const N=()=>{w.back()};return(e,l)=>{const c=n("t-navbar"),i=n("t-input"),r=n("t-form-item"),v=n("t-radio"),j=n("t-radio-group"),G=n("t-date-time-picker"),P=n("t-popup"),A=n("t-cascader"),I=n("t-stepper"),T=n("t-rate"),$=n("t-textarea"),g=n("t-button"),q=n("t-form");return Z(),ee(le,null,[a(c,{title:"表单demo","left-icon":"",onLeftClick:N}),_("div",ae,[a(q,{ref_key:"form",ref:p,data:o,rules:b,"reset-type":"initial","show-error-message":"","label-align":"left",disabled:f(x),onReset:F,onSubmit:L},{default:s(()=>[a(r,{label:"用户名",name:"name",help:"输入用户名"},{default:s(()=>[a(i,{modelValue:o.name,"onUpdate:modelValue":l[0]||(l[0]=t=>o.name=t),placeholder:"请输入内容"},null,8,["modelValue"])]),_:1}),a(r,{label:"密码",name:"password"},{default:s(()=>[a(i,{modelValue:o.password,"onUpdate:modelValue":l[1]||(l[1]=t=>o.password=t),type:"password",placeholder:"请输入内容"},null,8,["modelValue"])]),_:1}),a(r,{label:"性别",name:"gender"},{default:s(()=>[a(j,{modelValue:o.gender,"onUpdate:modelValue":l[2]||(l[2]=t=>o.gender=t),class:"box",borderless:"",onChange:k},{default:s(()=>[a(v,{block:!1,name:"radio",value:"man",label:"男"}),a(v,{block:!1,name:"radio",value:"women",label:"女"})]),_:1},8,["modelValue"])]),_:1}),a(r,{arrow:"",label:"生日",name:"birth","content-align":"right"},{default:s(()=>[a(i,{modelValue:o.birth,"onUpdate:modelValue":l[3]||(l[3]=t=>o.birth=t),align:"right",placeholder:"请选择日期",onClick:l[4]||(l[4]=t=>d.value=!0),disabled:"true"},null,8,["modelValue"]),a(P,{modelValue:d.value,"onUpdate:modelValue":l[5]||(l[5]=t=>d.value=t),placement:"bottom"},{default:s(()=>[a(G,{value:o.birth,mode:["date"],title:"选择日期",start:"2015-5-5",format:"YYYY-MM-DD",onChange:y,onPick:U,onConfirm:R,onCancel:B},null,8,["value"])]),_:1},8,["modelValue"])]),_:1}),a(r,{arrow:"",label:"籍贯",name:"place","content-align":"right"},{default:s(()=>[a(i,{modelValue:o.place,"onUpdate:modelValue":l[6]||(l[6]=t=>o.place=t),align:"right",placeholder:"请输入内容",onClick:S,disabled:"true"},null,8,["modelValue"]),a(A,{visible:u.value,"onUpdate:visible":l[7]||(l[7]=t=>u.value=t),value:E.value,title:"选择地址",options:f(D),onChange:M},null,8,["visible","value","options"])]),_:1}),a(r,{label:"年限",name:"age","content-align":"right"},{default:s(()=>[a(I,{modelValue:o.age,"onUpdate:modelValue":l[8]||(l[8]=t=>o.age=t),theme:"filled",onChange:Y},null,8,["modelValue"])]),_:1}),a(r,{label:"自我评价",name:"description","content-align":"right"},{default:s(()=>[a(T,{modelValue:o.description,"onUpdate:modelValue":l[9]||(l[9]=t=>o.description=t),clearable:"","allow-half":"",gap:z},null,8,["modelValue"])]),_:1}),a(r,{label:"个人简介",name:"resume"},{default:s(()=>[a($,{modelValue:o.resume,"onUpdate:modelValue":l[10]||(l[10]=t=>o.resume=t),class:"textarea",indicator:"",maxlength:50,placeholder:"请输入个人简介"},null,8,["modelValue"])]),_:1}),_("div",oe,[a(g,{theme:"primary",type:"submit",size:"large"},{default:s(()=>[V("提交")]),_:1}),a(g,{theme:"default",variant:"base",type:"reset",size:"large"},{default:s(()=>[V("重置")]),_:1})])]),_:1},8,["data","disabled"])])],64)}}},re=H(te,[["__scopeId","data-v-7cf1278d"]]);export{re as default};
