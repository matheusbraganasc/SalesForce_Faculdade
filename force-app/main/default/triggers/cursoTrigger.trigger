trigger cursoTrigger on Curso__c (before insert) {
    // Busca um professor com o nome 'Coordenação Geral' ou cria um temporário em memória
    // para ser inserido caso não exista. Como estamos em before insert, podemos atribuir
    // o Id se já existir ou criar um novo Professor__c e inserir antes de atribuir.

    // Primeiro, verifica se já existe algum curso sem professor
    List<Curso__c> cursosSemProfessor = new List<Curso__c>();
    for (Curso__c c : Trigger.new) {
        if (c.Professor__c == null) cursosSemProfessor.add(c);
    }

    if (cursosSemProfessor.isEmpty()) return;

    // Tenta localizar um Professor__c com Name = 'Coordenação Geral'
    Professor__c coord = null;
    List<Professor__c> encontrados = [SELECT Id, Name FROM Professor__c WHERE Name = 'Coordenação Geral' LIMIT 1];
    if (!encontrados.isEmpty()) {
        coord = encontrados[0];
    } else {
        // Cria um Professor__c record na transação para ser inserido
        coord = new Professor__c(Name = 'Coordenação Geral');
        try {
            insert coord;
        } catch (DmlException e) {
            // Se a inserção falhar por qualquer motivo, apenas logamos e não bloqueamos a operação
            System.debug('Não foi possível criar Professor Coordenação Geral: ' + e.getMessage());
            coord = null;
        }
    }

    if (coord != null) {
        for (Curso__c c : Trigger.new) {
            if (c.Professor__c == null) {
                c.Professor__c = coord.Id;
            }
        }
    }
}
