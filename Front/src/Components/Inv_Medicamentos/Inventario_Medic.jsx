import axios from "axios";
import { AxiosGet } from "../../Helpers/FetchAxios/FetchAxios";
import { Box, IconButton, Button, FormControlLabel, Radio, FormControl, FormLabel, RadioGroup } from '@mui/material';
import MUIDataTable from 'mui-datatables';
import { useEffect, useState } from "react";
// menu acorderon 
import Accordion from '@mui/material/Accordion';
import AccordionSummary from '@mui/material/AccordionSummary';
import AccordionDetails from '@mui/material/AccordionDetails';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
// iconMaterialUI
import LoupeIcon from '@mui/icons-material/Loupe';
import EditIcon from '@mui/icons-material/Edit';
import DeleteForeverIcon from '@mui/icons-material/DeleteForever';
import SettingsApplicationsIcon from '@mui/icons-material/SettingsApplications';
import ModalComponent from "../../Helpers/Modal/ModalComponent";
import BodyDetalles from "./BodyDetalles";
import BodyAddMedicamento from "./BodyAddMedicamento";
import BodyAddCantidad from "./BodyAddCantidad";
import BodyUpdate from "./BodyUpdate";
import PopupComponent from "../../Helpers/Modal/PopupComponent";
import BodyDelete from "./BodyDelete";
// muidatatable global 
import { customHeadRender } from '../../Helpers/Muidatatable/muidatatable';
import '../../assets/Css/muidatatable.css'




