import {NextRequest, NextResponse} from 'next/server';

export async function middleware(request: NextRequest) {
    const { pathname } = request.nextUrl;
    const isLoginPage = pathname.startsWith('/login');
    const isRegisterPage = pathname.startsWith('/register');

    // Skip auth check for login and register pages
    if (isLoginPage || isRegisterPage) {
        return NextResponse.next();
    }

    const token = request.cookies.get('token')?.value;

    // If no token is present, redirect to login
    if (!token) {
        return NextResponse.redirect(new URL('/login', request.url));
    }

    // For all other routes, let the client-side AuthContext handle the authentication
    // This prevents unnecessary server-side token validation
    return NextResponse.next();
}

// Configure which routes to run middleware on
export const config = {
    matcher: [
        /*
         * Match all request paths except for the ones starting with:
         * - api (API routes)
         * - _next/static (static files)
         * - _next/image (image optimization files)
         * - favicon.ico (favicon file)
         */
        '/((?!api|_next/static|_next/image|favicon.ico).*)',
    ],
};