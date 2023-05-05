import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import { Box, Container, CssBaseline } from '@mui/material';

import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';

import './index.css'
import img from './assets/Img/Exportar_img_all'

import './assets/Css/Fondo.css'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <Box sx={{width:'100%',height:'100vh'}}>
      <Box component='center' sx={{bgcolor:'#fff'}}>
        <img src={img.membrete} alt="" />
        
      </Box>
      <Container maxWidth='sl' sx={{my:'1rem'}}>
        <CssBaseline>
          <App />
        </CssBaseline>  
      </Container>
    </Box>
  </React.StrictMode>,
)
