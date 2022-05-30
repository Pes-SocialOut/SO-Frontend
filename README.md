## Team Members

| Name | GitHub username | Taiga username |
| --- | --- | --- |
| Franco Acevedo | frAC07 | frac07 |
| Laura Álvarez | Lauv0x | lauv0x |
| Guillem García | GuillemGarciaDev | Guillem20 |
| Francesc Holly | CescHolly | cescholly |
| Weijie Liu | WeijieLiu1 | WeijieLiu |
| Víctor Muñoz | tipeXwins | tipexwins |
| Manuel Navid | learningbizz | learningbizz |
| Adrián Villar | Avillar0211 | avillar0211 |

# SO-Frontend

A new Flutter project to build the mobile app.

## Getting Started
Algunos links interesantes para entender el proyecto:

- [🖥️  Flutter installation on Windows 10](https://www.youtube.com/watch?v=fDnqXmLSqtg&t=709s)
- [📁  Flutter Directory Structure:](https://medium.com/flutter-community/scalable-folder-structure-for-flutter-applications-183746bdc320)
- [⏳ Gitflow Tutorial](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [👁️ Flutter Tutorial and Guide](https://www.youtube.com/watch?v=P2IGQT3BZQo)

## Testing

- [🧪 Testing Guide](https://docs.flutter.dev/testing)

## Miembros actuales de Front End

* Weijie Liu
* Laura Álvarez
* Guillem García

## ✅ Definition of Done (DoD) 

⚠️ Es muy importante seguir estos pasos para no arrastrar errores en producción y asegurar una buena calidad de código.

Cuando acabemos una *feature* es **necesario** verificar que no existen problemas en el código (que cumple con la metodología de Flutter) y que los tests han pasado correctamente.

Para ello, es necesario ejecutar:

```bash
flutter analyze
```

Si el resultado del comando es que no encuentra problemas podemos ejecutar:

```bash
flutter test
```

Si los dos comandos no dan error podemos proceder a realizar merge con la rama **develop** y subir el contenido al repositorio mediante:

```bash
git push origin develop # Alternativamente git push si ya tenéis configuradas las ramas
```

Y eso es todo por ahora! ⭐️
