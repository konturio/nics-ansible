<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName" value="${(register.formData.firstName!'')}" autocomplete="fname" />
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName" value="${(register.formData.lastName!'')}" autocomplete="lname" />
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="email" class="${properties.kcLabelClass!}">${msg("email")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="email" class="${properties.kcInputClass!}" name="email" value="${(register.formData.email!'')}" autocomplete="email" />
                </div>
            </div>

          <#if !realm.registrationEmailAsUsername>
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="username" class="${properties.kcInputClass!}" name="username" value="${(register.formData.username!'')}" autocomplete="username" />
                </div>
            </div>
          </#if>

<div class="form-group">
   <div class="${properties.kcLabelWrapperClass!}">
       <label for="user.attributes.affiliatian" class="${properties.kcLabelClass!}">Affiliation</label>
   </div>
   <div class="${properties.kcInputWrapperClass!}">
           <select id="user.attributes.affiliation" name="user.attributes.affiliation" onchange="filterOrgs()" width="300" class="${properties.kcInputClass!} >
			   <option disabled value=""></option>
			   <option disabled selected="selected" value="">Please choose an Affiliation</option>
			   <#list client.getAttribute('affiliations')?split(",") as affiliation>
				<option value="${affiliation?keep_before("|")}">
                                    ${affiliation?keep_after("|")}
                                </option>
                           </#list>
	                   </select>
   </div>
</div>
<script type="text/javascript">
function filterOrgs () {
  allOrgs = document.getElementsByClassName("nics-org")
  for (i = 0; i < allOrgs.length; i++) {
      allOrgs[i].hidden = true;
  }
  selectedAffiliation = document.getElementById("user.attributes.affiliation").options[document.getElementById("user.attributes.affiliation").selectedIndex].value
"2";
  orgsToUnhide = document.getElementsByClassName("nics-affiliation-" + selectedAffiliation);
  for (j = 0; j < orgsToUnhide.length; j++) {
      orgsToUnhide[j].removeAttribute("hidden");
  }
  document.getElementById("user.attributes.organization").selectedIndex = 0;
}
function validateForm(){                                                                                                                                                                                                                                                          var affiliationValue = document.getElementById("user.attributes.affiliation").value;
  var organizationValue = document.getElementById("user.attributes.organization").value;
  if( affiliationValue === '' || organizationValue ==='') {
     alert("Please choose an Affiliation and Organization");
     return false;
  }                                                                                                                                                                                                                                                                               document.getElementById("kc-register-form").submit();                                                                                                                                                                                                                         }
</script>

<div class="form-group">
   <div class="${properties.kcLabelWrapperClass!}">
       <label for="user.attributes.affiliatian" class="${properties.kcLabelClass!}">Organization</label>
   </div>
<div class="${properties.kcInputWrapperClass!}">
           <select id="user.attributes.organization" name="user.attributes.organization" width="300" class="${properties.kcInputClass!} >
			   <option value=""></option>
			   <option disabled selected="selected" value="">Please choose an Organization</option>
                           <#list client.getAttribute('organizations')?split(",") as organization>
                                <option class="nics-org nics-affiliation-${organization?keep_before("|")}" value="${organization?keep_before_last("|")?keep_after_last("|")}" hidden>
					${organization?keep_after_last("|")}
				</option>
                           </#list>
                           </select>



   </div>
</div>
            <#if passwordRequired>
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('password',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password" class="${properties.kcInputClass!}" name="password" autocomplete="new-password"/>
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('password-confirm',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password-confirm" class="${properties.kcInputClass!}" name="password-confirm" />
                </div>
            </div>
            </#if>

            <#if recaptchaRequired??>
            <div class="form-group">
                <div class="${properties.kcInputWrapperClass!}">
                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                </div>
            </div>
            </#if>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="button" value="${msg("doRegister")}" onclick="validateForm()"/>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
