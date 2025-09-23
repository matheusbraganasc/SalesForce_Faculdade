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
            this.cursos = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.cursos = [];
            console.error('Erro ao buscar cursos', error);
        }
    }
}