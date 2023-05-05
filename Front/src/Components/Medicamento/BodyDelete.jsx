import {AxiosDelete } from '../../Helpers/FetchAxios/FetchAxios.jsx'

function BodyDelete(medicamento,tableData) {

    const url = 'http://localhost/Farmacia_Alto_Costo/App/Medicamentos/Medicamento/Delete'
    const medicamentoDelete = {
        medicamento : medicamento,
    }
    
    console.log(medicamentoDelete)

    AxiosDelete(url,medicamentoDelete,`${medicamento}`,tableData)
    tableData()
 
}

export default BodyDelete