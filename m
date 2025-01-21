Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3091F238E
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jan 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737481149; cv=none; b=CfMSiUexzec9xYKa5d3gG7hQjlKw6IVWaDTApTX0iOm4jfjLEQR/rS/eNOuvLJeqdjt8Vm6H+ufxBGQrJRmKXM74bjq8XdVSrqsvEArO6ayT4sa/L4X7Xl2S5CcCKAV04Sct+6cJU3MjnsxX8XKmRBlg3/dp4BjHHSYJio8DKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737481149; c=relaxed/simple;
	bh=Mjd/e/JvtmgejkmIdmev9p5DOrNmC2yCFPmaLYl470U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hyvrigrs2bEVBbhzpPf9Q3lbrX8I4OKyFeTI5Dt3oo4QWUTxcCs+M6YTvM68m2yLk3RzWevGp5KSBWXsmCgw+F64C+GMnXWEN1xclR3kV0s8jg61NiU/ZvwsRtgUciSCFNWg3bF3p25kuZraz2miMK6Jr0mhFfWt6z/5wCO4xWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qrAz824L; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qrAz824L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737481140; bh=C0A9mnZXjtU2iXGsyZ3JoaLGvDbntYZqXFe+JMTXumE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qrAz824LX42qRdXJcowvyeBOmV+Hy9MiFvxslsYg3udVW9/vS/md9KkOndR7aDeea6PawMVMok0iIgssjG06yV1zAjhlrdNaeIN3QrEDtBovAZDWbTwiKYzLPPNE2ccog7s70mbAUyAQ06xEXmV6UTmHj2a43EvfJzELCfZOQEfExuGg+8a5e+0PO0mjlfEsgyHyJiRk5vC5E2xzl1WOJmJA9FnstcNWPsxfG/p0W8nafbcEDSl9t3CG7WtOjDOu1E5h8UpTOZDPs7XPoWNpFZzWoJ6LtgrcBLt20BdT0NgqF+tnvmetyBzLN8yZ1FS/MHCvNY56hY6CcyknPWdT7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737481140; bh=fKTptBg2z5uPhdKzRcoMi7FFRP1wffGO4uuV6UYc8w7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=T7ABu9Wg/aygnNW+Q6HjDnFu/CLhtcKjNOfZie3/xk9oDZu63u3RuGc7afre1EXLiagcKngXS3Jau4rIM3dIAzcw+YQIA79RTtwQpSasOHqXHs+wjiNnwWBZ6pLgs59IPTypDErDGt/C/VlP5yBqsJurATmgeiEhHnNKRriuNGWrkE5nRtfMm166Majb+KzP0gRTAdVMWWCt0tFtmImKVfobv7s6wSudLD6EM5pGI/AKuGq6wbEGoyCp9bPRtp2yoLK0VM2wEcpDqj3mN1ORVNVwmDlkh9dq0aeEM/64tqG+fvf4lwmfjTxsOngVAcxUHirq4a8zltoMYOuu2Vi/xQ==
