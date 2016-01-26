// add polyfill for Map, Set, and WeakMap required for IE10
import 'babel-polyfill';

import React from 'react';
import ReactDOM from 'react-dom';

import App from './components/App.jsx'

ReactDOM.render(<App />, document.querySelector('.js-mount-point'))
