<html>
<body>
<h2>Statistiche AirWatch</h2>
<script>
  function UserAction() {
    var xhttp = new XMLHttpRequest();
    xhttp.open("GET", "https://www.repubblica.it", true);
    xhttp.setRequestHeader("Content-type", "application/json");
    xhttp.send();
    //var response = JSON.parse(xhttp.responseText);
}
</script>
  
<button type="button" onclick="document.getElementById('demo').innerHTML = Date()">Premi per visualizzare data e ora</button>
  
<p id="demo"></p>
  
</body>
</html>
