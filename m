Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDF3C4B93
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198837; cv=none; b=sLPuTWpi7QpNQcLctpogLpRr4WQcI1nUq9QzSCUCvfwoI7hnqsNMcbzgR5Y2CXssgGK7nvbzFPOFulu3shiXETpb9cYaK9NTRcL+uoW0gBdigOs5MXLmuRjWy4W7mxslG8jhIknnADtFCaL/38lum7hf5mJkkBS4KfAfZsB3lxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198837; c=relaxed/simple;
	bh=R4q5eqY41dd6Ubjl5PjNYO/uC+yf2Zj+2A5yPBbzegg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ew7begnSoph4uiN3qjeiNYMtmOUJjtu7ZeSa0+QOhoNiF7fOPGafeOlAS4J2vqlNXzNgtnXw6JXBK2Ve4yhNRU3pFaRa0doQCWQj87Cyxgi1tBU9YI5a6+4j1VlBGCdMS7D/gIAnaDnPTvZg0pazfFJlmObCBI75VhVZRBCIWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=gotsvS28; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="gotsvS28"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7CC753F47C
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 07:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782198827;
	bh=TFcPZJr7OnPmIdUVN+MTZFKKeAf+5ltdnQrc4dogtko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=gotsvS28JS1EbzvoJ2HkhO9ge4CpTLEA9nXCtqR1v1YeH5PnZBjGaUJ5UbIcINfeZ
	 Oji6fL38PD94D9+kG3smsoRXCjonLOcNj5fi44M2zKZ8tbesaByjIwlES1ouDFQ9va
	 YdQKh/ssgE0e3s+qoNXI704ufslFUrLBxDigyUgFvcAbWqu9CBnCqIarewPIGLXvkV
	 nP2c7HDcsgsQGk15Fj33C7dQsIVidBLuDRCrGaOD8dJethPrjwzyGRbEaWSwaSxZNM
	 vupbuugtLymROdf289/ijp5hG5Fki02p7D+W2JwiCnP8wOLQAHJHAd6uch4NeFZfH0
	 ehA11YIRhbEjImPHnpuJBtfLfZxPbd0PGJh1N2UAVCzY4HHrXBi3p18etjrgQzNVwS
	 BxBASvhyqVeXupEBwgPogdEx9xIfGvkjeB/n622cA7Q1su9YIP9Ob2mn1oEQ6oWSgi
	 SbO/PjwleCeM8W9DCxkxSFOHYyp6EV79hkyMr4l/5U1lQdT0LEQL9bjL/AVoENaHns
	 MqK4eL3+TO7fvHa/eg31jZ6J9Z4OEwfrlCFENcVIvLzfk9AsRXJajrB5uddV2riXau
	 pLavMA/ohqOCykeFXCiWIhZWXR8akcYT7NSsk27wKdJ0G0nG+QwnuZ5Gx1vAqYYTAj
	 xZW0/qwo9z8ZxGUnWYik40os=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d8719bae6so4305463a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 00:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782198826; x=1782803626;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFcPZJr7OnPmIdUVN+MTZFKKeAf+5ltdnQrc4dogtko=;
        b=Yz492q9U7RhTKXOrESHfHb8GRc1LmEBVLRnQtsf/0sHAeghXr+foznfL7cM+ogSxEv
         phkvQxbECiqjTnAOJ7ofS/2icS1pQqqIRm4WS6exaZp029wOsXAeIfG1rlgDCHSxRDAy
         Vxs8A2vMm2/iGFui58bXg+kZ+IfdYKWz3U7grJGdb99wwwMwzrh2LESo9xYEhcYFip+R
         Xpl5fLnLBUfayGiVf/HehNPGmr8EuogmL6FmVfZ80bLYTYuewYB6klkn5t7WzFk73v2T
         9gDVdNkSaEeuOh2y/NZE/Hk9owgqH/V8OTTKzgNuEIWoDc5FtUmurXvNlFIMW7QwkgHH
         383A==
X-Forwarded-Encrypted: i=1; AHgh+Roj8rCTGaxPrQBvTFYcwFXkVCOnabTQ4tCDmQDncynQRj5lwmTsUGZ3ezNkB1E4C+bMpPeT0wunK4MsYujPt9I0VU08dcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwO++Zc8/c6PiVis18hn+N8YaVLRMwnIPjc5De9j2LlTtsr4/p
	K08arDWxerLrf/j3PbawyxM2maJTcxoiO5jZ8PQKerJ48CeBK8D6tOiHiVmys001lxU19XPH4+l
	Rq+uXrWeQssLj+vWuNWIBB32rZqR6T/vZf7NnAIw3xllpNRzhdzzJXhqeYepwG08KTFVE9uNbhY
	mBOUnnTHjU0U+qiR/X5w==
X-Gm-Gg: AfdE7cnrsjHFC6WvbdqNKk610OBQbKf7WiZfruKP/iAHPj7r7DfhBKI20+uiS8FoyM+
	vDCzIPT58NgS6TtwB3ia6kGYV/3cf3a+80ckxgxKH2K1gLnpnra0jq0RBc5wLm/mSTpmdwtwe8s
	YDbQHKLcjly7+3uiTSUiavFb1yFyhsLYOQJFvAJX9qyx64wQgWH4d0Q3qdaIrgDNH8/QGZdS2ee
	/Xm7yZmoVqEdArI1IpFwa1uWLc3TeO8ZDmp1EI1Fo8jmXdEmnxSTkZ8I23UPWM9PX2NaBy//Jti
	f0Tkc8TG+cfsHOsDUiKEgw6bQcY45PS4+ytwT9nHeYRJ+5ivJZFByjDZSygdZvzDLNXCjFwf2rJ
	QUA3JHlREKtPQ5PtKIfOriQdEoQ==
