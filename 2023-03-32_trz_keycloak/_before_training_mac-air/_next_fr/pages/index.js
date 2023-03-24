import dynamic from 'next/dynamic'

const Keycloak = dynamic(
  () => import('./Keycloak'),
  { ssr: false }
)

import Cat from './Cat'

export default function Index() {

return  (<div>
  <Keycloak>
{/* <Cat /> */}
<h1>xxx</h1>
</Keycloak>
</div>)
}