X-YMail-OSG: T8pXtAAVM1m.p73y17ObzY0GhhHIYJLJ6mZrr1AcPjbgaW.M4NDdqHDjzME90Z2
 3hP4cy6jVAqvxP832kz1Zm75W5P5WRolBliJCDDrlDQzrOQ2h49X_MqNrue6DUSIqBI7GEWmoVCT
 9c5O6L949aNsedJV2lkJ2azus_m5weKBfYyUVx3UYzMAxRc9yaIjrUV.lTdO5MMwGFC6DpWphPNr
 qROFVqIQf7pPtboNUQbChGZyt71sE1WraLO3KhH5LsVc_KWqFJ_m7.VdKGYp6RvoWbLxkuL6s45M
 uGPT0ovT4IJF5se8PW7VZ84tfAgDFJ0wZ1hxI6_ex13y8S8d0FDMZv5zwYG4Gm6exK2pH7YF5VSc
 KY7SUnb6vlCLYZyRKBC58QFa49fNiOabbojZDmILUAjzEtT9RHgm1amQ5YvdZbAjjxN21nDFYeHs
 xnWSWbHADRptnLsV_gqrP6fRcRp_NE.pOuFvr3M7eXJuhGEHOEdv6_lYI6Bdpw.Phgf5l3QEZpNp
 tU4MLXhVx0ADpxQcMyzqCeuAgo8ar7xdC20IE1JdDB.oceGI6vutsxMDQoSCE3g0LSKc7HO2RFZV
 ajzmE1T55YHLoEYsUIFELNyZcR7agEtfWxC.993wjrik3JJIDLs2nPJFKm4rLr7fk4YfORT8tFp2
 o6y9om3ZWnAj7IBsAsJm7N_L0lfX3YrSmaf6md9GvIcwZ22EJ.qsWoIBLwS2Dqxg8aG40GZ2cVMY
 mDpFngDau_UF1f1ttJHlbZzDvdw3ChwY8aJdhGOqBoItftswufdhFQcb1ZwhQjH6LKstElref28l
 BfthdPI_KxJ0hZKFBGDLrz8roE0ZFu0jv6ABOENTXi6f5CtNfGM5XCXDHcmj0iNphj0lqjrMGi05
 7oj1r.xnsZWNxr4jOGlV5gdVP0QseugyIP36CM8yKkqp9905JMbSVQwB7zPSyjlgfY..5Wb6hf9L
 Kgm9kgNZu01PZqdamBFZdl.oLOiJpkDblctC66DajEs8XFV1pts5ZeyFwbFhU7za3p5PtZYebqko
 pJCkrnR3qPUl9MA46gsZoCgc4PE.3qPoN1sJWGmM5k.1Mlmf.79j.xX0acMLiChkru7ZgOWjQVwm
 WnLJRrIl0UTQc8HguUCVv_dFVlFJPV2gZpOG56Eyg2j.GYu57_LQPUhSQcaAffRDbsioroFglosi
 nSys_t9qYJ2E0SFm7OpR4xBooEJaNXjDmD6htyiAGlh_p.qCJhOZfxYqgAWqjioP4riVkFAIiLal
 _k8744IBnph81ZDmN10FqQQK788r48utcdlbgsEZqiqiboK2_t1jBN0JdzYaSV1Bz.YBzorxZOyx
 Wp3XoKM2i7SUNH0dcnyBxCzfvdl7dCrkAjH6j5xO3TiqH8fu8MosVf0WsXI2lXAd4HAhpJw.89ZH
 fAVs3KddAQCsgvhTKfgO4rnCLW9fQ4CcslDXGgySHsVE7GwIc7cLmGP5ng_ShPhEY3rWXxSCljij
 qdX8PYWlnRlnyNzl1nxwZSzErJg2CMCSKbYYMSdTMbxb9wrdMo5CJDl9v_1En6BFxwFdJhjvBlLy
 p97Dqk5oaEXvbKUdilRxQU1NlIBc4YF3di.0vwMOS3wMOLCVuq.xqD2Vnqw2vMNgq8Y7_kjJ._A_
 OPdpF5pcjEwpJifjjI._w9e0MX5apG39.HReLjH22VcaxhyXndccVNcfDi8gBefUi_jmVYScRT9y
 n8AjJDDDsL6HVmgLta9zihAy40SR5PuUVJPWXTO5OyOyKMNaTNmS5hQdtnpV.74zflsJRPOmEm2Q
 awJnhZzc7EcHpZHkgVc8QnSS1IFpRJZ_tEUzwGkLyj6KQoPPrgGbPn.lU0TCGOe6LKNQ0O81dMFj
 RPlUXOnpgG9dAYleDjFI9S2fNRX0dbdXVOpxaDgdnQ26xX6VtlhZ4LqFxlPTCIWMJg3uvMMHzql2
 4IkEMLQlbeh.ONB8guhN9M1Y_C46x1AgnAjEw45XFqXBI63Yp07ZK1F0qHIw1UZgry65TjmO_snC
 NwHDugHxoI96OuuRX5_hez7qS.A1VdhUWzpghWLAPHZ5t2ceHcqryVHZmOtFkOCBGGKKJSVzkFTk
 65mTY5nJaGhzj9BzebTpUaQPa_sIPWd3kEwk9Vz3nKAzyYM4YrZj8QWo7zBNOgthBiE5W.vAGBt8
 ov7YDEATGVvJL0McsKB67s_U_aD3dDd4a2s893h7I30PxGegM3vTTzaMnzrjFuqFEkRvLFojr_C8
 CAN03xJGrQY3ve69NnCf3gh6DHNs8eASEU7an6w3QSTbMYkVBWzUebUrwnY1s7YrRVupXLBW5Tje
 4eQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f01e4cba-cd24-4d4b-87cc-d1d6dc98e745
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Jan 2025 17:39:00 +0000
Received: by hermes--production-gq1-5dd4b47f46-xx4tp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6bf86920c876d71d6153de6bdbb93802;
          Tue, 21 Jan 2025 17:38:58 +0000 (UTC)
