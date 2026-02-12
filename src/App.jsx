import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import Home from './pages/Home';
import Data from './pages/Data';

import Functions from './pages/Functions';
import Lists from './pages/Lists';

import Examples from './pages/Examples';

function App() {
  return (
    <Router basename="/pensamento-computacional">
      <Layout>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/data" element={<Data />} />
          <Route path="/functions" element={<Functions />} />
          <Route path="/lists" element={<Lists />} />
          <Route path="/examples" element={<Examples />} />
        </Routes>
      </Layout>
    </Router>
  );
}

export default App;
