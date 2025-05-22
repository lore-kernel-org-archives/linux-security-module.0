Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8ED2580FD
	for <linux-security-module@vger.kernel.org>; Thu, 22 May 2025 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950404; cv=none; b=qmkY4kBgp3kb1W6tHenU6hAfch1OO/qoE5Puh2hVTzxVcPKfWrxHuPn9xfDKYiQkwkBw/+kKGgkl7JETutg2vBL1eOyAFv+3vr2DhBbnzR7TnHpeYljWxGyqW6H7oPK2vyP2PdTi3m994crHaYIz+h6BZ6EBUxPjdi0TjUYj2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950404; c=relaxed/simple;
	bh=p0XtKa4G3Os7sLtY7r/MCEt1W8df4n6nks5yo8d5ArQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqeYfY8q2yk7UjII4BZY9HGJY9b/b37LeDdgGiq+vCcm6XMEM06e+EtPOp9nfIJR+ISIXGKEQ64Sxv/+DpS4p3Xnm0GOFTEevB6TQuAjdeDkOhrTZIYAM4vd1d440/hbjNw8YHC0PXgYv2hi0bNxUulpFPsNBOQ7w6H3DpGQmD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Qna1I+NU; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Qna1I+NU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747950402; bh=d3NLFw1TTHGD7vlrnR29VaX5fVGtaKRIi+SZUrP6hnA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Qna1I+NUxFJL6gtqoIyptKluvI4dugk7Yw8Co7q0JtFRreuvphruVdzHxAeOwJ5Z/BWB1ek/utEOotWkWzmxdH+jdfabJQy29SeXVSzz2WAsE15zA6rSSvCiIi7aGOguvrLxiPm162Zz4j6G/yIFAvCwSPl7PUpzh6MlxyQ4oWY1YQWmXUOkckcAilSl24DDykZrbOTtXD0rfFWAgZRv9tBVCWk3emIgpdv1XJ5ymKaokRpGc/GPAMJKYcpNOc1tx0q9OrZJdxPJa40cEjEPVe47WyvxGfBafOXj1RAKBhQIkhSA+vLGhI8qR7V5ShslF6ih6Gz7eKK5yyKdCpXAfg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747950402; bh=QbmZg01oWW98uU8LoKEPnQFb5opyN5iQK9gRTsXZt9l=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=H5q+KKk9lTl+jixSvgbEUP6XOQp2zPHAIv4lYS/zzuNgNZCAKfhbk4GlLDM+ylymVM3QoV4j30pKbt1KxSoBsCnKgIzyazu4pHUq+WAyU5TgMoGwBMkBU5czm6jM9NuuJ2lkmPGTESb4dVyyr2QbzkbZHopTUu3RbfwWdiCZkeAOlex04e+L5zM210s9hUim3u53tuHfMPDjbnAaDhdymqhHv/z2GaOZbHMsx+3dUD08a+LG6HUE6W7WTT7wRKLyIuzbvdNPdyZJjdzJ/GU/FCy9a+OcqBuqq9pIpMYkyuFJxAcJW2gmFXhnz6BTYNvykI9jt89NZMsMBnhGOo3sWA==
