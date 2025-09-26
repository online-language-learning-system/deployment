import React from "react";
import ReactDOM from "react-dom/client";
import Auth from "./Auth";

const ctx = window.__KEYCLOAK_CONTEXT__;

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <Auth context={ctx} />
  </React.StrictMode>
);
