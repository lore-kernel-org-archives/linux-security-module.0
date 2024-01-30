Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F8E36102
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jan 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633231; cv=none; b=dhIqx5o3fqca+6BMfxmnk540Dh4+V66VaffnLPEdFNr5EV2V/Xcsd7JH3mEnDIUyTHNR/99hVkAZtSYIJgIPRR84Vbavuhg0Ugj8EylFH+FnL8rUM1T68jnhJFMUANXrZn+Dqbgy/QSnMndFCmXoBRqOgAvxUyF+xgDU98hbZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633231; c=relaxed/simple;
	bh=lLr81H+NuSvnDI8oRAA4GRSbzO3mvbG1F7z2dI922sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMPsdHpNzKnhubwkvh1MR7+JMFk7HoOOWmZcTdBiHL9sa7d+QCYZVNTny4K4yJCrRKE/ODyxHueXyQb+B1cHR0h70d5HGjRxrtzPGJJ789IczDtkk+cqU8REPs4m7QOMhBYFgKba+iPNvoUhF6kzI/Iq0YjcaWlcJj71X+YbRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FCsoqOMM; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FCsoqOMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706633229; bh=gpPSWSOFq6bu5/dlrDxM7ncCEhgoHbFH1Ln7IunTTyA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FCsoqOMMkUZnSC1ATIdbIISncVO3QDtocTjyZ0bfLWVYqe6xg7pLVxvxgimatPmFfVp02P1ECPatK/ZbEhcL3MacpGL29YDvZnJ98vvssoM29JzMixv1e+Vxm6BDC3qTPLklusA2FA66ps695mxKNjyqjyEmeeUPjsR4rMxR7Rn1CpouoZZ9voVeMUEofVSIymvpAhswaCDoiU2x3CdXBgMIzxHKu/BlmDQhZGg5MQ2Tjaf35fUM+Eir9RzoLw7fKzc49aj3KMfJgT38CgOhrQncmJyplJaY3xXIuFnUlwC5kQJ1PzeADzw2QCIiRv9/gtyiY2uCW5Y3YyLnJfFbxA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706633229; bh=eX4JtgM5JWpldXRyOBupGn7sL0xwi2NuoZkkvBSB9U4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aOBVLTUK5ajiuayMDOGm727iFxDZb/O8Oj/B3iSM2dzjAkDmGJLABb7KhYpjVomnd+Ov6oNocBrX5y3wpvr322meNXMGTBGl+fsdyYuUO9N1uswOmO7tLN0UmzHk720We3ZRa6xanbfENHz0SJB1ixDU4AWwXt6FNk+nEFks+t8C8CuaBcA/HeaNC3H9hhvkQn/eaABvYwSfN5ClHW4eR8EucUo182d7Muot6X7pvRdYv+DmIBkP1A4daajbk5hxssVNofHGpBypJ8iXd/8HmGk/r0rH2XC6bL1y1zTqBADMnYOlU/w/z+HH1xiSEQR2/81fUZyh/PE0vGILD4x/QA==