X-YMail-OSG: iTUA45AVM1mGA7O45zmNOTrUusVBFkbHmVe3EJ0Xdpn4bHLOwUx4C._N7iErJjK
 rWJc8.nHTHuy.dVBLgYxGcF39u.qAH1hUpcB1QaP.3EHI3rUTIMQkCDKTFQpDC9NffBXto5lTIcr
 QAISwFMwgJKaa0dYJ88iQqIJVpKT_X07zAMeP2suSVoCb2VLzDTehCMz7GG1WGthpqStRK3BOCLa
 Us3ACL0puKqtUtyNUOWMa1KuIuy8ZOU6qWvSlxK4YCHnmKvebPPE1jvn7G5uUR1vIOCxgb8bXXqI
 vhqpwHxdokF2GMhqKC5fGB8ZxpwBnKYbfQbp82shtuY2ArGt.dvelPGULcIykTn5VMxklywmri2j
 tpUIYjXlZWLrHUUDUVbZhhE0MxE8CryNrheBaJO0S4s6rLYrRnpxZyfkQ1_FA6kW7dnQeVc7nB9C
 6xmoZCUc.26k40vryH03kGIm3HIX.elUt.kvRzn38T591x1uSKa3G3hwRFVM515Cr.f_b3QjU55K
 SyuWg0ksSH51N52aGWXSii3hUZNQDtlVzfN1A8eQKYvljzbzlZC_B0YnfM8oi6YpQwbHCtwd93NQ
 ryNNUMbfgBw0Ui_GYx2N75mDHF7NeNb_HGPlvMu9TpeSkE0yV5YWCj9_FRJFmLNl7Mw0Ao902FWM
 srWATXaAtxq9mjdRSVGifBFRqShcT_PW3o2PlPACcBqtQmZF_xX94NjhmpRldBJ7MtrOhAPIc5MU
 qEAzF6ZoexYtsX9wHBoQRttdT3LAPS_Uz43MF0WcTy3sd8_dtB6RqlXm7jgI2FmtXrJ.7e4A8cwE
 4i99MUfCow.RV8Q77MoFLip8TwVWbN5k.r1dQG0s18QsvBzglMPMQSForKHfBTUkvqIKJXwLLJqI
 zEbwsKX7b4pg6bxqgAx86sclXaBiHUlnZJBeZyD2F08KoYUnVzPbDSVqx70oDySiBlRx.oZ9CYnb
 MKnf31tdDbxSNBZ65Ax4JDPjWygTNd3VfFqohtPkUtHAQMiNqVxrRypohhhZzoDcW_0k0Dso9tcu
 ZUAVxTBlhYx19W2xQHsXZh7qekmy1AG_knioOPV2yXIbVsuouoQhisUjDCPEZrFcbL9YXuDWTfLW
 uDKgoxUOH8tQZr.EOrrj4ff6xvmNXtsWQhkbYNkkJwTPAXD2zg8nwlMMqr39CmvsZ9fxYyd6EjY5
 4jCW8JyKHD1_SJ8S_N3su_Dp5EEgvA0wXcdu62hdHNxpFp0i.okhSeX2sObG6sFucc35MBSDUTZn
 eNZNl2shHMhNcR_hzUNiMIcMJ_CtWAqVzen42BX1Aoye9RnTYbeQC0uPyf2nLq3goACoXY0c1h_h
 Dct3gz_43UFpz06As4ZQSv_A0rCzUKWu.3U0mZ0jN.as2WChfLgppQSgxzc94Cta7eB7K9p05fyM
 iboHzEl6iVBeq94LdLGuZnKPLd7wuffaFn913EcKhBtwy4Yo5x3vEMoqFg_zgB52aVqjEB6RDjN_
 mKRFB5pZrRb5L8Mha0I3DZUTtl_phdWyFt1uIBK7vB2MPCNk3OxexZdv5UAMAqAVN9uB3ZUYEyPS
 9TuK1hLTS73duuZ9DX_vlROOqyRlsikM60qQZrLCXgVR9rUPYNBb3vMFGzQl.Ncp2ul1NcCom_fr
 OpKf2WTtykmbz_Vo0uiESTKhVNu_Xv_5gXihedOz_dzOSswgUzY2uBIp.T02nsns6Wl.03iNYB14
 oIF0728JfD7GsuNsjtGd6HAxzS5BCTzR.jHKSjIU6.UV2lPlUPF_MzOWPWcx_YHyLR.rxMRlZsNt
 4mI28yMJ.JfZRae5eQQ0VbAjp8cN68l8f2jaTI_hLzcPe1E6WfKNdQorpYucfLfllPvZ_vrmzfIf
 QoCrPiRm6lvDB_2n_anqKChDaLTg7sP1bgG0TBRKIozr4kS50lZ5HniBO4nDX356.TrWVPoXKQGQ
 5CpD3OOHWVPIqJDgvw5UcDmq6.15qZ_nTBOaYURa2WJJODQqXcyxkqAwm4lxSMMpGX3gCg_jXAGH
 bL_UwRmO2DQDOwBLECUbSlOFhxatMva9r9TY9gQ5L6jX0v3ANiZxwx4AvsYkmmBC6NmuqFH9LZ4a
 PLlsjGt2h5hYA3B2PUJTaPajlVB_pQ2GVXQf8MDSvzQVIiHZf9MGEBlgOB8L66kPpekJa6SPRFFr
 PsY0iobQ1tCaATQbNWDPRkSpV316mWIc_bwqdWcjibHTvd9TnBLvf0Of55cak6K11nl6JnI__knz
 uy0VTetySAFlwBdjWJDaeg_cM_HwfwdoHxnsrlKDUPQ9Eax7CXx_ZumL.FArpp628dCZKiUrgyOp
 5ExNHm5H7VlyjPgDeJ3aXyxNG
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 116fc614-cbcd-4d6e-a3f1-8482a3048b63
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 May 2025 21:46:42 +0000
Received: by hermes--production-gq1-74d64bb7d7-6nlps (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b10af0932dc8e225430908a16a0d3a50;
          Thu, 22 May 2025 21:26:24 +0000 (UTC)
Message-ID: <8bb003b3-8026-462c-ae9e-fd79fdb47ad5@schaufler-ca.com>
Date: Thu, 22 May 2025 14:26:22 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/29] lsm: get rid of the lsm_names list and do some
 cleanup
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-39-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250409185019.238841-39-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23884 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/9/2025 11:49 AM, Paul Moore wrote:
> The LSM currently has a lot of code to maintain a list of the
> currently active LSMs in a human readable string, with the only
> user being the "/sys/kernel/security/lsm" code.  Let's drop all
> of that code and generate the string on an as-needed basis when
> userspace reads "/sys/kernel/security/lsm".
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hooks.h |  1 -
>  security/inode.c          | 27 +++++++++++++++++++--
>  security/lsm_init.c       | 49 ---------------------------------------
>  3 files changed, 25 insertions(+), 52 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4cd17c9a229f..bc477fb20d02 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -169,7 +169,6 @@ struct lsm_info {
>  
>  
>  /* DO NOT tamper with these variables outside of the LSM framework */
> -extern char *lsm_names;
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>  
>  /**
> diff --git a/security/inode.c b/security/inode.c
> index da3ab44c8e57..49bc3578bd23 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -22,6 +22,8 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
>  
> +#include "lsm.h"
> +
>  static struct vfsmount *mount;
>  static int mount_count;
>  
> @@ -343,8 +345,29 @@ static struct dentry *lsm_dentry;
>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>  			loff_t *ppos)
>  {
> -	return simple_read_from_buffer(buf, count, ppos, lsm_names,
> -		strlen(lsm_names));
> +	int i;
> +	char *str;
> +	ssize_t rc, len = 0;
> +
> +	for (i = 0; i < lsm_count; i++)
> +		/* the '+ 1' accounts for either a comma or a NUL terminator */
> +		len += strlen(lsm_order[i]->id->name) + 1;
> +
> +	str = kmalloc(len, GFP_KERNEL);
> +	if (!str)
> +		return -ENOMEM;
> +	str[0] = '\0';
> +
> +	i = 0;
> +	while (i < lsm_count) {
> +		strcat(str, lsm_order[i]->id->name);
> +		if (++i < lsm_count)
> +			strcat(str, ",");
> +	}
> +
> +	rc = simple_read_from_buffer(buf, count, ppos, str, len);

This results in a trailing nul byte at the end of the string.

> +	kfree(str);
> +	return rc;
>  }
>  
>  static const struct file_operations lsm_ops = {
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 981ddb20f48e..978bb81b58fa 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -10,8 +10,6 @@
>  
>  #include "lsm.h"
>  
> -char *lsm_names;
> -
>  /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> @@ -363,42 +361,6 @@ static void __init lsm_init_ordered(void)
>  	}
>  }
>  
> -static bool match_last_lsm(const char *list, const char *lsm)
> -{
> -	const char *last;
> -
> -	if (WARN_ON(!list || !lsm))
> -		return false;
> -	last = strrchr(list, ',');
> -	if (last)
> -		/* Pass the comma, strcmp() will check for '\0' */
> -		last++;
> -	else
> -		last = list;
> -	return !strcmp(last, lsm);
> -}
> -
> -static int lsm_append(const char *new, char **result)
> -{
> -	char *cp;
> -
> -	if (*result == NULL) {
> -		*result = kstrdup(new, GFP_KERNEL);
> -		if (*result == NULL)
> -			return -ENOMEM;
> -	} else {
> -		/* Check if it is the last registered name */
> -		if (match_last_lsm(*result, new))
> -			return 0;
> -		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
> -		if (cp == NULL)
> -			return -ENOMEM;
> -		kfree(*result);
> -		*result = cp;
> -	}
> -	return 0;
> -}
> -
>  static void __init lsm_static_call_init(struct security_hook_list *hl)
>  {
>  	struct lsm_static_call *scall = hl->scalls;
> @@ -435,15 +397,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		hooks[i].lsmid = lsmid;
>  		lsm_static_call_init(&hooks[i]);
>  	}
> -
> -	/*
> -	 * Don't try to append during early_security_init(), we'll come back
> -	 * and fix this up afterwards.
> -	 */
> -	if (slab_is_available()) {
> -		if (lsm_append(lsmid->name, &lsm_names) < 0)
> -			panic("%s - Cannot get early memory.\n", __func__);
> -	}
>  }
>  
>  int __init early_security_init(void)
> @@ -480,8 +433,6 @@ int __init security_init(void)
>  	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->id->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
> -		if (lsm->enabled)
> -			lsm_append(lsm->id->name, &lsm_names);
>  	}
>  
>  	/* Load LSMs in specified order. */
