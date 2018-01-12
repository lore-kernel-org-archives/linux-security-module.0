From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 12 Jan 2018 10:33:10 -0500
Subject: [PATCH 2/2] ima: turn on force option for FUSE in builtin policies
In-Reply-To: <7a89ce9a7b8264f83fa5d61e146c01571017cca0.1515682581.git.dongsu@kinvolk.io>
References: <cover.1515682581.git.dongsu@kinvolk.io>
	<7a89ce9a7b8264f83fa5d61e146c01571017cca0.1515682581.git.dongsu@kinvolk.io>
Message-ID: <1515771190.3420.144.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fddef8f8..8de40d85 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -127,6 +127,7 @@ static struct ima_rule_entry default_measurement_rules[] __ro_after_init = {
>  	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
>  	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
>  	{.action = MEASURE, .func = POLICY_CHECK, .flags = IMA_FUNC},
> +	{.action = MEASURE, .fsmagic = FUSE_SUPER_MAGIC, .flags = IMA_FSMAGIC | IMA_FORCE},
>  };

Depending on the ordering of the policies and the number of "actions",
this works. ?It also matches all hooks, not only those in the
default_measurement_rule policy.

Although the rules are walked sequentially, there is an optimization
in ima_match_rules(), which ends walking the list early, as soon as
the last "action" rule is matched. ?Look at "actmask".

>  static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
> @@ -154,6 +155,7 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
>  	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .fowner_op = &uid_eq,
>  	 .flags = IMA_FOWNER | IMA_DIGSIG_REQUIRED},
>  #endif
> +	{.action = APPRAISE, .fsmagic = FUSE_SUPER_MAGIC, .flags = IMA_FSMAGIC | IMA_FORCE},
>  };
> 
>  static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {

This rule applies to the secure-boot rules as well. ?(How likely is it
to load a kernel module, kexec from a fuse filsystem?) ?However, after
replacing the builtin policies with a custom policy, the custom policy
might not contain the requirement to re-appraise fuse files.

With the "lockdown" patches, booting with secure-boot enabled, and
after loading a custom policy, the "secure-boot" rules are still
enabled. ?But now if the custom policy does not require fuse files to
be re-appraised, the secure boot rules will not require fuse files to
be re-appraised either.

This patch is simple and straight forward. ?It would be nice if it
worked in all cases. ?Unfortunately, there are a number of situations,
as described, that will not work.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
