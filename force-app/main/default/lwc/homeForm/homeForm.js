import { LightningElement, track, wire } from 'lwc';

export default class HomeForm extends LightningElement {
    professorId

    handleProfessorSelecionado(event) {
        this.professorId = event.detail.recordId;
        this.dispatchEvent(new CustomEvent('professorselecionaso', {
            detail: { professorId: this.professorId }
        }));
    }
}