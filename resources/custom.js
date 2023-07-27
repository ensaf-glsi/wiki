import Reveal from '/reveal/dist/reveal.esm.js'

import RevealNotes from '/reveal/plugin/notes/notes.esm.js';
import RevealMarkdown from '/reveal/plugin/markdown/markdown.esm.js';
import RevealHighlight from '/reveal/plugin/highlight/highlight.esm.js';

Reveal.initialize({
    hash: true,
    // Taille "normale" qui sera utilisé comme ratio
    // width: 960,
    // height: 700,
    width: 1400,
    height: 800,
    // % d'espace vide autour de la présentation
    margin: 0.04,
    // Scale minimum / maximum à appliquer
    minScale: 0.2,
    maxScale: 2.0,

    markdown: {
        smartypants: true
    },
    // Learn about plugins: https://revealjs.com/plugins/
    plugins: [RevealMarkdown, RevealHighlight, RevealNotes]
});
