Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3A1EA91
	for <linux-security-module@vger.kernel.org>; Tue,  3 Sep 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377918; cv=none; b=UQ2tAff7yERBhr68f7/vpASRkUo+jjuKyyUCY17h2avupN13tTu959R1IlgzFbMt301mbzaT7pRGFGUU/z+/EKCqcF0L+rjxz0A2aBikxpd7UiE/J9KTARowEFd59miDWdeHmUXiPGwTA91gRQpuigbZkMrztWb6HFcJC4DWc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377918; c=relaxed/simple;
	bh=e1kqJPocJt9+fQRxRSTPg6OYzy5gktz4+L+c/vl5fcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXOUnqvzqfyNp+nmgh5TMmZ/LOuGssG+7TxOydH54BgBStRBREtzZJ6sb85Ji2qCtlFFq3YjKK8sgkltNCNKQ/wnODf6W7Ykw9vRjFl/w2O9aTQHWFRaaCaevHeZeyGBHyRkBBh9LFkbNiPk8teyKg35aJUfnY5E6ptChLn6p4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZtMt3wS2; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZtMt3wS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725377909; bh=NhsBo3F5Jg8hR7luPZsA5qm6D/hzEdO76HHgvRURyhA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZtMt3wS2vP2QwXjNcCbquK9aHI4Pd4X9cqwazYEJZxIp9+vh+jebeoIm0KxIOQ5qQs7N3JWROLHx5PDDLxb3KeskOq8Z4ce4DBmPI4viDWi1Qs+0T1GZHwYOzee55u9uNIHn+3bPuePkqSWAYukQuJUIpK+sfEa07ITsSuSdH22ZC3nwC3uRe2Bhn4pHJKKA/fv04F49zNl7Ee6SqQk74Cu3F8/tXuQperZ6JCJazG2VGDu/lu0P4GwM5Bdq5m+rTkVLLFBGhr8HSwppG+Xg2COVE3Sl20bodFuUCw4F9nNXGLV+dIGU+V0rW1M66RxY8SUJEzYpcuiNVYEa1EO2Ig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725377909; bh=3u7bWrdwlMjDsSL6H/Idax+cqrWIDqZyGpyE2phq1hW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QZwqUJdjDdqweYsEIrEm83W/BrDOvm4lZBhGKOJ3qiQTpuVF3q2cEE3qKYE4/nEGgnhk1kIe6Xi/p6VJUzNeWCMrnajR8E4aCEIk61UGUwhYKdIuyaXXPxsBrGFUQq0vWlD9rrggMEW85j8DIXo7pbmOLVk4/vKjhSv9P6Hq7Guq7FbN7tyY2P0iwc6youvUi2lqXHaeyLd0qRjlmqRd5LYQhUVVF/kj9M7Mt8bmTDbFhkBJ2hN+O1jGhSPRhBVvzVEDB78fVqV45StgwIQf2GHGhpF9TxlZ8y9htvZFZUtogPO1DjjmbDrcpym2BWNi+GHP9zib4EmMkzrETQobWA==
