Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939113DB99
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293534; cv=none; b=sIfqnbKQBUNRvEeTH85GSJlr9rRSusiTld07S+9c7Uz1uMSt+Gwom8tgRZa6UcUHIBnxd6auuyGQ1Sv1+4BooseUqFXorYYqw5S5qrZvhj3RMk6rfQOdwZiJVX68oQ0BxjAuM2P1ZVtoK3Hh8krwgO7zQwbaSYYlLv8sHJ74t+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293534; c=relaxed/simple;
	bh=yxfAEPCXesfxUAHhSuTjLFA3zoWhtPqf93J6Oz+ROi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kF/WCayqLTftFwYrYoYXQBp9MU/9GP8e3Y7uLmiq3e7JnrIaJUeKvpmIpyV3lyTI5COpImP9ru+8dppvi3Ed43JXqU08IynYclmtX/1Opmf9XKOo7yzM1uD6CfkAtlyflosdc8w9Eh8aEzO81eyew5lpREZs4nAI+lmLBhpZ6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=M0ebSTpt; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M0ebSTpt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727293525; bh=mYnOd8wT5P08Hq9xlxvPZxDsw8+Nz3igPcYQA9WmMiE=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=M0ebSTptJUxxZUr6hM7tsE/Ahhfxfq9AKso30LhfDaZXgvwL50n8O70NdPTL5U8HapQRMWDb5EuZiZJZV1cTPhPdcPlO9gSkVCgquFeP//+e3dNwO9xgUeRFq5Qpto9YnBSL9rnlBCS1Kcoj3XXBtVsHc+JESP54P0XPRqSup6wTsC+xh4qRLC164UsTRK2kxZrckL+r6MZlAsOTJEt9f/uoFLbll8XIVnM2qWSWy4+DuOOtIa3/hk7F8KVwBLSUEohXQb/CZPjiBwFuZNoX31qi/lwuDwTFhIUu2c6cFNSlzlYIb0ccEIsL8CCBlc0WvuTydhUI0+ERsfe6G1N2Uw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727293525; bh=VwK/2xGgYUwl9Y6l/0sQixpV/5HsM7h+ckmQkxQVEaV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=p7iHH8/vfz4DKpOr4WkohI+0a/wrS+T97Po8ooNlMgUc2mNkI79wlk31h0UKH1p03MO3B6mWsslTm7DqUtHHZdUBlKdoA6Ab5vhMD415MtiVzy9ylp+yH9mGddZajKKCHjKrR/Xt6tO9ugIpwvoJLonM+p9uHBT1ydNP60+wd/1/czG/KabiuDVcc/yd3W7JXltU3fTTd85lfIZZkWfMR2XrqT3SjHEYFDWNKG5HQUa/qRfzCqPUmqZVCOGq65vT7FppE7nFlmrVyCFLDuGusSz525wZ3jv/fGPdCm3t6cedq29dUJGOy7R6PYdXAC48qN/pg8MyZYSC5lCR1Fbzlw==