X-YMail-OSG: Yqq8uEYVM1m5kcYOle84ZITnAPJ7NUGa4zm2QzVsyq.Va879lljOV7L4j8YVwmo
 V1M9DHDWnS3GD5uxUi_8q2UZSguM8uQN5FjrjC5iut0PWsgAxz5KbVT1MoAGqMsnpKZEhNdE2xK3
 kHk3DifW85Cu9SoDNScU2Tcs2Z6zVhL5tHU1q4Lh3vi8flqup2jNg1Fe5sh6bG3kzz3TiGxD.NT3
 HA76Drhx96Z0dajved_HxtSImLiUfaZLz.BN904mOh0.FYGl6v9ogR6.ISJs9E_ebULI4bhq6ZyW
 cZn6jiJ739Q8oUttnx_jClQgZXvlH9ifHJRu0063MtG9qKnksVBL6BzeTHAJmdzsVIQtZLRgnruY
 zkNh3xYvi_TV50iGC3d6xA1V_rtmYXIHF9CK2BskG3pqr3Qolz3bLV1aKghaRNxDhr.wNx9rB3z_
 ZEjcbpW7rvavjeahooyuiXxAKm1RDGn1NY_dVi1vtBoqX0NZJt5cooyDp_JP9MaU5Il6Q1ZjMDbp
 _Kk8KPs6CVIdLfNeZn0jWdD2IOlecFXpgS56007FSsmblCAnZ6HYo_04kSTEW.4DJIo6ompmn8Bp
 NJ0iKk6OeuVAY8owasiEM1kYsSsMGZFoQKAGbs_ZpRW7qxKUynTZLi5FqJouoyWSJ9IPJz5SbCbM
 90y4Om8BP5XgjfVJ59C61jLouZfatwS9ShkaelnfEORnnpj.fe6BJHMEOmVIdhU9h4LkJffvFlc4
 Ka_HrkXHhep7piuwqBCkKQpL2vYPTCKtTMvOcW.3AqD44l9wl0Zd1sb2x2wlClCAk0QJUcxzz_Fg
 cmSuuO.dFAuADDGjrua1mNMpwBtgrpDHJ9YUoKJ9iN3cq1W27n.IUIl7DrMX8nlTkibyh51zvD.f
 kO1f5BlgNQQmZ1rny0vlexiLbSa84W3pEhzxbAl2Ol4Wjh4qyX28REwRbfkqPkGHXWaqKw9xaSnp
 jMQcMPCGZPNglIwiI1rQxLpi_J8TlMJZhPjsHSmIRa5HRzsrsb6Cr4tXUVQULCKlmbTae022RvpP
 r8C3KH5FNyh6nd.PUSjzIarha.BhxohWHJwz9AXQUIMSwxnhRMvSOTAK6PWEhdWKJVpyLo4PBzsj
 V.FlNvHXx_nhagKrx.4gLvqJdtFuLmpr7LWvR7dhkr4vbCtsyi5dwDOj_QJShl0a8iOFQ6OrpxbQ
 jGwdhEGRxS6AHuYB37D.QgdOx7UPPdlPFZd9hjPdMJdkH6Ptd0vTr7lE_9PRMviSid6qU.lJ4ofJ
 fbsVq06iAg2Qdq5A8wbwceK0.u1ay.Zupo9Ich23zl4eX27G0xG5QmFd0unMubOsBF55oIIN0EuI
 UIgFJlfDfziihGAW9aTFWIORDWa8tmVHKlDYfe1kleF0PQo2Qg6EdccAEZXdkYV9NRP1Ff6EkOzj
 aXvU0U5w_FSdrnUetdmS11hrLLs3Qi6ctXB_0kIHpqAiEydMT1tPJaIX2WDP0A.P26gSb0.7yTEE
 S3w2HjjYdu438tA5ls5B9w6LV08hia57cVzRfyC0FATzNTEtRUvaGTfAjkfGwJFWuf1qWS4DQVbV
 usFLhPRFgMsqZFznL3RODcrs.Qh6YYFFonzI7svTeDVKAMkIHT1LXoSE6wwLIlT7PNCEO6ZDT3vY
 duI8NTPCSGXs0I5Ib3Iet6k3z3swRRxi_Lv9P7sgcNw_w6aZiPD4t8Okkhr8USomOO4n4Qy.qnxB
 aUhpInd9S7bAQwC7YreUH08vL_G0zTWlG1lqtfXD2P8CnA7sf.s0m90mH7HMDBCUUPMaPUOH3S_W
 WHfCZHKmgwP3xWEt05yQkQzC3m.b5QxikYq42Szq.iJ_aGwAXOVWTLHvCkLKn23hF0K8eHxFCoYS
 xAIBzT5HtMrNGYxueoi9tn4RHMZwl6LZhPkkdApy6sJuHE3I.IQPIS2wbERIeXdV93CS5a16HRuX
 xuhgptVpmLpbxPeCHh_pKGlmymF1VSGf66.0pd.k83dz158KUZoAAPLaBmLegtdMYJ.ucXml4Sr6
 OEb9c5pqMRon5EE0puLpjSlWpwZazny4L0Iu.kdV5E6nL8NBrArgkI.LSCO0pSHFjqW3VR8p2Nfy
 SCBK2X5cjk4VdvzupwIwF66qssBLq0YbhIIQUMIcq1RhoT6.KOrofZEtv0vfdMdm_RGFzPDvzLtB
 TkTXIxbkiXf0NJmGYmuZoqwwYn9fsCOVz_H.u0PFHzGhNGH2B9sPRZoL9mYFF1v18Cwh3foGQgEm
 Tntd8ab2XNsBcNS9ZUBX_wiRYF4aXn7NUOLnOARULk6Jjv5QaINpSPsFhMklH4DmK67N3B3bZq1O
 cMNTMyE_5L7re
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 33dffb39-f133-44bf-be3b-105dca8934a2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Jan 2024 16:47:09 +0000
Received: by hermes--production-gq1-5c57879fdf-kht2b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c169c4cb38a1477ddc28aec5ee2d666d;
          Tue, 30 Jan 2024 16:47:08 +0000 (UTC)
