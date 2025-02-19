Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6D23DEB6
	for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2025 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002089; cv=none; b=BsQ7J3y98tgM5keFMELj1eSkmrtKB+j0DeEIED0aXEm+F707zFgZCiAGC0NjndixL2Rgd1h3phAJD68t734WSVGwgr6UVZCmHPsldPbQuABbRqiUcNBVoJ8NFxLLG3R9dkxoGFuhOo+FufUXWdnGMNT4WfLXIr9wwgmSfQrP8SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002089; c=relaxed/simple;
	bh=9Ku9pMB4kt/k02+wHC+lbrXe1wvqEuDsnDXLxdTBU1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxPU+z+ebipdEkslZhUBZrICiHANYEtwsuxPzfcbmXs9QmGm0U+sB3o2t3Th41AonEV69oJdE3YP275aLKiIXZVsWedwqriQR2wgwBnmFXZhoY4Jd9XgnUUPYFHB2suHTj2wBOpXQnXp6QpYDY8qMbreyB1znmda3UEfUOJ1+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=aK9zRx7K; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aK9zRx7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740002086; bh=FVnfgmx0V6brS6SXbloTGvC0lg9apx7f4ABj0LYxkKI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=aK9zRx7KdWE7i4Hz7usE7V2Obr04cIA0m4uDvuEKE8P1eGSeuuWQ37cd7ml4XWsO7PmErrmqueckGQuhArM10mK/znrweOdaq7iSbmmENia9eFK6Q0BRsodGUJXRG+emV9yjOPvuFnMhF0i0TDf+SiL+fXitIlmleB58ki2fUivVNhK3j5U9BzT+dcpUR8gWJwDulSjlzK12jDDbdfWBrAT7ebdP+0sDD2ux6WxsdlI3/SwAF3JeoJ1E8sJVkOV6GWPEaftnQRbF9OkYt9/7Hv1L5juinV+Y9wKZEzxLuxvzzsTClHX6Z4VRInRNQCbkekyca1mFJdBlH4B3E29fwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740002086; bh=B73I1U3SXoznEjNuH3z2Jv96tCXn2ZR09TyezhBY7sr=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NOfeZYDaYjpx24OgDRTG/7ncKzG3W5+GPLnDWQkJ5ut2j1985+tiy2jS3ci3HPmS6hkriY+ts4MnoKeMMCYMNSUEilxnxNwayMmxB+m6lfM2OL/9Yr/eFU+mDqjjsMNUe97j6erur/5iSjsTqXH+u8yey8M7c3zOStvgdS/8w9olmzNo9PW8zUuSxIXHJVRkoGch4iUlu042ovpAtwRKkloUAXeTJbDGdm0WiGuU6rX02q1Gj5XwGfAftzXfFSUZD9hn+xxWSxjSCkq6mB/cSk3ca7zs5jjYfng8+WnYiHQ8Nayh6Td7d0HGwa+48SQ6UKQ5MQF7o1ZVFqAu66oUag==
