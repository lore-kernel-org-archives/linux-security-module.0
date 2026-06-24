Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8138398E
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329814; cv=none; b=ntO7AaQU/w4uHjjIFqAoSrzYjpo/66h9V7PjiaOwhy2uKg+Mrdu9Dbjee92cQo6wufOSF4SHPHMh7RaDJV6lSLOa8qcGGEGweyy4+KyOGpN68D3+8i7q5SlQgrTPGzfYSB9nyRmFWc4HHCPsGO/5XsfgMEquNoEIu1mux3ia3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329814; c=relaxed/simple;
	bh=IKT2Ql0Pr6mJ/zacSja2SCqs/CUu0fI59F6JP6xTkrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaBtDnjzj8ZN05PuMBXcn5ScuqoUD/w0Y6Ff6RDTwhrEE6t/+JYDVY4TcZMGVQwMegyQ/VfHP2m6n8Ja5NXD6RnJmZD/npzt1a/tTYw7JEZ40Y0m5FULr0AaDyFAeTxF+PsY+pLCI/xL/706iMrRtkvp1omg5utAiObKaBMqY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BGllTRi/; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BGllTRi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782329804; bh=0lIZa1tOKO70F8UAJaGC0dySh6fV6FRHbp4YiiZYcxw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BGllTRi/AcHd5ny+Q1YDwuWR0+liklGu0neG9kwt6j8RW7rPTc4+yjHeLB7hnD4/oxIfpD4/xNN1q/B6WRxZNQQIbRePxoyeajoshMiY4vAJuMcwpY+0aFk++kGVl+SE9HPG+gkfd1DwQJhCYO17Z7JzrP74/V05l6osNdh3xoTsi1hMA3d4pmHg/vJzZt+XMk3NEy2SY2d3sZuFVdoKQsEvJ0Z1KZPXoxxrKz4RNA7h+526itvAFVCCRkrG2rpccezEHuKfWlGZ5dwoKm3zQCeC85LAVhC8v5fHL1R7WnaqKvgULE5xXnIlpIbk5q2elmKweH86Ub+BQvjbhNxq3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782329804; bh=sEQp6Yt004zSJYIzSY/D3B6cuWnCe/uFQJnlZ9fTV8y=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YgtRZbtfLxzXHvIUxQfImLQtWhGkSe8yD07vpiNfXyYtc5R+wCW38F200CR7PGbDKjqCv7tDoFEL6JeBfMnp6V7hRjS549OCViBzlsDRQwVsH+PIlQD0Ob5q6usmxO9a0AMjiaw71b2vlot+fyyfUZBr4eN6vnQeyd3KZX0+7pEU5s5nKes1CrHVl6QFeYbTXCAWMaQ1HbAvfvkUEeNVBKRe8+aBW6+3t2NyipFwaPCTMF+mv05qyLb+rNfCg9ItMBbnm6CX8fc1a6FJGenN/6NWD6gbYppbDut27EFI/KdZUM8cSzgEDOluEyXoawyOn2PsoROFo6Q8KafcMHN6ww==
