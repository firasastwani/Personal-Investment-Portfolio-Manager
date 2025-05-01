"use client";
import { useState } from 'react';
import { useRouter } from 'next/navigation';
import axios from 'axios';

export default function RegisterPage() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [passwordRepeat, setPasswordRepeat] = useState('');
  const router = useRouter();

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await axios.post('http://localhost:8080/api/auth/register', { username, password, passwordRepeat });
      router.push('/login?registration=true');
    } catch (error) {
      console.error('Registration failed:', error);
      if (axios.isAxiosError(error)) {
        alert(error.response?.data?.message || "Registration failed.");
      }
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <form
        onSubmit={handleRegister}
        className="bg-white p-6 rounded shadow-md w-96"
      >
        <h2 className="text-2xl font-bold mb-4 text-center">Register New User</h2>

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

        <div className="mb-4">
          <label className="block text-sm font-medium mb-1" htmlFor="passwordRepeat">
            Confirm Password
          </label>
          <input
            type="password"
            id="passwordRepeat"
            value={passwordRepeat}
            onChange={(e) => setPasswordRepeat(e.target.value)}
            required
            className="w-full px-3 py-2 border rounded"
          />
        </div>

        <button
          type="submit"
          className="w-full bg-green-600 text-white py-2 rounded hover:bg-green-500 transition-colors"
        >
          Register
        </button>

        <a href="/login" className="block text-blue-600 hover:underline text-center pt-2">
          Return to Login
        </a>
      </form>
    </div>
  );
}
