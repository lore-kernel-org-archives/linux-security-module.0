Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C342AD03
	for <linux-security-module@vger.kernel.org>; Fri, 19 Jun 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893656; cv=none; b=OiDtXiEOxgby1MRplJnGllt3FWgY8iIliITRkZ7LeNe0a7g/xVKdari3dqIIT7ClI0TA1zmKTCDjVDmzY5TEFsxBp9pgg3OIpedml11+JuTZP0bNzhtH1kvW9t2jUTUdPTADL59/v2yXWvDFfwllUiZE2vYdlYzQLDiTH06Kq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893656; c=relaxed/simple;
	bh=Srl03WOA17gX1oVDkE4ErhibrvQmA6NrEpjbwpDTjhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ya9TviOFjWIez3VyFI8digZpQMljUI92fIIl9XfdPuEA+ckXHNnqvQWCfmBZDcwNll9zL5rrZTr5U4oMTj/gGZ2itIBMj/UR35PeIlEA3i1Ou6RZjkre2k6FxHUkcr30ekUErrrPQ7tEQ87AxLJT01aLqJgp1KSCg06lmijQVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=INERAoJs; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="INERAoJs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1781893653; bh=E5p7aYJTEnEmswxXD/gUKNG0HDouNLjMqScCFYt9fzA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=INERAoJsUGUDwlc90HnauNg57J94mIESVu8KOcULJCkQWVi61fGFgbD80lJpnsK/2JWMuLq+k3raAMmZZEMi5FQHCogL7bOoCbbq/cHpJQClHS/Uuu3CVlk+fQlLxnz4t+OKvDrlagnNLSJCiafTt0oPp8dJnYq5ocimKgu145/nQA0usPsFZ9IEN9tV/A9cBXdR42aRDORyukubV0EQjLFe4EFqKMbongFxdZBnv/LjO7cT9tIhdo/ezCQMBsdecJLACyECqBFbC5rtubUONFgyhZSyPQ9GIuOnNlnQlnfeuf6R48xRrAK+9IVzR5CvoFJPgQBBOmLO5CmzyOmayw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1781893653; bh=4pUBMd18MdlgG6LvRJKfj/4OjVlha/2XU18R1P1Pe0i=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HwTW8jDb5H8/XnGGmGOn0aHgiwwkTT0Oac+/NjtIa1JH+nDcdT7xNtDpNAtU9DfwS4EJRvPzkcfBkrAgxhec96+K7oJzz5+h6n5WM8tUihx/Gwn9gFMZz61PXG7ZOYdp8DNA3EFbvR9AcfFjAR6OixOB5orQv1Gm2tZVP6To4ES/FaCjEloF5/tSGnFe1qEPYimJlTqqldcnnIaRxXzHwf1P7fQ2BWQCSiNFuCZByKRAlZHOfBsR/iAkdX+JE2xlJJ3gjht/NsCYLElEUnzAi/xbeE7pYaFxzcwf38eaNeEg7bEfJpe4EFy72GLAXlRODacAM7wxAqqGFHxEJWH0kw==
