Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284002;
	b=ZSwd8/fDa2SpIoIJPMwYFgkvXfL3dcW8lyuc3QHc4RWFOtM30a5dr+my6MjHTsljPSrq
	 /ojwM5wq/iQDNxCWeNL/Rwqe3vlrGmenUs8SNRzTH+oAI7itJDfDdxV+W2yxBSBddeP+7
	 iYdZ+Erk+63DL+nLFZ4EDH7Rozvpt+YVzaBLJE5mxi7q9jPb2Dk941aYczSg1d7ack/O6
	 TS1lHZXAX2qrj36PJ2/E9L2mpSkWL2xYH2l994EfHL6HYHYUDSwmnPfX9UVUmNzsYy+if
	 gtWjB6Wtq/h1GxuRN6jx7sCgRbm48XgNHgKi+WOzfmGJO33N2+Z4V7i++wwT+Zv1A5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284002;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HrTjEFneqENEU0A0mAWv3OY0DnbJ+LX86QGLkzByCaM=;
	b=rYQIwnjbQttEqCrbrFs3JIW3szZQ374DIpaS+sFPF0QR02MRI2Oe3NGKjywFEHIP2ynr
	 cdg3c2w0tXPB7pNWukbcicG4ifsbgbGh8/c0i6WDhg1JGLSrR3d+un0IxIiz2J0Ms0OJ+
	 BNLKrF8eObJ05TTDylwdE11U5BLwFftTvgchzYoAKiAw0MorHElasQzqYpv5QafFn1I+U
	 URa5ChcHI1JJmsLHKrSE+UXtzfJUxi3DsGfGrh6m0QwqfpIWKg79END+BjhnhFVWLXXTu
	 PgIpggCwaDKygDC4afOHLbMPxhVNMeDsgfi5y1YuK0srrN39WUm+J/wiKo4fZ7ZIGTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WR6fH3sU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59054606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WR6fH3sU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BECA1F031E9
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793284002;
	bh=HrTjEFneqENEU0A0mAWv3OY0DnbJ+LX86QGLkzByCaM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WR6fH3sU0XYOgkzOmr/c9TjhvBeyEUuczEmKKzduYThRf784ug4PYVp0iA5Toxk+U
	 RBSm/hjPZprTO1Y/Rj1a/pjGptAsjY+QbZfl3vdffv67tULLhf7BTkU3yARuFb1RZk
	 Va/5Kys2Xzx2YqgetH6zHTAx9bEYnHlqhwVaVMsjYAmo9W+zqv3IlNyUx5/cj2h2vN
	 AX5Ksn21FELsOONu7vJG1XjTpUaXFsU6b37d6gPlIWkNYtR52mBWzGOTmAStibXBLH
	 oHGTllinn7TECyOqAYCy0QZ1A5DUXnqyhzZwlifxWGlUNAsFR6CoNAJH5Vp43GpFma
	 9R7CjYfRyTjDA==
Message-ID: <sashiko-outbox-189513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: fix race on NULL ctx->peer in update_sk_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029140643.4092-1-emanuele.rocca@arm.com>
References: <20261029140643.4092-1-emanuele.rocca@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:26:41 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] apparmor: NULL ctx->peer dereference under socket lock in update_s=
k_ctx()
--

commit 30beb04850046e0aecf0477d58886fc5cc6af632
Author: Emanuele Rocca <emanuele.rocca@arm.com>

apparmor: fix race on NULL ctx->peer in update_sk_ctx()

This commit adds a NULL check on ctx->peer in the unlocked RCU fast path of
update_sk_ctx() before calling aa_label_is_subset(), forcing the slow path
under the socket lock when ctx->peer is NULL.

Link: https://lore.kernel.org/all/20260824155822.9214-1-maxime.belair@canon=
ical.com/

> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index b908e744818c9..c405f08de630a 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
> @@ -657,9 +657,10 @@ static void update_sk_ctx(struct sock *sk, struct aa=
_label *label,
>  	bool update_sk;
> =20
>  	rcu_read_lock();
> +	old =3D rcu_dereference(ctx->peer);
>  	update_sk =3D (plabel &&
>  		     (plabel !=3D rcu_access_pointer(ctx->peer_lastupdate) ||
> -		      !aa_label_is_subset(plabel, rcu_dereference(ctx->peer)))) ||
> +		      !old || !aa_label_is_subset(plabel, old))) ||

[Severity: High]
Does this depend on the prerequisite patch referenced in the Link tag
(https://lore.kernel.org/all/20260824155822.9214-1-maxime.belair@canonical.=
com/)
that adds the NULL checks on ctx->peer under the socket lock?

In this tree, the commit message notes that "The earlier NULL checks only
cover accesses under the socket lock", but those checks under
unix_sk(sk)->lock are not present in security/apparmor/af_unix.c.

When ctx->peer is NULL (for example, after an AF_UNIX SOCK_DGRAM socket
connects via unix_dgram_connect() -> security_unix_may_send() ->
apparmor_unix_may_send() without setting ctx->peer, followed by
aa_unix_file_perm()), setting update_sk to true when !old causes
update_sk_ctx() to enter the locked section:

security/apparmor/af_unix.c:update_sk_ctx() {
	...
	if (plabel && rcu_access_pointer(ctx->peer_lastupdate) !=3D plabel) {
		old =3D rcu_dereference_protected(ctx->peer, lockdep_is_held(&unix_sk(sk)=
->lock));

		if (old =3D=3D plabel) {
			rcu_assign_pointer(ctx->peer_lastupdate,
					   aa_get_label(plabel));
		} else if (aa_label_is_subset(plabel, old)) {
			rcu_assign_pointer(ctx->peer_lastupdate,
					   aa_get_label(plabel));
			rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
			aa_put_label(old);
		} /* else race or a subset - don't update */
	}
	...
}

Here, if ctx->peer_lastupdate !=3D plabel and old (ctx->peer) is NULL, could
update_sk_ctx() pass old =3D=3D NULL as sub into aa_label_is_subset(plabel,=
 old),
triggering AA_BUG(!sub) and a NULL pointer dereference in
__aa_label_next_not_in_set()?

Similarly, if ctx->peer is NULL while ctx->peer_lastupdate =3D=3D plabel (t=
he
race where peer_lastupdate is visible before peer is set), the unlocked che=
ck
now sees !old and sets update_sk =3D true, but the locked check:

	if (plabel && rcu_access_pointer(ctx->peer_lastupdate) !=3D plabel)

evaluates to false and skips initializing ctx->peer.

Also, in aa_unix_file_perm() -> update_peer_ctx(), which runs right before
update_sk_ctx():

security/apparmor/af_unix.c:update_peer_ctx() {
	...
	spin_lock(&unix_sk(sk)->lock);
	old =3D rcu_dereference_protected(ctx->peer,
					lockdep_is_held(&unix_sk(sk)->lock));
	l =3D aa_label_merge(old, label, GFP_ATOMIC);
	...
}

is old (ctx->peer) also missing a NULL check before being passed to
aa_label_merge()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029140643.4092=
-1-emanuele.rocca@arm.com?part=3D1
