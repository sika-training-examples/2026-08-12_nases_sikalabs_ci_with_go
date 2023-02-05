import React from "react";

export default function Index(props) {
  return (
    <div>
      <center>
        <h1>[{props.HOSTNAME}] 👋 AK Example Application {props.count}</h1>
      </center>
    </div>
  );
}

export async function getServerSideProps() {
  const res = await fetch(process.env.COUNTER_API_ORIGIN+`/`)
  const data = await res.json()
  return {
    props: {
      HOSTNAME: process.env.HOSTNAME || "-",
      count: data.count
    }
  }
}
