<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h1>API Test</h1>
<div id="test-results"></div>

<script>
  const testCases = [
    { name: "Without 'Authorization' header", headers: {} },
    { name: "With non-Basic scheme", headers: { 'Authorization': 'Bearer token' } },
    { name: "Correct with login '234' and password '123'", headers: { 'Authorization': 'Basic ' + btoa('234:123') } }
  ];
  function runTests() {
    const resultDiv = document.getElementById('test-results');
    resultDiv.innerHTML = '';
    testCases.forEach(testCase => {
      fetch('/auth', { headers: testCase.headers }).then(response => response.json())
              .then(data => {
                const resultElement = document.createElement('div');
                resultElement.innerHTML = `
                        <h3>${testCase.name}</h3>
                        <pre ${isExpectedResult(testCase, data) ? 'class="success"' : 'class="error"'}>
                            ${JSON.stringify(data, null, 2)}
                        </pre>
                    `;
                resultDiv.appendChild(resultElement);
              }).catch(error => {
        console.error('Error:', error);
      });
    });
  }
  function isExpectedResult(testCase, data) {
    if (testCase.name === "Without 'Authorization' header")
      return data.code === 401 && data.status === 'error' && data.data === 'Authorization header not found';
    else if (testCase.name === "With non-Basic scheme")
      return data.code === 400 && data.status === 'error' && data.data.includes('Invalid Authorization scheme');
    else if (testCase.name === "Correct with login '234' and password '123'")
      return data.code === 200 && data.status === 'success' && data.data === '234:123';
    return false;
  }
  runTests();
</script>
<style>
  .success { color: green; }
  .error { color: red; }
  pre { white-space: pre-wrap; }
</style>