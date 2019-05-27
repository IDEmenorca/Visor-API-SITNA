/*! modernizr 3.6.0 (Custom Build) | MIT *
 * https://modernizr.com/download/?-canvas-inputtypes-touchevents-urlparser-mq !*/
!function(e,t,n){function o(e,t){return typeof e===t}function i(){var e,t,n,i,a,r,s;for(var u in l)if(l.hasOwnProperty(u)){if(e=[],t=l[u],t.name&&(e.push(t.name.toLowerCase()),t.options&&t.options.aliases&&t.options.aliases.length))for(n=0;n<t.options.aliases.length;n++)e.push(t.options.aliases[n].toLowerCase());for(i=o(t.fn,"function")?t.fn():t.fn,a=0;a<e.length;a++)r=e[a],s=r.split("."),1===s.length?Modernizr[s[0]]=i:(!Modernizr[s[0]]||Modernizr[s[0]]instanceof Boolean||(Modernizr[s[0]]=new Boolean(Modernizr[s[0]])),Modernizr[s[0]][s[1]]=i),d.push((i?"":"no-")+s.join("-"))}}function a(){return"function"!=typeof t.createElement?t.createElement(arguments[0]):p?t.createElementNS.call(t,"http://www.w3.org/2000/svg",arguments[0]):t.createElement.apply(t,arguments)}function r(){var e=t.body;return e||(e=a(p?"svg":"body"),e.fake=!0),e}function s(e,n,o,i){var s,l,u,d,f="modernizr",p=a("div"),h=r();if(parseInt(o,10))for(;o--;)u=a("div"),u.id=i?i[o]:f+(o+1),p.appendChild(u);return s=a("style"),s.type="text/css",s.id="s"+f,(h.fake?h:p).appendChild(s),h.appendChild(p),s.styleSheet?s.styleSheet.cssText=e:s.appendChild(t.createTextNode(e)),p.id=f,h.fake&&(h.style.background="",h.style.overflow="hidden",d=c.style.overflow,c.style.overflow="hidden",c.appendChild(h)),l=n(p,e),h.fake?(h.parentNode.removeChild(h),c.style.overflow=d,c.offsetHeight):p.parentNode.removeChild(p),!!l}var l=[],u={_version:"3.6.0",_config:{classPrefix:"",enableClasses:!0,enableJSClass:!0,usePrefixes:!0},_q:[],on:function(e,t){var n=this;setTimeout(function(){t(n[e])},0)},addTest:function(e,t,n){l.push({name:e,fn:t,options:n})},addAsyncTest:function(e){l.push({name:null,fn:e})}},Modernizr=function(){};Modernizr.prototype=u,Modernizr=new Modernizr,Modernizr.addTest("urlparser",function(){var e;try{return e=new URL("http://modernizr.com/"),"http://modernizr.com/"===e.href}catch(t){return!1}});var d=[],c=t.documentElement,f=u._config.usePrefixes?" -webkit- -moz- -o- -ms- ".split(" "):["",""];u._prefixes=f;var p="svg"===c.nodeName.toLowerCase(),h=a("input"),m="search tel url email datetime date month week time datetime-local number range color".split(" "),v={};Modernizr.inputtypes=function(e){for(var o,i,a,r=e.length,s="1)",l=0;r>l;l++)h.setAttribute("type",o=e[l]),a="text"!==h.type&&"style"in h,a&&(h.value=s,h.style.cssText="position:absolute;visibility:hidden;",/^range$/.test(o)&&h.style.WebkitAppearance!==n?(c.appendChild(h),i=t.defaultView,a=i.getComputedStyle&&"textfield"!==i.getComputedStyle(h,null).WebkitAppearance&&0!==h.offsetHeight,c.removeChild(h)):/^(search|tel)$/.test(o)||(a=/^(url|email)$/.test(o)?h.checkValidity&&h.checkValidity()===!1:h.value!=s)),v[e[l]]=!!a;return v}(m);var y=function(){var t=e.matchMedia||e.msMatchMedia;return t?function(e){var n=t(e);return n&&n.matches||!1}:function(t){var n=!1;return s("@media "+t+" { #modernizr { position: absolute; } }",function(t){n="absolute"==(e.getComputedStyle?e.getComputedStyle(t,null):t.currentStyle).position}),n}}();u.mq=y;var g=u.testStyles=s;Modernizr.addTest("touchevents",function(){var n;if("ontouchstart"in e||e.DocumentTouch&&t instanceof DocumentTouch)n=!0;else{var o=["@media (",f.join("touch-enabled),("),"heartz",")","{#modernizr{top:9px;position:absolute}}"].join("");g(o,function(e){n=9===e.offsetTop})}return n}),Modernizr.addTest("canvas",function(){var e=a("canvas");return!(!e.getContext||!e.getContext("2d"))}),i(),delete u.addTest,delete u.addAsyncTest;for(var w=0;w<Modernizr._q.length;w++)Modernizr._q[w]();e.Modernizr=Modernizr}(window,document);