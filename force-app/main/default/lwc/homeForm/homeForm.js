import { LightningElement, track } from 'lwc';
import getProfessores2 from '@salesforce/apex/homeController.getProfessores2';
import getCursosDeProfessor from '@salesforce/apex/homeController.getCursosDeProfessor';
import getAlunosDeCurso from '@salesforce/apex/homeController.getAlunosDeCurso';

export default class HomeForm extends LightningElement {
    @track professorOptions = [];
    @track cursoOptions = [];
    @track alunos = [];
    
    selectedProfessor = '';
    selectedCurso = '';
    /*eu não aguento mais*/
    columns = [
        { label: 'Nome', fieldName: 'Name' },
    ];

    connectedCallback() {
        this.loadProfessores();
    }

    async loadProfessores() {
        try {
            const result = await getProfessores2();
            this.professorOptions = result.map(prof => ({
                label: prof.Name,
                value: prof.Id
            }));
        } catch (error) {
            console.error('Erro ao buscar professores', error);
        }
    }

    async handleProfessorChange(event) {
        this.selectedProfessor = event.detail.value;
        this.selectedCurso = '';
        this.cursoOptions = [];
        this.alunos = [];

        try {
            const result = await getCursosDeProfessor({ professorId: this.selectedProfessor });
            this.cursoOptions = result.map(curso => ({
                label: curso.Name,
                value: curso.Id
            }));
        } catch (error) {
            console.error('Erro ao buscar cursos', error);
        }
    }

    async handleCursoChange(event) {
        this.selectedCurso = event.detail.value;
        this.alunos = [];

        try {
            const result = await getAlunosDeCurso({ cursoId: this.selectedCurso });
            this.alunos = result;
        } catch (error) {
            console.error('Erro ao buscar alunos', error);
        }
    }
}