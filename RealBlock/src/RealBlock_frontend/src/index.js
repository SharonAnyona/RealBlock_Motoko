import { RealBlock_backend } from "../../declarations/RealBlock_backend";

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const button = e.target.querySelector("button");

  // const id = document.getElementById("id").value;
  const id = parseInt(document.getElementById("id").value, 10);
  const role = document.getElementById("role").value.toString();
  button.setAttribute("disabled", true);
  console.log("id"+ id + "role"+ role);

  const registerUser = await RealBlock_backend.registerUser(id, role);
  console.log(registerUser);
  document.getElementById("myButton").addEventListener("click", function() {
    window.location.href = "src/RealBlock_frontend/src/home.html"; 
     });
  button.removeAttribute("disabled");

  document.getElementById("greeting").innerText = greeting;

  return false;
});
