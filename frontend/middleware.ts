import {NextRequest, NextResponse} from 'next/server';

export async function middleware(request: NextRequest) {
    const { pathname } = request.nextUrl;
    const isLoginPage = pathname.startsWith('/login');
    const isDashboardPage = pathname.startsWith('/dashboard');
    console.log('isDashboardPage', isDashboardPage);

    const checkAuth = async () => {
        try {
            const response = await fetch('http://localhost:8080/api/auth/check', {
                method: 'GET',
                credentials: 'include',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            
            const data = await response.json();
            return data.authenticated;
        } catch (error) {
            console.error('Error checking authentication:', error);
            return false;
        }
    };

    const isAuthenticated = await checkAuth();

    if (!isAuthenticated) {
        return NextResponse.redirect(new URL('/login', request.url));
    }

    return NextResponse.next();
}

export const config = {
    matcher: ['/((?!api|_next|static|favicon.ico|login|register).*)',],
}