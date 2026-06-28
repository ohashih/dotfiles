import { visit } from 'unist-util-visit';

export function remarkJapaneseBreak() {
  return (tree) => {
    visit(tree, 'text', (node, index, parent) => {
      if (node.value.includes('。')) {
        const parts = node.value.split(/(?<=。)/);
        if (parts.length > 1) {
          const newNodes = [];
          parts.forEach((part, i) => {
            if (part) {
              newNodes.push({ type: 'text', value: part });
              if (i < parts.length - 1) {
                newNodes.push({ type: 'html', value: '<br>' });
              }
            }
          });
          parent.children.splice(index, 1, ...newNodes);
        }
      }
    });
  };
}
