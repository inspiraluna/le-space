<g:form>
  <g:hiddenField name="id" value="${shiroUser?.id}" />
  <g:hiddenField name="version" value="${shiroUser?.version}" />
  <table cellspacing="2" cellpadding="2">
    <tr>
      <td valign="top">
        <table>
          <tr><th align="left"><g:message code="shiroUser.passwordOld.label" default="PaswordOld" />:</th><td><input type="password" id="password" name="passwordOld" size="20" value="" /></td></tr>
          <tr><th align="left"><g:message code="shiroUser.passwordNew.label" default="PasswordNew" />:</th><td><input type="password" id="password" name="passwordNew" size="20" value="" /></td></tr>
          <tr><th align="left"><g:message code="shiroUser.passwordNewAgain.label" default="PasswordNewAgain" />:</th><td><input type="password" id="password" name="passwordNewAgain" size="20" value="" /></td></tr>
        </table>
      </td>
   </tr>
   <tr><td valign="top" align="left"><g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if></td></tr>
   <tr><th colspan="2" align="center"><span class="button"><g:submitToRemote update="passwordChange" class="passwordChange" action="passwordChange" controller="shiroUser" name="passwordChange" value="${g.message(code:'shiroUser.passwordChangeButton.label')}" /></span></th></tr>
  </table>
</g:form>


