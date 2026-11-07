Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060141;
	b=YYz5BU+TfmQ6rkkaA1R0o+7tuSxlP9j8O/tZYEpamDetTOkWHpZ70XtNyS6xpSTmTxLm
	 sKpOIXSpRPkEMiargd9+juEwD4MTHmJUO9IJ9wBaMcY5FAK01xnK6snklf1J+EolEnMQW
	 of77m1hIaa3JAkzcqB7K0OpCS5uo4agO7qJVCZnLEnwXnKjIMmEuL2MSIHBkZVYr8BnrO
	 E2DXGSqgCKvkXEXrph/LJOFvkv5d7GOXu4Bghvwl9pl0XQlEbmkra97KKEwNxn61U/l6n
	 nKwXOskyyVPqsUzZcnF3KUNRIqniEN3Ll8Kq8KGjCmCAqaeaHzsslwjfSGRzcPtc4wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=jeBVTeWsp7XQ0SurPamFA2f1NhhOVbJgVg3z2VQmbcY=;
	b=i81DbjPElp/pWLRh92mHWbjLTIomDCOA9ZIzQ4yxGp4hm1QJ2dTOriomnB/jhBtDjFAY
	 lVeBWwtOQIp1VVGvnLyWrnOMba4mNTqb5ke6ti/yePy4CjMVtQGi7e3YZlazcNSKrU5xb
	 f1CUN6E5lkydhR6k5ajpjJSNIKBPsbSsnDMGcREKD503b1TXGCT1rhM4JD68tuuGHdHO1
	 U+FUwC/JiwfkleIIIMuiyKOpbV++MzUN9NnaiA1eGi+X2crWWLDAKqR4ZMTIxaEQ86gr5
	 9T1txwDTSZtJkTs24QQUoaTJTdbwNCOaks2JKWaW+JcQk8pVROMkcEb8tSWdY9MCYOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jzk4l6NG;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F81606A32C
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 14:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F81606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jzk4l6NG
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so13834285e9.3
        for <linux-security-module@vger.kernel.org>; Sat, 07 Nov 2026 06:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794060140; x=1794664940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jeBVTeWsp7XQ0SurPamFA2f1NhhOVbJgVg3z2VQmbcY=;
        b=Jzk4l6NGiX+HqnSZ15BN+hLDZCao5gt3EsidYlulPs2AUjGEDiGyZWmwm8GmKHSpz7
         iojUe+nL1sffGrls1EUSz35B+L2zLMAWzn3KRUoxu3AB3ZRHqz38t+xAu5DP7CAmJiWe
         EUttTOAPYVEQ4Ocb2noeI2H4/PpcrlISqFg5v2u8vqoWbU+QuZHnJ1QhMU1ZI1DqjF6p
         oWHIXNW9fcG9yLHwYrFWx9+BM55KroP/iJ6Gkol1afqzYAE/n97WMEdQgmfsdIbRS4Ow
         UfN7mEd7pXEXIDUHJUhKpe4u2Jl3vfSxM3ISoBAlP1KVx1NoOmcMePRrTxtmfgi/KlbG
         UCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794060140; x=1794664940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jeBVTeWsp7XQ0SurPamFA2f1NhhOVbJgVg3z2VQmbcY=;
        b=xmcmGcMCzTY3FCQbd5ubCRZ0MwAxuWUNVR+yINM4d4419GSlsnDAVRUAV7aXOhNX+z
         RJrWSM5GU1TcuzWQ5diczAMa8foP7gQiRu9LdPBcb2Xw2FzsU2k6CIIb7uPp55DR30VP
         piDAZSC1lcoJmKp43pZe0crZ5m1IgyDOqlqEGpjUcgTP6i8xMTw87Qwq5IMvGpMQ0FeR
         Ir0eXgqgawHm09x6pFKt0uG72WU50cJmAleSWR70Z1niiCvCjwhBwkjZQpPyS2LXUB1m
         Vg1wN614lsINhq6w2tRjsKLvq9287VACLq8WTgkVFT5vYBtM9oWgdOoaZMwnNa448F3j
         hBTA==
X-Forwarded-Encrypted: i=1; AKwUvBxK2j1kkzZ0w+cZr9bUfp29y70ptePRXQHMQMZ3lkeNA7zSHIm9Na7/V1GgPzZzA1Oyu6JRuDwRa3DqYEGdfTjUOUBMzZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GrlpZQi79MlRFqw6j/zhIP9l1x+7ElF1nLtjl1bVHok6a+iuh
	+xm2hbClghBy6uZQOpy9Z4jl6Ccw2XTrDSV1/Jff8QjH/zNPdpsdm1/b
