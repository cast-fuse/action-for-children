import "phoenix_html";
import { handleIntercomLaunch } from "./launcher.js";
import handleTimeOptions from "./callback.js";
import "accordion";

const removeFooterOnMenuOpen = () => {
  const toggle = document.getElementById("toggle");
  const footer = document.getElementById("footer");

  document.body.addEventListener("click", (e) => {
    if ((e.target.id = "toggle")) {
      e.target.checked
        ? (footer.style.display = "none")
        : (footer.style.display = "block");
    }
  });
};

let open = false;

const toggleModal = () => {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;

  const modal = document.querySelector(".modal");
  const modalWrapper = document.querySelector(".modalWrapper");

  const showModal = () => {
    open = true;
    modal.classList.remove("dn");
    modalWrapper.classList.remove("dn");
    modal.classList.add("flex");
    modalWrapper.classList.add("flex");

    document.body.style.margin = "0";
    document.body.style.height = "100%";
    document.body.style.overflow = "hidden";
  };

  const hideModal = () => {
    open = false;
    modal.classList.add("dn");
    modalWrapper.classList.add("dn");
    modal.classList.remove("flex");
    modalWrapper.classList.remove("flex");

    document.body.style.margin = "0";
    document.body.style.height = "auto";
    document.body.style.overflow = "inherit";
  };

  const onModalClick = (event) => {
    if (!event.target.closest(".modal")) {
      hideModal();
    }
  };

  if (open) {
    hideModal();
    modalWrapper.removeEventListener("click", onModalClick);
  } else {
    showModal();
    modalWrapper.addEventListener("click", onModalClick);
  }
};

window.toggleModal = toggleModal;

removeFooterOnMenuOpen();
handleIntercomLaunch();
handleTimeOptions();

var el = document.querySelector(".accordion");
new Accordion(el);
