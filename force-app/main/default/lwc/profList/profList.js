import { LightningElement, wire, track } from 'lwc';
import getProfessores from '@salesforce/apex/ProfessorController.getProfessores';
import getCursos from '@salesforce/apex/ProfessorController.getCursos';

export default class ProfList extends LightningElement {
    @track professores = [];
    columns = [
        { label: 'Nome do Professor', fieldName: 'Name' },
        { label: 'Curso', fieldName: 'Professor' } 
    ];

    @wire(getProfessores)
    wiredProfessores({ data, error }) {
        if (data) {
            this.professores = data.map(prof => ({
                Id: prof.Id,
                Name: prof.Name
            }));
        } else if (error) {
            console.error('Erro ao buscar professores:', error);
        }
    }

    @wire (getCursos)
    wiredCursos({ data, error }) {
        if (data) {
            this.cursos = data.map(curso => ({
                Id: curso.Id,
                NameC: curso.Name,
                Professor: curso.Professor__r ? curso.Professor__r.Name : 'Nenhum curso'
            }));
        } else if (error) {
            console.error('Erro ao buscar cursos:', error);
        }
    }

    get hasProfessores() {
        return this.professores && this.professores.length > 0;
    }
}