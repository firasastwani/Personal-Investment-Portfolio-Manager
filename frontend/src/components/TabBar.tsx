"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import clsx from "clsx";
import { useAuth } from "@/app/AuthContext/AuthContext";

const tabs = [
    { label: "Dashboard", href: "/dashboard" },
    { label: "Stocks", href: "/stocks" },
    { label: "Watchlist", href: "/watchlist" },
    { label: "Profile", href: "/profile" },
];

export default function TabBar() {
    const pathname = usePathname();
    const { logout } = useAuth();

    return (
        <nav className="bg-white shadow sticky top-0 z-50">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex space-x-4 py-4">
                    {tabs.map((tab) => (
                        <Link
                            key={tab.href}
                            href={tab.href}
                            className={clsx(
                                "px-4 py-2 rounded font-medium",
                                pathname === tab.href
                                    ? "text-white bg-blue-600"
                                    : "text-gray-700 hover:bg-gray-100"
                            )}
                        >
                            {tab.label}
                        </Link>
                    ))}
                    <button
                        onClick={logout}
                        className="px-4 py-2 rounded font-medium text-gray-700 hover:bg-red-200"
                    >
                        Logout
                    </button>
                </div>
            </div>
        </nav>
    );
}