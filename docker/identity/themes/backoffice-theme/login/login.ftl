<!-- Keycloak uses Apache Freemarker templates to generate HTML and render pages. -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${msg("loginTitle")}</title>
    <link rel="stylesheet" href="${url.resourcesPath}/style.css">
</head>

<body>
    <!-- MOUNT TO REACT -->
    <div id="root"></div>

    <script>
      window.__KEYCLOAK_CONTEXT__ = {
        actionUrl: "${url.loginAction}"
      };
    </script>

    <script type="module" src="${url.resourcesPath}/authentication.js"></script>
</body>
</html>