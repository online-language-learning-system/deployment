<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${msg("updateProfileTitle")}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${url.resourcesPath}/verifyProfileStyle.css">
</head>

<body>
    <!-- MOUNT TO REACT -->
    <div id="root"></div>

    <script>
      window.__KEYCLOAK_CONTEXT__ = {
        actionUrl: "${url.action!''}"
      };
    </script>

    <script type="module" src="${url.resourcesPath}/verifyProfile.js"></script>
</body>
</html>
