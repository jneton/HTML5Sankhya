
const prd=location.port==="40172";
const txt=prd?"🔴 AMBIENTE DE PRODUÇÃO":"🟢 AMBIENTE DE TESTE";
document.title=(prd?"🔴 ":"🟢 ")+document.title;
document.documentElement.classList.add(prd?"snk-prd":"snk-tst");
const b=document.createElement("div");
b.id="snk-env-banner";
b.style.background=prd?"#c00":"#0a0";
b.textContent=txt;
document.body.appendChild(b);
const c=document.createElement("canvas");c.width=32;c.height=32;
const x=c.getContext("2d");x.fillStyle=prd?"#c00":"#0a0";x.beginPath();x.arc(16,16,14,0,7);x.fill();
let l=document.querySelector("link[rel*='icon']"); if(!l){l=document.createElement("link");l.rel="icon";document.head.appendChild(l);} l.href=c.toDataURL();
