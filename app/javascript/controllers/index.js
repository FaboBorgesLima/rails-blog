// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

document.addEventListener("turbo:load", () => {
  // create copy for code blocks
    document.querySelectorAll(".prose pre").forEach((pre) => {
        let codeText = "";
        let lang = "";

        for (const code of pre.children) {
            lang = code.classList.toString();
            codeText += code.textContent;
        }
        // add lang to top 
        if (lang) {
            const langLabel = document.createElement("div");
            langLabel.className = "absolute top-2 left-2 bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-gray-200 rounded px-2 py-1 text-xs";
            langLabel.textContent = lang.replace("language-", "");
            pre.classList.add("relative");
            pre.appendChild(langLabel);
        }
        const button = document.createElement("button");
        button.className = "cursor-pointer absolute top-2 right-2 bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-gray-200 rounded px-2 py-1 text-xs opacity-0 group-hover:opacity-100 transition-opacity";
        button.textContent = "Copy";
        button.addEventListener("click", () => {
            navigator.clipboard.writeText(codeText).then(() => {
                button.textContent = "Copied!";
                setTimeout(() => {
                    button.textContent = "Copy";
                }, 2000);
            });
        });
        pre.classList.add("relative", "group");
        pre.appendChild(button);
    })
})