X-YMail-OSG: kWv2h5wVM1mtcf2UoCsQShZX7AXS2nnfnuDnRqthRaQhLxjnopufRU5FTtQ9pmZ
 jAj264Zwy1sCgMojtI_lxaBsq0XwwdifO.BoowfKMfnu.8Gw4xkmmAp_zzSk3logVsC3BEMli1ob
 W7kXV1WX65ICOj7C7I4wjNZt2Fp42WlYAJXlmdEPOFxcpiPWrttcSUq3NlEOgbiFieeU48F_X1Vm
 cjpQ84dgbghqdx0oCdXuT9E3dloI7cJZL5q5K1XnrrlNpztmDnskeURrtkB.HQgOPpceZBVhWFHm
 Z_7RYZ7Lfu2nzKFMA79QWDzCf_NecpS55fnMHJrgjzV9zL0tvV8kEivFqqhw6rPo_Yk1.VKpg6YB
 ph6W9OajPA17jUWQ7GrDQxBtN155mw_VlU9izyxNfUBbzd4M4NS8NnRFMQpgWQtGu2z3gsfu2qmN
 .3sigi9NSFCN8dWee9KKQBnlbVGp200MRCxTmhRAVj_RpVKyvfI9mbyPSYnt6v9y.dGE4mBY_O6v
 VgWf.6NlGsU1tluhxkOYLpXIKwZ72SaMMUqFhpMzn8BHfXTX9D9fYqgiBpy19rBHMe9PqUwOjJaz
 W_qEH1pW4nG9MgjdPyXzmghT1BBf7fhkD4UVK7ffRMpF4bUS8fHD8rOcEM8CKkZCVGFwMX67wSIj
 k0vqohoYpxm7KglMT8a9PETUd1ZDCj9y19aJDxpd20dNLrNlJyaCOQUdyZ36GM1MbjEAGNMNMrKg
 LXoHqjLMfDv7q5pSjyJsPUkwXqnkNywHXHFtsrrNH3etw_NfyRS8GvDGq9m5mqvJgp4fdu.HUwvE
 GdjTDFSlK3pPCTWlumjyht5NqG4kDzIA75LmKn0vxme094EMILq3PUn7RXdvUfPdjFe7hyldLiI3
 fVNtQjw4KoXA99WyPh16R4xbIEcQTgBZQtPbeCzMKe9g8fjyEF5QEAZVlYp6yvvYF6_ZXCtJfhYz
 W4roobwTxhOLXl9YDYzrQi2rzH1kP0HP7YZPKQndGkCeHJwIqB0SGy9eTj99AsjnAztEovOH3bjF
 RXZTHqQDTTpWl9eEV7Es0nCEYICsIN4CpP8_Chbw_rPYSGICdXuck3X9CwEdSNYcacBNQ8cuQ4t8
 iswUAs.Yafw_jzMdFKLFFaTM1rGbGcAJ2E7T.q6LWG6QcOub6xoFk_cAdt_qG7A.78YLxbQOSm4H
 jYbtSSPcq3iVHo1eIz8CN1DK2kSqtfnYDZFaMChhqbz7MKmt.1lmL0oTzbLR_Tw_DtqMHlLD7cId
 shidpyAVRta8rmP0mTMQan_Fy43IDdI_8Z7vCVDuswp04dO6Tep.lxYQGHUm8NSPv_dMwtV8xb4Z
 7SVPiqep1nOgKT0ddVQjmoCSuXQfVD0UmCONSEbsPSBgZhYIJELzhcy8aeIjfqRN9U8vMHBWjiVm
 0ZpA3RV1D3t_8a.9O_P6XuCDP3K2FSfSx1S9U32852hDDhu0NCYxGZXLqaKiW6fBUBSdFzw3KxQh
 guBDtE8YXRz5u7o9robg5lWeWEilSobqrTMsUStSx6RhOpHS6nIK6FcBBWVSD0RJUIgge1RsbiSH
 MMHbMneFi7cv.yzw_HdI2I.Cw5HyVXGk1tQ63dhrtynp.dLW9zYuUftgL55Ea35O8V8iLJXgvT3F
 rMbJyzx8BxJp8g8eK9Xy7yn7YMLQuSyDRKpYH5._BdF3.Cyq9anFRi2ibirFyFMcV4SbWTL_zdY2
 zU3IHwqcRHl2OjFWlrLkH1M76Gf.FzY6Zpy00eARVzcRqNloPk6a44XgwkZ5EdZcxGAYekCUqXiQ
 L8xzrtDgeriKAiMs2YK35dOQPfrrfzUmVPtnXRoyCr4xfu_FSPmfbYatIyDSNTS8.VEsRGD_CGNt
 4RBNruLEkU2hjdE1rxjsw6S8cNHXXbO1S8Tnx4iYoflBrhrJykXaPZxPAalde1XLRHuSquj4Z6fi
 myQrusXw6qlmvdBEHYr6MEl_UPgEpPl5Gpd2qtiPKVupDaLSNE8wVDdBwiSBlRWGPuOedq1wJW37
 dMrGaZyAHCLW4w8VlCuXugzQxaxtOd6V2SygRpq8iHV5uhhCKMTy61h_7aqScXE.U9.S4VszSPld
 I_X1JBdzw3rkpwi.bxKDW4OUhwntfJQxGah9u6vQgmbWwastN.N53J6UMN.KuKfd9G_y8IfTE34t
 TbArbGwA7S5f5WKXTPX4xKjIYwBxr56om_wu7JPaPNIskMltqMLAdUvyjirlEavrKSgBB_JahlwD
 q3CpFnlhkSHRas8wCbH5AmFRv_QeBwmWkFe25Vsuvnd2CFMd44eJUgzK7F0s4WdJxU1jSzbonVuA
 3qQXOZrbUuMk-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 63243ccb-73f0-424b-ad70-3de7d25d6d79
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Jun 2026 19:36:44 +0000
Received: by hermes--production-gq1-6dc558886b-r26lt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 72d15bc762981fa35c6a1f22d5690899;
          Wed, 24 Jun 2026 19:36:38 +0000 (UTC)
