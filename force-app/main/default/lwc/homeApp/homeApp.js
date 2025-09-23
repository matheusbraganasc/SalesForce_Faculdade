import { LightningElement, track } from 'lwc';

export default class HomeApp extends LightningElement {
    @track professorId;

    handleProfessorSelecionado(event) {
        this.professorId = event.detail.professorId;
    }
}