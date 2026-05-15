Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647F3B8921
	for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811521; cv=pass; b=gMLcq1ICGcF+RCXV8x0rQSis9+13R7BN5JnnmkpK84w8FlnP7Ecp9npSq7tUBMngxgOvIOTYjcWoJnYaHt8WoZNmSXblLtGxF7vH5eD1nKI+jJEXL9pKGHWgmqeF0iTEZ4lAjnSd1fd3l+3xeDaXkVMj0DLL3XoQ8Oz1E6fZmLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811521; c=relaxed/simple;
	bh=LZfwwb8fx/as6YLcdeGq22qzkOPv2+qLbXYDfiS6RJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGZu7a2iubwdbYDoBVy80cV512zBsJoKy4xjx4UTThK2xg3qjwEtSBCFyv36ZNz9atybHNQLh+iqYVotH7CefoWoIW+4yp0qPmzDpOoE4uIAr5UY6SQEqm+2Q9nrLt1SzsWIQv20u1ECVgi2X3a68Hmi4CL646l13dk8qfBV2aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G992P9eW; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G992P9eW"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8016d642b2so239442a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 19:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778811519; cv=none;
        d=google.com; s=arc-20240605;
        b=NCJIai8MHZs5C9qiYctq4ti6kov0jpcRYUg45HJIv5xunKJK7yHm9GXQ5haRnYlC1h
         LyMCUq50wL9HfetXkqiaIPJSCtFDqTcSJjQ4gfAj3K0fJds13NPdrOf/bRKF9W7skQB+
         P+xEoCL/IhuAlMARyWPJR1fLEP80zz/WgW2xxeKt7uafotIixPs+ZPh7sXwezpG9Vyfy
         yxJ/95A+/i654bDlB2+l4T08li07zE3HAZDx/2127fo8JzPx6Y8uYLRXyWHyyFtNiBMU
         5A6hzL1seaVzWqS0f1/6dGn7bf705lUSdp1FfnjI6Wx+BqQvt5hJK0BWldpjNRH19ZAr
         sfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gvHOVXemYQt1A6NQq0O+fwP9L6CAi8/q7rHtcivop/k=;
        fh=SsXkxOnM5yYvbtNzhO0lP8yVz1PkOJrwMxNcloULRJM=;
        b=P8o/WLNUZix17+cl1T3mEekhkvFs9CA0BygjfXP8B6NhjnVFi/g0jIR4XpP/o720oa
         UnZ7JfZyjOHSibVt2EI2flZpoVFTzm02p+3KFIQgsQDBAb/kh6XNTSqm/5hvTZKoq5fh
         6F7/DwF9laegwGHL4To9yOUFKH/SBbHCBjqg5GP/dmFLESB95xL4Juj2qiAs5e3p4VSk
         xjaEwnO+B1sjyzpaULtPQoEWr7j5jaC94RvQkVD60HNZbsik/sFfRnO8MqR3RzAHqI6p
         3hRZz8i3I9CCpTs1MTDV96PF2OEGR1hVomt0XTK1twVULEma8BFf3mj4i1ZAlsqqMeRX
         9zzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778811519; x=1779416319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvHOVXemYQt1A6NQq0O+fwP9L6CAi8/q7rHtcivop/k=;
        b=G992P9eWdXzOST1NPfVhWUChW/fW9OY9YgWHA1f4orvFCJ/XqpJs8olPposAGISlu4
         hSLbvRA6506FtLco1NvZ8rJOpafcPaIlXKSgn4XwrqkA3LIcdG2p4j2FnoknJQDsio7J
         WRzE7j2vBlVES+U/BcL8Cw7oGRpF/iRAqkXswNSE3xbvft2FvJ5Nk+7ZeRyGF5P9zsfo
         BXs2z+lH/x3wq1+XoSMq4dhVJ+tpRxJ7OPNrFuz3G6wL64jCO4p0AlbGgkWI3ZCMQHIS
         NcOQh6MPfYZClsIRsb8GXP1RiLp4JQH6LVCrrqUt10PKkqW+uXj4OpD6Ane2GLVN8aTk
         pOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778811519; x=1779416319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gvHOVXemYQt1A6NQq0O+fwP9L6CAi8/q7rHtcivop/k=;
        b=nvoFQ+vdB/nX3wsAOfBkUFUWZ2w6AiPvHUiO/WoVwKJsMOjhv30L6NmfnvaRTJfuQr
         h8QigkytQqMUzRiehR1ldPiJ6bOt+emFwCs3+JyIgViJJLzEvKTGUAmGpeAeKCO++0nb
         Hri3e0l0GoqrfLLC1XZNMwjWbaDrKGr+h3PUz+1Y5Cv4Q8ixiK1FogFvwMYskeT12ULZ
         AtJgv1QFov0QV5mj+jgi8IondGFXpAZacdPClb3dOwQ0sjf8R94rUMCrDgwfbIhiFUso
         /FMdMWxJfsfMmxQCHkl1W0UlXcvH8LKwR4LoCyVnejhngclSpY7vVmUrMTllJYO00KqJ
         TJTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zbLRu7Bsz/KkpyhZLPqodyAyP8dh5VbQlL9vK1q16sHALgjouu0WTzlv26yE59R/2smYo+NN1pr0d3mREVgGGpIhayUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2I0iUn8oq8sMKmnkrGWMPGoUwwdJ8F4tKkAtfI9SK53mvAB9
	+m3Mp64EDUQBHal8Zf3mXEvy4hWSDGzruODHkH8/3Q/xHqPPKqRzAfE7Ya8ZvehkqUqU6YMQExj
	f1SuScURSB75DLlMw7kbr9SSdGrgCsZ9ys7eEKDcV4oz3RAQpAY8BA7R2
