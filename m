Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16185260
	for <linux-security-module@vger.kernel.org>; Tue, 15 Jul 2025 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613848; cv=none; b=G0aFQmUPem1K/OZV/JlnSR8FaQhIXRvyRd5lXYFmbLL9z7pTuFUHryN2dCiWKT4Rg0xeh4jnLpsBDhhgLalcsEl0Qw+TXJFVvJP/45OyPmVRTWnRO41jbwuIf7rCSOb1KPEKjhdFqxLeCRxwERoWqPde4deEaikdnmJw3ZU19YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613848; c=relaxed/simple;
	bh=2luvZ3rqiBoEtpoW23pzMDM4/QRB3g6GQcH8HJUQnig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbSoZM1xgZlbS+NhiNXSkhatFkWnOXtLLOP2SNv9HR0Gf3UZy+97d7FETBhZSTq+XEz1ntkSLel5fEc/MlUWRh02ON74tBtT9cY/JmQwNB0Aph8U24CT4qOLooZoe9OjE7w2dy/I5CYEv9fAKBI6FdlgTJBTJwXoPUtpLb2/34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JEd9BpKn; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JEd9BpKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752613845; bh=OApSiV87jIiW0m7oie12+pVRZVLDkiLDCQwZ9GxZu1k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JEd9BpKnA7wjt2VRvLZnNKOmk4iKydzvzj7Fx5GfsbXfKBKQLXxdzFExGqtgU2UuBGFjgJY0y3J6P/2U6SjEpTpHgAORKtiHxWNG+n1/5K61e6K1wSYD7rih3kORaigLthXoYxwQzlZbFims58mkGhb6u+Uy3HoZQXDyh2RTMDBGozNa22wtItpp0BcjPrO5RgLRyna4PVSxuYlr6J0rYIOlS1fJz2uTkz/wgMCbQVWqlAMACo/wKFdUKq9RvTfj44C0jOCV+eFSKOiHsDFFVlQWdg6slD0ixHHUKqkCeMRevj1S7m2ou+fzi8enmZZlE/gd8HMxOgPU8zzaMNHhXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752613845; bh=RmHbfNG8RoTfxhjwMMVPIig1IJqhPCWYw/GBTOg0E1D=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HOwKWfuUw48NTLIzR8HxKPhTh7dLRsGwRYXMSwc6sZ/aEuzOzW5Ub3qq3q3KgcK4KrxNngQcjLKozKEND23mNOC0O3Gr/TPdJBLNA4tB/IzXoymzqGQHltNXUIs2E00CeIcrs53Smdw1jnuXUZm8em8NiF0axkLUEz6MjaUnxc4c0jCeraQDFXRvPjYelv+nvDza5uGtWyGjmS0UvvialPogY0iFBX5YGRt8MYt++hquCRZ1poZXbWAzRO2qZwlXe7mVh7srkqlQiD9uXW3uk7rxvcBatBjBVAWnqJ8sNLiJvrs2Bbs6mZx16MtzM5/rh5RL/h6MLHelcQBRM7F/Rw==
