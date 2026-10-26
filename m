Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042039;
	b=fSSUf3DNq5Veqt3tlVmt6/Me/zRO8SvFLCDsArJ8dB/sEYvRqrnzqKxCHpX/qGLxpc6g
	 GTK9c9lxnZO5j8vA8yhhyFEjHwpHWTSn53lnLEwfaD3VeAUaSMf1DWQVpnxum2zqkD2iJ
	 XHoZU+51qKJAJLnhv0VHiBoMLMwLVePyXX8BaJ0i/eHAtc9Y+o5vItAMPq9qNXHJa2DcY
	 WLhXB2I3NFW44mQoN8KbopGc4Kecdt7DLIofbKO6fooTijrcq3kryInzxcjQ9Jy6EHvEd
	 JNbaGJdZQlFKIqwF7+iJQpGBQvkMGsnlTwzyILATTIqVhVJlZaOIQ+PbS4uyJn9VUFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042039;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Vgy5tlJ4zIrrzxhPIS7IOokidEWZWzw4PbEzeqfHlqw=;
	b=T6g7TmciMZ105Q06EeIvjN8fBa9znSo46AEyStOFuSwGK7GDPeGCoalJn5iFL5m4f8aw
	 yH24W4oBw1viqQQeIBVSEhpA0UI9pWmLTiWP8+YtNNbWzt0MA1ESutOwVO9PiZj+ro4Yn
	 prrv7roLbJRF1b1u+xMfhXuUUcLS0X6vpXeXV6jikyvUycSQjjF+LIo421O6jqCPYQiMp
	 6UheXaFTg3JI5LVEYs49YpgEcnvV/bebj0eCS2SywnNjHlvzUceGhCUrewYwnQNM3m8Z3
	 oowtj0saOeFrHO1FGAx4A23062gpN5/AY16Dn4St1S8WLVO6IvgimKJ9WXiBJ4u85KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Pn6akygv;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3729606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 19:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3729606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Pn6akygv
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9B03B3F91E
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793042030;
	bh=Vgy5tlJ4zIrrzxhPIS7IOokidEWZWzw4PbEzeqfHlqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Pn6akygvva0iR8t/ZwQgSf23v849fAyWJlEPupwSjKLMr41/qikCoLLcShD0eLBn1
	 udrlVdtBnwrtWFBRKbaCztwyTDvoAeGGK6skQgtfsgBUUl1M7RHFSshgz4MmOFBvPf
	 k7/pUZSaQ8mxyNikFgxpo01NRY0bxVQBfyJUZyM+7+gIsxAbT51R6j4a76MOHTPXKz
	 UzDvzo/hvdDcsuf90vTonhM0mFv7riUuf9qeYotTWBFJQd2p+xab8yuTsj9582OjAy
	 bUC8DvWgUyx3Gnce2qRn2Pjl7/BgpYlFjxJX4+p5iiZPtvBPbsorvHhwb3I75oyOs2
	 WWQgtJs8QmDw10QCZu+jak+pKqu1dv5ema3ePRJLkEDwYdL0Un7A3JQeXMNVU00I4j
	 OuH1RR4P88ZqDhdk+xKEjhDusTvCy3AVbgKNteQhqU3wfP3BfibQ8ulF1vLu8pQpyq
	 LhNSjHFrUUHLiqBAdy+YnTYcfr/BhppcUhaElJp+LIRLDULfcWz+AKZj4RWe5fAGyt
	 C9IO0GYRjxqGEPP0l6OJ33YUVS3h1Qg+JmTaPc2qHYifpBiezNkkN6agWXo+kGusnw
	 PaxUwPY8+F0GGy2hfXDfxSkuEqbCFYub+1RYTJjqahJRO+qdAmbfF8wvnQ7K0oLoaM
	 Mc9+UuEOmJeGDLlBBbkL+AoM=
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8ab43f7f5faso59861627b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 12:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042029; x=1793646829;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vgy5tlJ4zIrrzxhPIS7IOokidEWZWzw4PbEzeqfHlqw=;
        b=N8y9fGdp0mhfoKTh5b2lFyuX/r6kCtQPQOF9LlfLmGqGPUC78MpVIdWGKFsbrmeutb
         9oE+PYY84+0gBQDtSd0jkC9TlvWlABvNoVHgs3G1o2dgUfccynUHnyy/N4U2a+Klb3CQ
         r+JBP0K5D8Fvlz35PwN2yRQvEoWRaGF5Polbh7USsvgMYAa349IiFzwifAnkkzKIsO/5
         z2mB8jhvV0T7aWq4h9aJI/V9iETg/YMcq9T+ZcUtR9cT4cEpS7iaGkX4ida93TnAohHi
         HyPIFbhZXJVq5+ryTl9z4MvNk0MrhfC/AV6krIS8lcgTZeFnVwTe2RAkIz5r8FDviDW6
         eXIQ==
