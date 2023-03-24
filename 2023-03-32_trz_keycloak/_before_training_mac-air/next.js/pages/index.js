import dynamic from 'next/dynamic'

const Keycloak = dynamic(
  () => import('./Keycloak'),
  { ssr: false }
)

export default function Index() {

return  (<div>
  <Keycloak>
    <h1>xxx</h1>
</Keycloak>
</div>)
}
