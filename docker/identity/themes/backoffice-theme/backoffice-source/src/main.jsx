import React from "react";
import ReactDOM from "react-dom/client";
import { ThemeProvider } from "@material-tailwind/react";
import Admin from "./Admin";

// Lấy context từ Keycloak (nếu có)
const ctx = window.__KEYCLOAK_CONTEXT__ || {};

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <ThemeProvider>
    <Admin context={ctx} />
    </ThemeProvider>
  </React.StrictMode>
);
