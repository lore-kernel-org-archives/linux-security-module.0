Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792617928;
	b=LUz8jQxURzf/j38atWwn/SqrnKVNqRrMYNYLhbIGDE6TKhGQliWpOjZhPN+lHmePb0XM
	 Rs44WYzxz+BUTjNGVDbXqdA2VqmJenk3uGxTJufCkYj4n7hcLFhSZvcU/V8h+YBAhxCor
	 3Tst8eO+Cnw5g+D3e+d7W+sdLZ3RTHsxwUUaQrKP/f3GR3AjD3w9RKpgR/0uWtd8r2W2j
	 pj0+Az9UxpYHDt2foko/UWmymRAJAO15k2M3fVIDjY8r/bpPkDOcxlR2NKwl0x92cMuXu
	 nWDb41cw7rH1L6+srL7cB/lpyoKMVp3vgvXDv2yZHHIL9a7Va7K2jDfCf82cfilPJwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617928;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=33JuXHyVlysurdpqf1yztITi2es9POo9XR0Odt0/vI0=;
	b=hQnPb5jfJNC17Zdx81blxHtyAOcvye1vEw3QFWJ9fWZDMci9wH2dlE/gOtW2sYigNgVf
	 WN2Qjgt1CedRAQEN2LhRKj63kHt+MEpv7aMXnqOlfPSiSxX9Hs0lrt84U0d0qwZl2TOlO
	 4PLtIRdkfoCFLYZwJfwNlf86MxNjIZtsbQToX+rm8ifnrYVt+F3+kEs0kWmf1+rczHAzd
	 qL6XyNXxZoqM3J0uofkqni8oV5016mroUrxTYSvmlCol00gVkkFqNw6wJgrbZuKGNya6P
	 weI2dKW6jRlqIoAPL5m/ugGF+Ai+h7Tty3NE5oO0suluTz5Vehhu+cggZ2WW+Dv5yrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=W+yXpeUi;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981E606A333;
	Wed, 21 Oct 2026 21:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7981E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=W+yXpeUi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1792617923; bh=YJaRefwOJLhahpsbRbaXvnvSPD2eF10+mf+xkt6Pzc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+yXpeUiUxF6WxRdjZP/fW6qjf2ABX311eGJL33c2qsEkf9YEpjquiaXX3KWPFwpD
	 uxgi0f9f7RimtL5I0rGm/qsGx6+H+bXYXv1Z0AvZjO9WfAAmcnQrK1warWQEdXtC1W
	 0pgnuzyRtl8idnKIR50ZKqgav1hDum6STnLFP84G69eOxp2UKnMbtNEb5R4xc8YpAx
	 1/Y8jupvdNUiGg8dKA5s8QI6K6W1OWoxHHJrLV6ZZJF+72gGsabqNgGl00E9nXjJol
	 r2noWnnOWEVmULzrMIZxjCp44Ffxpldjs6T2GB3a5EC6LvCTf7iF0aNYq0cDjsybEk
	 YfriqaI2l8uCQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id D9E3F277; Wed, 21 Oct 2026 16:25:23 -0500 (CDT)
Date: Wed, 21 Oct 2026 16:25:23 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Nik Tsytsarkin <nikt@meta.com>
Cc: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sam Dlinn <sledge@meta.com>
Subject: Re: [PATCH] apparmor: fix NULL peer label deref for connected
 SOCK_DGRAM sockets
Message-ID: <atktw9TRy0UKsjOB@hallyn.com>
References: <CAN8mxQpCCO3QNXb0pimRsNqfLs1qS0epZmB59q2sd8QCLhgOpA@mail.gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8mxQpCCO3QNXb0pimRsNqfLs1qS0epZmB59q2sd8QCLhgOpA@mail.gmail.com>

On Tue, Oct 20, 2026 at 12:30:41PM -0500, Nik Tsytsarkin wrote:
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
>   - update_peer_ctx() calls aa_label_merge(old, label, ...) with
>     old == NULL, which reads old->size;
>   - update_sk_ctx() calls aa_label_is_subset(plabel, old) with
>     old == NULL, which reads old->size via
>     __aa_label_next_not_in_set().
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
>   BUG: kernel NULL pointer dereference, address: 000000000000004c
>   RIP: 0010:aa_label_merge+0x63/0x730
>   Call Trace:
>    aa_unix_file_perm+0x477/0x800
>    aa_file_perm+0x434/0x550
>    common_file_perm+0x58/0x150
>    security_file_permission+0x22/0x50
>    vfs_write+0x76/0x410
>    ksys_write+0xb3/0xd0
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

How did you generate this patch?  (It looks damaged.)

> Signed-off-by: Nik Tsytsarkin (nikt@fb.com)
> ---
>  security/apparmor/af_unix.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index b908e744818c..e802538b0e54 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
> @@ -682,7 +682,7 @@ static void update_sk_ctx(struct sock *sk, struct
> aa_label *label,
>   if (old == plabel) {
>   rcu_assign_pointer(ctx->peer_lastupdate,
>     aa_get_label(plabel));
> - } else if (aa_label_is_subset(plabel, old)) {
> + } else if (!old || aa_label_is_subset(plabel, old)) {
>   rcu_assign_pointer(ctx->peer_lastupdate,
>     aa_get_label(plabel));
>   rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
> @@ -700,7 +700,11 @@ static void update_peer_ctx(struct sock *sk,
> struct aa_sk_ctx *ctx,
>   spin_lock(&unix_sk(sk)->lock);
>   old = rcu_dereference_protected(ctx->peer,
>   lockdep_is_held(&unix_sk(sk)->lock));
> - l = aa_label_merge(old, label, GFP_ATOMIC);
> + if (old)
> + l = aa_label_merge(old, label, GFP_ATOMIC);
> + else
> + /* connected dgram socket, peer ctx was never initialized */
> + l = aa_get_label(label);
>   if (l) {
>   if (l != old) {
>   rcu_assign_pointer(ctx->peer, l);
> --
