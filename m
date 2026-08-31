Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E7A411A00
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181905; cv=none; b=nF7QreiTXM5hAuriYHhEOL1znF/Wns7udlePeZUz2J71YQM18woFSuskl4/99CVeD9RRbgj7bkxNuaKNNWyE+7zulVf0un20I0nnwtU0lNrAtAmKAjalBLKqtRNfegWav6xnr4jqB9U3NwUguphee1pMZZin61xm9m0Y3bj4Zzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181905; c=relaxed/simple;
	bh=TxLbYFIeG32Cm5fP74PpnM0fvn+2ffrjC1dTaoyrSPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIMa0b8WpOTc1WPYhbyWR6Av9O11fNwcAi7iobDoWp+YxHJ94ntFXJ5Rox7ECOCYeGdI9E7EaFPSc5jLN1Y8PpWRIrOIuLazDLRRuL6Qhq9yP9MK14n9Nutp4eLcwp70B8PESBoAYfKMp1UQIF/Gb551BCYoRt2akq9cErYH92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr5etj9c; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr5etj9c"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-484374f54d0so872620f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181901; x=1788786701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nCrwd5lomZyvZDnWJBN6PQm4ecAtoB1KVxGo2UFaw+g=;
        b=hr5etj9cW5WosO66fkanOTAmSn6gsZaKx2FCvBJFyxcAF71RdbS0xPvTyxYFEFCUxg
         9LBbFdV6rObp7M7TwmVhg7RJ158uxcCXGB3rgPSX8YwvxnH4An96degqjItQ2ONRAaHA
         yzsdK58pfkXUUJUZoEFHHlgSP1D4rALya1jJeDSYnYoeHgrvtk64SHtGWfLLMTP/sSJc
         8pq+7z0yxdRTxbpNhBG1YllxPrpstX81b3DiAmd6NKxcOXiqzN3abUFOBronIAnBCFl0
         asHqJgkUjLUQ8tVpJNKRuJE3iq481xqvSzQUmfgGCkpeV2pRQo/3L8opqUPKxyKR2q1j
         q/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181901; x=1788786701;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nCrwd5lomZyvZDnWJBN6PQm4ecAtoB1KVxGo2UFaw+g=;
        b=Z1N7T1auHhGe0PHkicWKTImQfuLEfThPkgHbwS7WyBU8Ew7S97QorutyATnBYtiABa
         1Roepk+WU2lxVt+kS0N609Re9QNiOCNAXhPBl+Zjtiy2Whj66v80J+3+G77b96szI6IH
         QLjdIT6lzfa7doEo2QTjl2cZHyvMUo33c7NEpYqEn4qcCrBOA/VSTyfy1PC8e9nGjsta
         BmfExTXJ0WBPRSRBSYEu2gN9ybP0xEPIeY1FwHBcKbBejCYUYL7lMPy06UaGJl0U87Tw
         sBHlHLan8xbufB8jjeccjYJrNxEuuCO5482OMHHNV8vr0FGeBz7GTvolOVjLgY6PbfIK
         UKLA==
X-Forwarded-Encrypted: i=1; AKwUvBzKuW0y/77o081hKAL5OGCqen8m23kickeP5+O/n5SaudKfrLE5B6awKWTCUBp3iBfK9rmaADhRo7C12Z9klM7Lon8Xi24=@vger.kernel.org
X-Gm-Message-State: AFuF++l3Cz09tn9YXxMpwefor7mRSwm1pILNT1tM80YpkaOOoUbIKT5n
	odLAcrgGpy52hFwAZnVw7P6CBGJKQ+3Kz05kLpJfZrPsjAnOTjgbm/DP
X-Gm-Gg: AYBFou1wzEqhIyX7yNnkhj1i8q1IbuSQS+W+8B1lCHEx7LCc+PadyebtICSQshw1FlH
	hBX5/yAogyOw0beAuzBJ8X/3zDeRfFd650xWabb1m2th9C+XQMGHSmDK3kWNupBcFvhu6e/s87Q
	fO8dZLkzEjHwiZo2KNYTlslNVwhzvnO9eODusRK4outeK7VXefZfvdN8Ta+tVEecFNiwNo5j+pn
	hEkN6Z3qgHdhjbFWspIRMw7M+JF6+4H+WdWVTt3fjuk/hQugWxZQLeWczYNmd7M+uWEWjF8g17f
	qPWCN1OQKuZpGgZq+b/tFskB3J55MHKLHSUnETpzN4S2wqI/0cob8nBtev1RyWLzyMFc2rDa3y4
	81yFNwSW1V4sJIFnFHdQ/p6W4brlNs/bLo4D7XWdGEx4/fkXLVLcxq8K7VV9TGamoKwGzyKLjaw
	1gyXVTXvUfqYqekK1Q2Bk0WBTmrEW0Ssgw+vHqY/5ATiy2Lw0bl1o0XNxnKl1tWlWL9iIu
