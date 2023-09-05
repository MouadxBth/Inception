var firstColor = document.getElementById("firstColor");
var secondColor = document.getElementById("secondColor");
var body = document.querySelector("body");
var colorOutput = document.getElementById("colorOutput");

firstColor.addEventListener("input", setColor);

secondColor.addEventListener("input", setColor);

setColor();

function setColor() {
	body.style.background = 'linear-gradient(to right,' + firstColor.value + ',' + secondColor.value +')';
	colorOutput.textContent = body.style.background + ";";
}