X-Received: by 2002:a17:90b:3fc3:b0:36d:79c6:1562 with SMTP id 98e67ed59e1d1-37dd17a276emr1681371a91.25.1782198825943;
        Tue, 23 Jun 2026 00:13:45 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc3:b0:36d:79c6:1562 with SMTP id 98e67ed59e1d1-37dd17a276emr1681352a91.25.1782198825554;
        Tue, 23 Jun 2026 00:13:45 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37d15e0b1d4sm13105240a91.17.2026.06.23.00.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 00:13:44 -0700 (PDT)
Message-ID: <ff6eb32d-a2d3-480c-8291-e2e6dede2423@canonical.com>
Date: Tue, 23 Jun 2026 00:13:43 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AppArmor: TCP Fast Open bypasses connect mediation (last
 unaddressed LSM)
To: Bryam Vargas <hexlabsecurity@proton.me>,
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, Mickael Salaun <mic@digikod.net>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260619011138.264578-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260619011138.264578-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/26 18:11, Bryam Vargas wrote:
> Hello John, and LSM folks,
> 
> I have been working on the Landlock TCP Fast Open connect bypass [1]. Stephen
> Smalley's SELinux fix for the same issue [3] -- "Similar to Landlock, SELinux was
> not updated when TCP Fast Open support was introduced ..." -- made me go back and
> check the rest of the connect-mediating LSMs, since I had only been looking at
> Landlock. With Landlock [2], SELinux [3], and now TOMOYO [4] all getting fixes,
> AppArmor is the last one with the same gap and no fix yet.
> 
> Root cause (shared with the others)
> -----------------------------------
> security_socket_connect() has a single call site, net/socket.c (the connect(2)
> syscall). TCP Fast Open performs an implicit connect inside sendmsg:
> 
>    tcp_sendmsg -> tcp_sendmsg_fastopen -> __inet_stream_connect(..., is_sendmsg=1)
>                -> sk->sk_prot->connect()                 net/ipv4/{tcp.c,af_inet.c}
> 
> This never calls security_socket_connect(); the only LSM hook on the path is
> security_socket_sendmsg(). mptcp_sendmsg_fastopen reaches the same code and is a
> second producer.
> 
> AppArmor
> --------
> apparmor_socket_connect() requests AA_MAY_CONNECT; apparmor_socket_sendmsg() (via
> aa_sock_msg_perm) requests AA_MAY_SEND. These are distinct bits, and apparmor_parser
> compiles them independently: "network send inet stream," yields accept mask 0x02
> while "network connect inet stream," yields 0x40. So an egress-restriction profile
> that grants send but not connect is bypassed by MSG_FASTOPEN.
> 
> Reproduced on 6.12.88 with apparmor active. Under a profile granting the inet/inet6
> stream lifecycle except connect:
> 
>    aa-exec -p egress_restricted -- ./probe
>    [TCP ] connect(2)=EACCES(blocked)  sendto(MSG_FASTOPEN)=OK(reached)  => connection established
>    [TCP6] connect(2)=EACCES(blocked)  sendto(MSG_FASTOPEN)=OK(reached)  => connection established
> 
> (The coarse "network inet stream," idiom grants connect anyway, so this only bites the
> fine-grained "allow send, deny connect" policy that the asymmetry is meant to serve.)
> 
> Fix
> ---
> Same shape as the TOMOYO [4] and SELinux [3] fixes: in apparmor_socket_sendmsg (or
> aa_sock_msg_perm), when MSG_FASTOPEN is set and msg_name carries a destination on a
> not-yet-connected stream socket, additionally require aa_sk_perm(OP_CONNECT,
> AA_MAY_CONNECT, sk). I am happy to send that patch and the reproducer.
> 
If you have a patch, I'd love to take it and give you the credit other wise I can
throw it together.

> (A single core check in __inet_stream_connect(), gated on is_sendmsg, would have
> covered all five LSMs and both the TCP and MPTCP producers in one place -- the kernel
> already mediates the analogous implicit-connect-on-send for AF_UNIX via
> security_unix_may_send and for SCTP via security_sctp_bind_connect. But since the
> other four LSMs are taking per-hook fixes, AppArmor matching them is the consistent
> move; mentioning the core option only in case it is preferred.)
> 
I think per LSM makes sense, at least atm, as it is probably easier. We can look
at refactoring after the fact.

> [1] Landlock: LANDLOCK_ACCESS_NET_CONNECT_TCP bypass via TCP Fast Open (report)
>      https://lore.kernel.org/r/20260616201615.275032-1-hexlabsecurity@proton.me
> [2] landlock: fix TCP Fast Open connection bypass (Matthieu Buffet)
>      https://lore.kernel.org/r/20260617180526.15627-2-matthieu@buffet.re
> [3] selinux: check connect-related permissions on TCP Fast Open (Stephen Smalley)
>      https://lore.kernel.org/r/20260618175513.112443-2-stephen.smalley.work@gmail.com
> [4] tomoyo: Enforce connect policy in TCP Fast Open (Matthieu Buffet)
>      https://lore.kernel.org/r/20260619002207.61104-1-matthieu@buffet.re
> 
> Thanks,
> Bryam Vargas
> 
Thanks for the detailed report Bryan

