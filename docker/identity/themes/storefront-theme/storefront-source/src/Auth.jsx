import React, { useState } from "react";
import styles from "./css/auth.module.css";
import "@fortawesome/fontawesome-free/css/all.min.css";
import axios from "axios";

export default function Auth() {
  const [isActive, setIsActive] = useState(false);

  // State quản lý form đăng ký
  const [registerForm, setRegisterForm] = useState({
    username: "",
    email: "",
    password: "",
    passwordConfirm: "",
    firstName: "",
    lastName: "",
    role: "",
  });

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

  const getToken = async () => {
    try {
      const res = await axios.get("http://localhost:8000/get-token");
      const token = res.data.accessToken;
      return token;
    } catch (err) {
      console.error("Lỗi lấy token", err);
      return null;
    }
  };

  const handleRegister = async (e) => {
    e.preventDefault();
    console.log("Register form submitted", registerForm);

    try {

      const accessToken = await getToken();

      const res = await axios.post(
        "http://localhost:8000/storefront/users",
        {
          username: registerForm.username,
          email: registerForm.email,
          password: registerForm.password,
          passwordConfirm: registerForm.passwordConfirm,
          firstName: registerForm.firstName,
          lastName: registerForm.lastName,
          role: registerForm.role,
        },
        {
          headers: {
            Authorization: `Bearer ${accessToken}`,
          },
        }
      );

      alert("Đăng ký thành công! Hãy đăng nhập.");
      console.log(res.data);

      setIsActive(false);
      setRegisterForm({ username: "", email: "", password: "", passwordConfirm: "", firstName: "", lastName: "" }); // reset form
    } catch (err) {
      console.error(err);
      alert("Đăng ký thất bại!");
    }
  };


  return (
    <div className={`${styles.container} ${isActive ? styles.active : ""}`}>
      {/* Login Form */}
      <div className={`${styles["form-box"]} ${styles.login}`}>
        <form onSubmit={handleLogin}>
          <h1>Login</h1>
          <div className={styles["input-box"]}>
            <input type="text" name="username" placeholder="Username" required />
            <i className="fas fa-user"></i>
          </div>
          <div className={styles["input-box"]}>
            <input type="password" name="password" placeholder="Password" required />
            <i className="fas fa-lock"></i>
          </div>
          <div className={styles["remember-forgot"]}>
            <label>
              <input type="checkbox" /> Remember me
            </label>
            <a href="#">Forgot Password?</a>
          </div>
          <button type="submit" className={styles.btn}>
            Login
          </button>
          <p>or login with social platforms</p>
          <div className={styles["social-icons"]}>
            <a href="#"><i className="fab fa-google"></i></a>
            <a href="#"><i className="fab fa-facebook"></i></a>
          </div>
        </form>
      </div>

      {/* Register Form */}
      <div className={`${styles["form-box"]} ${styles.register}`}>
        <form onSubmit={handleRegister}>
          <h1>Register</h1>
          <div className={styles["input-box"]}>
            <input
              type="text"
              name="username"
              placeholder="Username"
              required
              value={registerForm.username}
              onChange={(e) => setRegisterForm({ ...registerForm, username: e.target.value })}
            />
            <i className="fas fa-user"></i>
          </div>
          <div className={styles["input-box"]}>
            <input
              type="email"
              name="email"
              placeholder="Email"
              required
              value={registerForm.email}
              onChange={(e) => setRegisterForm({ ...registerForm, email: e.target.value })}
            />
            <i className="fas fa-envelope"></i>
          </div>
          <div className={styles["input-box"]}>
            <input
              type="password"
              name="password"
              placeholder="Password"
              required
              value={registerForm.password}
              onChange={(e) => setRegisterForm({ ...registerForm, password: e.target.value })}
            />
            <i className="fas fa-lock"></i>
          </div>
          <div className={styles["input-box"]}>
            <input
              type="password"
              name="passwordConfirm"
              placeholder="Confirm Password"
              required
              value={registerForm.passwordConfirm}
              onChange={(e) => setRegisterForm({ ...registerForm, passwordConfirm: e.target.value })}
            />
            <i className="fas fa-lock"></i>
          </div>
          <div className={styles["input-box"]}>
            <input
              type="text"
              name="firstName"
              placeholder="First Name"
              required
              value={registerForm.firstName}
              onChange={(e) => setRegisterForm({ ...registerForm, firstName: e.target.value })}
            />
            <i className="fa fa-signature"></i>
          </div>
          <div className={styles["input-box"]}>
            <input
              type="text"
              name="lastName"
              placeholder="Last Name"
              required
              value={registerForm.lastName}
              onChange={(e) => setRegisterForm({ ...registerForm, lastName: e.target.value })}
            />
            <i className="fas fa-signature"></i>
          </div>
          
          <div className={styles["input-box"]}>
            <label>Register Role</label>
            <div className={styles["roles-checkbox"]}>
              {["STUDENT", "LECTURER"].map((role) => (
                <label key={role}>
                  <input
                    type="radio"
                    name="role"  // cùng name để chỉ chọn 1
                    value={role}
                    checked={registerForm.role === role}
                    onChange={(e) =>
                      setRegisterForm({ ...registerForm, role: e.target.value })
                    }
                  />
                  <span>{role.charAt(0) + role.slice(1).toLowerCase()}</span>
                </label>
              ))}
            </div>
          </div>


          <button type="submit" className={styles.btn}>
            Register
          </button>
          <p>or register with social platforms</p>
          <div className={styles["social-icons"]}>
            <a href="#"><i className="fab fa-google"></i></a>
            <a href="#"><i className="fab fa-facebook"></i></a>
          </div>
        </form>
      </div>

      {/* Toggle Box */}
      <div className={styles["toggle-box"]}>
        <div className={`${styles["toggle-panel"]} ${styles["toggle-left"]}`}>
          <h1>Hello, Welcome!</h1>
          <p>Don't have an account?</p>
          <button
            type="button"
            className={styles.btn}
            onClick={() => setIsActive(true)}
          >
            Register
          </button>
        </div>

        <div className={`${styles["toggle-panel"]} ${styles["toggle-right"]}`}>
          <h1>Welcome Back!</h1>
          <p>Already have an account?</p>
          <button
            type="button"
            className={styles.btn}
            onClick={() => setIsActive(false)}
          >
            Login
          </button>
        </div>
      </div>
    </div>
  );
}
