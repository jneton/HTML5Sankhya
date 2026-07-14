const p = location.port === '40172';

document.documentElement.classList.add(p ? 'prd' : 'tst');

// Cria o indicador
const d = document.createElement('div');
d.id = 'snkbanner';
d.textContent = p ? '🔴 AMBIENTE DE PRODUÇÃO' : '🟢 AMBIENTE DE TESTE';

// Estilo
Object.assign(d.style, {
    position: 'fixed',
    top: '0',
    left: '0',
    right: '0',
    width: '100%',
    height: '40px',

    background: p ? 'rgb(58, 3, 255)' : '#0a0',
    color: '#fff',

    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',

    fontSize: '16px',
    letterSpacing: '1px',

    zIndex: '999999',
    boxShadow: '0 2px 6px rgba(0,0,0,.3)',
    whiteSpace: 'nowrap',

    cursor: 'default',

    transition: 'top .25s ease'
});

document.body.appendChild(d);

// Esconde a faixa deixando apenas 4px visíveis
d.addEventListener('mouseenter', () => {
    d.style.top = '-36px';
});

// Quando o mouse voltar ao topo da tela, exibe novamente
document.addEventListener('mousemove', (e) => {
    if (e.clientY <= 4) {
        d.style.top = '0';
    }
});

// Ícone na aba
if (!document.title.startsWith('🔴') && !document.title.startsWith('🟢')) {
    document.title = (p ? '🔴 ' : '🟢 ') + document.title;
}