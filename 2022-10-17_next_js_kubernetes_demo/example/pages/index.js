import React from "react";

const Index = ({ HOSTNAME }) => {
  return <div>Hello World from {HOSTNAME}</div>;
};

Index.getInitialProps = async () => {
  return {
    HOSTNAME: process.env.HOSTNAME || "localhost",
  };
};

export default Index;
