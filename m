Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C42C87A
	for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340907; cv=none; b=GUQ5UlCPCXWVjj60JrIyhY2Qgc1EZ8Ld2ucSyzgKdwvN9HPZNLtBwP4DaxHsetz03n6VAJIbbfJbT7/tvxwjWi+s13V1NjDppeieIsEEVhptvBaAplisGnOf+UjYiPV1uWK1c+cByBvszmhDVtFsZFCC9rGm6SWkcA88I3rjTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340907; c=relaxed/simple;
	bh=LXL4fx28/hT/LAUEZ1ykMATKvM5QbHTLtfey0LD5lvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LWJY7LtwO4311u5SoOn4J5ZIuSMUcRVHhH5xW/eDJWTmnM94PheVFjiluJjHPedXQgzbc88SF1eh0ATmORjON89tyKixjzVqnAMRS/6ha6E5julFZuiXhZ2E/DJoy188vdqTYrxyQrqNukpEhVLu+SLwZeNBhyHGrosw8rUl4Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fDdMJwuT; arc=none smtp.client-ip=66.163.189.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fDdMJwuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724340898; bh=SMHYMPHnqpQW/IWVang3vZTGNn8xdM1VbrgfyoTZEj8=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=fDdMJwuTPn7PXTRAmarfPHa+bQvp51bOCJbxhEZn0VL/Saaj6fBOgotqBFy9DFZw9cpqOlEvJAlTED389fUWe/pzsZXDZwcdd0MxDGifg55ZkhNa4Q6j9e7NQ0GNKo+65Q0DN2o6geyfqNcKycDsoeOeOsT6L2UJ9AA9qX1HXy/DPFyACf7BHI8djf0XWBKMKAo7UyXUdYIWrn3z4nqSXE6rG9gaXgpt2P2kM3lXqvn7raGeBgxl0d5MOSUO7676faDZZhkQSKI9vAMlhlFaZUme9SnM41BE3BkQsrYWFq1weDMgckxW6AcK+HxZ0djaFym2kyzN31DHh2TMs9hZwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724340898; bh=fRFS2HAd2RELxVPswHXQs2cMFCQUSWaw6fJkjC88qpu=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mXM9OyFI0Cw/uBiEnCRecM2pDLxc2sz3GByAqytCuSDiXMldgQzNIewnDMbtd3IoDD1CCARpmrO6g0HZQ1Dy4tPtWQm47FK2NDi0WkZzmt15HCGxnLHnCx4oK7JWXyU1dP4kT7eVyfIE9LEOoMiNEsKZBlXTT0V0NhE0ddfROMkvO6bPAjhXXq0ANnb0KHSMqejWI9D07LhYZ+lD0/7W0CHsEhgs6NF9zJcULD+1InuvBZhggdqnSIIAbrxH5vO7McCBVO+cVcUHJHvWe9QrsZ8vJpsldIXhjNA8a2th2mvBUGDB+0n84wYuuzIntquFfCqDJzO3z4pAwq54/qD5dA==
