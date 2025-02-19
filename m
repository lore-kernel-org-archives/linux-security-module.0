Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3E216389
	for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001910; cv=none; b=j9F1njOdRgJ7964flGXe9uuODfBLsnTZlBFlqhl94u9TXb7t12lUeAi8NvXb3TkhcJFzF5Jg0fJczdSbbb8aW9SSVd2k+zAUPfgOKF24Nk1EOrAHMdlr8aPyc5JmAN/scwEXXBS9OQ5yrpUIJ72ufz2T0QID30OX5u2p0QWB38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001910; c=relaxed/simple;
	bh=4o5+dtdo+FMb6rV2Wmp6zS1XLpCp3aFBgexmx+ZBco0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWR69I1At4kA3yXtsMvXSJkBHZZI3qKS4Xlv2d2QFzRwHzUejDaPS9s9qwCSoBBlEpvhY/Z6zVWJQCpiWL6/tbPbcD8PuXIYYJkr8URvh6eWMyfodLqV+VDVddXIeEYfdhdPW4CDsBiJkBjPf/knCtsR3ublWcW6MGZRgzSoBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kjE6BSi/; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kjE6BSi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740001901; bh=G8qforFtoNBqtXBu+yXzsQj2QW24dqQJUK1R5Ron3uU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=kjE6BSi/P8FSw9ffr0m2cOuGIeZNnCKl8jZEeY4kwtxN0YEPIGrP6b+JZVt7WBeKDtSbHlhD/+mZAqTBnzy6U3tp7kTY5UJI0eQMO1hUKYZtfygFTZzyDpwSkotqIuJE/dnkEqf0VMu4jiym0qrKHeXWPtBn29k66QsGJnyCaTwLq2LdEQM/7PPQ//IxNrzv9sLNsgJnluqKKbqRsXJBtMbZii6qP/clz+4WoiSXblo8wkADe7RK87LbcPu/AkmtAV6qRMToQo8+eeIOsuPrFZVxvUghHUbV6K9LkBtuRlYBrkSd12fc4eXP3eXQNOpnXVkt5MlBCYg3W2yUzGJZ5A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740001901; bh=u/x+Tyb7oqmLE2N6sS45e/dtk+1h/vdPY106PLe7EXg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=elXHx4G+P7Vas1oe7xDHg+QwnA00B2/gq0gZeUly7x/FBlxXBQbKDC9Zt9n5Kigh4q/2PuBUXo2mmB3pQuJR9yjRomp8LsZrUrHM97rjwmjNPQs2i0FUbsxuUh3tA1lJLINJExlWWcuIwup/rcyoKOQVk4i+Wh0OpPaV4mw6yZE5uw0KLO+FHoQBopRf5dnsrTVy3eQwE+zCDVd5OgeNwCzspUS8960+CCmkYugeu7hQ/M+YQtoBvZMe5MP5W5jopRQ2nkfSq0JFpSnsV1+4RbMBcr/IwfutCW5sT7tkPWAciP2m9/1GF5KfMzHZrdLUEQEwZ4zOgdPH5S8J8iLxuw==
