import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import Home from './pages/Home';
import Data from './pages/Data';

import Functions from './pages/Functions';
import Lists from './pages/Lists';
import ExercisePage from './pages/ExercisePage';

import Topics from './pages/Topics';
import Examples from './pages/Examples';

function App() {
  return (
    <Router basename="/pensamento-computacional">
      <Layout>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/topics" element={<Topics />} />
          <Route path="/topics/data" element={<Data />} />
          <Route path="/topics/functions" element={<Functions />} />
          <Route path="/exercises" element={<Lists />} />
          <Route path="/exercises/:id" element={<ExercisePage />} />
          <Route path="/examples" element={<Examples />} />
        </Routes>
      </Layout>
    </Router>
  );
}

export default App;