Message-ID: <40046ce8-1117-47a7-80a3-650f7adb1ecc@schaufler-ca.com>
Date: Tue, 21 Jan 2025 09:38:57 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: dont compile ipv6 code unless ipv6 is configured
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250117163645.3069927-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250117163645.3069927-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/17/2025 8:36 AM, Konstantin Andreev wrote:
> I want to be sure that ipv6-specific code
> is not compiled in kernel binaries
> if ipv6 is not configured.

The IPv6 Smack support really ought to be replaced with an
implementation of CALIPSO, now that it is available. The
conditional compilations that already exist have drawn no
small amount of well founded criticism. I will most likely
take this patch, but if you want to be extremely helpful
you could have a shot at CALIPSO for Smack.


>
> [1] was getting rid of "unused variable" warning, but,
> with that, it also mandated compilation of a handful ipv6-
> specific functions in ipv4-only kernel configurations:
>
> smk_ipv6_localhost, smack_ipv6host_label, smk_ipv6_check.
>
> Their compiled bodies are likely to be removed by compiler
> from the resulting binary, but, to be on the safe side,
> I remove them from the compiler view.
>
> [1]
> Fixes: 00720f0e7f28 ("smack: avoid unused 'sip' variable warning")
>
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
> ---
>  security/smack/smack.h     |  6 ++++++
>  security/smack/smack_lsm.c | 10 +++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 4608b07607a3..c4d998972ba5 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -152,6 +152,7 @@ struct smk_net4addr {
>  	struct smack_known	*smk_label;	/* label */
>  };
>  
> +#if IS_ENABLED(CONFIG_IPV6)
>  /*
>   * An entry in the table identifying IPv6 hosts.
>   */
> @@ -162,7 +163,9 @@ struct smk_net6addr {
>  	int			smk_masks;	/* mask size */
>  	struct smack_known	*smk_label;	/* label */
>  };
> +#endif /* CONFIG_IPV6 */
>  
> +#ifdef SMACK_IPV6_PORT_LABELING
>  /*
>   * An entry in the table identifying ports.
>   */
> @@ -175,6 +178,7 @@ struct smk_port_label {
>  	short			smk_sock_type;	/* Socket type */
>  	short			smk_can_reuse;
>  };
> +#endif /* SMACK_IPV6_PORT_LABELING */
>  
>  struct smack_known_list_elem {
>  	struct list_head	list;
> @@ -315,7 +319,9 @@ extern struct smack_known smack_known_web;
>  extern struct mutex	smack_known_lock;
>  extern struct list_head smack_known_list;
>  extern struct list_head smk_net4addr_list;
> +#if IS_ENABLED(CONFIG_IPV6)
>  extern struct list_head smk_net6addr_list;
> +#endif /* CONFIG_IPV6 */
>  
>  extern struct mutex     smack_onlycap_lock;
>  extern struct list_head smack_onlycap_list;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index c3f8de53aefd..ce7d44509973 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2492,6 +2492,7 @@ static struct smack_known *smack_ipv4host_label(struct sockaddr_in *sip)
>  	return NULL;
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV6)
>  /*
>   * smk_ipv6_localhost - Check for local ipv6 host address
>   * @sip: the address
> @@ -2559,6 +2560,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
>  
>  	return NULL;
>  }
> +#endif /* CONFIG_IPV6 */
>  
>  /**
>   * smack_netlbl_add - Set the secattr on a socket
> @@ -2663,6 +2665,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
>  	return rc;
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV6)
>  /**
>   * smk_ipv6_check - check Smack access
>   * @subject: subject Smack label
> @@ -2695,6 +2698,7 @@ static int smk_ipv6_check(struct smack_known *subject,
>  	rc = smk_bu_note("IPv6 check", subject, object, MAY_WRITE, rc);
>  	return rc;
>  }
> +#endif /* CONFIG_IPV6 */
>  
>  #ifdef SMACK_IPV6_PORT_LABELING
>  /**
> @@ -3027,7 +3031,9 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
>  		return 0;
>  	if (addrlen < offsetofend(struct sockaddr, sa_family))
>  		return 0;
> -	if (IS_ENABLED(CONFIG_IPV6) && sap->sa_family == AF_INET6) {
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (sap->sa_family == AF_INET6) {
>  		struct sockaddr_in6 *sip = (struct sockaddr_in6 *)sap;
>  		struct smack_known *rsp = NULL;
>  
> @@ -3047,6 +3053,8 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
>  
>  		return rc;
>  	}
> +#endif /* CONFIG_IPV6 */
> +
>  	if (sap->sa_family != AF_INET || addrlen < sizeof(struct sockaddr_in))
>  		return 0;
>  	rc = smk_ipv4_check(sock->sk, (struct sockaddr_in *)sap);
