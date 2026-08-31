Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804A3F210C;
	Mon, 31 Aug 2026 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178036; cv=none; b=lpzuhBVrI/owPdVSu3x2LQPivuL7njJ7ogJkwTzLQydKF2uxUc0mzGnFvPmrEO8BKSehvhqhPC1C2OErvko2H7CLmLNVoo3TuGtWBwomz/iBqnfk461PgqYfoJIZokOR1Kne9RovcnmFzBuW5UaatpxIhY3wDDFfTMtEtEcNSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178036; c=relaxed/simple;
	bh=DTi4Na5nKmEUdjsy9ahHtylA+gceC3VtgtT+pY0vsJ8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZrlEibh2vFV4FuKOhj4CepSjqxZkM0c5vcHqHdytX6mLhCb2lIdfWu2bX+tEdjLt+R593rugEzEkXvDHv5Egdw9zIIwgAniiZUlpwwe8x7fiyMC9Adzu/cHP9WOBFCM3cgXFuoAkLvfOhj9ZvZPHbD8I1eL6DU5vmMf9J/5j6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnvWqxpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnvWqxpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9A01F00A3D;
	Mon, 31 Aug 2026 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788178034;
	bh=Ac3dV6gQKs1+Xudu2sTUQrH/g3JwnbcTZa09txyKXy0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hnvWqxpzZGGQRKW6u6mtzuRbYCxb7iYzUA+KchJZTNNSquR2RwWQySmecMs2PAtl7
	 lHc5pMd4WI0finUR03LXxz0ANQpymjqhKBiMMs7JU6Ry+0kCpxGEPfGdpqrvQ0F9p2
	 WL5P227l/M3f8ROM88KWl9PPNGHv483LHDof6d/ySsmXjzKk2ju7GEF8rSi62vFFZ5
	 QsvPSTyMhCU/gHp+dh8fBoIwdqxEDLvgQ/FKa6ftds/Eh6vG1xYgCmRzlKtERx00o+
	 bJfp3HlYVFvmbAJTvDMYO2HSkpR4lKrR3dMuamr/nz8W3pQdcZTBz0GC1tgW1MqXlH
	 3sj3psREvJ+OA==
Content-Type: multipart/mixed; boundary="===============3547586745664727827=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7396552568004928dc8c7d43c5a8b3de699e698f37f6fc555ea49312a5116a9f@mail.kernel.org>
In-Reply-To: <20260831110934.241898-3-a.s.protopopov@gmail.com>
References: <20260831110934.241898-3-a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next 2/7] net, bpf: Add a generic netlink hook on msg_rcv
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,john.fastabend@gmail.com,brauner@kernel.org,paul@paul-moore.com,torvalds@linux-foundation.org,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 12:07:13 +0000 (UTC)

--===============3547586745664727827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 18faf289d6ccb694a2ce1ae68f5c3cf881de2fd4
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
>
>     net, bpf: Add a generic netlink hook on msg_rcv
>
>     Add a new bpf_lsm_genl_family_rcv_msg() BPF hook called from within
>     the genl_family_rcv_msg() function. The hook sees the genl family,
>     net, cmd, and nlmsg_flags.  As the hook receives all the information
>     pre-parsed, it is not put into the sleepable list.
>
>     There is already an existing LSM hook sitting right at netlink_send,
>     however, it looks to be too coarse-grained to be used directly. The
>     netlink_send hook sees the struct sock and struct skb, and thus must
>     duplicate all the parsing inside BPF. The messages can actually contain
>     multiple netlink datagrams, dynamic info (see e.g., selinux_nlmsg_lookup()
>     in context of generic netlink), etc.
>
>     The purpose of this hook is to mitigate, in a coarse-grained way,
>     CVEs reachable via the corresponding control path: genl recvmsg.
>     While looking at the recent CVEs, robots found ~300 CVEs reachable
>     via the genl_rcv. We can roughly split them as follows:
>
>       * Around 100 are ethtool-related. For more detailed information,
>         see the following commit which adds even more finer-grained
>         ethtool hooks.
>
>       * Around 100 of the remaining are fully dominated by the new hook.
>
>       * Around 100 remaining aren't fully mitigatable, as other control
>         paths, besides the genl, lead to the buggy code.
>
>     To be more precise, the following CVEs are properly mitigated by the
>     new hook:
>
>       * CVE-2021-47518 CVE-2021-47594 CVE-2021-47612 CVE-2022-48687
>         CVE-2022-49060 CVE-2022-49085 CVE-2022-49300 CVE-2022-49862
>         CVE-2022-49959 CVE-2022-50656 CVE-2022-50834 CVE-2022-50854
>         CVE-2023-52698 CVE-2023-52702 CVE-2023-52977 CVE-2023-53113
>         CVE-2023-53298 CVE-2023-53686 CVE-2023-53843 CVE-2024-26608
>         CVE-2024-26663 CVE-2024-26754 CVE-2024-26811 CVE-2024-26950
>         CVE-2024-27025 CVE-2024-27410 CVE-2024-36941 CVE-2024-38562
>         CVE-2024-43912 CVE-2024-45010 CVE-2024-46711 CVE-2024-49937
>         CVE-2024-50085 CVE-2025-21706 CVE-2025-21787 CVE-2025-21862
>         CVE-2025-21875 CVE-2025-21947 CVE-2025-22024 CVE-2025-38184
>         CVE-2025-38443 CVE-2025-40084 CVE-2025-68263 CVE-2025-68366
>         CVE-2026-23297 CVE-2026-23436 CVE-2026-43252 CVE-2026-43394
>         CVE-2026-53128 CVE-2026-53227 CVE-2026-53233 CVE-2026-53238
>         CVE-2026-53257
>
>     The following are mitigated as well, but, theoretically, could
>     benefit from a finer-grained hook, running after a deeper
>     parsing/taking locks (this is however out of scope for now to
>     add finer-grained hooks for each involved subsystems, as, unlike
>     ethtool, they are more-or-less evenly distributed):
>
>       * CVE-2021-47250 CVE-2021-47257 CVE-2021-47554 CVE-2022-48915
>         CVE-2022-49374 CVE-2022-49505 CVE-2022-50042 CVE-2022-50678
>         CVE-2023-52845 CVE-2023-53141 CVE-2023-53543 CVE-2023-53652
>         CVE-2023-54031 CVE-2024-26725 CVE-2024-26951 CVE-2024-42073
>         CVE-2024-42154 CVE-2024-46676 CVE-2024-47687 CVE-2024-50028
>         CVE-2025-21973 CVE-2025-38020 CVE-2025-38628 CVE-2025-40254
>         CVE-2025-40321 CVE-2025-68785 CVE-2025-71091 CVE-2025-71297
>         CVE-2026-23321 CVE-2026-31707 CVE-2026-31744 CVE-2026-43012
>         CVE-2026-43467 CVE-2026-43481 CVE-2026-45840 CVE-2026-52978
>         CVE-2026-52979 CVE-2023-53570 CVE-2024-42114 CVE-2024-53189
>         CVE-2024-56663 CVE-2025-21909 CVE-2026-53182
>
>     Policies for selected CVEs are added in the corresponding
>     selftests patch.
>
>     Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

