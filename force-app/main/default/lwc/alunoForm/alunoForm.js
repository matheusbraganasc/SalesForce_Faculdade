import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import salvarAluno from '@salesforce/apex/AlunoController.salvarAluno';
import getCursos from '@salesforce/apex/ProfessorController.getCursos';
import criarCurso from '@salesforce/apex/ProfessorController.criarCurso';
export default class AlunoForm extends LightningElement {
    @track nome;
    @track status = 'Ativa';
    @track cursoId;
    @track registroNumero;
    @track nomeCurso = '';

    @wire(getCursos)
        cursos;

    get options() {
        return [
            { label: 'Ativa', value: 'Ativa' },
            { label: 'Inativa', value: 'Inativa' },
        ];
    }

    get cursoOptions() {
        return this.cursos?.data
            ? this.cursos.data.map(c => ({ label: c.Name, value: c.Id }))
            : [];
    }

    handleFilterNome(event) {
        this.nome = event.target.value;
    }

    handleFilterStatus(event) {
        this.status = event.detail.value;
    }

    handleFilterRegistroNumero(event) {
        this.registroNumero = event.target.value;
    }

    handleSelectCurso(event) {
        this.cursoId = event.detail.value;
    }

    salvar() {
        salvarAluno({
            nome: this.nome,
            statusValue: this.status,
            cursoId: this.cursoId,
            registroNumero: this.registroNumero
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
