import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import Home from './pages/Home';
import Functions from './pages/Functions';
import PyretStyleGuide from './pages/PyretStyleGuide';
import Laboratories from './pages/Laboratories';
import LabPage from './pages/LabPage';
import ExercisePage from './pages/ExercisePage';
import Lists from './pages/Lists';
import Topics from './pages/Topics';
import Examples from './pages/Examples';
import Learning from './pages/Learning';

function App() {
  return (
    <Router basename="/pensamento-computacional">
      <Layout>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/topics" element={<Topics />} />
          <Route path="/topics/functions" element={<Functions />} />
          <Route path="/topics/style-guide" element={<PyretStyleGuide />} />
          <Route path="/topics/learning" element={<Learning />} />
          <Route path="/labs" element={<Laboratories />} />
          <Route path="/labs/:id" element={<LabPage />} />
          <Route path="/exercises" element={<Lists />} />
          <Route path="/exercises/:id" element={<ExercisePage />} />
          <Route path="/examples" element={<Examples />} />
        </Routes>
      </Layout>
    </Router>
  );
}

export default App;
