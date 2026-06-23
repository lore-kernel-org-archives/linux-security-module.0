Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996C2D7D59
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198941; cv=none; b=ON8rvIVeVOs0J3rouFwfBQwZzyDY6SgUbI1T3KteJVGfz2kiGqepqJZK/zkFFYp5oRUr9ZXNBy+aRLDQHO7y/E3um1tuIm+hotWaNUyCOrlHuk6lWroTqCErEBw+Xa4pl50AYIFicP3TsF8er9rG4yM9omaidNE1xDGyf8GxVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198941; c=relaxed/simple;
	bh=VA3vA/Pk0DENCPGNfN0xBwb1mOFKd6hFsEH7Q9D3pcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BucHKMBxGKPz59sPZ2FN1SDuN1SldUVS2T1eSDOtLrS3e9j3uG/GkWnIomvYf1CeYASK7IhJDaOhtz0PveymLu+63dXBHa1iNKN07Od1OAnAdoww1sd/1+Mrhu4x7AnAKIfDebZM6BSwLZ5HQV6CEbraohcpwrBCZk5pV4NLGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=cwcVPgW8; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="cwcVPgW8"
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5774A3F4C7
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 07:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782198938;
	bh=UJ28Quv7slmdN0gFykwlCCszHWU5zR4AurdWTg5hrBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=cwcVPgW8GnJARTFmc5iq0jOyt5+hyB2dBH0x4EDAhmx155ZEQyHBaJv4+N7Ox4nO/
	 9ywCHBviRKXLPrN5I/q+u256Pv1uhcyHclq/eu+wv+imv2uRGxkCBiDaoK3ZWgcT5T
	 U41Qz2O0S8XB0GZ0CuV9TUZ3b7e2gWo28w5c9h9RTAbjbckOYuFwuXuQPx5pZTh/6Q
	 PSwb6zopV5dwTfsVjAQ8I830hgwofr+wbPbnn/c2qznepP6HQnpwF3wchl4S5r/a/z
	 y8Qm/913rcb+ac80g2x76LMDMkm74Uw95VuZunVz3d2VlqLmw4K9L9au3T2gV63S4W
	 0Ngvv8o6STEEHMxYmXUPbjsuQuMMZ5ryHztuG4oWJS6dficYjijWjWeGsszlsgdZwC
	 tSn+VoqOmVwkPRQaeQIZwRaQakGDZdmmcDmxJ/QHVi/m5kB56kvgToVeLGIcU/3+0L
	 JnGwzNrfs+XW7IsS8qQuGGjlLivxxyT8WRD/Q+J8VkhcQ2pFtltWDqSC6sLLpumC1X
	 68x1jom8vjnctGA1icmHXycGO6C77L3LCENOAyevCOFnflvZ6Tno5fBz7LCOyyOb3c
	 m6oPY48fusRaTfxfPuzZRXfAjwkVwdVRU0qlERpMaueNObicnwkE0NsqOlMpjB1LmY
	 Jynm30OXc6OgDUFQNm8CRvGQ=
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8454912a507so7415181b3a.2
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 00:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782198937; x=1782803737;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ28Quv7slmdN0gFykwlCCszHWU5zR4AurdWTg5hrBs=;
        b=WYH5nJv62XK/S6Em9YDWCNwgSJHf4nWuKxx3xrKPxx9D5sUQEtkk2ZzCgFR+DFMT1Q
         zlMKE8/rg2HgoGvtywUcYHDAXkvW/fXt7mWDF8xr4VerHfbQJMZCBInJhP61yg3Qg+0I
         MJu1RdgT6yP9AO5mGyM5TZrFO680/L3OLdn8whRz98xk5DvbDQLrKiF706GRkG373WpN
         QWIWBaItZHymiCJPrpFwa6tx3am01tsC9bZVW9SjEj4FNY1sb7MAbO8uRlWZpj70rdQY
         GyXBEf0FXU6+Ff/moTo5Hx/OZs40m6eDxQFmJEWfc05EhL+tz96Xy9if0Z5LkkGVrCjt
         VUIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+E6CQTylVaGps4bEUiLyz3bJvnSIE+GvcrOyOqMv4HaFjaNTHELoZmLzTdQzpcOy4R/1RK+D+I55XQYMT2hMNlfhuSU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+fLj8HJ92FKP2h1zrk0XXixdFGdN7Ip3u6YaOsiANGS0vmjH
	8shvEfeYD+h3FV66n20poNfAPvD/1fQtCa6PZwFze9GSoP/VfQ36LE2drm1KA07Qi5vWJctfRw9
	lp6Vcqk+6LW8aDD5Pd03bHeq4Sc+a1aJ9PPDketTvBEoTQOFvfgDQ2jjerhhvsLlU583LgxIESI
	q6THsQXRxslMhW43gjAA==
X-Gm-Gg: AfdE7clXuGUeqNd5cTzrL+VyrdGEqA6UeBKA0rFpYH4HNYADmNtdk+CzFt3X+FHUJ/o
	J9l7NrrENjxtH5HHsxBOWvMWKYHdsRwW6JpfVLaN6DzfrPrv/oAOSOY7oEWVU7wXp1pMql/c1RI
	j8N+DmAKzieBgmgq8U3EjRtuamHd0n3bxKY+W6g0a6uYk77seyMT+3roG2dNlYmsgN7i7Rl5FI8
	FCBdKWjqbdmyD1vQ+8XXSRCwEsqfsL22t66KueiMvOmOkQlR5AJzeO9SpSmKTF1ieZe3Zycnxx0
	qrf9V+8pYL9ZH4NrDSj1eXM4hPwF2559bOhNTnJPb8YyEVmMZY+xOPx7Pan8tSBJgZNCN1qYvnA
	rhD2Ks1o7VpT/WLh1YcKbFmmshA==
