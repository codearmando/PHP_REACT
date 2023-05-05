import styled from '@emotion/styled'
import React from 'react'
import { NavLink } from 'react-router-dom'

import '../assets/Css/NavLink.css'
import { Accordion, AccordionDetails, AccordionSummary, Box, Typography, IconButton, Toolbar, Button, AppBar } from '@mui/material'
import {evento} from '../assets/JS/NavLink'
import img from '../assets/Img/Exportar_img_all'

import AddHomeWorkOutlinedIcon from '@mui/icons-material/AddHomeWorkOutlined';
import PersonAddAlt1OutlinedIcon from '@mui/icons-material/PersonAddAlt1Outlined';
import ArrowForwardIosOutlinedIcon from '@mui/icons-material/ArrowForwardIosOutlined';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import CloseSharpIcon from '@mui/icons-material/CloseSharp';
import MenuIcon from '@mui/icons-material/Menu';

function NavBar() {

    


  return (
    <>

                {/* <li><NavLink className={({isActive}) => isActive ? 'activeLink' : 'noactiveLink'} to='/'>Inicio</NavLink></li>
                <li><NavLink className={({isActive}) => isActive ? 'activeLink' : 'noactiveLink'} to='/Ticket'>Ticket</NavLink></li>
                <li><NavLink className={({isActive}) => isActive ? 'activeLink' : 'noactiveLink'} to='/Paciente'>Paciente</NavLink></li>
                <li><NavLink className={({isActive}) => isActive ? 'activeLink' : 'noactiveLink'} to='/InventarioMedicamentos'>Inventario</NavLink></li> */}
       
       {/* <Box sx={{ flexGrow: 1 }}>
            <AppBar position="static">
                <Toolbar>
                <IconButton
                    size="large"
                    edge="start"
                    color="inherit"
                    aria-label="menu"
                    sx={{ mr: 2 }}
                >
                    <MenuIcon />
                </IconButton>
                <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
                    News
                </Typography>
                <Button color="inherit">Login</Button>
                </Toolbar>
            </AppBar>
        </Box> */}

        <Box component='nav' className='nav'>
            <IconButton aria-label="" color='primary' id='btn_close'onClick={() => alert('close nav')} >
                <CloseSharpIcon />
            </IconButton>
            <Box component='div' id='nav_logo'>
                <img src={img.logo_ivss_blanco} id='logoivss' alt="logo_ivss_blanco" />
                <Typography id='tit_logo' variant="p" color="initial">Instituto Venezolano del Seguro Social</Typography>
            </Box>    
            <Box component='div' id='cont_list'>
                <Accordion id='linkacordeon'>
                    <NavLink className={({isActive}) => isActive ? 'activeLink' : 'noactiveLink'} to='/'>Inicio</NavLink>
                </Accordion>
                <Accordion id='linkacordeon'>
                    <NavLink className={({isActive}) => isActive ? 'activeLink' : 'noactiveLink'} to='/Ticket'>Crear Ticket</NavLink>
                </Accordion>
                <Accordion id='acordeon'>
                        <AccordionSummary
                            expandIcon={<ExpandMoreIcon />}
                            aria-controls="panel1a-content"
                            id="panel1a-header"
                        >   
                            <Typography>Gestión Medicamentos</Typography>
                        </AccordionSummary>
                        <AccordionDetails>
                            <NavLink className={({isActive}) => isActive ? 'activeLink' : 'noactiveLink'} to='/InventarioMedicamentos'>Inventario</NavLink>
                        </AccordionDetails>
                </Accordion>
                <Accordion id='acordeon'>
                    <AccordionSummary
                        expandIcon={<ExpandMoreIcon />}
                        aria-controls="panel1a-content"
                        id="panel1a-header"
                    >
                        <Typography>Gestión Pacientes</Typography>
                    </AccordionSummary>
                    <AccordionDetails>
                        <NavLink className={({isActive}) => isActive ? 'activeLink' : 'noactiveLink'} to='/Paciente'>Pacientes</NavLink><br />
                    </AccordionDetails>
                </Accordion>
            </Box>
        </Box>

        
        
        


    </>
  )
}

export default NavBar