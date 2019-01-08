  <%@page import="beans.Patient"%>
<%  
     out.println(new Patient().getListPatient(request.getParameter("nompatient"), request.getParameter("action")));
   // out.println(new Patient().getListPatient(request.getParameter("Nomtable"), request.getParameter("action")));
%>


<script>
    $(function (){
         $('.btn-modifier-patient').click(function (){
             // alert('type av = '+$('#txt-op-patient').val());
             $('#head-modal-patient').text('MODIFIER PATIENT');
            $('#txt-op-patient').val('2');
            //alert('type ap = '+$('#txt-op-patient').val()+' modal head = '+$('#head-modal-patient').text());
               //createPatient('o',$('#txt-op-patient').val(),$('#txt-id-type-patient').val());
            });
    });
</script>