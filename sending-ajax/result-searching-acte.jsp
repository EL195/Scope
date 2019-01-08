  <%@page import="beans.Acte"%>
<%@page import="beans.Patient"%>
<%  
     out.println(new Acte().getListActebyNamebyDomaine(request.getParameter("NomActe"), request.getParameter("CodePatient"), request.getParameter("IDDomaine")));
%>


