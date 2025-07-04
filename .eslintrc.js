module.exports = {
  extends: 'standard',
  env: {
    node: true,
    es2021: true
  },
  rules: {
    // We will add custom rules here later
    "semi": ["error", "always"],
    "comma-dangle": ["error", "never"],
    "space-before-function-paren": ["error", "never"]
  }
};
