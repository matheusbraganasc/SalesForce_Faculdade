import { LightningElement, track, wire, api } from 'lwc';
import getAlunos from '@salesforce/apex/AlunoController.getAlunos';
import { refreshApex } from '@salesforce/apex';

export default class AlunoList extends LightningElement {
    @track alunos;
    @track Status = 'Todos';
    @track registro = '';
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
            if (Array.isArray(result.data)) {
                console.log('Dados retornados:', result.data);
                this.alunos = result.data.map(a => ({
                    ...a,
                    cursoName: a.curso__r ? a.curso__r.Name : 'Sem curso',
                    registro: a.registros__c ? a.registros__c : 'Sem registro'
                }));
            } else {
                this.alunos = [];
                if (result.error) {
                    console.error('Erro ao carregar alunos', result.error);
                }
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