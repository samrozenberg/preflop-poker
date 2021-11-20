
const joinGame = () => {

  const button = document.querySelector('#join_game_button')
    button.addEventListener('click', (event) => {
      const current_user = document.querySelector("#current_user").innerText;
      const users = document.querySelector(".pseudos");
      if (current_user != users.innerText) {
        users.insertAdjacentHTML("beforeend", `<br>${current_user}`);
      }
      // const price_per_day = animal.price;
      // console.log(price_per_day);

    })
  }


export { joinGame }
