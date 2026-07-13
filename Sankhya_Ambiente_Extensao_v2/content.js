const p = location.port === '40172';

document.documentElement.classList.add(p ? 'prd' : 'tst');

// Cria o indicador
const d = document.createElement('div');
d.id = 'snkbanner';
d.textContent = p ? '🔴 AMBIENTE DE PRODUÇÃO' : '🟢 AMBIENTE DE TESTE';

// Estilo
Object.assign(d.style, {
    position: 'fixed',
    left: '0',
    top: '50%',
    transform: 'translateY(-50%)',
    width: '36px',
    height: '400px',
    background: p ? '#c00' : '#0a0',
    color: '#fff',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    fontSize: '14px',
    fontWeight: 'bold',
    zIndex: '999999',
    borderRadius: '0 8px 8px 0',
    boxShadow: '2px 0 6px rgba(0,0,0,.3)',
    cursor: 'default',

    // Texto na vertical
    writingMode: 'vertical-lr',
    textOrientation: 'upright',
    letterSpacing: '2px',
    whiteSpace: 'nowrap'
});

document.body.appendChild(d);

// Ícone na aba
document.title = (p ? '🔴 ' : '🟢 ') + document.title;