X-Forwarded-Encrypted: i=1; AKwUvByAuB/Z2AcjJ64puhvp1VdeuUubhLc+L3nh5iCQFcHd+Oes0CNoQ292r3zFRQTFwCSrl9iRAtLD0fhfxdOIDAhXnv5Xq2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6+kWb9Z/IgxoLUyvgMhJdoNmePP85dHgmXAJAQJRPO8sRjrUH
	BfTkMsF89hA0Fb1HWAaDz37UTfUy+BOc0zlicJRClUalFsHLUSuZk6ovMSSf6xEWyy9ESrci79J
	v6UX3jxVH8qRJ1g9EuFkEKPhmEr0cRQs83I4TMXZGCZC6Jcw78adQAZloIjuwFvoQPn8uOD2lib
	C4Youu2XTDC697fG0EdQ==
X-Gm-Gg: AYBFou0rFvYwdTVPkvm/7hJs05n2EB4Ob75ucn1myrg5ujcfyd5rsHNIcaLo6oVxgXk
	w9KbWzJD1Uh9xQ7llze33h7WqUIRG7qyL7gxTmKZNBU7nDRO9sRsLyrWd1VL0rKC0lWcCv6Lpu0
	AgwqH+W6spJ8nIl5JPaLX2GVyORjQEu1PxeofcP0WFLHcuvqTjchrRSX8F3kTDi5SuGY1oPeYDq
	+09oG0+uZvpBKj416dyr8ZTAvuVPD6/h5iVPP2moKb3sC1KTBVor7Po9z5lE4lHmBvCtbf8JEGS
	E+c2Y59K0A8zWjdQD1jINBl1Wrwc8/qkXdC6eXQzSqsWeEw4GEnu5kz9okPcnzcPpDTqXXn0Wa5
	zz+57lnLH8/Nz703hPuoL+G4w9xqhN2QlqwW0o4gPFcnELBhHf5U7Oej9
X-Received: by 2002:a05:690e:438e:b0:679:9afd:c0dd with SMTP id 956f58d0204a3-67a4552069bmr3589003d50.111.1793042029259;
        Mon, 26 Oct 2026 12:13:49 -0700 (PDT)
X-Received: by 2002:a05:690e:438e:b0:679:9afd:c0dd with SMTP id 956f58d0204a3-67a4552069bmr3588993d50.111.1793042028912;
        Mon, 26 Oct 2026 12:13:48 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-67a45ff8d6dsm3976103d50.1.2026.10.26.12.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:13:48 -0700 (PDT)
Message-ID: <ffcda856-cffb-4aba-9a7f-fece5ac6419a@canonical.com>
Date: Mon, 26 Oct 2026 12:13:46 -0700
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
Subject: Re: [PATCH] apparmor: fix NULL peer label deref for connected
 SOCK_DGRAM sockets
To: Nik Tsytsarkin <nikt@meta.com>,
 Georgia Garcia <georgia.garcia@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sam Dlinn <sledge@meta.com>
