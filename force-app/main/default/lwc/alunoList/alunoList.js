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
        { label: 'Professor', fieldName: 'ProfessorName' }
    ];

    @wire(getAlunos, { statusMatricula: '$Status' })
    wiredAlunos(result) {
        this.wiredAlunosResult = result;
        if (result.data) {
            this.alunos = result.data.map(a => ({
                ...a,
                ProfessorName: a.Teacher__r ? a.Teacher__r.Name : ''
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