import { LightningElement, track, wire } from 'lwc';
import getProfessores from '@salesforce/apex/ProfessorController.getProfessores';
import getCursos from '@salesforce/apex/ProfessorController.getCursos';
import getAlunos from '@salesforce/apex/AlunoController.getAlunos';

export default class HomeForm extends LightningElement {
    @track professores = [];
    @track cursos = [];
    @track alunos = [];
    @track selectedProfessorId = '';
    @track selectedCursoId = '';

    alunoColumns = [
        { label: 'Nome', fieldName: 'Name' },
        { label: 'Status', fieldName: 'Status__c' }
    ];

    @wire(getProfessores)
    wiredProfessores({ data, error }) {
        if (data) {
            this.professores = data.map(prof => ({
                label: prof.Name,
                value: prof.Id
            }));
        } else if (error) {
            console.error('Erro ao buscar professores:', error);
        }
    }

    handleProfessorChange(event) {
        this.selectedProfessorId = event.detail.value;
        this.selectedCursoId = '';
        this.alunos = [];
        getCursos()
            .then(result => {
                this.cursos = result.filter(curso => curso.Professor__c === this.selectedProfessorId)
                    .map(curso => ({ label: curso.Name, value: curso.Id }));
            })
            .catch(error => {
                this.cursos = [];
                console.error('Erro ao buscar cursos:', error);
            });
    }

    handleCursoChange(event) {
        this.selectedCursoId = event.detail.value;
        getAlunos({ statusMatricula: 'Todos' })
            .then(result => {
                this.alunos = result.filter(aluno => aluno.Curso__c === this.selectedCursoId);
            })
            .catch(error => {
                this.alunos = [];
                console.error('Erro ao buscar alunos:', error);
            });
    }
}