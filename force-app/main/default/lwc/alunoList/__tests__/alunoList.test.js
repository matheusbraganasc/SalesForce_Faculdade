import { createElement } from '@lwc/engine-dom';
import AlunoList from 'c/alunoList';

describe('c-aluno-list', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('should handle filter change and update the selectedStatus', () => {
        const element = createElement('c-aluno-list', {
            is: AlunoList
        });
        document.body.appendChild(element);

        // Simulate a filter change
        const combobox = element.shadowRoot.querySelector('lightning-combobox');
        combobox.dispatchEvent(new CustomEvent('change', { detail: { value: 'Ativa' } }));

        // Verify that the selectedStatus is updated
        expect(element.selectedStatus).toBe('Ativa');
    });

    it('should display the correct status options in the combobox', () => {
        const element = createElement('c-aluno-list', {
            is: AlunoList
        });
        document.body.appendChild(element);

        // Verify that the combobox options are correct
        const combobox = element.shadowRoot.querySelector('lightning-combobox');
        const options = combobox.options;
        expect(options).toHaveLength(3);
        expect(options[0].label).toBe('Todos');
        expect(options[0].value).toBe('Todos');
        expect(options[1].label).toBe('Ativa');
        expect(options[1].value).toBe('Ativa');
        expect(options[2].label).toBe('Inativa');
        expect(options[2].value).toBe('Inativa');
    });
});