X-YMail-OSG: DIb9D5YVM1m3U5PADDgAZJXfBm02zYZcZXYItjtV88Ey2MZE2AbHm4Nqrc8VKNq
 HMJo6DZrQSOotCUloHCqc51hs_4mXD_eFiA0E0dtwb3vjznfQzSmWODZkBYuDNb9u13SHoUXg9Wj
 IvdtGIsfEjn2Z.sWqe8PtP3i4NBdtqvzh4tihOux_a8nnWZcrkh5LXQ.1ehHqymtsGGQi.s3Uxde
 LFb1eLOke4WkozXBvi0DPX4JaMHnNSf4lsxKBnxR_yNvAOAHQWVou1YXbZlSBbwBv1oWoLriGN5.
 E1MUExTjd91DO8HKHbj5o6oi7H_i6BumNxyQS428PL8Bh54vvSNj6TiqLJCBi.hawaDhUmytxuOc
 ObTcmOGR20WIj7eezePpphbz9ndXXsdJgHgAvWGlHb.8hyYcjJLWtOrSZ5AfXOjUzGWPRbksM_u4
 9kCkF76SUM96QEU7YRmUnmk4Rk99G6FXKwyqQBRSbSVpZxu0IaHze1zxxmKiELfTqAwQRSqNCqwK
 bfjMenCiJjMEzP43eNK922WsR0eD0H3VOvIqgLDXfvUCrxX2hcgGZvZ4GGoiULO8ScsL9W09ZR2r
 4IZ0x6rxoPzYOZP3BxcFpE0mxrpo1BREDqgIluVBT1ZTh7hGLQ.w1KYsqy00Bnw5R8GZ8pC1pJWo
 0RxK6kb2ium5R7gArj1AIpCB2iqj.aORsnS4RZQ8vDb.27lpH9AC9NIVCn8H062eCAbiHLHFW9Wx
 Xv1YOIBPxjgGmWUN.YkeU1nfDdKy6K118xGjs03.T32Wb7xUv5s8M.am9cozAv0NkjUjdsa0H8CW
 u3_euS2HEjwjtKmaXNgbxNwIIArEyq06zdfEloOxc5AY9D90YfvH5zYEk61ducZy5pNMsGt2ZxHz
 gkCGxmLLIcaN5Fb6QYVbD7f.RSpDzmf_eQbrg2vBWobMsuxDsryEQoWP_dzdZSyAJHdKttuX1zDQ
 V_dKSout3_8KgvyYmMgtih8AMcGSOXQVVtCF8dQ7kzIZfptUhh.XF3fenzr9EBzMAKahe84O0mwP
 5sWErcA6lgzghcbNZbqVEvo5Whxg0Y104.RAWnTN8LiUway4Kc_V3CF_GfhiW0ndJ4NXA9mN08G2
 .D0gRTMIoncJgNzL6BvU4ik8XopcY13P0iLc.MBXjmc3i7VFqe.L0wrUhUkrH_H9yyfgZQmA7rGp
 tqAynYTxmNLfQne1qksbSSDHiQUjvzPTf6E84BPwGc8Q4yrBGspYmhHzYq9v6lL8P_EW99ecYdZC
 IKjSfv2l8abX_2WhTCcUZdnrSUJm8uy5DHQyHwiX6eSfXUebT1KF8rNM7NgFWSX5fPoZ8g_TmQMT
 C3YVXG9pSE.J9MlicsKcyBViw7DltAw1UHoz6rgT4TT5Gdq5KRBKqC7jHtzqfIhKj8hVKGsJx34o
 ezbSzoJYR2c9sUlzr8Ud7bDZgbCFGj9noSSiCq6hXI37qvj4p25PM4.X8WcfN_TFXgcW7BQybn1j
 uKxo6E9q_oNj2YCZ2kfC9I0NmkCWu3PKRPdWgvdUJLuf2aPUxZulH7qVE0VzZvqayZ_k81SePs83
 4kkUxKjPjC4anwaF4w2IFDg2r0y4i9ncZzpor9ULn6DBcLMXj.onapNf7RawYiJOYhthkmfWw3iy
 tmL6WAJpOCNMld1fafu9ebR4Xr9LqcZYdvUgs_vTtP2WrgUKqehioeNxl06ofCKtLCKrDmOzsRWq
 _OWynvfDBLaC1K90QO4l.mxvmEV59IM.pOWZeARqtC2k_pMqmqGfINPClQml06R.se_ffUqi4AVN
 yPEaj8Pnw1N_pD0yBpxyfG9.QbTXtY7PdTowWSnFprF7XF2sPPr6n_6KKnUd.MquiH.Pbh0Uq9XU
 u9xrhhwQHDRc5zAkfnnNXoBCYoUi5ig6cXS0BphjvYBdpDgZTVcRA0BYbUhyL.rutJdrgDT9Lzcb
 TZGSwK3OX5_g5bzQWjYLNn58nAolhrxdooweH4QWpn2UomuJoGkASRQ3dxHphnnpxc8hd1FfL9a5
 K8v1ad_rXNulsnrQcG9OebjOnmoz8xASZzKjNuXl1X4H4vH2B2loizmzomBYPdnV74G9JG4M6J9O
 2C33u3_r7xwgg9qxZfjg3OaiTyZVlE1sIgp_rhhGWtOjeJ9zcmVdZloOdsM5j__IiJRDu5ZvytPp
 hzIVGsHq7WZeePtvuTt6eCOOu_0k64YnNRdBr4zoP1LFgl26taX9zMIwwkUZ_VgMvY7UrTeE1AO.
 aE3sQlW263DxpEuK08kUUqmc24yqTujj.6E8dnI7rKJHV6yO3jTU48OF_bvOecC3.rK9SaCmfdqx
 WRM2vS9ix0etuQ6hByxU8.XaGGN0X
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 995c5849-5748-47c2-8267-08f51816560d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Feb 2025 21:54:46 +0000
Received: by hermes--production-gq1-5dd4b47f46-9j75b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3e73d72e5d241818b13006ef21946cc8;
          Wed, 19 Feb 2025 21:54:44 +0000 (UTC)
Message-ID: <e929c863-a569-4911-a617-8da02fa826ba@schaufler-ca.com>
Date: Wed, 19 Feb 2025 13:54:41 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: ipv4/ipv6: tcp/dccp/sctp: fix incorrect child
 socket label
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250126140735.3296531-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250126140735.3296531-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/26/2025 6:07 AM, Konstantin Andreev wrote:
> Since inception [1], SMACK initializes ipv* child socket security
> for connection-oriented communications (tcp/sctp/dccp)
> during accept() syscall, in the security_sock_graft() hook:

I have accepted this patch. It is in smack-next.

