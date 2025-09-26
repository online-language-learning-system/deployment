import React from "react";
import ReactDOM from "react-dom/client";
import { ThemeProvider } from "@material-tailwind/react";
import Auth from "./Auth";

// Lấy context từ Keycloak (nếu có)
const ctx = window.__KEYCLOAK_CONTEXT__ || {};

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <ThemeProvider>
    <Auth context={ctx} />
    </ThemeProvider>
  </React.StrictMode>
);