X-Received: by 2002:adf:e00c:0:10b0:47f:9096:3ef1 with SMTP id ffacd0b85a97d-48440fc78ebmr1222844f8f.9.1788181900425;
        Mon, 31 Aug 2026 06:11:40 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843ce8b015sm5697604f8f.13.2026.08.31.06.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:11:39 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:22:20 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	kpsingh@kernel.org, matt@bobrowski.net, john.fastabend@gmail.com,
	brauner@kernel.org, paul@paul-moore.com,
	torvalds@linux-foundation.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/7] net, bpf: Add a generic netlink hook on
 msg_rcv
Message-ID: <apWADDwqx4r2xEZU@mail.gmail.com>
References: <20260831110934.241898-3-a.s.protopopov@gmail.com>
 <7396552568004928dc8c7d43c5a8b3de699e698f37f6fc555ea49312a5116a9f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7396552568004928dc8c7d43c5a8b3de699e698f37f6fc555ea49312a5116a9f@mail.kernel.org>

On 26/08/31 12:07PM, bot+bpf-ci@kernel.org wrote:
> > commit 18faf289d6ccb694a2ce1ae68f5c3cf881de2fd4
> > Author: Anton Protopopov <a.s.protopopov@gmail.com>
> >
> >     net, bpf: Add a generic netlink hook on msg_rcv
> >
> >     Add a new bpf_lsm_genl_family_rcv_msg() BPF hook called from within
> >     the genl_family_rcv_msg() function. The hook sees the genl family,
> >     net, cmd, and nlmsg_flags.  As the hook receives all the information
> >     pre-parsed, it is not put into the sleepable list.
> >
> >     There is already an existing LSM hook sitting right at netlink_send,
> >     however, it looks to be too coarse-grained to be used directly. The
> >     netlink_send hook sees the struct sock and struct skb, and thus must
> >     duplicate all the parsing inside BPF. The messages can actually contain
> >     multiple netlink datagrams, dynamic info (see e.g., selinux_nlmsg_lookup()
> >     in context of generic netlink), etc.
> >
> >     The purpose of this hook is to mitigate, in a coarse-grained way,
> >     CVEs reachable via the corresponding control path: genl recvmsg.
> >     While looking at the recent CVEs, robots found ~300 CVEs reachable
> >     via the genl_rcv. We can roughly split them as follows:
> >
> >       * Around 100 are ethtool-related. For more detailed information,
> >         see the following commit which adds even more finer-grained
> >         ethtool hooks.
> >
> >       * Around 100 of the remaining are fully dominated by the new hook.
> >
> >       * Around 100 remaining aren't fully mitigatable, as other control
> >         paths, besides the genl, lead to the buggy code.
> >
> >     To be more precise, the following CVEs are properly mitigated by the
> >     new hook:
> >
> >       * CVE-2021-47518 CVE-2021-47594 CVE-2021-47612 CVE-2022-48687
> >         CVE-2022-49060 CVE-2022-49085 CVE-2022-49300 CVE-2022-49862
> >         CVE-2022-49959 CVE-2022-50656 CVE-2022-50834 CVE-2022-50854
> >         CVE-2023-52698 CVE-2023-52702 CVE-2023-52977 CVE-2023-53113
> >         CVE-2023-53298 CVE-2023-53686 CVE-2023-53843 CVE-2024-26608
> >         CVE-2024-26663 CVE-2024-26754 CVE-2024-26811 CVE-2024-26950
> >         CVE-2024-27025 CVE-2024-27410 CVE-2024-36941 CVE-2024-38562
> >         CVE-2024-43912 CVE-2024-45010 CVE-2024-46711 CVE-2024-49937
> >         CVE-2024-50085 CVE-2025-21706 CVE-2025-21787 CVE-2025-21862
> >         CVE-2025-21875 CVE-2025-21947 CVE-2025-22024 CVE-2025-38184
> >         CVE-2025-38443 CVE-2025-40084 CVE-2025-68263 CVE-2025-68366
> >         CVE-2026-23297 CVE-2026-23436 CVE-2026-43252 CVE-2026-43394
> >         CVE-2026-53128 CVE-2026-53227 CVE-2026-53233 CVE-2026-53238
> >         CVE-2026-53257
> >
> >     The following are mitigated as well, but, theoretically, could
> >     benefit from a finer-grained hook, running after a deeper
> >     parsing/taking locks (this is however out of scope for now to
> >     add finer-grained hooks for each involved subsystems, as, unlike
> >     ethtool, they are more-or-less evenly distributed):
> >
> >       * CVE-2021-47250 CVE-2021-47257 CVE-2021-47554 CVE-2022-48915
> >         CVE-2022-49374 CVE-2022-49505 CVE-2022-50042 CVE-2022-50678
> >         CVE-2023-52845 CVE-2023-53141 CVE-2023-53543 CVE-2023-53652
> >         CVE-2023-54031 CVE-2024-26725 CVE-2024-26951 CVE-2024-42073
> >         CVE-2024-42154 CVE-2024-46676 CVE-2024-47687 CVE-2024-50028
> >         CVE-2025-21973 CVE-2025-38020 CVE-2025-38628 CVE-2025-40254
> >         CVE-2025-40321 CVE-2025-68785 CVE-2025-71091 CVE-2025-71297
> >         CVE-2026-23321 CVE-2026-31707 CVE-2026-31744 CVE-2026-43012
> >         CVE-2026-43467 CVE-2026-43481 CVE-2026-45840 CVE-2026-52978
> >         CVE-2026-52979 CVE-2023-53570 CVE-2024-42114 CVE-2024-53189
> >         CVE-2024-56663 CVE-2025-21909 CVE-2026-53182
> >
> >     Policies for selected CVEs are added in the corresponding
> >     selftests patch.
> >
> >     Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> This isn't a bug, but would it be worth trimming the two CVE enumerations
> or pointing at where the classification lives so the coarse-grained-vs-
> netlink_send rationale is not outnumbered roughly 3:1 by bare IDs?
> 
> The selftests patch is already referenced for the policies. The tail of
> the second CVE list also breaks the ascending order it starts with
> (CVE-2026-52979 is followed by CVE-2023-53570).