X-Received: by 2002:a05:6a00:238c:b0:845:3d4b:8f8a with SMTP id d2e1a72fcca58-845508a1d4fmr20512994b3a.35.1782198936955;
        Tue, 23 Jun 2026 00:15:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:238c:b0:845:3d4b:8f8a with SMTP id d2e1a72fcca58-845508a1d4fmr20512970b3a.35.1782198936570;
        Tue, 23 Jun 2026 00:15:36 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84564d8a7f0sm10037091b3a.13.2026.06.23.00.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 00:15:36 -0700 (PDT)
Message-ID: <2ea3bc97-8422-4e33-88b8-a8b0fee79793@canonical.com>
Date: Tue, 23 Jun 2026 00:15:35 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: mediate the implicit connect of TCP fast open
 sendmsg
To: hexlabsecurity@proton.me, Ryan Lee <ryan.lee@canonical.com>
Cc: Mickael Salaun <mic@digikod.net>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 James Morris <jmorris@namei.org>, Matthieu Buffet <matthieu@buffet.re>,
 linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, apparmor@lists.ubuntu.com
References: <20260622-b4-disp-aba401c6-v1-1-9d74343c7ced@proton.me>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260622-b4-disp-aba401c6-v1-1-9d74343c7ced@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/22/26 13:57, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> sendmsg()/sendto() with MSG_FASTOPEN is a combination of connect(2) and
> write(2): it opens the connection in the SYN. apparmor_socket_sendmsg()
> only checks AA_MAY_SEND, so a profile that grants send but denies connect
> lets a confined task open an outbound TCP/MPTCP connection that connect(2)
> would have refused, bypassing connect mediation.
> 
> Mediate the implicit connect when MSG_FASTOPEN is set and a destination
> is supplied. Add it to apparmor_socket_sendmsg() (not the shared
> aa_sock_msg_perm() helper, which recvmsg also uses) and call aa_sk_perm()
> directly, mirroring the selinux and tomoyo fixes. sk_is_tcp() does not
> cover MPTCP fast open, so the SOCK_STREAM/IPPROTO_MPTCP arm is explicit.
> 
> Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
> This is the patch and reproducer requested in [1]. A userspace regression test
> (tests/regression/apparmor/net_inet_tcp_fastopen) follows separately to the
> apparmor tree, as suggested.
> 
> Reproducer (behavioral; the bypassed value is policy, not bus state, so no special
> hardware). Under a profile that grants inet/inet6 stream send but denies connect, on
> the current Debian security kernel 6.12.94 (apparmor active):
> 
>    [TCP ] connect(2)=EACCES   sendto(MSG_FASTOPEN)=OK   -> connect bypassed (listener accepted)
>    [TCP6] connect(2)=EACCES   sendto(MSG_FASTOPEN)=OK   -> connect bypassed
> 
> The kernel audit shows the connect(2) denial and no connect record for the fastopen
> sendto:
> 
>    apparmor="DENIED" operation="connect" profile="egress_restricted" comm="lsm_tfo_ab"
>      family="inet" sock_type="stream" protocol=6 requested_mask="connect" denied_mask="connect"
> 
> With this patch the fastopen sendto hits that same connect denial. Full reproducer
> available on request.
> 
> Same-class fixes: selinux [2], tomoyo [3]; the original cross-LSM report (landlock,
> the first instance) is [4].
> 
> [1] https://lore.kernel.org/r/20260619011138.264578-1-hexlabsecurity@proton.me
> [2] https://lore.kernel.org/r/20260618175513.112443-2-stephen.smalley.work@gmail.com
> [3] https://lore.kernel.org/r/20260619002207.61104-1-matthieu@buffet.re
> [4] https://lore.kernel.org/r/20260616201615.275032-1-hexlabsecurity@proton.me
> ---
>   security/apparmor/lsm.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 3491e9f60194..e01efdf50efa 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1422,7 +1422,21 @@ static int aa_sock_msg_perm(const char *op, u32 request, struct socket *sock,
>   static int apparmor_socket_sendmsg(struct socket *sock,
>   				   struct msghdr *msg, int size)
>   {
> -	return aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
> +	int error = aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
> +
> +	if (error)
> +		return error;
> +
> +	/* TCP fast open carries connect() semantics in sendmsg(); mediate
> +	 * the implicit connect so it cannot bypass the connect permission.
> +	 */
> +	if ((msg->msg_flags & MSG_FASTOPEN) && msg->msg_name &&
> +	    (sk_is_tcp(sock->sk) ||
> +	     (sk_is_inet(sock->sk) && sock->sk->sk_type == SOCK_STREAM &&
> +	      sock->sk->sk_protocol == IPPROTO_MPTCP)))
> +		error = aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
> +
> +	return error;
>   }
>   
>   static int apparmor_socket_recvmsg(struct socket *sock,
> 
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260622-b4-disp-aba401c6-f02842c82975
> 
> Best regards,

