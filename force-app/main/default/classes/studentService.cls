public interface studentService {
    void validarMatricula(list<Aluno__c> Aluno);
    void atualizarQtdAlunosPorCurso(List<Aluno__c> alunos);
    void notificarProfessorAlunoInativo(List<Aluno__c> novos, List<Aluno__c> antigos);
}