X-YMail-OSG: 36YRXRUVM1n1qfRueQnUt8d4Vli._AuoUTorMgNo1kalm3cx_cvc_s7u0tK12hA
 XMKolKzql.hQARpHEuG76Os7xrC2WsnNZHo4XxBcRULfXKWPUtStRUtAhOs2RNgl1rqs6g27KgxX
 A5uZk8zOeD33vIM7tJZ85mWLtxSw7Wk2TS4fyjKL_pF9SVbBIGWHJUSeE3UzOdZ8qTE7JsAnYjKd
 zEI7mgKvd.ThpNNR9oOGl5qwG9yk7WAQbEIR4zVFh_gCDxJ2I3JbcOzeJW8iOrCMfTkWGynDZAlc
 0ov.st9c5RfmzIMe.pEsXHzfznkcauGUqPK3geES9KAL8mi1.I5rcmcs.g8QYqM7eLC57_rXMjkE
 FaccgGSnPJaLy5Yuw7VHua9NyZ9DBL1Yf55RJTD6JU40PmI5t_79QRoEFEUgD7.vMewTVKaQqc_U
 NFgIEqbcX2Va9b85_A41gmzRgVOHhd5BoEt5sSwbHd1TdqmgAbh4nJDQTr.BXlxPHCmD0vN5Mtmu
 PaU7H8.aQp4g73IQ0U0Zx1kUpdWcaki.Oa9qCHMFh1678b8solw6SDCdscY6190zvrBmCr_KYO7Z
 8YTNUwHE1u9xmmf1oXMZRIZ8QA2OFA0_Z_0byBLE6ZG7QvAblE1H5u_o6Qimp9ORlluW0yq7nX6C
 PwkB6MgHyY_zXnBCYt7QrqX_QwNeUUusSbpEMdRTEiVz_mqq7Rs8RemRZZ0tBT0i4nbtgObnXqkA
 xNtPvNvTQPxKzqed66Xv72hq3gSAsnYlVYGz7JAZzEr03Pxzuy_M8RkrcZ82dmmi5s6IKYzqrRrY
 sBXCFfimHJH02FxXmbtqzMpNMfHRCGkDjUC6uTzLJKUTZfiwKlYi6s4BTBGIQhP4XFLtTzpWIa_I
 tKngNYMdirtX6Dsr7iZQaXQURfx26kK5S06guFU_.WIZVdon2dPY8_4xnrzyvUYHyF6pojixzrj6
 yKD0XXXLmk18PB9Bqa6h1Y.eeehGE3idO05lBniXZyNtAgnHS2BkJM9n.B_j2IzKYRPXGIY1KfBE
 18T5KQgDutEB6vi6wL5roKjtjk0dFAyFCYAKDr5qABjGVUI9RrnuHBkZlOdDB7gPx6laUXNLeVO1
 hkJNJeddocCND5DfIyOz4KtdN6XqtaaKnmEzpPfIfSPAGpSUYTyplXJ3HFGmUzvD18jSdVOfGMpS
 fTv4O5YZiPmLK7I5hpA5bvr36KfgR6k0f5qfqkvUtbAT6Yr9hsVpkULk2SuTPMu2IOTN0loPcSTO
 Hidkq18xwKHxHNnZQPxBExyq39em5uN.alSPEw.mfEzE05lWhk2ufYAjd1Mc1IbaSf6rr6WSIk2F
 Thc8.6OuVObxfKEel2QAsgcsukDCdLZbFMtLf8CvTZOFrTb_Bpy4nD5JG7CLZnm2Am4pdynYGQk3
 7xh6l7cdsVkRYL9MomcPJFwBoVo6yJVdkbmX177Vxdv7kQh7uWPpwBL53btDgV5fdgfGucrfFJWB
 DroFL8DQ7J42Yuj8EqlSpruJpZZapj9wfBUUgI9jz1lEv0wVmLFsPCdtEbi5TcqutrHwXNkbfEgG
 Q8DX0i3eFDKR_N6f_4ycMzvAbXvyoe5k3wYwo0qjXTNpc4VmqxpELZGVxLgVkLxcRhh.iRiwZaZj
 tBz9ajQtNG9JIcyqQAVYE1sUnFAiGvLTIxYwY2msdYHT8EnAqEvmVeZf6AEQullbqPwAkwimj_JW
 bvg5c.cZPXPKxw.8K_kg7BkJC5Z5ZZ_YtcyGYHp7kmMxc.rkc6hhV3iLdBVc68wEGbN7mTkU9hIv
 8Vzyv7cErw9K8ecaWE.d8_DhUcLmnktISGqBxgGfOleeHDEnAI73bIB2cOdZ843FYSL6gmHlX2am
 NhvNqSO_o5LvXnJYx_TOfKbX9adoFSH_91GWDqFXcr0w6nsify7huo3IyZTpfctHSmNXGn.zy9DQ
 xQMpSX3arllYd4ZMGgjWgRUkzyFuRoDOy7WBru4rqGh7Ybzm8UzLomgNuzuTiZXTb2v9MK.PC8L.
 lg4UTEN4JeHzgad5rGvdfMHr4jJOxXZjV4AVDjldCB3gOP6iwBWj3.4PgKzgceMv8Wu2EdJDQf4P
 audGgdpSE49mlK42qni9dieo6ehSmVU3Q9G2vEXzAKR.P9K9SOB0qnPGgngHqNCy4KuwHWvZnR6U
 aSCVxYeHurVC9_8C9EQXHYihU7S1v.c8NrRciLAh_54Lg7.V6iN8U7koQBeKfBhlofuq08.d3gYw
 JTIiakKcu12gTLkhMi0Wtr2Tnox5zIRSpNmBdUQSwB4yxtZe3C62KsjlIwVVJHdjFhT6JMbJZwdb
 xIPzHbGkSs185
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c9752729-bc8d-4bf6-9be5-73d182dbe40f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Sep 2024 19:45:25 +0000
Received: by hermes--production-gq1-5d95dc458-sd55t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f62ab2ea9ff860b4ba1637899f6d5a7e;
          Wed, 25 Sep 2024 19:45:22 +0000 (UTC)
Message-ID: <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>
Date: Wed, 25 Sep 2024 12:45:20 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] capabilities: remove cap_mmap_file()
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 serge@hallyn.com
References: <20240925192018.15290-2-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240925192018.15290-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/25/2024 12:20 PM, Paul Moore wrote:
> The cap_mmap_file() LSM callback returns the default value for the
> security_mmap_file() LSM hook and can be safely removed.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/commoncap.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index cefad323a0b1..3d103069903b 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1428,12 +1428,6 @@ int cap_mmap_addr(unsigned long addr)
>  	return ret;
>  }
>  
> -int cap_mmap_file(struct file *file, unsigned long reqprot,
> -		  unsigned long prot, unsigned long flags)
> -{
> -	return 0;
> -}
> -
>  #ifdef CONFIG_SECURITY
>  
>  static const struct lsm_id capability_lsmid = {
> @@ -1453,7 +1447,6 @@ static struct security_hook_list capability_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
>  	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
>  	LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
> -	LSM_HOOK_INIT(mmap_file, cap_mmap_file),
>  	LSM_HOOK_INIT(task_fix_setuid, cap_task_fix_setuid),
>  	LSM_HOOK_INIT(task_prctl, cap_task_prctl),
>  	LSM_HOOK_INIT(task_setscheduler, cap_task_setscheduler),