This isn't a bug, but would it be worth trimming the two CVE enumerations
or pointing at where the classification lives so the coarse-grained-vs-
netlink_send rationale is not outnumbered roughly 3:1 by bare IDs?

The selftests patch is already referenced for the policies. The tail of
the second CVE list also breaks the ascending order it starts with
(CVE-2026-52979 is followed by CVE-2023-53570).

> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 1e54c7cca27ad..452b9d1d7c494 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -12,6 +12,8 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/lsm_hooks.h>
>
> +struct genl_family; /* for the bpf_lsm_genl_family_rcv_msg hook */
> +
>  #ifdef CONFIG_BPF_LSM
>
>  extern bool bpf_lsm_initialized __ro_after_init;
> diff --git a/include/linux/bpf_lsm_hook_defs.h b/include/linux/bpf_lsm_hook_defs.h
> index 29bc0b514d168..3f57022744a31 100644
> --- a/include/linux/bpf_lsm_hook_defs.h
> +++ b/include/linux/bpf_lsm_hook_defs.h
> @@ -4,3 +4,10 @@
>   * This is a set of BPF LSM hooks, which are _not_ fully implemented
>   * as LSM hooks. Thus, they only can be used by BPF LSM programs.
>   */
> +
> +#ifdef CONFIG_NET
> +
> +LSM_HOOK(int, 0, genl_family_rcv_msg, const struct genl_family *family,
> +	 const struct net *net, u32 cmd, u16 nlmsg_flags)
> +
> +#endif /* CONFIG_NET */
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 0da39eaed255f..12b4f49c72534 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -17,6 +17,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/mutex.h>
>  #include <linux/bitmap.h>
> +#include <linux/bpf_lsm.h>
>  #include <linux/rwsem.h>
>  #include <linux/idr.h>
>  #include <net/sock.h>
> @@ -1161,6 +1162,7 @@ static int genl_family_rcv_msg(const struct genl_family *family,
>  	struct genlmsghdr *hdr = nlmsg_data(nlh);
>  	struct genl_split_ops op;
>  	int hdrlen;
> +	int err;
>  	u8 flags;

This isn't a bug, but would int err sit better after u8 flags so the
declaration block stays longest-to-shortest, per the reverse xmas tree
ordering in Documentation/process/maintainer-netdev.rst?

[ ... ]

> @@ -1187,6 +1189,10 @@ static int genl_family_rcv_msg(const struct genl_family *family,
>  	    !netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN))
>  		return -EPERM;
>
> +	err = bpf_lsm_hook(genl_family_rcv_msg, family, net, hdr->cmd, nlh->nlmsg_flags);
> +	if (err)
> +		return err;
> +

This isn't a bug, but could the bpf_lsm_hook() call be wrapped the way
the genl_family_rcv_msg_dumpit() / _doit() calls just below it are, so
it stays under 80 columns like the rest of the file?

>  	if (flags & GENL_CMD_CAP_DUMP)
>  		return genl_family_rcv_msg_dumpit(family, skb, nlh, extack,
>  						  &op, hdrlen, net);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074
--===============3547586745664727827==--
