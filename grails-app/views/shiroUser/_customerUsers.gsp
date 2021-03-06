<hr/>
<h2><g:message code="shiroUser.label" default="User" /></h2>
<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<g:each in="${contract?.customer?.shiroUsers?.toArray()?.sort{it.id}}" status="i" var="shiroUser">
  <g:form>
    <table>
      <g:hiddenField name="id" value="${shiroUser?.id}" />
      <g:hiddenField name="contract.id" value="${contract?.id}" />
      <g:hiddenField name="version" value="${shiroUser?.version}" />
      <tr>
        <th align="left"><g:message code="shiroUser.salutation.label" default="country" /></th>
      <th align="left"><g:message code="shiroUser.firstname.label" default="firstname" /></th>
      <th align="left"><g:message code="shiroUser.lastname.label" default="lastname" /></th>
      <th align="left"><g:message code="shiroUser.email.label" default="email" /></th>
      <th align="left"><g:message code="shiroUser.birthday.label" default="birthday" /></th>
      <th align="left"><g:message code="shiroUser.mac.label" default="mac" /></th>
      </tr>
      <tr>
        <td><input type="text" id="salutation" name="salutation" size="10" value="${shiroUser?.salutation}" /></td>
        <td><input type="text" id="firstname" name="firstname" size="20" value="${shiroUser?.firstname}" /></td>
        <td><input type="text" id="lastname" name="lastname" size="20" value="${shiroUser?.lastname}" /></td>
        <td><input type="text" id="email" name="email" size="20" value="${shiroUser?.email}" /></td>
        <td><g:datePicker precision="day" name="birthday" value="${shiroUser?.birthday}" defaultValue="${new Date()}" /></td>
      <td><input type="text" id="mac" name="mac" size="20" value="${shiroUser?.mac}" /></td>
      </tr>
      <tr>
        <th align="left"><g:message code="shiroUser.occupation.label" default="occupation" /></th>
      <th align="left"><g:message code="shiroUser.telMobile.label" default="telMobile" /></th>  
      <th align="left"><g:message code="shiroUser.twitterName.label" default="twitterName" /></th>
      <th align="left"><g:message code="shiroUser.facebookName.label" default="facebookName" /></th>
      <th align="left"><g:message code="shiroUser.password.label" default="password" /></th>
      <th align="left"><g:message code="shiroUser.optOutIamHereFunction.label" default="no I'm here" /></th>
      </tr>

      <tr>
        <td><input type="text" id="occupation" name="occupation" size="20" value="${shiroUser?.occupation}" /></td>
        <td><input type="text" id="telMobile" name="telMobile" size="20" value="${shiroUser?.telMobile}" /></td>
        <td><input type="text" id="twitterName" name="twitterName" size="20" value="${shiroUser?.twitterName}" /></td>
        <td><input type="text" id="facebookName" name="facebookName" size="20" value="${shiroUser?.facebookName}" /></td>
        <td><input type="password" id="password" name="password" size="20" value="" /></td>
        <td><g:checkBox id="optOutIamHereFunction" name="optOutIamHereFunction" value="true" checked="${shiroUser.optOutIamHereFunction}"/></td>
      </tr>
      <tr>
        <td colspan="4">
          <span class="button"><g:submitToRemote update="shiroUserAdd" class="save" action="shiroUserUpdate" controller="shiroUser" name="shiroUserupdate" value="${g.message(code:'default.button.update.label')}" /></span>
          <span class="button"><g:submitToRemote update="shiroUserAdd" class="shiroUserRemove" action="shiroUserRemove" controller="shiroUser" name="shiroUserRemove" value="${g.message(code:'default.button.delete.label')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </td>
      </tr>
    </table>
  </g:form>
</g:each>
<g:form>
  <table>
    <g:hiddenField name="id" value="${shiroUser?.id}" />
    <g:hiddenField name="contract.id" value="${contract?.id}" />
    <g:hiddenField name="version" value="${shiroUser?.version}" />
    <tr>
      <th align="left"><g:message code="shiroUser.salutation.label" default="country" /></th>
    <th align="left"><g:message code="shiroUser.firstname.label" default="firstname" /></th>
    <th align="left"><g:message code="shiroUser.lastname.label" default="lastname" /></th>
    <th align="left"><g:message code="shiroUser.email.label" default="email" /></th>
    <th align="left"><g:message code="shiroUser.birthday.label" default="birthday" /></th>
    <th align="left"><g:message code="shiroUser.mac.label" default="mac" /></th>
    </tr>

    <tr>
      <td><input type="text" id="salutation" name="salutation" size="10" value="" /></td>
      <td><input type="text" id="firstname" name="firstname" size="20" value="" /></td>
      <td><input type="text" id="lastname" name="lastname" size="20" value="" /></td>
      <td><input type="text" id="email" name="email" size="20" value="" /></td>
      <td><g:datePicker precision="day" name="birthday" defaultValue="${new Date()}" /></td>
    <td><input type="text" id="mac" name="mac" size="20" value="${shiroUser?.mac}" /></td>
    </tr>

    <tr>
      <th align="left"><g:message code="shiroUser.occupation.label" default="occupation" /></th>
    <th align="left"><g:message code="shiroUser.telMobile.label" default="telMobile" /></th>
    <th align="left"><g:message code="shiroUser.twitterName.label" default="twitterName" /></th>
    <th align="left"><g:message code="shiroUser.facebookName.label" default="facebookName" /></th>
    <th align="left"><g:message code="shiroUser.password.label" default="password" /></th>
    <th align="left"><g:message code="shiroUser.optOutIamHereFunction.label" default="no I'm here" /></th>
    </tr>

    <tr>
      <td><input type="text" id="occupation" name="occupation" size="20" value="" /></td>
      <td><input type="text" id="telMobile" name="telMobile" size="20" value="" /></td>
      <td><input type="text" id="twitterName" name="twitterName" size="20" value="" /></td>
      <td><input type="text" id="facebookName" name="facebookName" size="20" value="" /></td>
      <td><input type="password" id="password" name="password" size="20" value="" /></td>
      <td><g:checkBox id="optOutIamHereFunction" name="optOutIamHereFunction" value="false" /></td>
    </tr>
    <tr>
      <td colspan="4">
        <span class="button"><g:submitToRemote update="shiroUserAdd" class="shiroUserAdd" action="shiroUserAdd" controller="shiroUser" name="add" value="${g.message(code:'default.button.add.label')}" /></span>
      </td>
    </tr>
  </table>
</g:form>

