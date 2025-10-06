// Script Apex anônimo para testar notificação de professor e atualização de Qtd_Alunos__c
// Passos:
// 1) Cria um Professor__c com email Prof_Email__c
// 2) Cria um Curso__c vinculado ao professor
// 3) Cria 2 Aluno__c ativos (Status__c = 'Ativa') vinculados ao Curso
// 4) Atualiza 1 Aluno para Status__c = 'Inativa' e verifica via debug a chamada do trigger
// 5) Exibe Qtd_Alunos__c do Curso antes e depois

// Observação: ajustar nomes de campos/valores se seus labels/API names forem diferentes.

// Cleanup (em caso de rerun): remover registros criados por Name prefix 'TEST-'
List<Professor__c> oldProf = [SELECT Id FROM Professor__c WHERE Name LIKE 'TEST-%'];
if(!oldProf.isEmpty()) delete oldProf;
List<Curso__c> oldCurso = [SELECT Id FROM Curso__c WHERE Name LIKE 'TEST-%'];
if(!oldCurso.isEmpty()) delete oldCurso;
List<Aluno__c> oldAluno = [SELECT Id FROM Aluno__c WHERE Name LIKE 'TEST-%'];
if(!oldAluno.isEmpty()) delete oldAluno;

// 1) Criar professor
Professor__c prof = new Professor__c(Name = 'TEST-Prof', Prof_Email__c = 'prof.test@example.com');
insert prof;
System.debug('Professor criado: ' + prof.Id + ' email=' + prof.Prof_Email__c);

// 2) Criar curso
Curso__c curso = new Curso__c(Name = 'TEST-Curso', Professor__c = prof.Id, Qtd_Alunos__c = 0);
insert curso;
System.debug('Curso criado: ' + curso.Id);

// 3) Criar 2 alunos ativos
Aluno__c a1 = new Aluno__c(Name = 'TEST-Aluno-1', Status__c = 'Ativa', Curso__c = curso.Id);
Aluno__c a2 = new Aluno__c(Name = 'TEST-Aluno-2', Status__c = 'Ativa', Curso__c = curso.Id);
insert new List<Aluno__c>{a1, a2};

// Recarregar curso e mostrar Qtd_Alunos__c
curso = [SELECT Id, Qtd_Alunos__c FROM Curso__c WHERE Id = :curso.Id];
System.debug('Qtd_Alunos__c após inserção (esperado 2): ' + curso.Qtd_Alunos__c);

// 4) Atualizar 1 aluno para Inativa
a1.Status__c = 'Inativa';
update a1;

// Pequena pausa não necessária em Apex anônimo; apenas recarregar
curso = [SELECT Id, Qtd_Alunos__c FROM Curso__c WHERE Id = :curso.Id];
System.debug('Qtd_Alunos__c após inativar 1 aluno (esperado 1): ' + curso.Qtd_Alunos__c);

// Verificar emails enviados: em uma sandbox, Messaging.sendEmail irá registrar envios; em Production, depende de configurações.
System.debug('Script de teste finalizado. Verifique logs/debug e se aplicável caixa de email do professor (prof.test@example.com).');

// NOTA: Se o trigger enviar emails, as mensagens serão registradas; para checar filas de email, olhe em EmailMessage/Task dependendo da implementação.
