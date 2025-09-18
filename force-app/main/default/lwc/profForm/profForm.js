import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import criarProfessor from '@salesforce/apex/ProfessorController.criarProfessor';
import criarCurso from '@salesforce/apex/ProfessorController.criarCurso';
import criarProfessorComCurso from '@salesforce/apex/ProfessorController.criarProfessorComCurso';
import getProfessores from '@salesforce/apex/ProfessorController.getProfessores';

export default class ProfForm extends LightningElement {
    @track nomeProfessor = '';
    @track nomeCurso = '';
    @track professorId;

    @wire(getProfessores)
    professores;

    get professorOptions() {
        return this.professores?.data
            ? this.professores.data.map(p => ({ label: p.Name, value: p.Id }))
            : [];
    }

    handleChangeProfessor(event) {
        this.nomeProfessor = event.target.value;
    }

    handleChangeCurso(event) {
        this.nomeCurso = event.target.value;
    }

    handleSelectProfessor(event) {
        this.professorId = event.detail.value;
    }

    criarSomenteProfessor() {
        criarProfessor({ nomeProfessor: this.nomeProfessor })
        .then(id => {
            this.showToast('Sucesso', 'Professor criado com ID: ' + id, 'success');
            this.clearFields();
        })
        .catch(error => this.showError(error));
    }

    criarSomenteCurso() {
        criarCurso({ nomeCurso: this.nomeCurso, professorId: this.professorId })
        .then(id => {
            this.showToast('Sucesso', 'Curso criado com ID: ' + id, 'success');
            this.clearFields();
        })
        .catch(error => this.showError(error));
    }

    criarProfessorECurso() {
        criarProfessorComCurso({ nomeProfessor: this.nomeProfessor, nomeCurso: this.nomeCurso })
        .then(id => {
            this.showToast('Sucesso', 'Professor e Curso criados! Professor ID: ' + id, 'success');
            this.clearFields();
        })
        .catch(error => this.showError(error));
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }

    showError(error) {
        let msg = error?.body?.message || JSON.stringify(error);
        this.showToast('Erro', msg, 'error');
        console.error(error);
    }

    clearFields() {
        this.nomeProfessor = '';
        this.nomeCurso = '';
        this.professorId = null;
    }
}