X-YMail-OSG: dl7b3rkVM1kbuOGa.JnDfJaW4C8TiEvPXcUHh9J5BadlHeidVmAdJaw5q.SlOJm
 Ct_lkEIK4zw6_EoKwoayeEmGZwDaZwuNaVG.m_rI52yPkHpcc8mKzaS4E3KR9q2bsdgMBkex3mur
 vzAfUISjSiuAYI8s7wJ631OHc9H01vaAjkVEuppkR8CiUYQCRZWG8Z6UoQi5hO_3bg2HA6ooEb2k
 XUrR62xL_p76nV6gYlocmG1LLxVB_LTMoeAsV.Q0qol7Y4UtR.YblSgQ3xuduMF0VYaYxqVIWXwz
 TwJgFoGSJQmmxxgYNJaDH4DA9aLgsm6cFxKx0SkXeciovIf7AFIzVNotb5zbGR9MGgoRTb_nxY60
 ynZxENoLSKnLbm.mDHRM3YbSkT5x4ZgTOmB4Xz.AF66WGH2C1hviUrRtEBVHvlDm7eDimbBaWPKo
 MhBQU9lrNauvgoEiSqQsyEBSPrZ8Z3W1.R0PEIir4nyjM0gB69W9jx__Tfnzm7mF8cNj8LsQyM_2
 heH9LxiNwt2vQdXzLXGmYiZOKwaoH7jHyEsmRJ_goX5Gt2MRG6qG_45PyqMkwhtSXoRG0qX9T4B8
 Q1vAto0nUfw8NnRwzj55jVNYF1RKCNp_gvZx8vcUZKTLb9YBL2wdaBUNwY906Zh9IjOwwWZGk2DM
 7y.aFOr1T4Z3fhNcYdr.W5ySrBKaR8PBKXjco2D3rXL5sFb29lOQSscfm6wmwsen32MJFqW8GLje
 MJgz3mMwVOEEiGn1cqFp9N50rbdHKpXUcdcrGIBgdnjLf77LXRT.TikvWycI2rMR2escxpzvuiMf
 Zxa8ZkxNzYgCrKqPOHZ69QM.UBMhjIylyh0E3CesWP9s21iAaGCf3eFz1XELY8ErCsJsRnxYrRX5
 3.7SPEFm7BY8QvkEq8yl_6wCuF0EethmBQgY5rPn_VbUALgmo.36trqKqLnNDUwHyjPmw.HmA9zF
 pyIjVGyLIWXiMV7yVyb12Q9AnajGaQHd0YMPTxlUHEjbcboBnIEeCauWMab2ZhKHN54UDmG4NcE6
 EmXhHFUfiz8L.yuMiWBG4OOTSXSGf1NUgt8aivQ8pH73tFNAP61AugpNyi61yio_IsymxxU.BUOo
 3RZjo3p6gPXIeVXITWUCxXFmWlwJ4FNJJ7wuvTAfWxhkRMVxoewy15dLg5OX8MImMSjfSsx7bVpD
 ZgEsN943GiZfRWSjT1zgm1TarHbCTbeOt7WtKUSJnBJEgR_pmdqzlUYB6wAGjnu2QWOhQxMo3v0l
 9WyQItiSBvN1GNs.WAa5gXTuGZhYww0mrZkv.lUPAv0Bfr5QSSF0xDCuLBq80ksj3nfvfudFpiLK
 mmyhMTZPhi_T1IofgFBRY8fMEoGdI64pV2G1DIoYcfiqFUotFX071lV5nK.LL8GfuZVox.7nh5Nk
 eWZ4TFQNRyrLeBBGXA6.cbreWNU_gA8.KgcT.x0jYbRNuo8p88_a4xNt2b2dFPPXJQENa7wDjjK1
 eANhwh2KvDu6xIEpXx5wZqjXhJoivHNVPpxEwEYMRAEz.gAAa3_rUFsRJFgqaEfDwmRnBFXAW2ZD
 _DgRXHLK3baHWxd_Q0MhnkY56fl4qkUrXLXo9sOIZEBUJ3zrhHMSXFRXGwIMtSf7t7SVYNusLPaP
 nNqBUpw.se0TKax6MX4BaqwnzXFf0DtKLFQQjb_GoiXnpGDPUtvz2WOjFvWHBMY3yqrorVmWMWh8
 oGvb41uJuxPLZctCpUnGK839YxlG7Go33JN92Ffihby_f_ThblfKcMTsdWpgQLvGAXHfwhkUuaVK
 _lw066cSB48g2vYsCd55K3rcc.NIxq5RlTSDoyipEV7GJ0EZE81CvRQWeyKQJTcpngbaPDxHlXf6
 JaL2dyVcBDR.EBpYCTZopHiNhiCceccHXU_yqs8CiaGuP3a_KPwXPyU_o7Vh4DMjqAozHa5Siq4D
 NyElc34S.PLGePweuiDvJp0irG6TsXKJbWtBI_UjNfRaDK8q83E03qut1vmEH8mn9MvWHejI5Av4
 wi1ZumypNrpw8pYL64rspQOmGJv.z047vXFHY2C6rMfRJ5raGMtMIuo_VZjJlgI_Rz2FvQFtmXRy
 adtlP5OUmuDMFfhysSnU1ZA9BVSljlCNHqZ.awcd_RyPD8uwvj9O52n___c1m0FpDgKwzI..n4pC
 y2GNyMmDWVSePjfzO5eqqeTvT.mRfDRL_S.Kk0IkHujhhdSKSjpq1f6HU1Td9r02TmwSQUqKLbSU
 1SHahZr1cSfncA4qa9sgvBkB7GkXRRN0QqS_lhiIKbbLMLg5bfyXxBvgRNZXGIhA.1Hr22tgPBbF
 fbaD3ZtLamIpJaLcTKmu8HRs-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c92e579f-d95b-415b-81b9-610dd7e70660
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 15 Jul 2025 21:10:45 +0000
Received: by hermes--production-gq1-74d64bb7d7-4ndhm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e83d77ed7c13adb4e82ac288e4a5ab46;
          Tue, 15 Jul 2025 20:40:20 +0000 (UTC)
