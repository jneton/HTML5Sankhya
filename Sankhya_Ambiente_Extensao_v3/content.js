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
    height: '36px',

    background: p ? '#c00' : '#0a0',
    color: '#fff',

    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',

    height: '40px',
    fontSize: '16px',
    letterSpacing: '1px',

    /*fontSize: '15px',
    fontWeight: 'bold',*/

    zIndex: '999999',
    boxShadow: '0 2px 6px rgba(0,0,0,.3)',
    cursor: 'default',

    whiteSpace: 'nowrap',

    transition: 'opacity .3s ease',
    opacity: '1'
});

// Oculta ao passar o mouse
d.addEventListener('mouseenter', () => {
    d.style.opacity = '0';
});

// Exibe novamente quando o mouse sair
d.addEventListener('mouseleave', () => {
    d.style.opacity = '1';
});

document.body.appendChild(d);

// Ícone na aba
document.title = (p ? '🔴 ' : '🟢 ') + document.title;