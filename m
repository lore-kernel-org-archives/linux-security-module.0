Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044068;
	b=hybes4R7x8Ufktj7zUUQhtybZJijz9V7jLe4azA24fnUuzOh6kaHURZtNxg9ztTyiXWW
	 Bf7jNLLRZCJlMtQ7TQW7fFOuUXzTaKIGwSfconMMjn0Rk/83iEQ/6UhqqnFk5o1RffILz
	 m4O0aXGwgLHxkIEP+80NSeWVufSb3DOM41E6Yt0mtlGMLZmHz6jDzSr0Ygq7VZVvDMNh0
	 gucqOj+ODMTuaFinTbe+UeDE4tdVZFdsdVwa8zBSouWH4IJXbBKQZzAO/BJRQLLQyGBpn
	 siysNRugdUfJjJRZD8Wj5MFoMMuvGVveAnsq3L+8A04bk/TUv43AvlLAmMd3XCUqDzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044068;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=R31dxPRwAL0rgdgAHSWbnri3dyw9opSnzzBfvu62EX4=;
	b=xoh2f/qnbBZEoA3QUIz3EOvgkqkkpkSHxonQqfbeo6D4uvgowHj48MNpmHMgVBN/hcQa
	 anJEQNC4zKBMxmmE0qg66+L4LJGYDHEcrzaKD9wrAznLYMC7mNSGj1KjhDkz+dGD0jHtL
	 fnEcTxSY7oyCWSjq2cnBfVn6ZtYydnnPci+s+y0uPUhn24d3z7lrzYunIvDOXoPOUVbGX
	 gKoDj79hVie6esuScdiAO1bZcpw3Aj9AnttyhjEg220Ja9+P7duxLF4w7JuSY9ftXM5a9
	 hLMjUpxX+gdc6z/CyNvs7yYLn5XV0+po0miMGHcG/tvEiLGWgS0PaBpk9OC1/2044WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=YYhrV6OO;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87868606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 19:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87868606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=YYhrV6OO
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EBE1C3F97F
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793044064;
	bh=R31dxPRwAL0rgdgAHSWbnri3dyw9opSnzzBfvu62EX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=YYhrV6OOa57TxbAGhbA4iCPYIMiQgx5HThj7uCkh2pyak9NP3SBtqvMkd17Il1H1k
	 SrthAQ5mwCaQYsjfYDZYieoeKECrc6t4/m+rT5KfHqAr+nhoDYrexr8YxtIZwfUzFF
	 zO+i9qnnVf1bOuM13OZCa8xHYYg5Yc5nLU+fCSNboVkCKmlGxObUhXjO/INjWEhsbx
	 KQOU3a3V+r6NcRbyJ70MMa7zkGXsloiaFYInzh38VhO3IHrrGbwuehQjne96DVZR1p
	 OZc4lAvMSDG3Z7h+V0XpduYvMFijUwl3REp+DpHGE3quG+wNyFFkCHkLfAJXD8jjey
	 L3jk7MVecBUcGO1oFauAolY4UgeFgSibca3vu0GyIXFzpBEI/vVq44k95tL5fMD8vs
	 Q/fD6jvUhDmJZCIFjFjv1lE/5K/4kUIvziX04mMCu/Cv24OB3XF5BxmZ1itV5V8sA9
	 1XZAnjzjrPZUAn4YvVEkJ5pz7lR+E+HPtjU49IOMbDjyigXN4k/PqR+sQ6N1YBMxQz
	 D8HhlPPZP+jFm2bn+/w8lYEUOc6JFhhgwp7JhWkJecy/gM03wFl35gP3Ddfi9UzHx3
	 5aiA3tdhVBYfPOCes3MzsHrqYpgtN+GeYBJ8/UySDw87Y6mmlGXrY4CvV2OnGqIQGl
	 dSzpXVf/p4qnspgSBQbilTe4=
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b155f4eb8eso56105527b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 12:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044064; x=1793648864;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R31dxPRwAL0rgdgAHSWbnri3dyw9opSnzzBfvu62EX4=;
        b=Zk937S0LatAHtgwGcu6+Gz5FJL1XMXxXmDIVHAYDKo3mluHAMqghNAxNuO6b1VQzr8
         NCGBM5O+g39EoCzNLecq4dOfz8xFVwuvXZoNGKY/bhjsQlY+IrgRwe/5GMhMewlegooY
         yE9bfUtCSFcXsnBo8h5nbi5VHTdXPe9ctX8QTJBcNLHhKfOBzC7mMuQP7IRT2ikM5rnf
         NTgr2LKC0lJNaI4jkBy0tMI+8Lh2w0jkTFmcoIRVwwWyuncDF1jmdhyCNz6vioYt9beK
         qwXzh2Di9lSWglrLIkRDKUhBcNu0m/9ua4rcPkF4qeYJJOWLkr55AeNhq3fNN3Cj3RC/
         fJXA==
