const apiUrl = "https://vllv40p656.execute-api.us-east-1.amazonaws.com/prod/count";

fetch(apiUrl)
  .then(res => res.json())
  .then(data => {
    document.getElementById("counter").innerText =
      `Visitas: ${data.count}`;
  })
  .catch(err => {
    console.error(err);
    document.getElementById("counter").innerText =
      "Error cargando visitas";
  });