Message-ID: <88b13658-1a4c-4ebe-92b4-5be93c9356c9@schaufler-ca.com>
Date: Tue, 15 Jul 2025 13:40:18 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] Audit: Add record for multiple object contexts
To: Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250607005134.10488-5-casey@schaufler-ca.com>
 <88f740c7efa914435e2223e90666c8b2@paul-moore.com>
 <9fcc7e8f-7d5c-4499-9693-787bd7ecc8ed@schaufler-ca.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <9fcc7e8f-7d5c-4499-9693-787bd7ecc8ed@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24149 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/4/2025 1:18 PM, Casey Schaufler wrote:
> On 6/16/2025 1:54 PM, Paul Moore wrote:
>> On Jun  6, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
>>> An example of the MAC_OBJ_CONTEXTS record is:
>>>
>>>     type=MAC_OBJ_CONTEXTS
>>>     msg=audit(1601152467.009:1050):
>>>     obj_selinux=unconfined_u:object_r:user_home_t:s0
>>>
>>> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
>>> the "obj=" field in other records in the event will be "obj=?".
>>> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
>>> multiple security modules that may make access decisions based
>>> on an object security context.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>  include/linux/audit.h      |  7 +++++
>>>  include/uapi/linux/audit.h |  1 +
>>>  kernel/audit.c             | 58 +++++++++++++++++++++++++++++++++++++-
>>>  kernel/auditsc.c           | 45 ++++++++---------------------
>>>  security/selinux/hooks.c   |  3 +-
>>>  security/smack/smack_lsm.c |  3 +-
>>>  6 files changed, 80 insertions(+), 37 deletions(-)
>> ..
>>
>>> diff --git a/kernel/audit.c b/kernel/audit.c
>>> index 0987b2f391cc..451c36965889 100644
>>> --- a/kernel/audit.c
>>> +++ b/kernel/audit.c
>>> @@ -2337,6 +2344,55 @@ int audit_log_task_context(struct audit_buffer *ab)
>>>  }
>>>  EXPORT_SYMBOL(audit_log_task_context);
>>>  
>>> +int audit_log_obj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
>>> +{
>>> +	int i;
>>> +	int rc;
>>> +	int error = 0;
>>> +	char *space = "";
>>> +	struct lsm_context ctx;
>>> +
>>> +	if (audit_obj_secctx_cnt < 2) {
>>> +		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
>>> +		if (error < 0) {
>>> +			if (error != -EINVAL)
>>> +				goto error_path;
>>> +			return error;
>>> +		}
>>> +		audit_log_format(ab, " obj=%s", ctx.context);
>>> +		security_release_secctx(&ctx);
>>> +		return 0;
>>> +	}
>>> +	audit_log_format(ab, " obj=?");
>>> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
>>> +	if (error)
>>> +		goto error_path;
>>> +
>>> +	for (i = 0; i < audit_obj_secctx_cnt; i++) {
>>> +		rc = security_lsmprop_to_secctx(prop, &ctx,
>>> +						audit_obj_lsms[i]->id);
>>> +		if (rc < 0) {
>>> +			audit_log_format(ab, "%sobj_%s=?", space,
>>> +					 audit_obj_lsms[i]->name);
>>> +			if (rc != -EINVAL)
>>> +				audit_panic("error in audit_log_obj_ctx");
>>> +			error = rc;
>> Do we need the same logic as in audit_log_subj_ctx()?
> I seriously debated the issue. Subjects always have data to put in
> the aux record. Objects may or may not, in the AppArmor case. Not having
> a subject context is an error, not having an object context is interesting,
> but not necessarily an error. Hence the different treatment. You can tell
> me I'm wrong, and I'll make them consistent.
>
>>> +		} else {
>>> +			audit_log_format(ab, "%sobj_%s=%s", space,
>>> +					 audit_obj_lsms[i]->name, ctx.context);
>>> +			security_release_secctx(&ctx);
>>> +		}
>>> +		space = " ";
>>> +	}
>>> +
>>> +	audit_buffer_aux_end(ab);
>>> +	return error;
>>> +
>>> +error_path:
>>> +	audit_panic("error in audit_log_obj_ctx");
>>> +	return error;
>>> +}
>>> +
>>>  void audit_log_d_path_exe(struct audit_buffer *ab,
>>>  			  struct mm_struct *mm)
>>>  {
>>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>>> index 322d4e27f28e..0c28fa33d099 100644
>>> --- a/kernel/auditsc.c
>>> +++ b/kernel/auditsc.c
>>> @@ -1098,7 +1098,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>>>  				 char *comm)
>>>  {
>>>  	struct audit_buffer *ab;
>>> -	struct lsm_context ctx;
>>>  	int rc = 0;
>>>  
>>>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>>> @@ -1108,15 +1107,9 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>>>  	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>>>  			 from_kuid(&init_user_ns, auid),
>>>  			 from_kuid(&init_user_ns, uid), sessionid);
>>> -	if (lsmprop_is_set(prop)) {
>>> -		if (security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF) < 0) {
>>> -			audit_log_format(ab, " obj=(none)");
>>> -			rc = 1;
>>> -		} else {
>>> -			audit_log_format(ab, " obj=%s", ctx.context);
>>> -			security_release_secctx(&ctx);
>>> -		}
>>> -	}
>>> +	if (lsmprop_is_set(prop) && audit_log_obj_ctx(ab, prop))
>>> +		rc = 1;
>> We should probably use the return value from audit_log_obj_ctx().
> Sure.

On further inspection, the callers of audit_log_obj_ctx() don't
do anything with the return code, and similar functions have their
returns treated the same way. Unless there's a major rework of the
audit code there isn't any value in "using" the return code.

>>>  	audit_log_format(ab, " ocomm=");
>>>  	audit_log_untrustedstring(ab, comm);
>>>  	audit_log_end(ab);
>> ..
>>
>>> @@ -1780,15 +1756,16 @@ static void audit_log_exit(void)
>>>  						  axs->target_sessionid[i],
>>>  						  &axs->target_ref[i],
>>>  						  axs->target_comm[i]))
>>> -				call_panic = 1;
>>> +			call_panic = 1;
>>>  	}
>>>  
>>>  	if (context->target_pid &&
>>>  	    audit_log_pid_context(context, context->target_pid,
>>>  				  context->target_auid, context->target_uid,
>>>  				  context->target_sessionid,
>>> -				  &context->target_ref, context->target_comm))
>>> -			call_panic = 1;
>>> +				  &context->target_ref,
>>> +				  context->target_comm))
>>> +		call_panic = 1;
>> I appreciate the indent fixes, would you mind pulling this out and
>> submitting them separately?
> Sure.
>
>> --
>> paul-moore.com