X-Forwarded-Encrypted: i=1; AKwUvByPp95kecSUczWc8ZkYpbHvh2shxzhRqFDz6gn3vqrHa71kZouqjbiiI9ufWJ8MKNuAjbmHxdxHu9mv6sOIb06SPq73BUQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3gPYikvBelvnG0dh19YeXvIVp2RlLiRnBt2M47h0IAfbnUgyt
	vQLFExlsJp7vFQfQLaAHSyNoDHa3x81yYpTY+LV862U3+nPInSNmh/imgXipC1oK24EuQ8eKISK
	pYYdm+b4EfyA2a5aBhDz0F8q1HvV7gAgDPKHkT6T47pggV1oPD2zusbMQ40LWZzIMW1lXqnWoIp
	baKzSX6n07kYg0V7RzcQ==
X-Gm-Gg: AYBFou30d0K2FnEOE+GVk6Dq6gkVDbdtDO/eK/ITe7qINV0MkOaJIJ7hw6FC7g192x1
	Gjm8aXLluartMOqNWBg8ne4vm03Q5udsdw/wyNUNPxrLNBZ/wKaSZ9D7sCe5sZyT3JqhSmMXUOZ
	59FmpPGspDfVXD8M1FhYvbUVx90LyXd6zwxf/J1SlBWVPFNgdn1ntPZrYcpK+zv2DzUP4l+D3Ps
	WO9wwvwGXf4NQlUnlM8xzvqGjDUO6NW/TVXuH8Z6zXPMwKtAPBBt+gsJzjf732itFk9RA+QFu32
	EL4q3T5qv2kcp+lJP+0pNFjJ8bN0MuCSz0wxiZakpWtlbPn9ndKfjW0mXhS1dBfx82gB8AAupwb
	img93c6KHAyuUXOP6nFFV6NCBOH505/KCS39b2eA18F35meR5CtChkQBR
X-Received: by 2002:a05:690c:8e0e:b0:8a8:8dd2:f5b3 with SMTP id 00721157ae682-8b166c16abbmr48032007b3.43.1793044063738;
        Mon, 26 Oct 2026 12:47:43 -0700 (PDT)
X-Received: by 2002:a05:690c:8e0e:b0:8a8:8dd2:f5b3 with SMTP id 00721157ae682-8b166c16abbmr48031867b3.43.1793044063317;
        Mon, 26 Oct 2026 12:47:43 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8b19e56ea84sm1127927b3.18.2026.10.26.12.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:47:42 -0700 (PDT)