X-YMail-OSG: _i2UJr4VM1l693NcGeZNljVvQX4nXgrVk_3re.di3hxj.CgOjWZlFc.VRY0Bp8O
 sT9D2HO0YyXWtFrbnadeSFGRp_cK1tsJ5brUttNMdj7fEiGpazmENl86MHgcOJ4v.G5MryYueH1G
 NwGU96KLqGFaF.zkM2AXcEDIX9wVveQ37HHwKOgvuJbaF4DotOcSEJSrzWpgB18SgDqvIZH8xdMz
 JphcagOmlNyj8YOM7xFP4hL8.45o9Om0ZnQrVcPmmnw6_pXSfYBe.dQ.y.JwMO5GGT9HLJdD90wY
 o.DZwtatVQz0U_aHrk5XmktoFn3CHChdstKuTnR1h31.wwtEd_8UVlqihxAIx8e1HShCkAAGpnwZ
 RVc_VBGZ7eX5hTAdKmWWNX2j2zvGsgh7XU0TNbrB02vrTKPNhMKaOh_XvQR9xh.3xHO9FJ7QCthI
 rmclw.j4ww6SbM4ej15dy26IOejflI4iaVH4WFylk34FH1CYlgeOSnz8iURnBbszkXF.aGu0k4CF
 h70nfTaYdasx0T.qJGaDLR4NLBCYSioecmJhMfpoUE3Rt2m8.ra1s2X.b3G2i1CP7M8_r_Us8yxV
 ksT7Uicgtx5A_ApPbitkKlfZhpzPL61qIj4BgnODOJdxXQFDVgyblzfZHVNOb9LWUM6i73IXn6Es
 RVvIr37kc9Ah.3j56ALMQdFLxU1mgSpX5LhHDrT0wJmtpTBnjjeKHVj92mqdkOLjjvaLbUTUEoBH
 OvAl8WLe.rE8RYtoj0j3xZQw_zS8m1UBLaHydK2aftvKn4Cv6o.6QOrR28M9GUtOV1KrYc_8AXqd
 b5jy3u1TViEEPjuV90DLTMbbXMVg45uk.HssU12HxPgc7AsJkRFLmoCwD8RGv6IERKR6nf47cQ3J
 1NhtO24mpGdbrwX0SI5hGWlW4RltYFhlO5.8gZWhhCCxn1nm3lfuDCUVCDqJkMymxasnmAKsfzxF
 Fbf_sNJWq18leVpShTzCl_X.nlwuVnUqhzuToNHUlcItDyrHAkbKg7lDtkMvfpQaMwev63nzsl9w
 BFISbF5L_OCkhi9xrXZeDwvSttvQ.GePi.6vsceKgo0Va.BLrAA_waB89jE7eS2FU9DUciGwLQ.d
 HixoCT_.cZq62UluS.yZeTNv3zvsyTwgvW.jpmT6Vjh67SeC4cgxGRhRbdMP7c9X8ayu4RbrSFKB
 kGQJkcQZaGKFRvh6I8fheyTT7RuvxDUSzyj9mSnA9OUlV2hXejp5bpxwC9xqo8XW.TjwUJJmZbjr
 YvDSBBOSHV.zR3Wyp8Gc5KpPrf9yzZ5eKt9CGysWtw9_IG2.YkpbbuZtN_9BzbZmBcNYpM8iI8vt
 o1sN43G7tE5hXMSI9QQQSvAW3T3bf4q0qhj5XBJpZpgn_bYB2GabWI.q1ttGVDP8VK42tMvO661m
 sieMBVzx.g.Vn9jChhtUqgWhd_gxK7ZmAPkC1sjeybG2b2tDoy2Pb2ZFfV_X2R5p2MUurHv4Euro
 DXbsA23v49aJNkBE9W6r2FsC4f9MTF9ZnJv56I3kYfmhS41iWLNRArokAaJp1VhB1gPIoq3CZxvk
 j7N_ow_LJR4BGEM_Yydz2k69DhECLGLEQXMLzGfoT_oImC29WI8lbPlMNjiN1RMu8EjHVzGDqKce
 0YsorWgJ8SZCe.roqI2HwkTLhe3AxgGIBRfeK3CTEw9xuXRfezZH9gVHoUqMPpjCzjysgEBVVS2_
 IzvtRwY4gg1vV8NBG.rHZucaGLCm_mtBP072Nue0.eUF2o5lozQjhsnOrH9oW_7KWOv52N6KxUho
 FOxXC_nY8oiy_DK7F8zTLx2Eux4E6eUlf2IBEBZceGrst7LoOE3PfoWyGBvi3uYmC3Z0CDpUZWmV
 Qn1kOCbncS5jkcf3ox8v5qcPO92yMWqrTdJ_lKxt7Biv7ANocRnNNTKVz20jMaRTW7Wo1_KzJdSA
 hbdH2KSEWpS8jbhNU2Yr8h5tdwxXNc6.JSFGIBoAOSk.DoDZAOVy8vfWlTgVKyQKXf0JvCybLe06
 hhn1fvDgW4wK8KiBOiZ_.koRx_nwGE6IpEG1DckpuD15mA4pZVQpsek.xejkD6IrbpBxbdvPGmNP
 lYs5H6jPkRYQVWJfrade0AEdEPzYcpKCe6MLlv7DjZ83KUsNslgsFWHCcRoy1urNm9bgeMicjPdJ
 IYdT0hXptK7kW_UOvgqpLBm8kbBYL8cGzqQrzN80oKu81kRqKj5EAGz0CpF_bqq_FvP249tu8pHp
 _oh_yyH8ZWkeIey0SWtd_03FLk637BgfsCBiOb1i_z3Q6Rb_nKQwprjRGP4O0YI2kZkOVqkX6Hcr
 rUgLL4tN8fg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 69650217-0a2a-4cd8-b701-1e66856b243d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Feb 2025 21:51:41 +0000
Received: by hermes--production-gq1-5dd4b47f46-xsxj6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9d891d70db66ebcb9254fc0c9f4e2e97;
          Wed, 19 Feb 2025 21:51:37 +0000 (UTC)
Message-ID: <205188fc-fff7-40ba-9fee-0fbca1e4a704@schaufler-ca.com>
Date: Wed, 19 Feb 2025 13:51:34 -0800
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
X-Mailer: WebService/1.1.23394 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/17/2025 8:36 AM, Konstantin Andreev wrote:
> I want to be sure that ipv6-specific code
> is not compiled in kernel binaries
> if ipv6 is not configured.
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

I have accepted this patch. It is in smack-next.

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
