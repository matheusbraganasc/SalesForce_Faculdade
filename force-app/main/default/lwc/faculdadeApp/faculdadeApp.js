import { LightningElement } from 'lwc';

export default class FaculdadeApp extends LightningElement {
    handleAlunoSaved() {
        this.refs.alunoList.refreshList();
    }
}