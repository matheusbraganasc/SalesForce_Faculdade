import { LightningElement, track, wire } from 'lwc';
import getProfessores from '@salesforce/apex/ProfessorController.getProfessores';

export default class ProfList extends LightningElement {
    @track data = [];
    @track columns = [
        {
            type: 'text',
            fieldName: 'Name',
            label: 'Professor / Curso'
        }
    ];

    @wire(getProfessores)
    wiredProfessores({ error, data }) {
        if (data) {
            this.data = data.map(prof => {
                return {
                    Id: prof.Id,
                    Name: prof.Name,
                    _children: prof.Cursos__r ? prof.Cursos__r.map(c => ({
                        Id: c.Id,
                        Name: c.Name
                    })) : []
                };
            });
        } else if (error) {
            console.error('Erro ao carregar professores:', error);
        }
    }
}