
function init() {
  var bgpics = ["bg1", "bg2", "bg3", "bg4"];
  var someimage = bgpics[Math.floor(Math.random() * 4)];
  console.log(someimage);

  // document.body.style.background = 'url('+someimage+'.png) no-repeat center center'
  document.body.style.backgroundImage = "url(images/" + someimage + ".png)";
  document.body.style.color = "#FFFFFF";
}
window.onload = init;