import React, { useState, useEffect } from 'react';
import axios from 'axios';

export default function Cat() {
  const [catUrl, setCatUrl] = useState('');
  const [error, setError] = useState(false);
  const [state, setState] = useState('');
  useEffect(() => {
      setState('loading');
      axios
          .get('https://cataas.com/cat?json=true')
          .then((res) => {
              console.log(res);
              setState('success');
              setCatUrl('https://cataas.com' + res.data.url);
          })
          .catch((err) => {
              console.error('Error:', err);
              setState('error');
              setError(err);
          });
  }, []);
  if (state === 'error')
      return (
          <h1>

              {error.toString()}
          </h1>
      );
  return (
      <div>
          <div>
              {state === 'loading' ? (
                  <h1>Loading...</h1>
              ) : (
                  <img src={catUrl} />
              )}
          </div>
      </div>
  );
}