Message-ID: <21d56533-84bc-4be5-af05-a40072fc9e8e@schaufler-ca.com>
Date: Tue, 30 Jan 2024 08:47:06 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: use default hook return value in
 call_int_hook()
Content-Language: en-US
To: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240130125659.1709410-1-omosnace@redhat.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240130125659.1709410-1-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/30/2024 4:56 AM, Ondrej Mosnacek wrote:
> Change the definition of call_int_hook() to treat LSM_RET_DEFAULT(...)
> as the "continue" value instead of 0. To further simplify this macro,
> also drop the IRC argument and replace it with LSM_RET_DEFAULT(...).
>
> After this the macro can be used in a couple more hooks, where similar
> logic is currently open-coded. At the same time, some other existing
> call_int_hook() users now need to be open-coded, but overall it's still
> a net simplification.
>
> There should be no functional change resulting from this patch.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Minor comment below, otherwise

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/security.c | 525 +++++++++++++++++++-------------------------
>  1 file changed, 221 insertions(+), 304 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index cedd6c150bdd..11012dcfd68e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -855,14 +855,14 @@ out:
>  			P->hook.FUNC(__VA_ARGS__);		\
>  	} while (0)
>  
> -#define call_int_hook(FUNC, IRC, ...) ({			\
> -	int RC = IRC;						\
> +#define call_int_hook(FUNC, ...) ({				\
> +	int RC = LSM_RET_DEFAULT(FUNC);				\
>  	do {							\
>  		struct security_hook_list *P;			\
>  								\
>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
>  			RC = P->hook.FUNC(__VA_ARGS__);		\
> -			if (RC != 0)				\
> +			if (RC != LSM_RET_DEFAULT(FUNC))	\
>  				break;				\
>  		}						\
>  	} while (0);						\
> @@ -881,7 +881,7 @@ out:
>   */
>  ...
> @@ -2629,21 +2603,15 @@ EXPORT_SYMBOL(security_inode_copy_up);
>   */
>  int security_inode_copy_up_xattr(const char *name)
>  {
> -	struct security_hook_list *hp;
> -	int rc;
> -
>  	/*
>  	 * The implementation can return 0 (accept the xattr), 1 (discard the
>  	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
>  	 * any other error code in case of an error.
>  	 */
> -	hlist_for_each_entry(hp,
> -			     &security_hook_heads.inode_copy_up_xattr, list) {
> -		rc = hp->hook.inode_copy_up_xattr(name);
> -		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
> -			return rc;
> -	}
> +	int rc = call_int_hook(inode_copy_up_xattr, name);

I think this is the only place call_int_hook() is used in a
declaration. Maybe break it up into:

	int rc;

	rc = call_int_hook(inode_copy_up_xattr, name);

Not a big deal, I won't fuss over it, but it might make the next mass
overhaul a touch simpler. Even more trivial: use ret instead of rc.

>  
> +	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
> +		return rc;
>  	return evm_inode_copy_up_xattr(name);
>  }
>  EXPORT_SYMBOL(security_inode_copy_up_xattr);
> @@ -2661,7 +2629,7 @@ EXPORT_SYMBOL(security_inode_copy_up_xattr);
>  