function Inventario_Medic() {
  
  const [tabla, setTabla] = useState()
  const [detallesmedicamentos, setDetallesMedicamentos] = useState({})
  const [dataeditar,setDataEditar] = useState({})
  const [datasliminar,setDataEliminar] = useState({})

  const [modaldetails, setModalDetails] = useState(false)
  const [modalNewMedicamento, setModalNewMedicamento] = useState(false)
  const [modaladdcantidad, setModalAddCantidad] = useState(true)
  const [modalupdate, setModalUpdate] = useState(false)
  const [modaldelete, setModalDelete] = useState(false)

  const OpenCloseModalDetails = () =>{setModalDetails(!modaldetails)}
  const OpenCloseModalNewMedicamento = () => {setModalNewMedicamento(!modalNewMedicamento)}
  const OpenCloseModalAddCantidad = () => {setModalAddCantidad(!modaladdcantidad)}
  const OpenCloseModalUpdate = () => {setModalUpdate(!modalupdate)}
  const OpenCloseModalDelete = () => {setModalDelete(!modaldelete)}

  const tableData =  () =>{
    const url = 'http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/inventario/table'
    AxiosGet(url,setTabla)
    // const resp = await axios.post(url)
    // const resp_data = await resp.data

    // setTabla(resp_data)

  }

  useEffect(() =>{
    tableData()
  },[])

  const DetallesInventario = (data_medicamento) =>{
    let dataMedicamento = data_medicamento[0]
    let datapresentacion = data_medicamento[1]
    let datagramo = data_medicamento[2]
    console.log(dataMedicamento)
    console.log(datapresentacion)
    console.log(datagramo)
    const detallesMedicamentos = tabla.filter((item) => 
      item.NOMBRE_MEDICAMENTO == dataMedicamento && 
      item.PRESENT_MEDICAMENTO == datapresentacion &&
      item.UNIDAD_MEDIDA == datagramo 
      
    )
    console.log(detallesMedicamentos)
    setDetallesMedicamentos({

      TIPO_ALMACEN: detallesMedicamentos[0].TIPO_ALMACEN,
      NOMBRE_MEDICAMENTO: detallesMedicamentos[0].NOMBRE_MEDICAMENTO,
      TIPO_MEDICAMENTO: detallesMedicamentos[0].TIPO_MEDICAMENTO,
      PRESENT_MEDICAMENTO: detallesMedicamentos[0].PRESENT_MEDICAMENTO,
      UNIDAD_MEDIDA: detallesMedicamentos[0].UNIDAD_MEDIDA,
      PISO: detallesMedicamentos[0].PISO,
      PASILLO: detallesMedicamentos[0].PASILLO,
      CANTIDAD: detallesMedicamentos[0].CANTIDAD,
      LOTE: detallesMedicamentos[0].LOTE,
      ESTATUS: detallesMedicamentos[0].ESTATUS,
      FECHA_VENCIMIENTO: detallesMedicamentos[0].FECHA_VENCIMIENTO,
      COMPONENTE_PRINC: detallesMedicamentos[0].COMPONENTE_PRINC,
      OBSERVACION: detallesMedicamentos[0].OBSERVACION,

    })

    OpenCloseModalDetails()
    console.log(tabla)
  }

  // --------------------------------
  // -----------NEW MEDICAMENTOS-------
  // -------------
  const AddMedicamento = () => {
    OpenCloseModalNewMedicamento()
  }
  // --------------------------------
  // -----------ADD CANTIDAD MEDICAMENTOS-------
  // -------------
  const AddCantidadMedicamento = () => {
    OpenCloseModalAddCantidad()
  }
  // --------------------------------
  // -----------UPDATE MEDICAMENTOS-------
  // -------------
  const UpdateMedicamento = (data) => {
    let dataMedicamento = data[0]
    let datapresentacion = data[1]
    let datagramo = data[2]
    const updateMedicamento = tabla.filter((item) => 
      item.NOMBRE_MEDICAMENTO == dataMedicamento && 
      item.PRESENT_MEDICAMENTO == datapresentacion &&
      item.UNIDAD_MEDIDA == datagramo 
    )
    console.log('update',updateMedicamento)
    setDataEditar({
      medicamento : data[0],
      estatus : updateMedicamento[0].ESTATUS,
      gramos : updateMedicamento[0].UNIDAD_MEDIDA,
      almacen : updateMedicamento[0].TIPO_ALMACEN,
      presentacion : updateMedicamento[0].PRESENT_MEDICAMENTO,
    })
    OpenCloseModalUpdate()
  }

  // --------------------------------
  // -----------DELETE MEDICAMENTOS-------
  // -------------

  const DeleteMedicamento = (data) =>{
    console.log(data)
    console.log(data[0],data[1],data[2])

    BodyDelete(data[0],data[1],data[2],tableData)
    
  }
  
  const columns = [

    {
      name : 'NOMBRE_MEDICAMENTO',
      label : 'NOMBRE MEDICAMENTO',
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
      name : 'PRESENT_MEDICAMENTO',
      label : 'PRESENTACION DE MEDICAMENTO',
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
      name : 'UNIDAD_MEDIDA',
      label : 'UNIDAD DE MEDIDA',
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
      name : 'CANTIDAD',
      label : 'CANTIDAD',
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
        customHeadRender: (columnMeta, handleToggleColumn) => {
          return customHeadRender(columnMeta, handleToggleColumn)
        },
        customBodyRender:(value, tableMeta, updateValue) =>{
            const transf_obj = Object.assign({},tableMeta.rowData)
            return (
                <>
                    
                    <IconButton aria-label="editicon" color='success' onClick={() => DetallesInventario(transf_obj)}>
                        <LoupeIcon />
                    </IconButton>
                    <IconButton aria-label="editicon" color='info' onClick={() => UpdateMedicamento(transf_obj)}>
                        <EditIcon />
                    </IconButton>
                    <IconButton aria-label="deleteicon" color='error' onClick={() => DeleteMedicamento(transf_obj)}>
                        <DeleteForeverIcon />
                    </IconButton>

                </>
            )
        }
        
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

  return (
    <>
      <Box className='Inventario'>
        <Box className='modal_Detalles'>
          <PopupComponent
            onOpen={modaldetails}
            title='Detalles Medicamentos'
            onClose={OpenCloseModalDetails}
            bodymodal={
              <BodyDetalles  
                // onClose = {OpenCloseModalDetails}  
                almacen = {detallesmedicamentos.TIPO_ALMACEN}
                medicamento = {detallesmedicamentos.NOMBRE_MEDICAMENTO}
                tipomedicamento = {detallesmedicamentos.TIPO_MEDICAMENTO}
                presentmedicamento = {detallesmedicamentos.PRESENT_MEDICAMENTO}
                unidadmedida = {detallesmedicamentos.UNIDAD_MEDIDA}
                piso = {detallesmedicamentos.PISO}
                pasillo = {detallesmedicamentos.PASILLO}
                cantidad = {detallesmedicamentos.CANTIDAD}
                lotes = {detallesmedicamentos.LOTE}
                estatus = {detallesmedicamentos.ESTATUS}
                fecha_vencimiento = {detallesmedicamentos.FECHA_VENCIMIENTO}
                componente = {detallesmedicamentos.COMPONENTE_PRINC}
                observacion = {detallesmedicamentos.OBSERVACION}
              />
            }
          />
        </Box>
        <Box className='modal_add_medicamento'>
          <PopupComponent
            onOpen={modalNewMedicamento}
            title='Registrar Medicamento'
            onClose={OpenCloseModalNewMedicamento}
            bodymodal={
              <BodyAddMedicamento
                onClose={OpenCloseModalNewMedicamento}
                tableData={tableData}
              />
            }
          />
        </Box>
        <Box className='modal_cantidad_medic'>
          <PopupComponent
            onClose={OpenCloseModalAddCantidad}
            onOpen={modaladdcantidad}
            title='Nueva Cantidad de Medicamentos'
            bodymodal={
              <BodyAddCantidad
                onClose={OpenCloseModalAddCantidad}
                tableData={tableData}
              />
            }
          />
        </Box>
        <Box className='modal_cantidad_medic'>
          <PopupComponent 
            onOpen={modalupdate}
            title='Editar Medicamento'
            onClose={OpenCloseModalUpdate}
            bodymodal={
              <BodyUpdate 
                onClose={OpenCloseModalUpdate}
                medicamentoactual={dataeditar.medicamento}
                estatus={dataeditar.estatus}
                presentacion={dataeditar.presentacion}
                gramos={dataeditar.gramos}
                almacen={dataeditar.almacen}
                tableData={tableData}
              />
            }
          />
        </Box>
        
        {/* --------------------------------------------- */}
        {/* --------------opciones de medicamentos(menu acordeon) --------- */}
        {/* ------------------------------------------------ */}
        <Box className='Acorden_menu' sx={{mt:'7rem'}}>
          <Accordion sx={{zIndex:2,position:'absolute',top:'8rem'}}>
            <AccordionSummary
              expandIcon={<ExpandMoreIcon />}
              aria-controls="panel1a-content"
              id="panel1a-header"
            >
              <Button variant="contained" sx={{width:'100%'}} color="error" startIcon={<SettingsApplicationsIcon />}>
                Opciones Medicamento
              </Button>
            </AccordionSummary>

            <AccordionDetails>
              <FormControl>
                <FormLabel id="demo-radio-buttons-group-label">Seleccionar:</FormLabel>
                  <RadioGroup
                      aria-labelledby="demo-radio-buttons-group-label"
                      name="radio-buttons-group"
                    >
                    <FormControlLabel value="medicamento" control={<Radio />} label="Agregar Medicamento a Inventario" onClick={AddMedicamento} sx={{mb:2}} />
                    <FormControlLabel value="cantidad" control={<Radio />} label="Agregar Nueva cantidad" onClick={AddCantidadMedicamento} />
                  </RadioGroup>
              </FormControl>
            </AccordionDetails>
          </Accordion>
           
        </Box>
          
        <Box component='div' sx={{margin:'2rem 0'}}>
          <MUIDataTable 
            sx={{textAlign:'center'}}
            title={"INVENTARIO DE MEDICAMENTOS"}
            data={tabla}
            columns={columns}
            options={opciones}
          />
        </Box>

        

      </Box>
    </>
  )
}

export default Inventario_Medic