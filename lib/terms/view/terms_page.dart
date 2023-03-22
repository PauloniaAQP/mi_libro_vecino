import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsAndPrivacyPage extends StatelessWidget {
  const TermsAndPrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const data = '''
# TÉRMINOS Y CONDICIONES DE USO MI LIBRO VECINO

Los términos y condiciones regulan el uso del servicio ofrecido por la aplicación web de propiedad de la empresa Paulonia S.A.C, en adelante “LA EMPRESA”,  denominada "Mi libro vecino” en adelante, la "APLICACIÓN WEB".
La APLICACIÓN WEB está dirigida a personas que deseen pertenecer a la comunidad de intercambio y préstamo de libros, búsqueda de bibliotecas cercanas, etc.
Al permanecer en la aplicación web usted acepta, sin reservas, todas las disposiciones contenidas en el presente, así como en cualquier otro aviso legal o condiciones que las sustituyan, complementen y/o modifiquen que puedan encontrarse en la APLICACIÓN WEB. Si no acepta estos términos y condiciones, por favor, no utilice la APLICACIÓN WEB.
&nbsp;
&nbsp;
## PRIMERO. Cambios y actualizaciones

LA EMPRESA se reserva el derecho de modificar o suspender, temporal o permanentemente, en cualquier momento y sin previo aviso, LA APLICACIÓN WEB. Sin que ello genere derecho a reclamo o indemnización alguna a favor del usuario.

## SEGUNDO.  De la exactitud, precisión y actualidad de la información contenida	  

LA EMPRESA aclara que la información aquí expuesta podría no ser exacta, completa ni actualizada y que,  LA APLICACIÓN WEB solo es un instrumento de concentración de información proporcionada por y para usuarios. Toda la información contenida no debe utilizarse como la única base para tomar decisiones. Confiar en este material será bajo responsabilidad y riesgo de quien la utilice. Convenimos que es su responsabilidad vigilar los cambios y actualizaciones.
      
## TERCERO. Seguridad y privacidad

La información que se registre a través de formularios para completar datos en LA APLICACIÓN WEB se regirá de conformidad con el siguiente texto. En ese sentido, como usuario de este sitio web, le informamos sobre el uso que le damos a los datos que registre en el mismo, a fin que pueda decidir si quiere ingresar sus datos o no.	

Al registrar sus datos usted consciente y voluntariamente suministra dicha información a LA EMPRESA. Los datos registrados serán objeto de tratamiento automatizado e incorporados a las bases de datos de LA EMPRESA, quien es titular y responsable identificada como Paulonia Sociedad Anónima Cerrada con RUC N° 20606121203, con domicilio en Calle 15 de agosto, Mza. 25 Lote 13-A P.J. Alto libertad, Cerro Colorado, Arequipa, Arequipa. 

Es así que, LA EMPRESA se compromete a usar los datos para las siguientes finalidades:  (i) Identificar e individualizar al usuario dentro de la aplicación y así pueda acceder a las funcionalidades que se brindan; (ii)  con fines estadísticos para la medición de calidad  y mejora de la experiencia para el Usuario. En ese sentido, LA EMPRESA declara que no utilizará esta información con ningún fin comercial o publicitario, ni con el fin de rastrear o localizar individualmente a sus usuarios.

Estos datos serán almacenados mientras sean necesarios para cumplir con las finalidades anteriormente descritas y únicamente serán usados para los fines aquí descritos. LA EMPRESA se compromete a no divulgar sus datos.

Usted podrá ejercer los derechos que la legislación vigente en materia de protección de datos personales los cuales abarcan la información, acceso, actualización, inclusión, rectificación y supresión, de impedir el suministro de sus datos personales, y  oposición al tratamiento, sin justificación previa y sin que se le atribuyan efectos retroactivos. Para ejercerlos, usted debe enviar un correo a central@paulonia.dev  el cual permitirá acreditar el envío y recepción de la solicitud.

## QUINTO. Confidencialidad de los datos personales

La privacidad del usuario es muy importante para LA EMPRESA; por consiguiente, esta información es tratada como información confidencial y no será proporcionada a terceros.
Asimismo, garantizamos la absoluta confidencialidad de los mismos y empleamos altos estándares de seguridad conforme a lo establecido en la Ley de Protección de Datos Personales - Ley N° 29733, su Reglamento aprobado por el Decreto Supremo N° 003-2013-JUS (“las normas de protección de datos personales”) y sus modificatorias.

## SEXTO. Usted reconoce y acepta que:

- Ha leído y acepta los términos y condiciones de uso descritos anteriormente
- Al permanecer en la aplicación web  acepta los términos y condiciones de uso. 
- Al registrar sus datos en los formularios de la aplicación web, usted consciente y voluntariamente suministra dicha información a la empresa.
- La aplicación web solo es un instrumento de concentración de información proporcionada por y para usuarios.
- La información expuesta en la aplicación web podría no ser exacta, completa ni actualizada. 
     ''';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 150,
          right: 150,
          top: 30,
          bottom: 30,
      ),
        child: Markdown(
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                .copyWith(textScaleFactor: 1.3),
            data: data,
        ),
      ),
    );
  }
}