Message-ID: <3a6208ae-ed80-4859-8c41-76010fad3f0d@schaufler-ca.com>
Date: Wed, 24 Jun 2026 12:36:36 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LSM: check if lsmprop_to_secctx call is supported by LSM
To: Sebastian Bockholt <sebastian.bockholt@bevuta.com>,
 linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260619171945.1617498-1-sebastian.bockholt@mail.networkname.de>
 <a28fb6b5-cdf3-4523-813a-165c00f7aef6@schaufler-ca.com>
 <DJHGSEVHV1M1.2DMGCPPU1YK4Z@mail.networkname.de>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <DJHGSEVHV1M1.2DMGCPPU1YK4Z@mail.networkname.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26016 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/24/2026 10:44 AM, Sebastian Bockholt wrote:
> On Fri Jun 19, 2026 at 7:44 PM CEST, Casey Schaufler wrote:
>> If you want to help with the multiple LSM support, there's still
>> plenty of work to do. Let me know.
> This is my first time trying to contribute to the kernel. If this is the wrong
> mailing list or wrong format to discuss this, please tell me directly.

You have come to the right place.

> Otherwise, multiple LSM support seems to be a little bit to ambitious for my
> first contributions.

OK.


>> If the BPF LSM (the BPF LSM infrastructure, not the eBPF programs)
>> is going to support security contexts you need to mark it
>> LSM_FLAGS_EXCLUSIVE.
> [...]
>
>> Until then your choices are:
>>
>> 	- Make the BPF LSM exclusive
>> 	- Do not use any of the security context or secid based hooks
>>
> I am not trying to load any BPF myself but I am debugging issues when using
> auditd and apparmor in parallel.

Where does BPF appear in your LSM order?

	% cat /sys/kernel/security/lsm

If bpf shows up ahead of apparmor you will see this problem.

>  As soon as I try to load audit rules from
> userspace our logs get spammed with "error in audit_log_subj_ctx" messages.
> According to my analysis, the function call chain leading to the bug is:
>
> 1. audit_log_subj_ctx defined in kernel/audit.c
> 	 // the only LSM enabled is apparmor -> audit_subj_secctx_cnt == 1
> 	 // confirmed using bpftrace
> 	 if (audit_subj_secctx_cnt < 2) {
> 	 	error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
> 	 	if (error < 0) {
> 			if (error != -EINVAL)
> 				goto error_path; // produces err msgs in logs
> 			return 0;
> 		}
> 		audit_log_format(ab, " subj=%s", ctx.context);
> 		security_release_secctx(&ctx);
> 	}
>
> 2. security_lsmprop_to_secctx defined in security/security.c
> 	// lsm_for_each_hook iterates over all registered LSMs
> 	// lsm_id == LSM_ID_UNDEF -> the first lsmprop_to_secctx hook is used
> 	// tracing the following probes using bpftrace
> 	// 	kretprobe:apparmor_lsmprop_to_secctx
> 	// 	kretprobe:selinux_lsmprop_to_secctx
> 	// 	kretprobe:smack_lsmprop_to_secctx
> 	// 	kretprobe:bpf_lsm_lsmprop_to_secctx
> 	// 	kretprobe:security_lsmprop_to_scctx
> 	// bpf_lsm_lsmprop_to_secctx hook is executed and returns -EOPNOTSUPP
> 	lsm_for_each_hook(scall, lsmprop_to_secctx) {
> 		if (lsmid != LSM_ID_UNDEF && lsmid != scall->hl->lsmid->id)
> 			continue;
> 		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
> 	}
>
> 3. bpf_lsm_lsmprop_to_secctx
> 	is defined through #include <linux/lsm_hook_defs.h> and returns
> 	-EOPNOTSUPP default. The return value is propagated up the call stack
> 	up to security_lsmprop_to_secctx and then to audit_log_subj_ctx.
> 	audit_log_subj_ctx checks for error return values and prints the
> 	audit_panic "error in audit_log_subj_ctx"
>
> My patch could check for any errors or lsmprop_to_secctx but since some might
> be useful to check by another function in the call stack, i decided to only
> check if the hook is supported by the LSM.
