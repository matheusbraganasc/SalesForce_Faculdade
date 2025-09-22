import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import criarProfessor from '@salesforce/apex/ProfessorController.criarProfessor';
import criarCurso from '@salesforce/apex/ProfessorController.criarCurso';
import relacionarCursoProfessor from '@salesforce/apex/ProfessorController.relacionarCursoProfessor';
import getProfessores from '@salesforce/apex/ProfessorController.getProfessores';
import getCursos from '@salesforce/apex/ProfessorController.getCursos';


export default class ProfForm extends LightningElement {
    @track nomeProfessor = '';
    @track nomeCurso = '';
    @track professorId;
    @track cursoId;

    @wire(getProfessores)
    professores;

    @wire(getCursos)
    cursos;

    get professorOptions() {
        return this.professores?.data
            ? this.professores.data.map(p => ({ label: p.Name, value: p.Id }))
            : [];
    }

    get cursoOptions() {
        return this.cursos?.data
            ? this.cursos.data.map(c => ({ label: c.Name, value: c.Id }))
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

    handleSelectCurso(event) {
        this.cursoId = event.detail.value;
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
        criarCurso({ nomeCurso: this.nomeCurso })
        .then(id => {
            this.showToast('Sucesso', 'Curso criado com ID: ' + id, 'success');
            this.clearFields();
        })
        .catch(error => this.showError(error));
    }

    relacionar() {
        relacionarCursoProfessor({ professorId: this.professorId, cursoId: this.cursoId })
        .then(() => {
            this.showToast('Sucesso', 'Professor vinculado ao curso!', 'success');
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
        this.cursoId = null;
    }
}