X-Gm-Gg: AYBFou0lCVx1q+O/sfIdrSwmCR06FdQHsEt2s9kpnVQ4X8bPImNZNYV9pWK5b3pCOlT
	Vr7F5Llhu/2Zh/dmv0UYFt2WoAcZcjzLudIXk6LC6JJx9m9zmyhDagjPPEzSizi5iOoxVOpmyAq
	U1OSKKDCAhSEh5GCRaddLxV00UPzMtw2Q1qFJqCfK747nlhZSe0SzrfDl1f1sXhlFkjq9s9+OmF
	/z5wq5GcRaeIKJpm2D2covMMBjHgM/i+1ufVkaw5J//s4oUy4Vw8g6LbFKbGd6yVfHu3846qdEu
	1tf7PX14Tap4IwmgnbLfrYKX9NsjpFyZ8ZkmCCGGn/ESq0WeFL9P0omArjFmQDJzJhZXSE/RkwL
	STxy4TzbZhedwmdmbc4cXU2q3b5DErFz6OWwdGqEE7yfUHLJ+sgKhy6Y3hjksgE2UuKCO5q3Yws
	x2qpP0Ad1l98KsrwR1M1AOwGpK7rBxBaK7jSHaTeCIDmjOxU6X7ay4PyIRQVXE7mfId/13YyPNm
	QiQp0Zu0kGgRFq55D1gWJFmrzAejsa/H/+v4+pZSzx5XhaHX2Phfwc685liFm0l49/S0677YjMC
	UnjT5aS5xUGXXMXMw2TE8w4i6oWOPjgDQ2HzhQ7+D8BCtvbD561p
X-Received: by 2002:a05:600c:34ce:b0:4a3:59ee:86b with SMTP id 5b1f17b1804b1-4b6dc400256mr107335175e9.4.1794060139414;
        Sat, 07 Nov 2026 06:02:19 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1547fsm122148745e9.11.2026.11.07.06.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:02:18 -0800 (PST)
Date: Sat, 7 Nov 2026 15:02:13 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Christopher Lusk <clusk@northecho.dev>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] docs: landlock: clarify TTY signal scoping
Message-ID: <20261107.7c3abf9dfa59@gnoack.org>
References: <20260923163321.79770-1-clusk@northecho.dev>
 <20260923163321.79770-2-clusk@northecho.dev>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923163321.79770-2-clusk@northecho.dev>

On Wed, Sep 23, 2026 at 12:33:20PM -0400, Christopher Lusk wrote:
> LANDLOCK_SCOPE_SIGNAL limits signals sent to arbitrary processes outside
> a domain.  A PTY master differs because its holder controls attached
> processes through input and signal injection.
> 
> Clarify this boundary in the userspace guide and narrow the UAPI
> description to arbitrary target processes.
> 
> Built the userspace-api docs; no new warnings.
> 
> Link: https://lore.kernel.org/r/20260916152336.1589383-1-clusk@northecho.dev
> Suggested-by: Günther Noack <gnoack@google.com>
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Christopher Lusk <clusk@northecho.dev>
> ---
>  Documentation/userspace-api/landlock.rst | 6 ++++++
>  include/uapi/linux/landlock.h            | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 84cb7bf6b3ed..4d9fb1f1588c 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -430,6 +430,12 @@ The operations which can be scoped are:
>      This limits the sending of signals to target processes which run within the
>      same or a nested Landlock domain.
>  
> +    Holding a PTY master FD grants control over the processes running under that
> +    terminal, including the ability to inject input and signals.  A process able
> +    to write to the master should therefore be considered as privileged as those
> +    processes, and this capability is not restricted by
> +    ``LANDLOCK_SCOPE_SIGNAL``.
> +
>  ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
>      This limits the set of abstract :manpage:`unix(7)` sockets to which we can
>      :manpage:`connect(2)` to socket addresses which were created by a process in
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index cceda3b3b961..ad7b1ebd62ed 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -500,7 +500,7 @@ struct landlock_net_port_attr {
>   *   connecting to an abstract UNIX socket created by a process outside the
>   *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
>   * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
> - *   to another process outside the domain.
> + *   to an arbitrary process outside the domain.
>   */
>  /* clang-format off */
>  #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> -- 
> 2.55.0
> 

Apologies for dropping the ball on this, I'm only realizing it now.

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

A related documenation patch was brought up in [1] as well.

–Günther

[1] https://lore.kernel.org/all/tencent_1D938EDA50BCDB080CFADC6A@qq.com/
