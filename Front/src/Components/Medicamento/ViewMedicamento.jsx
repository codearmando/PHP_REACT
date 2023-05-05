import { AxiosGet } from "../../Helpers/FetchAxios/FetchAxios";
import { Box, IconButton,Button } from '@mui/material';
import MUIDataTable from 'mui-datatables';
import { useEffect, useState } from "react"; 
// iconMaterialUI
import EditIcon from '@mui/icons-material/Edit';
import DeleteForeverIcon from '@mui/icons-material/DeleteForever';
import AddCircleOutlineSharpIcon from '@mui/icons-material/AddCircleOutlineSharp';
import BodyAddMedicamento from "./BodyAddMedicamento";
import BodyAddCantidad from "./BodyAddCantidad";
import BodyUpdate from "./BodyUpdate";
import PopupComponent from "../../Helpers/Modal/PopupComponent";
import BodyDelete from "./BodyDelete";
// muidatatable global 
import { customHeadRender } from '../../Helpers/Muidatatable/muidatatable';
import '../../assets/Css/muidatatable.css'



function ViewMedicamento() {
  
  const [tabla, setTabla] = useState()
  const [dataeditar,setDataEditar] = useState({})

  const [modalNewMedicamento, setModalNewMedicamento] = useState(false)
  const [modaladdcantidad, setModalAddCantidad] = useState(false)
  const [modalupdate, setModalUpdate] = useState(false)
  const [modaldelete, setModalDelete] = useState(false)

  const OpenCloseModalNewMedicamento = () => {setModalNewMedicamento(!modalNewMedicamento)}
  const OpenCloseModalAddCantidad = () => {setModalAddCantidad(!modaladdcantidad)}
  const OpenCloseModalUpdate = () => {setModalUpdate(!modalupdate)}
  const OpenCloseModalDelete = () => {setModalDelete(!modaldelete)}

  const tableData =  () =>{
    const url = 'http://localhost/Farmacia_Alto_Costo/App/Medicamentos/ListMedicamento/table'
    AxiosGet(url,setTabla)
    // const resp = await axios.post(url)
    // const resp_data = await resp.data

    // setTabla(resp_data)

  }

  useEffect(() =>{
    tableData()
  },[])

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
    
    const updateMedicamento = tabla.filter((item) => 
      item.NOMBRE_MEDICAMENTO == data[0]
    )
    console.log(updateMedicamento)
    setDataEditar({
      medicamento : data[0],
      tipomedicamento : data[1],
      componenteprinc : updateMedicamento[0].COMPONENTE_PRINC,
      estatus : updateMedicamento[0].ESTATUS,
      gramos : updateMedicamento[0].UNIDAD_MEDIDA
    })
    OpenCloseModalUpdate()
  }

  // --------------------------------
  // -----------DELETE MEDICAMENTOS-------
  // -------------

  const DeleteMedicamento = (data) =>{
    BodyDelete(data[0],tableData)
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
      name : 'TIPO_MEDICAMENTO',
      label : 'TIPO DE MEDICAMENTO',
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
      name : 'COMPONENTE_PRINC',
      label : 'COMPONENTE PRINCIPAL',
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
                  <div className="celdas_data">
                    <IconButton aria-label="editicon" color='info' onClick={() => UpdateMedicamento(transf_obj)}>
                        <EditIcon />
                    </IconButton>
                    <IconButton aria-label="deleteicon" color='error' onClick={() => DeleteMedicamento(transf_obj)}>
                        <DeleteForeverIcon />
                    </IconButton>
                  </div>

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
                tipmedicamento={dataeditar.tipomedicamento}
                componenteprinc={dataeditar.componenteprinc}
                estatus={dataeditar.estatus}
                gramos={dataeditar.gramos}
                tableData={tableData}
              />
            }
          />
        </Box>
        
        {/* --------------------------------------------- */}
        {/* --------------opciones de medicamentos(menu acordeon) --------- */}
        {/* ------------------------------------------------ */}
        <Box className='Acorden_menu' sx={{mt:'1rem'}}>
          <Button variant="contained" color="error" startIcon={<AddCircleOutlineSharpIcon />} onClick={AddMedicamento} >
            Registrar Medicamento
          </Button>
           
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

export default ViewMedicamento
