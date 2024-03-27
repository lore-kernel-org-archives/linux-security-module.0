Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6414E2F1
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559521; cv=none; b=MhKBkHejgI9nhlNNDIeKLaZD2jl9qirGJTwCq7LhogGxI0FkD6TQZGuDaJUDoiMVFsNbZK1pcsbHJxex8QXV/QR5PnBgXi1uNYaX2KCUq2IUq2HaYObk7UtFMR/nM//UBfUF+9PjZh+f5FT0wNh1ddIjcDH7u3WaVIeZiscFXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559521; c=relaxed/simple;
	bh=gmH+uTacPzjyp7Yurex/z4wPGEI7RsT5ppa+mADoqcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEI02Lxnbl8a91n40RA0qOpR98t73Zw8j25AF2R846QJy/SrybSu55gubFptfmD59Z7Wjhzh5gjv2Be4Q3mRacBpvFAe54PbwsiAuo8QH2oxz8EOcuD03J5tG7uZ2Fvz5K+tQmQEe8789grQe9xVe4Pi+QVO0/P5McZfi5aMyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YdAl/ae5; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YdAl/ae5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711559513; bh=S4s/cRuVn8aOsyEwWy6dTN26SfAB3+28DeSKA/yH8YI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YdAl/ae5ufidZgQOt+ViQhr/+/yr4mzxK6WF3dcT6XVWssTg6sBbPEA7GW2qAPMoQ6NA4S50QszNwoqDTYC46lt5GP6ASgE+DO3qWsgnLMp7dOsdo///8A3VTE/iI8aYz74bSpZvBLLWztL/SLuVr+PdaI2V/9E+UehQCSche5/4Q06q+uJatQTvOy/ImMsI0GZY6WMjNGmHvRUhxNLYzielUQEI/ARqUOWsmnLmE9DR2V/nWgGgjpUYLqQezoDYO5M2mA62/ieavx/eESQJiVLk3Kv78Z9g6Xzm8Tw9xBH8YWpAZQgiFQTfd721ink2SWJWzMITw2Am7I6K69yfpQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711559513; bh=sLOWVUioAOPB9XF4o+C/pzRJ05tZvIfEvqVuA86OJo3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ukvoBRV8Z+KJm8tkjLKHFSZHo/86FL/5D94Fp9sLk1hXTzB85K2PddvyiQ41Q69pdkSJX3FUrZL0rqxQXKQlms1M63TxqCDQ7giGC4N7mgXFpkjsdrYGo3hElEmG1kchZkfRO0EW7n+8+Ep8YGn/9Ja8oM+1D2fgCoJQGMaIITbs0BFoNt0OSAWZnRTu/P0cmhGhVhGbJpCtGV3kjEQe9u2ZX4SuWq8DrsScO4zT84bGeLnS9ACD8TUr/tYM+k1vLkW4iGUQqihvnuSHz+yHAj4h+tTQK2ptGSuBxsvo5uu3KSYXHKOazxZlECt+G9DcMaTT/f04jZXpNKu/vLA8EQ==
