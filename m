Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795211516;
	b=UO0nC+5+5jwf+xCLkLSz+WDi9W8QdQM6bYoIqhzVE7w7/uPicS/ezd5I+Wa6liDCmUkK
	 wZRbEiUxZfhmMWQap7oHo+BtICFyUtE/2KrTJbwJh834jrE9eiGM89wtJ15hSVEhmdudP
	 Lfu/+8+uhxfESDOhsl2BqQQa/kF+qBWv61vwBPpInOvdP+w3fSmBHGTti2nQD9FkIGheo
	 FqWotMGtmJrPtDqxdqK9ts0KJqqxQ2OSviN9Nhi7JRSixmiNAGQQp2XkWLazw0vdlH30d
	 5MdASvHMvSMYRIGKG4evaDlxMDrJTZXl9MGeRPjDq0wME33hLm+elNuAAZBAvi5VEbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QXn3BxyfcaTRVPKnRds+vZOyXItuUDy8pAU3lM3mH/k=;
	b=lxOHJFFoHRxJ6pA7TvkKbK1ErMWYUZnKIOyZI3mrHGSKsVHB+JHtOjRJUzsrqLwCZ17+
	 S2IaXf1YOPX/gmsmu2WCpaYSzYOwMzgOnm4Qhy3d44sK2UgX+SFghVZP163BZhaG6GWHB
	 gptBZZW5FvWwkiRjkIKzQbzAonwc16CqAoqCcYLjm2N8/eY5CPPhR3365NMxuSjmG25K4
	 Vba94Kk+FVKC6IkZ8NKq+eifZTcHunPCNEV2mFVAeC2XI8+kN3CtwRDZBaeL0rnGo+OGT
	 9ZxuEMD42oNaA5lyOvoYlwA6uDJilXzxX4Lw9JbAUJGslXTLur+ulwr/U7Pai55Eu5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=AgPu5J62;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85748606A6AC
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 21:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85748606A6AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=AgPu5J62
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso811531a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 13:51:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795211514; cv=none;
        d=google.com; s=arc-20260327;
        b=Q+gbA6QC9xguJv8hLh+KPG2VImkLMoDeR/8NIwUzeep4dI/X7q66HLdMU3T55dgrik
         hsUSvaPl3dnPsjgxRsm8eldQZ9VrxAhreAAeHPOwr5e/Ud7pWtwjoERAJw2VtQxCQQud
         KC8E2ZRQxPfWAY+r5QhaMuZyrrVWG7psV0vggypyY53uW90wpbqLqx4TlBo6Hhjj4iCq
         bUOwQ5aUzEsTHEG114reA0vGR3JQrKvc+m7DFu4DufLkw/fg9Bng8AMOY8UwJa1Dmq+b
         gMPENDLgyXvz2o/TnFT3xItL69FVG2lL95KH5lPeXDp7TfqG349CEqvsmEGXcfSisV0p
         DU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXn3BxyfcaTRVPKnRds+vZOyXItuUDy8pAU3lM3mH/k=;
        fh=N3BMLAMrSGHvwqhxavASxZ6ldbtyjhwQ+68+SWCX5H4=;
        b=P9FMCmOkGDXlZSyRnPBZaOc+crxJTrQCMIN0b47kl+oe2NGm0sxSiyUK07qhFlQiNr
         Hk+MIMFai/ruTaUxr3uUrRO5clPBDp+GnHady9k3xpcIWCI+TogE8dUppuAGRN80p54T
         TKv2LX16motUhwKVWw4y+/9JK2P3kYFAWg7n9pujQYt7mONE1f33+Pa0IM9shLvnror7
         G/pIIY8EDWP5XkXoj277vqkoub5Ddz671OHpxMD03urDr3Tla3WP+wPs88iwWzBY2cfD
         2z+NySzdVcHjkjYLoR8uJBTx2SPSQcIR6Lo4c7FstTPSfhDVNs2ziWSJIJlE4PH/wneg
         E9QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795211514; x=1795816314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QXn3BxyfcaTRVPKnRds+vZOyXItuUDy8pAU3lM3mH/k=;
        b=AgPu5J62QchcMUFXnKGeHGbhznBH6/4T7KsyEkUOY27M7C4mEFFSzy3D0ukukqTs+v
         UdDLQh9qODUhqfGqFsRY3RqFnN8uTMHP1xeNP3cvDMwmgCPX4Mh9/RW5fC4sFN8V0uTn
         rU7AJPDQYLS821tOzruzDeD6nTadcmIZcqcMg8/4CMjmseE7wxWIgYPV4emZX9th4PF/
         eW1doKHM0VaUDJeBjIj5UGavF+VbJvuhjne7xwCi5+CvJ9jFe4lnge6932l/u3shVWyB
         WP2/riBG8FPPVN5srrNlbcNZ/Er2N1sDRsJb8wvAsxiv4vGiQ3YH3XA0C+ow9fDDXmBH
         jbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211514; x=1795816314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXn3BxyfcaTRVPKnRds+vZOyXItuUDy8pAU3lM3mH/k=;
        b=HzkH1LZ3GNIrwm2HQWkXmb2YiSgq4Nn4DWB28xxgtuwNQzgrM8jqYIE4raiK0GR7uc
         bk33h1kvuUGmZ7m7y/1RO84haTEVuuxyMIZOj2olWXLUAin9IC93P8R/CcCrucYxM4z2
         zTTLy5OHA7ZZ8UyJLj7YGddMwi3Q2kQ7rA7QwtKW27fNtYFLgvkT4ySr7XT0HcfBrvYW
         PbI3u7wCkoRGczX40chysYj6YUV5kvvp4r//DIPZlLa/SWwDP9/QkY05KYKMIsKLV1/f
         YM0PDuLBhDOfwUp2x73359HMe2GaZoPdhEMmBnnVXcYKe395SKQM5JB6/ya5DUxYoNT6
         gptw==
