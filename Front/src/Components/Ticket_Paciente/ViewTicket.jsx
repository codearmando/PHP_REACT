import { Box, Button } from '@mui/material';
import MUIDataTable from 'mui-datatables';
import { useEffect, useState } from "react";
import { AxiosGet } from "../../Helpers/FetchAxios/FetchAxios";
// iconMaterialUI
import ReceiptLongSharpIcon from '@mui/icons-material/ReceiptLongSharp';
// import components
import PopupComponent from '../../Helpers/Modal/PopupComponent';
import BodyCrearTicket from './BodyCrearTicket';
import BodyRegistrarpaciente from './BodyRegistrarpaciente';
import BodyPacienteRetirado from './BodyPacienteRetirado';
// muidatatable global 
import '../../assets/Css/muidatatable.css'
import { customHeadRender } from '../../Helpers/Muidatatable/muidatatable';

function VistaPrincipal() {

    const [tabla, setTabla] = useState()
    const [ciudadano, setCiudadano] = useState({})

    const [modalcrearticket, setModalCrearTicket] = useState(false)
    const [modalaprobar, setModalAprobar] = useState(false)
    const [modalretirado, setModalRetirado] = useState(false)

    const OpenCloseModalCrearTicket = () =>{setModalCrearTicket(!modalcrearticket)}
    const OpenCloseModalAprobar = () =>{setModalAprobar(!modalaprobar)}
    const OpenCloseModalRetirado = () =>{setModalRetirado(!modalretirado)}

    const tableData = () => {
        const url = 'http://localhost/Farmacia_Alto_Costo/App/ticket/ticket/Table'
        AxiosGet(url,setTabla)
    }
    useEffect(() =>{
      tableData()
    },[])
  
    // --------------------------------
    // -----------CREAR TICKET-------
    // -------------
    const AddNewTicket = () => {
      OpenCloseModalCrearTicket()
    }
    // --------------------------------
    // -----------APROBAR PACIENTE-------
    // -------------
    const AddPaciente = (data) => {
      const data_ciudadano = data
      setCiudadano({
        cedula: data
      })
      
      OpenCloseModalAprobar()
    }
    // --------------------------------
    // -----------RETIRADO PACIENTE-------
    // -------------
    const AddPacienteRetirado = (data) => {
      BodyPacienteRetirado(data,tableData)

      
    }
    const color ={
      bgcolor:'#f2f2f2'
    }
    const columns = [

        {
          name : 'CEDULA_CIUDADANO',
          label : 'CEDULA CIUDADANO',
          options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender: (value, tableMeta, updateValue) => {
              return <div className="celdas_data">{value}</div>
            },
          }
        },
        {
          name : 'NOMBRE_TICKET',
          label : 'TIPO DE TICKET',
          options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender: (value, tableMeta, updateValue) => {
              return <div className="celdas_data">{value}</div>
            },
          }
        },
        {
          name : 'NRO_TICKET',
          label : 'NRO DE TICKET',
          options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender: (value, tableMeta, updateValue) => {
              return <div className="celdas_data">{value}</div>
            },
          }
        },
        {
          name : 'ESTATUS',
          label : 'ESTATUS',
          options:{
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            customBodyRender: (value, tableMeta, updateValue) => {
              return <div className="celdas_data">{value}</div>
            },
          }
        },
        {
          name : 'Action',
          label : 'ACCIONES',
          options:{
            // encabezado de columnas
            customHeadRender: (columnMeta, handleToggleColumn) => {
              return customHeadRender(columnMeta, handleToggleColumn)
            },
            // celdas con los datos
            customBodyRender:(value, tableMeta, updateValue) =>{
                const transf_obj = Object.assign({},tableMeta.rowData)
                return (
                    <>
                      <div className="celdas_data">
                        <Button variant="contained" color="success" onClick={() => AddPaciente(transf_obj[0])}>
                          Aprobar
                        </Button>
                        <Button variant="contained" color="warning" onClick={() => AddPacienteRetirado(transf_obj[0])}>
                          Retirado
                        </Button>
                      </div>
                      
                    </>
                )
            },
            

          }
        },
    
        
    
    ]
  


    const opciones ={
        filterType: 'checkbox',
        // fixedHeader: true,
        selectableRows: false ,// o none
        // selectableRowsOnClick: true,
        filter:true,
        search:true,
        searchPlaceholder:'Buscar..',
        // searchAlwaysOpen:true,
        print: false ,
        download: false ,
        viewColumns:true,
        sort:true,
        draggable:true,
        responsive:'standard',
        rowsPerPage: 5,
        rowsPerPageOptions:[5,10,15,20,30,40,50],
    
        draggableColumns:{
            enabled:true
        },
    
    }
    const title = <Box component='div' id='title_table'></Box>

  return (
    <>


      <Box className='cont_tickets'>
  
        <Box className='modal_add_ticket'>
          <PopupComponent
            onClose={OpenCloseModalCrearTicket}
            onOpen={modalcrearticket}
            title='Crear Ticket'
            bodymodal={
              <BodyCrearTicket
                onClose={OpenCloseModalCrearTicket}
                tableData={tableData}
              />
              
            }
          />
        </Box>
        <Box className='modal_add_paciente'>
          <PopupComponent
            onClose={OpenCloseModalAprobar}
            onOpen={modalaprobar}
            title='Registrar Paciente'
            bodymodal={
              <BodyRegistrarpaciente
                onClose={OpenCloseModalAprobar}
                tableData={tableData}
                cedula= {ciudadano.cedula}
              />
           
              
            }
          />
        </Box>
        

        <Button  variant="contained" color="error" startIcon={<ReceiptLongSharpIcon sx={{fontSize:'30px'}} />} onClick={AddNewTicket}>
          Ticket
        </Button>

        <Box component='div' className='list_ticket' sx={{margin:'2rem 0'}}>
          <MUIDataTable 
            title={"LISTA DE TICKETS"}
            data={tabla}
            columns={columns}
            options={opciones}
          />
        </Box>
      </Box>
    </>
  )
}

export default VistaPrincipal