X-YMail-OSG: YvPU9YQVM1lEBtPAUIB9HWblh9TRRUZhYxzmSA0si_DL1F1kzQ.9fjOyiKsIwQk
 qbZ1Dm4zEq5HgN5_4JjAuxs9SgBdW9y_8t0VNBNwRASwDu9Y11dKSynIAkF9eFBP0I77FmB2hxrm
 WwnDUMGi1iT0ZKXPK_hD6YqcOWutdt_mbacCYySgZIyhpng_m.zda566cvOraagqDHwLO7qHOyCO
 iWRZ0NMp4fLRAipraMlgPBMcxZm_O7DX7ZLuB.0PI8mMhH..B5IdNu64jIChH67.PRdNus8L1Mwe
 35Xq2FskOcSaFTHltkMfKgv_Wzx3WZnteH3Nnz8MRpmjb8lET0QSZ.GQRjLK95t3llvsr5BRAlcc
 T92dwmazwKovBxZnS.JHmK37aWUg.I1I7cvn8o9VjhF7QrioGdpVCGW_.dCHejK0_DTdW2xa81aF
 jvmnuISsPPrSJ2ovDZxvP.nV.XxdC3lueoasQQr7kTuw8MlQIy.FjGDpmkZkukZoStycr64CSz_1
 cSlpDj4ulSvF.fSvlOLe4E3569OLrFHEDX3eBu6EfKejWgLOPGX5Sy1gy3w9Q2zSBpgdRXufZBo6
 LmzQ_2JL63TLVtziakxg38pWFfuJaJ255wSDJC.9OblVvXKHKZUAFwu2g1eR54TvXh3YRQ62CETI
 D5F_mFIz5ciGmMsGZTME8iISLku0dzBKO8cM3CehgR6LhEgHhb1X08qzwT_Bx1ba6w3wI1hcFj9E
 udAz6_aIVmAtr21FNvO9O0hgoC92vv5TodPX1jtZezw_kXVG108yeNjaQFg7rUsirGlRSUAe2aTu
 .QNZETUJeI2a4ty471vQidYDHR_fBZg2AYgI5LJ0gIg0FXMsLPU_KPDkxlcLh72zR8_t9NWsrug5
 .PnA2gZB8itqim2Z20ScVtVBkAMzSU3VM.LlGzPA8FsCurPO0y5J0KKdvfrSvWrXyfUyCRaaIxyg
 rW46yqez519KpQI13XMttRWHAwvVBM5Lg8TIRV8I5qwItysrBw4.M23s8gNPxDHahLYyYh9QW0Pf
 UWC56BvQ8Cjg5uhcVlNeaLK6l5XkQVf4aK4VN2Hytop.ydbe0nxUcvi7IrwzCxklrMfyGeBWU4PW
 kpXBXoPWYQXV2qxX959jPWmClhQpIh6A7IM5I5ruRFVRzDTpv7mYI5Fu8uosqL5l1VlR7Uuj_cUN
 .AG3WrpDuYZayM5byAlGML9REvQtIL81N.gyE4TKhW_ZjsRXO8u0rCM7_o9OsXej3tzbFeV3zfZJ
 Cb5U8YwZ532299L6Dsk3C4wzhdUuM4OEpyzwhOApXNYsyxP4oQcBLmneIdS4d9O9UhwBN8GuL1C2
 WojNxuDXuWDTpc32cJGOWS8.heuW1kwB8._5cq2Hijun7._d9pvsQQw_KQirbB3Q81pFZgg.vjXf
 cL2dwRLDwHU06f8ew5G8iZMuXb6rPFu5tAHdyzZR8vgkvn.8lSldz4UerrBIP5K0poncIQGMSKgc
 evSQ5w4fpDptjX7k6qHfGCt4UgfR008cUDdXqE2h_PMQW63WYUc2Eu0ht2K9ueaPvuyOPmEtqXMQ
 eOPNyKztSNCSoT5lm0LoCp2uGOgAfGVZwJigaCnQPgHpMjL8C7tJk4T2eW5zY_L.9sS6Ha4TPoNP
 nxjecjXk2IP7pXYl8oYGqlIcvTEbi2rw2JSO2doxVYbpz8HQ4iVaTy8aBFMbwcgiVpoZo.Q.h7X5
 eQnnYlqDTAE974vycsyN3t6Gnqvv0gcTtWtdI7j6XjL8Mc3HSZn3F7n3QuMxBIwd8i_Aas8BXInq
 IUuCizsEVR2A1Y4LtysYQGH5M0PHqd4SkovPgvi5QHYwIs9S0QVbpvs3YAuogtE..CvqkkxUk91y
 CtD0ssHSqO0.A3so7InbOrOEqK_l4_IhpR1Q.OG5_FWzgdpnjXhQvaotmrmU4DTgHrKqjZgTHOZJ
 w0d307532k5tMFHXTuu4mrgoeHIu.tzbEAHA0Z6C66jLjnyHc2tH3pZpvJD340ahOO6g5eqe3QRD
 YiOZMidYBXppFArdXe97nxYy2_psJeKFPK1DQ3hOLeq2eHUgKwe3vcYWVLa.2fZwZ7OkKsiik_42
 bnmxH2aVVCAnllO1S72AHxLEe5SH09cC1a4MdT6JYw1lVLz_zZkvOX4Jvb3vSqBH5DsAfCksVHpC
 lrKW8YcMW7vhFU2bRDfIAkuPvOvORLMcSZezpoh1uK0srTePkuPMA4MGp5OSPtYPhdiECDwVzjns
 TDlHFsLlAF125YB2m0xA9Vsfx81uaS9uACDnu97Bpi8hAgV8St29uw7XCSTXo70yB3FTMu4Jp1iZ
 .DfBSG0xdLuw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 87e86a45-cae3-4f9c-90d3-4c3d3667730f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Mar 2024 17:11:53 +0000