X-Forwarded-Encrypted: i=1; AL+hErGirRTN2mm+HE/dua3RaYiFJDdFB13EiSHrinrWw9/8AW3oQDVJMl7F+tekTaKePoANFr9OAmClwA/0Blzg47hwU6l6sMs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eEH2pNhLGe2NAOehGa03fhQepZv/oe6p31vgWnBp1ErxSLN+0
	wSYu4/PXuY2Kpy7uKUBCIkzKFesv3+hzhBxc6xKrStegR0WuUxTcvI7DOZeKdlsp/O2qFo2C/rF
	Lwl0wiGwsmd81I12/QzzrTPsv0mo9iKa0N8iWdtkc
X-Gm-Gg: AZFdTZcaz+k+bItAU41X+1qAsVEx0UXaoTfLHot4GbHS/AS/l7rSOc3a/mINUqpZ/SH
	nvnlnhPtgPFtMbbxlW1Uwbsol0jryvfB9AQmUXZQkqQdo4vGv40IzshlHzxF3WBKbZujCyVklb0
	WZiQTlVH6RjiZfbZjAfhGS4+wxeXlTTs3U9GdlefW6f6BI/vU+q9yBi5cAiC+2CUeFCrinN7lkp
	qiOMdK5+k2TXt0M8FsFWLC6LTdgk05TSfbEcYVFAClttaxX7MdRuTF0432AC6TKG659ijGud/ts
	1JNYygy/lWVou/0cLntvCn6GwrePxFFeSARt8LNpKZ/8NEiZGyrT2gUnTTZMc6xPKV6EKt9iFUD
	4QcR6+rGlxE4utYNXI2bRlNkYzyP40YD5bNOzGvJsKzXtVtlsdRiHuJ+3z66RJBUYouPW
X-Received: by 2002:a17:90b:4d86:b0:3ac:7c52:faeb with SMTP id
 98e67ed59e1d1-3b41c93b0dfmr4530278a91.41.1795211513818; Fri, 20 Nov 2026
 13:51:53 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115144508.71543-1-jiayuan.chen@linux.dev> <cbaa372f-6ec1-4ceb-a012-30eaac5ae8eb@redhat.com>