X-YMail-OSG: At01VsYVM1k8WAtTlUsfcBuw1KU.pmmQYiHCSXVz5n8GnoFXbSR3D0P0MiYTzx9
 6.v20IDMk0Iu99Z2ug2C6bIGsgFjX86dVeJb3E0Br9g2Bui3fWdHn8_Za6lyYNSrLIkQXQQ7qxd7
 cgb0zOzm8vv_WXxo8d8.9fPKucjhNd5i6EZLL31FpSfG1xGZrtlsyXRbN6jNoedsk_BoXG2AxG3M
 h09MtVVhy2j6z0BX_Jigm_s0BtlBEkCA5tdeOFD1nhL67KFHtukC.IhDSoDrE8mWSl3.oZCqZX1U
 DCYwFP9Iu4Vt1F4FZRxc3L5h03FiIg_QFJ2xYbzXWL.OwZpqcm99HIKEbZIsyWdujWAx1F0UFWya
 KhDfQhRbGGpO4aKy6_BLEQjSxQtWiRfE1wxl3EfqiqDZtg2GYhhVrL0sVgvUFnF3yhCJeyQtXLVm
 xvf0uZt_qsGbvCQiymhz5CsT6WuXlHemdnIU.qOIFxYetpZXpnCFgh4qRrla3ye12tphkXCq33lA
 uw8CcIqcHf_7QEm047lkNgIcTJC.d5FZU2yJ_EaV1KB.1GBhpg_ADOVljTozg8MGGkxvKN632CMn
 n3d8ZGWHH2yryjjo2SzLLcZ7zi1Pj63VBsBUnZmdv1VwvSGozqTsNBNJ2X94ABDS0eydFqJkF15K
 WLU7Ep7jJviJRPT28UmjGdZNc4JPXfkZYgjwTq1wgcWTD7NOzzWst99lB5J7oQXENqCAv_ah9kVC
 _veWlsAqx51xB0qOc2B0HGUugtGyIhDYSne2xc5NmEvqK7Gg4t8rdIjhzAuHbA7_UCtVGtfuFINS
 qYp8fUUC5t1IG1t1gEiDSNKUg35.AY_z9rA2zAWbsV8PV0pcWWVUZd.qGG7OhdYO0A00q586Oi9e
 .J3xrnjPab.2JUlmYHgKHRRh6zTITcR.vbDLcOYjxuZ3DILeitovawTeh22wfJAvryGmvpI_rthW
 XxzVwGUphAiFt2rECOl5m9GUNLgz822a_Xc.J84JXtmRtYiqHvuqlhryB0aA6x4X.UI50XT3g8x.
 nxXXkNSd.ibDq6umj02vozEVL4zdNkAmFfNvFdfQtiNQFhXPI6_99tPejYPw0Yuu8r9Usl1pem2n
 .Jhx9bV6NeYyVWg7ty5mKmvuLRjpLUUcW1zUTzOi7mThlNkjxThcyhDLcjp5ZpiZpR_o6nBMn1sH
 8lzF4L8tVh0nKJq4vDbwHvz0xNft0.KuPTrAu_5KA9nzZnAx8ElGUrD6UdZKfaraunPyaoc4M9mn
 XYd1bRbeGOBcTlaoE1XELsmgI6bUoxendZAWm.CnUZjYCPmMS8SnRc.QUQsBkj1EmES.REzeNoj8
 iVKXh4yXJbQmXzVgfK6Y_IY6ERz3cYz7kMY066L1Waw_v7cLmwyvVgIP70FBvb4GSKWv5CEhmQJH
 TzuL0KDwwFFykkWd6YM8wUAMEe2xSiSJIymPrmynO_1BXKShZsFtjP_phHrAvLrdw3rdUWpo5Ee0
 4jK4ob6VL3EvzeudFVqOOrcQlFiCSlTI8fotPIdE9pg3hP.SgBgRCPaNIhcpJKLFDi0OIldboGeh
 4qZyZOpiLjWLQYNO15cO_sA4OG_kMGdxc4QKLXPhM02Vhwip06wmtqBp.sEzQvdcuU7g3.Y70Hu8
 aQGUPtlqOORmc5h__OU7Qyyy_c51RHk._W.nfjTPlgzE2RnNTmzGdQkbl9o9MKmk22WX_dOsaPLU
 6DtCF00nAE.hEgXgzHb0Gyhk7XbWRhKyXnQb4eQ4DVTHnfHbL3UQBxXVtv8iYLvxWJM8.ISCWQ1.
 FgCUeewA8lozcL5CWbEtqkC0A5BmPxTDY0pbXFRtsbn7b7_uhkQBhlaWDucavqEVpyzeL_KLGkcH
 Yj9f2vL7RLYFnaR3URJ5FyMNQ_jqkTEG4i5zKZcgE6AdVZhdhy_fizmebstP2uEJIEfHZnqpkTmO
 ieYGIxZXxspaH.INzF9JeCHIXuipHN_RAslFH.Oqyfkqw.f2eQOODOVA3eQAs5clBxm0RHCF4PHw
 fOqgii2mkLlCiZTRjIH4JTcUvxLud9S_ILPT1dALKw4vAQf.C9a2kcJnKYWDj.KdUPI9ZY0oO8Vr
 gJRMZ_WyrPmNUNpKNLA0b72qM5.KQCMX9Eqdel58SGPFCGLlQ1yVH5Mc4MG3J2kzjiPPmMribXDB
 Mgg3tvb7uYyTrnk2XeUcyU0AhId64VaWuqOJHfQxQbpsTs3079iUCIGf0yHAiG9jgjbt42yHywlN
 RJQrrfC1uqxfAvV5LgJ2tb4YWQyNuKysdWLiyep2uftJxDmX9nCJA1hs_vxP7WdatzAZuuCmlbcm
 7mkXhmnHdH3wNHyvD
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8eadac3b-70c9-4fda-aee6-d00d6c09292c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Aug 2024 15:34:58 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0ca2964bdbd1343241fc3ce26dd3e4d4;
          Thu, 22 Aug 2024 15:34:56 +0000 (UTC)
Message-ID: <7680815b-1f40-47fa-a0b9-ef8f7fdcc457@schaufler-ca.com>
Date: Thu, 22 Aug 2024 08:34:54 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: smack: Fix indentation in smack_netfilter.c
To: GiSeong Ji <jiggyjiggy0323@gmail.com>,
 linux-security-module@vger.kernel.org
References: <20240822091806.89425-1-jiggyjiggy0323@gmail.com>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240822091806.89425-1-jiggyjiggy0323@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/22/2024 2:18 AM, GiSeong Ji wrote:
> Aligned parameters in the function declaration of smack_ip_output
> to adhere to the Linux kernel coding style guidelines.
>
> The parameters of the smack_ip_output function were previously misaligned,
> with the second and third parameters not aligned under the first parameter.
> This change corrects the indentation, improving code readability and
> maintaining consistency with the rest of the codebase.
>
> Signed-off-by: GiSeong Ji <jiggyjiggy0323@gmail.com>

Thanks. I'll take this in the Smack tree.

> ---
>  security/smack/smack_netfilter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index b945c1d3a743..ce06cd268d81 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -19,8 +19,8 @@
>  #include "smack.h"
>  
>  static unsigned int smack_ip_output(void *priv,
> -					struct sk_buff *skb,
> -					const struct nf_hook_state *state)
> +                                    struct sk_buff *skb,
> +                                    const struct nf_hook_state *state)
>  {
>  	struct sock *sk = skb_to_full_sk(skb);
>  	struct socket_smack *ssp;