X-Gm-Gg: Acq92OHgu6Jg4W8aDz6WHprpNT7WDDX+6sFqBlGDapgklubIbvrrOKhlYLsSNt2sgmm
	DmnD4hzpPKXTsL5oIMWQf4dSfdcEnG6UwvP4f0kpo6O34fELRaBCOm3ZWnqLrLX7fUuAw7TK5nS
	jpQacvHB2GyDJuCz6g0H2jrC7l8BqIMCcE0Eu8iPz/G5BqIKJdswXb8g0y6YbsB23grwVzgcTEH
	Vm2h3+PUROC3InW0wmw+ZctozSRC9LlbDmNfRppdtd0+AXRG139WQrMIdIlEJVBJrNx/qvixafl
	5cBCvjY=
X-Received: by 2002:a17:90b:4b8f:b0:366:5283:cddf with SMTP id
 98e67ed59e1d1-3695149a001mr1414760a91.9.1778811519322; Thu, 14 May 2026
 19:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514165139.436961-5-tpluszz77@gmail.com>
In-Reply-To: <20260514165139.436961-5-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 22:18:25 -0400
X-Gm-Features: AVHnY4KwcYaSMM6ME_zDmyreBOKsbOgGqvR0byjCKHroUrtDuoM0Rdy3xLGdKoc
Message-ID: <CAHC9VhS63xq5Pja2iA4DEkRU5sqpQ8ozXzgLBaE6Ck4PDCKpMQ@mail.gmail.com>
Subject: Re: [PATCH net 4/4] netlabel: validate CIPSO option against skb tail
 in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 12:52=E2=80=AFPM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> netlbl_skbuff_getattr() locates the CIPSO option in the IPv4 IP header
> via cipso_v4_optptr() and hands the bare pointer to cipso_v4_getattr().
> The consumer re-reads cipso[1] (option length), cipso[6] (tag type),
> and then cipso_v4_parsetag_*() re-reads further bytes from the skb.
>
> __ip_options_compile() validates these bytes only at parse time.  An
> nftables LOCAL_IN payload write reachable from an unprivileged user
> namespace can rewrite them after parse and before the SELinux/Smack
> peer-label consume path (selinux_sock_rcv_skb_compat ->
> selinux_netlbl_sock_rcv_skb -> netlbl_skbuff_getattr).  This is the
> IPv4 analogue of the CALIPSO IPv6 trust-after-modification fixed in
> the previous patch: the tag parsers walk the option using attacker-
> controlled length bytes, producing slab-out-of-bounds reads whose
> contents feed into the MLS access decision.
>
> Validate the option fits within skb_tail_pointer(skb) before invoking
> cipso_v4_getattr().
>
> Runtime confirmation (Smack peer-label policy + nft LOCAL_IN
> mutation of tag_len): UdpInDatagrams increments to 1 and recvfrom
> returns the payload, showing netlbl_skbuff_getattr ->
> cipso_v4_getattr -> cipso_v4_parsetag_rbm -> netlbl_bitmap_walk runs
> end-to-end past the option's true bound; with this patch the
> consume path short-circuits at the bounds check and the counter
> stays 0.
>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 04f81f0154e4 ("cipso: don't use IPCB() to locate the CIPSO IP opti=
on")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 4af8ab76964e0..ace561a2904a4 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1393,11 +1393,21 @@ int netlbl_skbuff_getattr(const struct sk_buff *s=
kb,
>         unsigned char *ptr;
>
>         switch (family) {
> -       case AF_INET:
> +       case AF_INET: {
> +               const unsigned char *tail =3D skb_tail_pointer(skb);
> +               u8 opt_len, tag_len;
> +
>                 ptr =3D cipso_v4_optptr(skb);
> -               if (ptr && cipso_v4_getattr(ptr, secattr) =3D=3D 0)
> +               if (!ptr || ptr + 8 > tail)
> +                       break;

Similar to my CALIPSO comments, I suspect we would want to return an
error here, yes?

Also, how did you arrive at the magic number of '8' above?

> +               opt_len =3D ptr[1];       /* total CIPSO option length */
> +               tag_len =3D ptr[7];       /* first tag length */
> +               if (ptr + opt_len > tail || ptr + 6 + tag_len > tail)
> +                       break;
> +               if (cipso_v4_getattr(ptr, secattr) =3D=3D 0)
>                         return 0;
>                 break;
> +       }
>  #if IS_ENABLED(CONFIG_IPV6)
>         case AF_INET6: {
>                 const unsigned char *tail =3D skb_tail_pointer(skb);
> --
> 2.47.3

--=20
paul-moore.com