Received: by hermes--production-gq1-5c57879fdf-c7xks (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d60cd2f837db50b116b6abd5ed0cb669;
          Wed, 27 Mar 2024 16:41:26 +0000 (UTC)
Message-ID: <cebcfa4f-885f-45de-b629-165d521a2756@schaufler-ca.com>
Date: Wed, 27 Mar 2024 09:41:24 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 Alexey Kodanev <alexey.kodanev@oracle.com>,
 Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240327120036.233641-1-mic@digikod.net>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240327120036.233641-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/27/2024 5:00 AM, Mickaël Salaün wrote:
> Because the security_socket_bind and the security_socket_bind hooks are
> called before the network stack, it is easy to introduce error code
> inconsistencies. Instead of adding new checks to current and future
> LSMs, let's fix the related hook instead. The new checks are already
> (partially) implemented by SELinux and Landlock, and it should not
> change user space behavior but improve error code consistency instead.
>
> The first check is about the minimal sockaddr length according to the
> address family. This improves the security of the AF_INET and AF_INET6
> sockaddr parsing for current and future LSMs.
>
> The second check is about AF_UNSPEC. This fixes error priority for bind
> on PF_INET6 socket when SELinux (and potentially others) is enabled.
> Indeed, the IPv6 network stack first checks the sockaddr length (-EINVAL
> error) before checking the family (-EAFNOSUPPORT error). See commit
> bbf5a1d0e5d0 ("selinux: Fix error priority for bind with AF_UNSPEC on
> PF_INET6 socket").
>
> The third check is about consistency between socket family and address
> family. Only AF_INET and AF_INET6 are tested (by Landlock tests), so no
> other protocols are checked for now.
>
> These new checks should enable to simplify current LSM implementations,
> but we may want to first land this patch on all stable branches.
>
> A following patch adds new tests improving AF_UNSPEC test coverage for
> Landlock.
>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Fixes: 20510f2f4e2d ("security: Convert LSM into a static interface")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/security.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/security/security.c b/security/security.c
> index 7e118858b545..64fe07a73b14 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,7 +28,9 @@
>  #include <linux/xattr.h>
>  #include <linux/msg.h>
>  #include <linux/overflow.h>
> +#include <linux/in.h>
>  #include <net/flow.h>
> +#include <net/ipv6.h>
>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> @@ -4415,6 +4417,82 @@ int security_socket_socketpair(struct socket *socka, struct socket *sockb)
>  }
>  EXPORT_SYMBOL(security_socket_socketpair);
>  
> +static int validate_inet_addr(struct socket *sock, struct sockaddr *address,
> +			      int addrlen, bool bind)
> +{
> +	const int sock_family = sock->sk->sk_family;
> +
> +	/* Checks for minimal header length to safely read sa_family. */
> +	if (addrlen < offsetofend(typeof(*address), sa_family))
> +		return -EINVAL;
> +
> +	/* Only handle inet sockets for now. */
> +	switch (sock_family) {
> +	case PF_INET:
> +	case PF_INET6:
> +		break;
> +	default:
> +		return 0;
> +	}

Seems like a clunky way to say:

	if (sock_family != PF_INET && sock_family != PF_INET6)
		return 0;

> +
> +	/* Checks minimal address length for inet sockets. */
> +	switch (address->sa_family) {
> +	case AF_UNSPEC: {
> +		const struct sockaddr_in *sa_in;
> +
> +		/* Cf. inet_dgram_connect(), __inet_stream_connect() */
> +		if (!bind)
> +			return 0;
> +
> +		if (sock_family == PF_INET6) {
> +			/* Length check from inet6_bind_sk() */
> +			if (addrlen < SIN6_LEN_RFC2133)
> +				return -EINVAL;
> +
> +			/* Family check from __inet6_bind() */
> +			goto err_af;
> +		}
> +
> +		/* Length check from inet_bind_sk() */
> +		if (addrlen < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +
> +		sa_in = (struct sockaddr_in *)address;
> +		if (sa_in->sin_addr.s_addr != htonl(INADDR_ANY))
> +			goto err_af;
> +
> +		return 0;
> +	}
> +	case AF_INET:
> +		/* Length check from inet_bind_sk() */
> +		if (addrlen < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +		break;
> +	case AF_INET6:
> +		/* Length check from inet6_bind_sk() */
> +		if (addrlen < SIN6_LEN_RFC2133)
> +			return -EINVAL;
> +		break;
> +	}
> +
> +	/*
> +	 * Checks sa_family consistency to not wrongfully return -EACCES
> +	 * instead of -EINVAL.  Valid sa_family changes are only (from AF_INET
> +	 * or AF_INET6) to AF_UNSPEC.
> +	 */
> +	if (address->sa_family != sock_family)
> +		return -EINVAL;
> +
> +	return 0;
> +
> +err_af:
> +	/* SCTP services expect -EINVAL, others -EAFNOSUPPORT. */
> +	if (sock->sk->sk_protocol == IPPROTO_SCTP)
> +		return -EINVAL;
> +
> +	return -EAFNOSUPPORT;
> +}
> +
>  /**
>   * security_socket_bind() - Check if a socket bind operation is allowed
>   * @sock: socket
> @@ -4425,11 +4503,23 @@ EXPORT_SYMBOL(security_socket_socketpair);
>   * and the socket @sock is bound to the address specified in the @address
>   * parameter.
>   *
> + * For security reasons and to get consistent error code whatever LSM are
> + * enabled, we first do the same sanity checks against sockaddr as the ones
> + * done by the network stack (executed after hook).  Currently only AF_UNSPEC,
> + * AF_INET, and AF_INET6 are handled.  Please add support for other family
> + * specificities when handled by an LSM.
> + *
>   * Return: Returns 0 if permission is granted.
>   */
>  int security_socket_bind(struct socket *sock,
>  			 struct sockaddr *address, int addrlen)
>  {
> +	int err;
> +
> +	err = validate_inet_addr(sock, address, addrlen, true);
> +	if (err)
> +		return err;
> +
>  	return call_int_hook(socket_bind, sock, address, addrlen);
>  }
>  
> @@ -4447,6 +4537,12 @@ int security_socket_bind(struct socket *sock,
>  int security_socket_connect(struct socket *sock,
>  			    struct sockaddr *address, int addrlen)
>  {
> +	int err;
> +
> +	err = validate_inet_addr(sock, address, addrlen, false);
> +	if (err)
> +		return err;

The smack_socket_connect() code is among my ugliest. I don't think this
would do any harm, but if you haven't run the Smack test suite you probably
should.

> +
>  	return call_int_hook(socket_connect, sock, address, addrlen);
>  }
>  
