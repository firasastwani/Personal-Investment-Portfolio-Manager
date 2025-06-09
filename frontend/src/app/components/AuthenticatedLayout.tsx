'use client';

import { useAuth } from "../AuthContext/AuthContext";
import BalanceDisplay from "./BalanceDisplay";

export default function AuthenticatedLayout({ children }: { children: React.ReactNode }) {
  const { user } = useAuth();
  
  return (
    <>
      {user && <BalanceDisplay />}
      {children}
    </>
  );
} 