import React from "react";
import styles from "./css/auth_admin.module.css";
import "@fortawesome/fontawesome-free/css/all.min.css";

export default function Admin() {
  const handleLogin = (e) => {
    console.log("Login form submitted");
    e.preventDefault();

    const username = e.target.username.value;
    const password = e.target.password.value;

    const form = document.createElement("form");
    form.method = "POST";
    form.action = window.__KEYCLOAK_CONTEXT__?.actionUrl || "#";

    const userInput = document.createElement("input");
    userInput.type = "hidden";
    userInput.name = "username";
    userInput.value = username;
    form.appendChild(userInput);

    const passInput = document.createElement("input");
    passInput.type = "hidden";
    passInput.name = "password";
    passInput.value = password;
    form.appendChild(passInput);

    document.body.appendChild(form);
    form.submit();
  };

  return (
    <div className={styles.container}>
      {/* Login Form */}
      <div className={`${styles["form-box"]} ${styles.login}`}>
        <form onSubmit={handleLogin}>
          <div className={styles["admin-header"]}>
            <i className="fas fa-shield-alt"></i>
            <h1>Đăng Nhập Quản Trị</h1>
            <p>Cổng Truy Cập Dành Cho Quản Trị Viên</p>
          </div>
          <div className={styles["input-box"]}>
            <input type="text" name="username" placeholder="Tên đăng nhập" required />
            <i className="fas fa-user-shield"></i>
          </div>
          <div className={styles["input-box"]}>
            <input type="password" name="password" placeholder="Mật khẩu" required />
            <i className="fas fa-lock"></i>
          </div>
          <div className={styles["remember-forgot"]}>
            <label>
              <input type="checkbox" /> Duy trì đăng nhập
            </label>
          </div>
          <button type="submit" className={styles.btn}>
            Đăng Nhập
          </button>
        </form>
      </div>
    </div>
  );
}