Message-ID: <3a3c7010-26f6-493e-baf9-6045c0ed2c56@canonical.com>
Date: Mon, 26 Oct 2026 12:47:41 -0700
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: mediate AF_UNSPEC socket disconnects
To: shaos <shawnq1@163.com>
Cc: Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261020001256.888314-1-shawnq1@163.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20261020001256.888314-1-shawnq1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 17:12, shaos wrote:
> Hello,
> 
> aa_inet_connect_perm() returns success immediately for AF_UNSPEC before checking the active AppArmor profile.  AF_UNSPEC is the socket disconnect operation for TCP and UDP.  A process confined by a profile containing deny network can therefore disconnect inherited sockets even though ordinary socket creation and connect calls are denied.
> 
> HEAD commit:    fe2ec83746e501645709761605c2464a44fd2929
> git tree:       upstream Linux checkout, local branch master
> source version: Linux 7.3.0-rc4-70-gfe2ec83746e50
> compiler:       gcc 11.4.0, GNU ld 2.38 (build details in reproduction notes)
> 
> console output:
> https://gist.githubusercontent.com/shaos26/73b057c77b9ea22d5e6813c259dbf43c/raw/fab5c58d6f184f5fab88a3a31a80c2b919efecf0/console-output.txt
> reproduction kernel config:
> https://gist.githubusercontent.com/shaos26/73b057c77b9ea22d5e6813c259dbf43c/raw/b9192c97c92fdd3b59089704bad6fbd0a33ccf06/kernel-config.txt
> reproducer:
> https://gist.githubusercontent.com/shaos26/73b057c77b9ea22d5e6813c259dbf43c/raw/92c7dd098a227276fe3daeea45996e2848e66439/poc.c
> 
> Build the kernel from HEAD with the attached reproduction config, then make a one-file initramfs.  The PoC mounts sysfs and securityfs itself; DEVTMPFS_MOUNT supplies /dev/console.
> 
>      mkdir -p build rootfs
>      cp kernel-config.txt build/.config
>      make O=build olddefconfig
>      make O=build -j"$(nproc)" bzImage
>      cc -O2 -static -Wall -Wextra -o poc poc.c
>      cp poc rootfs/poc
>      (cd rootfs && find poc | cpio -o -H newc --owner=0:0) | gzip -9 > initramfs.cpio.gz
>      timeout 900 qemu-system-x86_64 -kernel build/arch/x86/boot/bzImage \
>          -initrd initramfs.cpio.gz -append "console=ttyS0 rdinit=/poc panic=-1 loglevel=7 lsm=apparmor security=apparmor apparmor=1" \
>          -nographic -m 1024 -smp 1 -no-reboot 2>&1 | tee console.log
> 
> Under the deny-network profile, socket() and connect(AF_INET) returned EACCES, but connect(fd, AF_UNSPEC) returned success and tore down the inherited connection and listener.  Two fresh boots matched.  A one-line control that routed AF_UNSPEC through aa_sk_perm returned EACCES and kept both sockets alive.
> 
> Impact and prerequisites:
> A confined process that inherits a TCP/UDP socket can bypass the profile's network mediation for disconnect and disrupt that socket.  The finding does not permit socket creation, bind, or arbitrary peer connections; no privilege escalation is demonstrated.
> 
> Run the normal connect permission check for the AF_UNSPEC disconnect case:
> 

sorry for the lateness of the reply,

Acked-by: John Johansen <john.johansen@canonical.com>

> diff --git a/security/apparmor/af_inet.c b/security/apparmor/af_inet.c
> --- a/security/apparmor/af_inet.c
> +++ b/security/apparmor/af_inet.c
> @@ -425,7 +425,7 @@
>   	if (addrlen < offsetofend(struct sockaddr, sa_family))
>   		return -EINVAL;
>   	if (addr->sa_family == AF_UNSPEC)
> -		return 0;
> +		return aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
>   
>   	/* do we need early bailout for !family ... */
>   	return sk_has_perm2(sock->sk, OP_CONNECT, AA_MAY_CONNECT, profile, ad,
> 
> Fixes: 89ac6aa752ec8 ("apparmor: push inet mediation into profile callbacks, and improve auditing")
> Signed-off-by: shaos <shawnq1@163.com>
> 
> Validation: Two fresh vulnerable boots showed socket teardown.  The one-line fixed-kernel control denied the call and preserved both sockets.
> 
> Thanks,
> 
> shaos