>
> | void smack_sock_graft(struct sock *sk, ...)
> | {
> |     // only ipv4 and ipv6 are eligible here
> |     // ...
> |     ssp = sk->sk_security; // socket security
> |     ssp->smk_in = skp;     // process label: smk_of_current()
> |     ssp->smk_out = skp;    // process label: smk_of_current()
> | }
>
> This approach is incorrect for two reasons:
>
> A) initialization occurs too late for child socket security:
>
>    The child socket is created by the kernel once the handshake
>    completes (e.g., for tcp: after receiving ack for syn+ack).
>
>    Data can legitimately start arriving to the child socket
>    immediately, long before the application calls accept()
>    on the socket.
>
>    Those data are (currently — were) processed by SMACK using
>    incorrect child socket security attributes.
>
> B) Incoming connection requests are handled using the listening
>    socket's security, hence, the child socket must inherit the
>    listening socket's security attributes.
>
>    smack_sock_graft() initilizes the child socket's security with
>    a process label, as is done for a new socket()
>
>    But ... the process label is not necessarily the same as the
>    listening socket label. A privileged application may legitimately
>    set other in/out labels for a listening socket.
>
>    When this happens, SMACK processes incoming packets using
>    incorrect socket security attributes.
>
> In [2] Michael Lontke noticed (A) and fixed it in [3] by adding
> socket initialization into security_sk_clone_security() hook like
>
> | void smack_sk_clone_security(struct sock *oldsk, struct sock *newsk)
> | {
> |    *(struct socket_smack *)newsk->sk_security =
> |    *(struct socket_smack *)oldsk->sk_security;
> | }
>
> This initializes the child socket security with the parent (listening)
> socket security at the appropriate time.
>
> I was forced to revisit this old story because
>
> smack_sock_graft() was left in place by [3] and continues overwriting
> the child socket's labels with the process label,
> and there might be a reason for this, so I undertook a study.
>
> If the process label differs from the listening socket's labels,
> the following occurs for ipv4:
>
> assigning the smk_out is not accompanied by netlbl_sock_setattr,
> so the outgoing packet's cipso label does not change.
>
> So, the only effect of this assignment for interhost communications
> is a divergence between the program-visible “out” socket label and
> the cipso network label. For intrahost communications this label,
> however, becomes visible via secmark netfilter marking, and is
> checked for access rights by the client, receiving side.
>
> Assigning the smk_in affects both interhost and intrahost
> communications: the server begins to check access rights against
> an wrong label.
>
> Access check against wrong label (smk_in or smk_out),
> unsurprisingly fails, breaking the connection.
>
> The above affects protocols that calls security_sock_graft()
> during accept(), namely: {tcp,dccp,sctp}/{ipv4,ipv6}
> One extra security_sock_graft() caller, crypto/af_alg.c`af_alg_accept
> is not affected, because smack_sock_graft() does nothing for PF_ALG.
>
> To reproduce, assign non-default in/out labels to a listening socket,
> setup rules between these labels and client label, attempt to connect
> and send some data.
>
> Ipv6 specific: ipv6 packets do not convey SMACK labels. To reproduce
> the issue in interhost communications set opposite labels in
> /smack/ipv6host on both hosts.
> Ipv6 intrahost communications do not require tricking, because SMACK
> labels are conveyed via secmark netfilter marking.
>
> So, currently smack_sock_graft() is not useful, but harmful,
> therefore, I have removed it.
>
> This fixes the issue for {tcp,dccp}/{ipv4,ipv6},
> but not sctp/{ipv4,ipv6}.
>
> Although this change is necessary for sctp+smack to function
> correctly, it is not sufficient because:
> sctp/ipv4 does not call security_sk_clone() and
> sctp/ipv6 ignores SMACK completely.
>
> These are separate issues, belong to other subsystem,
> and should be addressed separately.
>
> [1] 2008-02-04,
> Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")
>
> [2] Michael Lontke, 2022-08-31, SMACK LSM checks wrong object label
>                                 during ingress network traffic
> Link: https://lore.kernel.org/linux-security-module/6324997ce4fc092c5020a4add075257f9c5f6442.camel@elektrobit.com/
>
> [3] 2022-08-31, michael.lontke,
>     commit 4ca165fc6c49 ("SMACK: Add sk_clone_security LSM hook")
>
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
> ---
>  security/smack/smack_lsm.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index ce7d44509973..1084ec5fca98 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4350,29 +4350,6 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
>  	return 0;
>  }
>  
> -/**
> - * smack_sock_graft - Initialize a newly created socket with an existing sock
> - * @sk: child sock
> - * @parent: parent socket
> - *
> - * Set the smk_{in,out} state of an existing sock based on the process that
> - * is creating the new socket.
> - */
> -static void smack_sock_graft(struct sock *sk, struct socket *parent)
> -{
> -	struct socket_smack *ssp;
> -	struct smack_known *skp = smk_of_current();
> -
> -	if (sk == NULL ||
> -	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
> -		return;
> -
> -	ssp = smack_sock(sk);
> -	ssp->smk_in = skp;
> -	ssp->smk_out = skp;
> -	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
> -}
> -
>  /**
>   * smack_inet_conn_request - Smack access check on connect
>   * @sk: socket involved
> @@ -5179,7 +5156,6 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
>  #endif
>  	LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
> -	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
>  	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
>  	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
>  
