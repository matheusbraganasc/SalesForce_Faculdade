import { LightningElement, api, wire, track } from 'lwc';
import getCursosEAlunos from '@salesforce/apex/homeController.getCursosEAlunos';
export default class HomeList extends LightningElement {
    @api professorId;
    @track cursos = [];
    @track error;

    columnsCursos = [
        { label: 'Curso', fieldName: 'Name' }
    ];

    columnsAlunos = [
        { label: 'Aluno', fieldName: 'Name' },
        { label: 'Status', fieldName: 'Status__c' }
    ];

    @wire(getCursosEAlunos, { professorId: '$professorId' })
    wiredCursos({ data, error }) {
        if (data) {
            this.cursos = data.filter(curso => curso.Students__r && curso.Students__r.length > 0);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.cursos = [];
            console.error('Erro ao buscar cursos', error);
        }
    }

    get hasCursos() {
        return this.cursos && this.cursos.length > 0;
    }
}
