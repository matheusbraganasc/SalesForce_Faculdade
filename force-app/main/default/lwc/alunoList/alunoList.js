import { LightningElement, track, wire, api } from 'lwc';
import getAlunos from '@salesforce/apex/AlunoController.getAlunos';
import { refreshApex } from '@salesforce/apex';

export default class AlunoList extends LightningElement {
    @track alunos;
    @track Status = 'Todos';
    wiredAlunosResult;

    get options() {
        return [
            { label: 'Todos', value: 'Todos' },
            { label: 'Ativa', value: 'Ativa' },
            { label: 'Inativa', value: 'Inativa' },
        ];
    }

    columns = [
        { label: 'Nome', fieldName: 'Name' },
        { label: 'Status', fieldName: 'Status__c' },
        { label: 'Curso', fieldName: 'cursoName' },
        { label: 'Registro', fieldName: 'registro' }
    ];

    @wire(getAlunos, { statusMatricula: '$Status' })
    wiredAlunos(result) {
        this.wiredAlunosResult = result;
        if (result.data) {
            this.alunos = result.data.map(a, b => ({
                ...a,
                cursoName: a.curso__r ? a.curso__r.Name : '',

                ...b,
                registro: b.registros__c ? b.registros__c : 'N/A'
            }));
        } else if (result.error) {
            this.alunos = [];
            console.error('Erro ao carregar alunos', result.error);
        }
    }

    handleFilterChange(event) {
        this.Status = event.detail.value;
        refreshApex(this.wiredAlunosResult);
    }

    @api
    refreshList() {
        refreshApex(this.wiredAlunosResult);
    }
}