X-YMail-OSG: yEuDpPgVM1lCfqag73KfrgJDNDA1wfVKTPQwoFfiWWtIisapRJuHLu3r5VlRdLN
 MaAbANO_wKx97tx20MgHuilnh3oiQjuirBV.aiCcu7orf2pTqeHNtoa..LLLmJieYRcaV1QE301Y
 fJnjdEhP.LmZKP8mgUsIkUR4_nc64K0L29Woj_LJ8JEaClm01rka27IGG8qVsJ1lS2XIguvk74g4
 yw0ahe4kCCk51J3JAKZM5awr_ECfbVHGPV5kZq_SjTvU_S9Kte_kN1jS8RDJrAGPMdZxK7hT8NfN
 rkxH3iJ8fpa3rOgxcLDK9h9KJOEorxs2lbVuGr3GD1Pm592fVAe1w0eDYPwlCjVocRtsqSsb6QuM
 UXKdHOdNaOqb45IBUsklivqnE_TXelzFtfwDeEdW_rLp_EJpJ2GltbWmyGizjKUTABsQU.l5YyqA
 QwQSA_23hjD9HCbLz15v1YZQMGzBEDjCI5LHUJY3LhniObhUhIJStDFWHakAJkl8QRkhwWlRipCf
 4fo_7pbSqyOW2WFO_oXQKJnDdZrERTUh8_E81aa0RQkR1dkDqHbwvA4SNyggeMuTtTYfmG7evVGH
 Nn8xHMWltwEMfYaaBuuw4vNJHf9gLXSZLUXXu03R3m3joTMHVMENJW_36pXEhzHE.D6Dyn4JN.F7
 iVAvjrr6m3lTqUVuBhI.HVW4y_i5kn4H60xsd3qBmkITDYvGypGv6jWBjchm.IkFj8pF7XMomkvd
 CJ_pOAoPBCd6V.cBjg2yFymiQALlZvglnCojMj8jAPz_5GVBhhODVbC4CAQef8nKwarccmipN8w0
 DGL1K.DaUXPJhuYJPTpxdzjE.AJz4J7p9ff.GiLoEBNqZTYlG.p3SVVDKowFTckzRu8QLYmsjjhr
 LbnYmUOrc9Np1bM3aGarVz8FOx.z6_maGawmENUwCpUSrdw5usfXDm2ntGhYSQ_n_Txk9fM5LQLo
 5MvzJmRWij20OiHdpwuGwPnDwv6xqV4SL9CPkDY1PYwe0UgdG3YWTNozDd5UAoHGX8fcYF1vREEJ
 Kv83ueWEWfWsz4g4O1rYlyUS3NbcNKnfYmcLUYUUjvvz3NR7nQU4y9yWDOmuYCoDep7EfWoGP2l_
 Aj2ASNBdCjKSATELXV.WQklAplpdI5UUZN1bW.fSWuGyZbyA.vNFfpR9kqcQqI.aFu.uy_UdVOx1
 ZYQj.XPGho9FuZGgF4oD0CaEf0.T20mYIUBy7lmFyjzMLGp.s6qr0HId.8rzVnn3aM9O69ujzhIK
 M7ubPMNW7P_rCZaw5ehE5totcRxHOdV6ZEj3orcSFbTNDFuVUaZ.SFtLMSKEA07aoCpIdplI7vVD
 x1WXnhqfcYeDO6waYfJp.66beqh9uPglNIte3aEf11_XFVEBEyxLtPMSuU6A32CPzd1j.RNqmwtC
 iKlVy4y3m.Xz9uq5TjHiX9a731B98cWGaYLH4IO12to62uuZhQtOBUbOUhMCaVUfUyt4kIMMA.Mt
 UnfD8ohqGJhH.2QVETJLzgUa.bHHg2J7vEpYt2vbpijdMPm97NF_5W399cdXrapahkSxglOmTR.m
 UBmMxQ72VotFoFZ.8pprmvFDK7T0S8mpX5715_lT663RP6tpIrH2a6L8Bab33iSydcp8DfoHHEUJ
 Px2hS5X6Yy5x.3.sSP.vQoBQobGayGkUpfMkGZ30wC62wrWLbB0wVUNyNl7ztScSuemSceWtyX6m
 Kher3uhM9M_4k9gsRpkVv6zqspiDZ1k0uELzLfITx4.GImRJxdLoOB3uf5NjwHtYgQxEsr7z1zSV
 ZlP43Gkc35xoqL7J7tFyQd67o4AdlQc1kriPNF1QafCQRizQA1BuTruioF9f_16jnjGhMeWg7IuD
 1G8at9_Ve6xR9Ql_vrxccAZPFLaPRJHJC6ioZlz97aUDBNGLHBYLKBsixOW1SdSSaH5tTb8DVy0g
 AnFJKrwh5H_fge3phMrrT8CxvhA1xtMhFM2paIiim._PRQL.8xrjG.q_o7L_1HScVcdlKeUlANUE
 BqVsL8la0f9k2CeEg70Xicr7C2e_acT41nxaDVaSmjwsfTvqmkfwrG8QSTEUHAUlsyKh5.oy4snL
 BEgBBU0oVSdyZX1ru8EZn2bdERXbPStLaZFIXBi9J2BopdZiQAp_1budgtkomNNIqrMVcpy7EWVn
 WVFsCT_HjYdUSYvRjv2jdKOmqrYXhqQCB_.SoI_uoyUdkJULEXsfLWPPSIYUpuiQJW_hVfI5vP5r
 N88D5XQRXAnF3kZu.c3n5AI1kYIbJnhl8eZRKy3fpiQytu5pDJEjNrjggR7yCrxSOVOQ4kzcb0ai
 ViVvEDH3Rcpq_dipcvMIz.0wJx8.YCBPZMfM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1dc729c6-e6a5-4724-830e-b0dfea66fdcc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Sep 2024 15:38:29 +0000
Received: by hermes--production-gq1-5d95dc458-xmcnd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6583d442f3e74485b4e4e7523becc6a6;
          Tue, 03 Sep 2024 15:38:24 +0000 (UTC)
Message-ID: <8f6524bc-1695-421c-acc6-a31528e84ab3@schaufler-ca.com>
Date: Tue, 3 Sep 2024 08:38:23 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smackfs: Use rcu_assign_pointer() to ensure safe
 assignment in smk_set_cipso
To: Jiawei Ye <jiawei.ye@foxmail.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pawan.kumar.gupta@linux.intel.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <tencent_39FA49154F494DFE0FEC2F20A9A34AA9B308@qq.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <tencent_39FA49154F494DFE0FEC2F20A9A34AA9B308@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/2/2024 1:47 AM, Jiawei Ye wrote:
> In the `smk_set_cipso` function, the `skp->smk_netlabel.attr.mls.cat`
> field is directly assigned to a new value without using the appropriate
> RCU pointer assignment functions. According to RCU usage rules, this is
> illegal and can lead to unpredictable behavior, including data
> inconsistencies and impossible-to-diagnose memory corruption issues.
>
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
>
> To address this, the assignment is now done using rcu_assign_pointer(),
> which ensures that the pointer assignment is done safely, with the
> necessary memory barriers and synchronization. This change prevents
> potential RCU dereference issues by ensuring that the `cat` field is
> safely updated while still adhering to RCU's requirements.
>
> Fixes: 0817534ff9ea ("smackfs: Fix use-after-free in netlbl_catmap_walk()")
> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>

Applied to the smack-next tree. Thank you.

> ---
>  security/smack/smackfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index e22aad7604e8..5dd1e164f9b1 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -932,7 +932,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
>  	}
>  	if (rc >= 0) {
>  		old_cat = skp->smk_netlabel.attr.mls.cat;
> -		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
> +		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
>  		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
>  		synchronize_rcu();
>  		netlbl_catmap_free(old_cat);