In-Reply-To: <cbaa372f-6ec1-4ceb-a012-30eaac5ae8eb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Nov 2026 16:51:42 -0500
X-Gm-Features: AclHuK_GGiWFUVKZSpr8dYR-2FHgC-uowX04GimNX21-i66RpifdzgYCCqwHyG8
Message-ID: <CAHC9VhTBf7wHMsneqUTT0p3pABkbD0GHuTJXFehKhA10NvWgxQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6, calipso: fix data-race in calipso_cache_add()
 bucketsize check
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 7:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
> On 11/15/26 15:45, Jiayuan Chen wrote:
> > Issue found by sashiko when reviewing my data-races patch [1]. This is
> > not a plain READ_ONCE() annotation like the rest of that series but a
> > real fix, so it is sent separately.
> >
> > calipso_cache_add() reads calipso_cache_bucketsize twice: the "<=3D 0"
> > guard on entry, then the "size < bucketsize" test after taking the
> > bucket lock. A writer can flip it to 0 in between:
> >
> >    CPU0                                    CPU1
> >    calipso_cache_add()
> >      calipso_cache_bucketsize =3D=3D 10 (> 0)
> >                                            proc_dointvec()
> >                                              calipso_cache_bucketsize =
=3D 0
> >      spin_lock_bh(&bucket.lock)
> >      size(0) < calipso_cache_bucketsize(0) -> false
> >      -> else branch, but the bucket is empty
> >
> > On an empty bucket the else branch takes list.prev (the list head
> > itself), list_del()s it and then list_add()s through the now poisoned
> > head:
> >
> >   Oops: general protection fault, probably for non-canonical address
> >   0xdead000000000108
> >   RIP: 0010:calipso_cache_add+0x2f0/0x380
> >   Call Trace:
> >    <IRQ>
> >    calipso_cache_add+0x4c/0x70
> >    netlbl_cache_add+0x4a/0xa0
> >    selinux_netlbl_skbuff_getsid+0x1ac/0x280
> >    selinux_skb_peerlbl_sid+0x7d/0x100
> >    selinux_socket_sock_rcv_skb+0x2d3/0x460
> >    security_sock_rcv_skb+0x86/0x150
> >    sk_filter_trim_cap+0x56/0x730
> >    sock_queue_rcv_skb_reason+0x1e/0x80
> >    rawv6_rcv+0x679/0xb20
> >    raw6_local_deliver+0x1f0/0x5b0
> >    ip6_protocol_deliver_rcu+0x215/0x9a0
> >    ip6_input_finish+0xb0/0x1b0
> >    ip6_input+0xa8/0x250
> >    ipv6_rcv+0x14b/0x1c0
> >    __netif_receive_skb_one_core+0x8f/0xe0
> >    __netif_receive_skb+0x23/0xb0
> >    process_backlog+0x27a/0x950
> >    __napi_poll.constprop.0+0x61/0x2c0
> >    net_rx_action+0x372/0x800
> >    handle_softirqs+0x109/0x570
> >    __do_softirq+0x10/0x18
> >    do_softirq.part.0+0x47/0xd0
> >    </IRQ>
> >    <TASK>
> >    __local_bh_enable_ip+0xf0/0x120
> >    __dev_queue_xmit+0x578/0x23f0
> >    neigh_resolve_output+0x278/0x3c0
> >    ip6_finish_output2+0x4b1/0xcb0
> >    ip6_finish_output+0x2b6/0x6b0
> >    ip6_output+0x122/0x400
> >    ip6_local_out+0x61/0xb0
> >    ip6_send_skb+0xa0/0x260
> >    ip6_push_pending_frames+0x2b/0x40
> >    rawv6_sendmsg+0x1b7a/0x2750
> >    inet_sendmsg+0xa1/0xb0
> >    __sys_sendto+0x2fe/0x350
> >    __x64_sys_sendto+0x7f/0xb0
> >    do_syscall_64+0xe1/0x450
> >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Snapshot the sysctl into a local once and use it for both tests, like
> > cipso_v4_cache_add() has since commit dd44f04b9214 ("cipso: Fix
> > data-races around sysctl.").
> >
> > [1] https://lore.kernel.org/netdev/179428999963.994134.1690454450089005=
3668@kernel.org/
> >
> > Fixes: 4fee5242bf41 ("calipso: Add a label cache.")
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> LGTM, but let's wait for Paul's explicit ack.
>
> @Paul: please LMK if you prefer we apply this kind of
> simple, clean fixes directly.

Looks good to me too, thanks Jiayuan for working on this!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
