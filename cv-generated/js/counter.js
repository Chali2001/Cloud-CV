const API_URL = "https://vllv40p656.execute-api.us-east-1.amazonaws.com/prod/count";

async function updateCounter() {
  try {
    const res = await fetch(API_URL);
    const data = await res.json();

    console.log("Visitas:", data.count);

    const el = document.getElementById("visit-counter");
    if (el) {
      el.textContent = data.count;
    }
  } catch (err) {
    console.error("Error cargando contador:", err);
  }
}

document.addEventListener("DOMContentLoaded", updateCounter);