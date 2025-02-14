import globals from 'globals';
import pluginJs from '@eslint/js';
import pluginJest from 'eslint-plugin-jest';
import pluginReact from 'eslint-plugin-react';
import eslintConfigPrettier from 'eslint-config-prettier';

export default [
  {
    ignores: [
      '**/node_modules',
      '**/.git',
      '**/target',
      '**/build',
      '**/logs',
      'docs/generated',
      'coverage',
    ],
  },
  { languageOptions: { globals: globals.browser } },
  pluginJs.configs.recommended,
  {
    files: ['frontend/**'],
    ...pluginReact.configs.flat.recommended,
  },
  {
    files: ['frontend/**/__tests__/**'],
    ...pluginJest.configs['flat/recommended'],
    settings: {
      jest: {
        version: 27,
      },
    },
  },
  eslintConfigPrettier,
];
