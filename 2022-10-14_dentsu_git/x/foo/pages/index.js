import React from "react";
import "normalize.css";

import Hero from "../components/Hero.js";

const style = {
  backgroundColor: "lightblue",
  height: "100vh",
  margin: 0,
  padding: 10,
};

const Index = () => {
  return (
    <div style={style}>
      
      <Hero />
      <h1>Better Demo Project Foo</h1>

      <p>Ahoj tady Paty</p>
      <img src="/dentsu.svg"></img>

      <section>
        <div className="row">
          <div className="column">
            <h2>Octocat</h2>
            <p>
              GitHub's mascot is an anthropomorphized "octocat" with five
              octopus-like arms. The character was created by graphic designer
              Simon Oxley as clip art to sell on iStock, a website that enables
              designers to market royalty-free digital images.
            </p>
          </div>
        </div>
      </section>

      <p>&copy; 2022</p>
    </div>
  );
};

export default Index;