X-YMail-OSG: Ma953KcVM1nbNV0jEKjPHLkiY_N8DZsDzQDOexiNIcPvUqiyaaxFmUGHRlzklhj
 OD267yrFlXFpYYmwlWInKXhv3m.Oi4mWf7KcCMipKgkY49O4kUD.8z8ewHSBhlZwIuDTN3l1.NMR
 e768RAKy3OihsLDLsKEzoxTJcHnLWEO3.N9LYBKAXey3J3800X9OCFsBpOdND9R4Le056QoJUmF.
 xkc7n9GeYNIwETG6hgARa.Ym6Fs86Birh1CH3Bc4ocQeJNCSiT5gGGVszqwdlw19Wz9VkH_L75HH
 tax64lc2LXAI5HR6wlBh1pTKf1_G2iTGku.Ili7LXXhrD804C67Xt7I9bV4aBBxWGhdWCeip4VXS
 jCYrmz5Bmi9SIrK9Fi53Jm5D2YAKakJzI9_yjZ.UWglCt28RdsGIK.NxGIC7SBD_EH4GG7J8k2As
 ywm2xLWwY29DeEMlZulqaM1kLjnORVwbCOuGUxHUQsz59FxOuQGz0JRRFIZCsZM4Tb2X_7mvtkEy
 YnmyIXt3ilR.ubiTuu0PWbfzNgDDYCJwPGfpKL87Ql92i_l_brOj63h8p01k6qUuvkhtrQmOWvPK
 EpQWilVrYm2DZ_suYGpPuTaLUoFzijcEXm.6bKioWGStiN2OQU.TNd0IUbrL.z05ISjDxxC4oXR3
 A9bxV8SeEj5HY4d4Zv_iltEUQ2RX5_mIybtxuI9Z4BOw7rJg.AOYmO0nhFVDXy8oBTf1H.Sogul0
 9d48uCYiWJ9oumO2U0HWt7s_X6IEO4EZZgSlbQST0wT098qOZ1h5xjLrQj6BfxFaIGEsc5jO.54A
 vquEZCdxGMdXXQYEACNd_chccAn4DzENtUk8SdU3__6HNCAvfQMR.h6mu_vKAfi.l_Ku9Y0pNFy7
 dQ.NPj0lFFNrM5jvYqTVxgLQ2mlqsw0uafRVAEmobPcfga5nNzA3mQiSkOm6L8vrdSEqJ0w97EZv
 zX7eKfdducAcaF2MYNiEQa6VBn3faj05K8Wn47N5bHFahxPHKYJe9YC_MSY9H.faRmjEmfzrHb.u
 IovLcnQnjz5nOL_..WgBRDxYZow2rgnGbkZw0YI.hRAax.zfQf4nB6nRNTRGIj1nVFKL1d1iuinl
 16n4cj.OlRPj1WfG39OhkAw7g76RBWlnJs0hhIlPdA3EEk95nmJ8Ac35KldPv4gflzIOivFiYyma
 mUntoGglRILeuU0xbz44zuIh5VXgS_VJSYfUN89Y5mU.8tZW.yT6yOH7bRGzqcTdrM7ts8vcShHZ
 LArloz4Z3j2VwYnBgQyBLu6sUoPgVnX9e6zelajzDuxIUBbMkrVwSclQ0nNJMSCoCtU4qj_jJMqo
 iG.n.SieFKszfQjifpX.hUkEgyz0XyRDXsMG_yPHW5JCfhZxvuZP0khfDOoJ2sS4xKb6913wGecN
 w.wtlBb.lwZ1SRLhv1JaAGTGI3kiCV4iVSReEBWtZjyJSJxeC1xFHlfxFwdgmhpWt9IOVzUh4GPb
 HQnNBsNUz4gWhTfjJIKJeWg8xFCyNfQOJxKilqJorN7ferHtNoFwinOD2We_IBbd0gURC35zbxmQ
 Ltn0q_.Iqm5hsb0jnb21E8reuryNlaoFOOMABhWARFB8YiNPX3YaPsiPFvctzsNkwW7vxHU.MMGB
 DS8OptwXuCyW4c_bhhT.YVXRP3nK4_1tMHhDO2RvKTyD63ShCUqLcQimEA6mG0emrW7OcN4PFB99
 khNlTg6ylvRfVTIsY4quAGvR7X.ODfFSi6uiyFw1sOehXXn7H5OhMhbwaR83GGCNvdYR.NfZ1dpo
 QEzx2k2ERS3oWSutZ.UahZAGhdye5bg6rwJ9i4pcjN5eMsJcRrlIM.kpJVxfdpqQRqtCck.zG74i
 yLTm0cz8RnwY05tqaHS9Fj4d3vjDA02fdhGLnwz2sjmrX2aSqGlQFfux_GI23DoDqCXhRgW7E9B.
 tC0sQP9jNTd7KF_dbo_3vjESBfY7dHQmhzeyrf_npKjnl_Mgiyv2kXQhyjIoGYJRlk5wDW1HWTiH
 pOSLtr2qwzC7QQzS3_FUFWosLd_5UMvymLkLI7TbnpdevCt8ALfsVIVPfKq6Dd1sgFh9lxC5sepu
 PyeanHifd3ubQ3lVqF8khwL7G.dv0n_ZNCyh2LpCobRMEMdgEG8r2JmVDnBA27vv8kKq90uw6zFs
 ydworHHIPQqmK76m_OW88nLH1LkPndSpuJJue1BkQbhIP6b5RjOzyEDKBwko6UqyjbMoSds6XjRr
 q7pKq2l4P9b6qaKRqarYBw7_x96d.XzLY2CgXUL2d3aB3dlXyZ4hi_MVn3BNGlmTVIMo85IoKMZ7
 LIIG1TarS
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 24a6eeb7-0d67-42c8-afac-bf160e5ccb3a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 19 Jun 2026 18:27:33 +0000
Received: by hermes--production-gq1-7bb7df5c46-cpn2t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 79b34351adc82a6cfda9328e2ae8f4ac;
          Fri, 19 Jun 2026 17:45:01 +0000 (UTC)
Message-ID: <a28fb6b5-cdf3-4523-813a-165c00f7aef6@schaufler-ca.com>
Date: Fri, 19 Jun 2026 10:44:58 -0700
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
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260619171945.1617498-1-sebastian.bockholt@mail.networkname.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26016 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/19/2026 10:19 AM, Sebastian Bockholt wrote:
> In include/linux/lsm_hook_defs.h, lsmprop_to_secctx is defined with
> a default return value of -EOPNOTSUPP.
> The function bpf_lsm_lsmprop_to_secctx, defined in
> security/bpf/hooks.c, returns the hook's default value. Therefore,
> directly returning the result of the bpf_lsm_lsmprop_to_secctx call
> propagates an unchecked EOPNOTSUPP error.

If the BPF LSM (the BPF LSM infrastructure, not the eBPF programs)
is going to support security contexts you need to mark it
LSM_FLAGS_EXCLUSIVE. Sorry, but the work to support multiple LSMs
that use security contexts is not progressing at a brisk pace.
Until then your choices are:

	- Make the BPF LSM exclusive
	- Do not use any of the security context or secid based hooks

If you want to help with the multiple LSM support, there's still
plenty of work to do. Let me know.

>
> Signed-off-by: Sebastian Bockholt <sebastian.bockholt@bevuta.com>
> ---
>  security/security.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf014..9c63699d45fc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3954,12 +3954,16 @@ EXPORT_SYMBOL(security_secid_to_secctx);
>  int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
>  			       int lsmid)
>  {
> +	int error;
>  	struct lsm_static_call *scall;
>  
>  	lsm_for_each_hook(scall, lsmprop_to_secctx) {
>  		if (lsmid != LSM_ID_UNDEF && lsmid != scall->hl->lsmid->id)
>  			continue;
> -		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
> +		error = scall->hl->hook.lsmprop_to_secctx(prop, cp);
> +		if (error == -EOPNOTSUPP)
> +			continue;
> +		return error;
>  	}
>  	return LSM_RET_DEFAULT(lsmprop_to_secctx);
>  }
