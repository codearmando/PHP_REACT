import {AxiosDelete } from '../../Helpers/FetchAxios/FetchAxios.jsx'

function BodyDelete(medicamento,presentacion,gramos,tableData) {

    const url = 'http://localhost/Farmacia_Alto_Costo/App/inv_Medicamento/inventario/Delete'
    const medicamentoDelete = {
        medicamento : medicamento,
        gramos : gramos,
        presentacion : presentacion,
    }
    
    console.log(medicamentoDelete)

    AxiosDelete(url,medicamentoDelete,`${medicamento} en ${presentacion} de ${gramos}`,tableData)
    tableData()
 
}

export default BodyDelete