References: <CAN8mxQpCCO3QNXb0pimRsNqfLs1qS0epZmB59q2sd8QCLhgOpA@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAN8mxQpCCO3QNXb0pimRsNqfLs1qS0epZmB59q2sd8QCLhgOpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 10:30, Nik Tsytsarkin wrote:
> apparmor_sk_alloc_security() initializes ctx->peer and
> ctx->peer_lastupdate to NULL, and unix_connect_peers() is the only
> place they are set.  It is called from the unix_stream_connect and
> socket_socketpair hooks, but not for SOCK_DGRAM sockets paired with
> connect(2): the dgram connect path only goes through the unix_may_send
> hook, which does not touch the socket's apparmor context.  So after
> connect(2) on an AF_UNIX SOCK_DGRAM socket, unix_peer(sk) is set while
> ctx->peer stays NULL.
> 
> When a confined task later triggers file revalidation on such a
> socket (its first write(2) on the fd suffices, with or without a
> profile change in between), aa_unix_file_perm() runs the post-check
> cache update with peer_sk != NULL and a NULL cached peer label, and
> both update paths dereference the NULL label:
> 
>    - update_peer_ctx() calls aa_label_merge(old, label, ...) with
>      old == NULL, which reads old->size;
>    - update_sk_ctx() calls aa_label_is_subset(plabel, old) with
>      old == NULL, which reads old->size via
>      __aa_label_next_not_in_set().
> 
> The AA_BUG() NULL assertions in those helpers compile out without
> CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS, so production builds oops
> under spin_lock(&unix_sk(sk)->lock).  An unprivileged confined task
> can trigger this whenever its profile mediates unix sockets (complain
> mode included).  Because the oops happens under the unix sock
> spinlock, the dying task then deadlocks against itself in
> unix_release_sock() on exit, leaving an unkillable spinning task and
> an RCU stall on that CPU (and a full crash with panic_on_oops=1).
> 
>    BUG: kernel NULL pointer dereference, address: 000000000000004c
>    RIP: 0010:aa_label_merge+0x63/0x730
>    Call Trace:
>     aa_unix_file_perm+0x477/0x800
>     aa_file_perm+0x434/0x550
>     common_file_perm+0x58/0x150
>     security_file_permission+0x22/0x50
>     vfs_write+0x76/0x410
>     ksys_write+0xb3/0xd0
> 
> Treat a NULL cached peer label as "not initialized yet" in both
> update helpers: have update_peer_ctx() adopt the checked label
> instead of merging with the missing old one, and have update_sk_ctx()
> initialize ctx->peer/ctx->peer_lastupdate when no peer label was
> recorded.  This lazily completes, at first revalidation, the peer
> cross-referencing that unix_connect_peers() performs for stream and
> socketpair sockets.
> 
> Fixes: c05e705812d1 ("apparmor: add fine grained af_unix mediation")
> Assisted-by: LLM
> Signed-off-by: Nik Tsytsarkin (nikt@fb.com)

Hi Nik, thankyou for the patch. This issue has already been addressed
in the apparmor tree by

f61da65fd09e3 apparmor: fix NULL ctx->peer derefs in unix socket ctx updates

> ---
>   security/apparmor/af_unix.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index b908e744818c..e802538b0e54 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
> @@ -682,7 +682,7 @@ static void update_sk_ctx(struct sock *sk, struct
> aa_label *label,
>    if (old == plabel) {
>    rcu_assign_pointer(ctx->peer_lastupdate,
>      aa_get_label(plabel));
> - } else if (aa_label_is_subset(plabel, old)) {
> + } else if (!old || aa_label_is_subset(plabel, old)) {
>    rcu_assign_pointer(ctx->peer_lastupdate,
>      aa_get_label(plabel));
>    rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
> @@ -700,7 +700,11 @@ static void update_peer_ctx(struct sock *sk,
> struct aa_sk_ctx *ctx,
>    spin_lock(&unix_sk(sk)->lock);
>    old = rcu_dereference_protected(ctx->peer,
>    lockdep_is_held(&unix_sk(sk)->lock));
> - l = aa_label_merge(old, label, GFP_ATOMIC);
> + if (old)
> + l = aa_label_merge(old, label, GFP_ATOMIC);
> + else
> + /* connected dgram socket, peer ctx was never initialized */
> + l = aa_get_label(label);
>    if (l) {
>    if (l != old) {
>    rcu_assign_pointer(ctx->peer, l);
> --

