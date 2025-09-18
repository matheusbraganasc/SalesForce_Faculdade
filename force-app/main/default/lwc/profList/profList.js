import { LightningElement, wire, track } from 'lwc';
import getProfessores from '@salesforce/apex/ProfessorController.getProfessores';

export default class ProfList extends LightningElement {
    @track professores = [];
    columns = [
        { label: 'Nome do Professor', fieldName: 'Name' },
        { label: 'Curso', fieldName: 'Curso' } // campo único agora
    ];

    @wire(getProfessores)
    wiredProfessores({ data, error }) {
        if (data) {
            this.professores = data.map(prof => ({
                Id: prof.Id,
                Name: prof.Name,
                Curso: prof.curso__r ? prof.curso__r.Name : 'Nenhum curso'
            }));
        } else if (error) {
            console.error('Erro ao buscar professores:', error);
        }
    }

    get hasProfessores() {
        return this.professores && this.professores.length > 0;
    }
}