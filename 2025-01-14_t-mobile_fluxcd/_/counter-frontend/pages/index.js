import React from "react";
import os from "os";

const H1 = (props) => (
  <h1
    style={{
      fontSize: "7rem",
      margin: "0",
    }}
  >
    {props.children}
  </h1>
);

const H2 = (props) => (
  <h2
    style={{
      fontSize: "3rem",
      margin: "0.2em",
    }}
  >
    {props.children}
  </h2>
);

export default function Index(props) {
  return (
    <div
      style={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        height: "100vh",
        fontFamily: "Arial",
        color: props.FONT_COLOR,
        backgroundColor: props.BACKGROUND_COLOR,
      }}
    >
      <div
        style={{
          textAlign: "center",
        }}
      >
        <H1>👋 {props.extraText}</H1>
        <H1>{props.counter}</H1>
        {props.hostnameApi === props.HOSTNAME ? (
          <>
            <H2>{props.HOSTNAME} (frontend)</H2>
            <H2>{props.hostnameApi} (backend)</H2>
          </>
        ) : (
          <>
            <H2>{props.HOSTNAME}</H2>
            <H2>{props.hostnameApi}</H2>
          </>
        )}
      </div>
      <style jsx global>{`
        body {
          margin: 0;
        }
      `}</style>
    </div>
  );
}

export async function getServerSideProps() {
  const HOSTNAME = os.hostname();
  var API_ORIGIN = process.env.API_ORIGIN || "http://127.0.0.1";
  const res = await fetch(API_ORIGIN + `/api/counter`);
  const data = await res.json();
  return {
    props: {
      HOSTNAME: HOSTNAME,
      counter: data.counter,
      hostnameApi: data.hostname,
      extraText: data.extra_text,
      FONT_COLOR: process.env.FONT_COLOR || "black",
      BACKGROUND_COLOR: process.env.BACKGROUND_COLOR || "white",
    },
  };
}
