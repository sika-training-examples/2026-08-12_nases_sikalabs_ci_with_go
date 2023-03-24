import keycloak from "keycloak-js";
import React, { useState, useEffect } from 'react';

export default function Keycloak(props){
  const [authenticated, setAuthenticated] = useState(false);
  const [name, setName] = useState("");

  const k = new keycloak({
    url: "https://keycloak.sikademo.com",
    realm: "example",
    clientId: "example",
   });
  useEffect(() => {
    k.init({ onLoad: "" })
    .then(auth => {
      setAuthenticated(auth)
      if (auth) {
        setName(k.tokenParsed.name)
      }
    })
  }, []);
   return <>
    {!authenticated && <button onClick={() => k.login()}>Login</button>}
    {authenticated && <button onClick={() => k.logout()}>Logout</button>}
    <h1>{name}</h1>
    {props.children}
   </>
};
