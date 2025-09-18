import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import salvarAluno from '@salesforce/apex/AlunoController.salvarAluno';
import getProfessores from '@salesforce/apex/ProfessorController.getProfessores';

export default class AlunoForm extends LightningElement {
    @track nome;
    @track status = 'Ativa';
    @track professorId;

    get options() {
        return [
            { label: 'Ativa', value: 'Ativa' },
            { label: 'Inativa', value: 'Inativa' },
        ];
    }

    @wire(getProfessores)
    wiredProfessores;

    get professores() {
        const { data, error } = this.wiredProfessores || {};
        if (data) {
            return data.map(p => ({
                label: p.Name,
                value: p.Id
            }));
        }
        if (error) {
            console.error('Erro ao carregar professores:', error);
        }
        return [];
    }

    handleFilterNome(e) {
        this.nome = e.target.value;
    }

    handleFilterStatus(e) {
        this.status = e.detail.value;
    }

    handleFilterProfessor(e) {
        this.professorId = e.detail.value;
    }

    salvar() {
        salvarAluno({
            nome: this.nome,
            statusValue: this.status,
            professorId: this.professorId
        })
        .then(id => {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Sucesso',
                message: 'Aluno salvo com ID: ' + id,
                variant: 'success'
            }));
            this.dispatchEvent(new CustomEvent('alunosaved'));
        })
        .catch(error => {
            const msg = error?.body?.message || JSON.stringify(error);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Erro ao salvar',
                message: msg,
                variant: 'error'
            }));
            console.error('Erro ao salvar aluno:', error);
        });
    }
}
