import { LightningElement, wire, track } from 'lwc';
import getCursos from '@salesforce/apex/ProfessorController.getCursos';

export default class ProfList extends LightningElement {
    @track cursos = [];
    columns = [
        { label: 'Nome do Curso', fieldName: 'Name' },
        { label: 'Professor', fieldName: 'ProfessorName' }
    ];

    @wire(getCursos)
    wiredCursos({ data, error }) {
        if (data) {
            this.cursos = data.map(curso => ({
                Id: curso.Id,
                Name: curso.Name,
                ProfessorName: curso.Professor__r ? curso.Professor__r.Name : 'Sem professor'
            }));
        } else if (error) {
            console.error('Erro ao buscar cursos:', error);
        }
    }

    get hasCursos() {
        return this.cursos && this.cursos.length > 0;
    }
}