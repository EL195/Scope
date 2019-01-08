function showNotification(_type,_attr) {

    /**/
    /*exemples de attr
      delay: _delay,
            sound: _withSound,
            img:  'img/notification/2.jpg',,
            position: 'top right',
            title: _title,
            icon: _withIcon,
            size: 'large',
            msg: _msg*/

    /*=====AUTERS ATTRIBUTS============

     taille-> size: 'large',


 animation  ==>   {['fadeInDown','fadeUpDown'],
                  ['fadeInDown','fadeUpDown']
                  ['bounceIn','bounceOut'],
                  ['zoomInUp','zoomInDown'],
                  ['rollIn','rollOut']
                  ['bounceIn','bounceOut']
                  ['bounceIn','bounceOut']}
                  showClass: 'fadeInDown',
                  hideClass: 'fadeUpDown',

    /*==================================*/
    $(function () {
        Lobibox.notify(_type,_attr);
    });
}