Yeah, thanks, I will consider this.

> 
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index 1e54c7cca27ad..452b9d1d7c494 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -12,6 +12,8 @@
> >  #include <linux/bpf_verifier.h>
> >  #include <linux/lsm_hooks.h>
> >
> > +struct genl_family; /* for the bpf_lsm_genl_family_rcv_msg hook */
> > +
> >  #ifdef CONFIG_BPF_LSM
> >
> >  extern bool bpf_lsm_initialized __ro_after_init;
> > diff --git a/include/linux/bpf_lsm_hook_defs.h b/include/linux/bpf_lsm_hook_defs.h
> > index 29bc0b514d168..3f57022744a31 100644
> > --- a/include/linux/bpf_lsm_hook_defs.h
> > +++ b/include/linux/bpf_lsm_hook_defs.h
> > @@ -4,3 +4,10 @@
> >   * This is a set of BPF LSM hooks, which are _not_ fully implemented
> >   * as LSM hooks. Thus, they only can be used by BPF LSM programs.
> >   */
> > +
> > +#ifdef CONFIG_NET
> > +
> > +LSM_HOOK(int, 0, genl_family_rcv_msg, const struct genl_family *family,
> > +	 const struct net *net, u32 cmd, u16 nlmsg_flags)
> > +
> > +#endif /* CONFIG_NET */
> > diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> > index 0da39eaed255f..12b4f49c72534 100644
> > --- a/net/netlink/genetlink.c
> > +++ b/net/netlink/genetlink.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/skbuff.h>
> >  #include <linux/mutex.h>
> >  #include <linux/bitmap.h>
> > +#include <linux/bpf_lsm.h>
> >  #include <linux/rwsem.h>
> >  #include <linux/idr.h>
> >  #include <net/sock.h>
> > @@ -1161,6 +1162,7 @@ static int genl_family_rcv_msg(const struct genl_family *family,
> >  	struct genlmsghdr *hdr = nlmsg_data(nlh);
> >  	struct genl_split_ops op;
> >  	int hdrlen;
> > +	int err;
> >  	u8 flags;
> 
> This isn't a bug, but would int err sit better after u8 flags so the
> declaration block stays longest-to-shortest, per the reverse xmas tree
> ordering in Documentation/process/maintainer-netdev.rst?

yes

> 
> [ ... ]
> 
> > @@ -1187,6 +1189,10 @@ static int genl_family_rcv_msg(const struct genl_family *family,
> >  	    !netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN))
> >  		return -EPERM;
> >
> > +	err = bpf_lsm_hook(genl_family_rcv_msg, family, net, hdr->cmd, nlh->nlmsg_flags);
> > +	if (err)
> > +		return err;
> > +
> 
> This isn't a bug, but could the bpf_lsm_hook() call be wrapped the way
> the genl_family_rcv_msg_dumpit() / _doit() calls just below it are, so
> it stays under 80 columns like the rest of the file?

ok

> 
> >  	if (flags & GENL_CMD_CAP_DUMP)
> >  		return genl_family_rcv_msg_dumpit(family, skb, nlh, extack,
> >  						  &op, hdrlen, net);
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074

