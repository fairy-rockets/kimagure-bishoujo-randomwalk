import React from 'react';
import ReactDOM from 'react-dom';
import { HashRouter, Route } from 'react-router-dom';
import 'jquery/src/jquery';
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap/dist/js/bootstrap.js'
import './fonts/fonts.css'
import './index.css';
import App from './components/App';
import registerServiceWorker from './registerServiceWorker';
import GAN from './utils/GAN'
import ImageEncoder from './utils/ImageEncoder'
ReactDOM.render(
    <HashRouter>
        <Route path="/" component={App} />
    </HashRouter>,
    document.getElementById('root')
);
registerServiceWorker();
window.GAN = GAN;
window.ImageEncoder = ImageEncoder;
