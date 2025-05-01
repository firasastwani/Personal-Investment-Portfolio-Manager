"use client";

import { useState, useEffect } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import axios from "axios";

export default function LoginPage() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const router = useRouter();
  const searchParams = useSearchParams();
  const registrationSuccess = searchParams.get("registration");

  useEffect(() => {
    if (registrationSuccess === "success") {
      alert("Registration successful");
    }
  }, [registrationSuccess]);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await axios.post("http://localhost:8080/api/auth/login", { username, password });
      router.push("/dashboard");
    } catch (error) {
      console.error("Login failed:", error);
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <form
        onSubmit={handleLogin}
        className="bg-white p-6 rounded shadow-md w-96"
      >
        <h2 className="text-2xl font-bold mb-4 text-center">Portfolio Login</h2>
        <div className="mb-4">
          <label className="block text-sm font-medium mb-1" htmlFor="username">
            Username
          </label>
          <input
            type="text"
            id="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
            className="w-full px-3 py-2 border rounded"
          />
        </div>
        <div className="mb-4">
          <label className="block text-sm font-medium mb-1" htmlFor="password">
            Password
          </label>
          <input
            type="password"
            id="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            className="w-full px-3 py-2 border rounded"
          />
        </div>
        <button
          type="submit"
          className="w-full bg-green-600 text-white py-2 rounded hover:bg-green-500 transition-colors"
        >
          Login
        </button>

        <a href="/register" className="block text-blue-600 hover:underline text-center pt-2">
          Register here
        </a>
      </form>
    </div>
  );
}
