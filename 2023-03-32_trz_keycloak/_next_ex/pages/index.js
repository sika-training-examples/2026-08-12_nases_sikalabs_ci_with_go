import { signIn, signOut, useSession } from "next-auth/react"

export default function Home() {
    const { data: session, status } = useSession()
    return <>
        <a
          href="/api/auth/signin"
          onClick={(e) => {
            e.preventDefault()
            signIn("keycloak")
          }}
        >Sign in</a>
        <br />
        <a
          href="/api/auth/signout"
          onClick={(e) => {
            e.preventDefault()
            signOut()
          }}
        >Sign out</a>
        <pre>{JSON.stringify(session, null, 2)}</pre>
        <br />
        <pre>{JSON.stringify(status, null, 2)}</pre>
        <br />
        <a href="/api/session" target="_blank">/api/session</a>
        <br />
        <iframe src="/api/session" />
        <br />
        <a href="/api/jwt" target="_blank">/api/jwt</a>
        <br />
        <iframe src="/api/jwt" />
    </>
}
