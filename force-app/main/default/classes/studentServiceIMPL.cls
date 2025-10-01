public with sharing class studentServiceIMPL implements studentService {
    
    public void validarMatricula(list<Aluno__c> Aluno){

        for (Aluno__c a : Aluno) {
            if (String.valueOf (a.Status__c) == 'Inativa') {
                a.Status__c.addError('Aluno Inativo não pode ser matriculado');
            }
        }

    }
}