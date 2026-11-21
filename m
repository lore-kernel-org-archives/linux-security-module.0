Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795297366;
	b=LgHCXvCBERQDd6sf5WF+e4HNNFVsK2CTHjMTqazvtAjUJXZqTPKl0vZ9M4HNasAjZ0Fi
	 jhMYZghIIsGTF7DQzQuUBmmqZGpgpdRks59Fr5JVnsfPIgFRALCPeDDRM/K67r9czdP9h
	 1UyGQeZaNru28R1qqQGjWl9lnjhThzVlal6QiQJg4hG3+3Z7V23QpMEWNCUdIiXN7aWeF
	 iIdEO6XvSQIDPV9YCe8r2Q6lCquG0qfzjJDL39ws2TNH7sWiGS0cpMUZk+8AjGEaArVLL
	 50Ih1ZWhMO6SkuWELZGZhXs3sc2T7xvNyMaD/4SaCHwIG9X0BKGfjE16NM71op0NFrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795297366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Drxc7qxNTP9/BRaF1WqAVtABWP9tV6uKIiuQgO5CPjM=;
	b=xRUJP5jxjxCm/AcOKkCgG6iI7zY4fy9p2Poze+eM3VLyUkAHzpnVonjfJsjLlxIpBMUf
	 tz1n3l/LTss/UZ6G7TA2HmFvAgIdSBugS8xfhTadUTBmsThVNZrEdQ/wG/jispzXzH2On
	 52O0maYfrdzSPUjc792+0myDeTEVoYOa1VPkuoAnaOrjd/fe01Sk+SXfhxFPeobN7YNh5
	 KiGyeaxrA3YvjxGgA9mUyNEGUsuSQDGVZ8DmPNr2hhGhssqBhBh4uNflEZMOdc+kTJDMH
	 SxGJKw2lGEiTnv/C5W3ezISmPKMsd9jqPR1BiTyxsrES8+phCm4ZnE2VHD/Li/NN5Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6pYyCvy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472EC606A320
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6pYyCvy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8AE1F000C0
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 21:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795297365;
	bh=Drxc7qxNTP9/BRaF1WqAVtABWP9tV6uKIiuQgO5CPjM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=m6pYyCvyE8aUBWy3cHKelmJS1nyQ7OQ7floh4agDW4dTunA+B+fXudeCtVI6UCgCN
	 VvJKb82Wor0VBJH6eo5nOswF550U9f6dlRQ5bS8tqh1ulGBmlQ1xNmFMKoEAEerx4B
	 8nNAbYMMbmYcRCt5FEpm8KzBhz8+rbBpMRdSnEP/AACxi08XzCUAUWvOwvV4HTr74h
	 MqQVwyu+Q8NpBHUJloigIderAZdA4HJLY7P7wKPFCPUnZbVmTj1VUpYzQDnj2B/N26
	 qSW5JBXdYB+sOUB1dRNuShqXwWKvrjogNYEs+z2WqaSd7OSroGhFj6TO244nVW9lyQ
	 GJAODNN1d+i8Q==
Message-ID: <sashiko-outbox-227419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: don't sleep in unix peer checks for path
 sockets
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261121-apparmor-unix-peer-v1-1-99dd1cdb1e27@gmail.com>
References: <20261121-apparmor-unix-peer-v1-1-99dd1cdb1e27@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 21:42:45 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] apparmor: unsafe RCU label reference acquisition in
  aa_unix_file_perm() [1]
--

commit effda5eb5a50afb4aa0bf1fcfad7c08d47306526
Author: Arun Iyengar <aiyengar1990@gmail.com>

apparmor: don't sleep in unix peer checks for path sockets

This commit passes an in_atomic parameter through unix_fs_perm() to
aa_path_perm() so that unix peer checks performed under unix_state_lock()
allocate buffers without sleeping.

> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index 58c638830afc4..ff851ddd43b44 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
[ ... ]
> @@ -775,7 +776,7 @@ int aa_unix_file_perm(const struct cred *subj_cred, s=
truct aa_label *label,
> =20
>  			last_error(error,
>  				   unix_fs_perm(op, request, subj_cred, label,
> -						&peer_path));
> +						&peer_path, false));
>  			if (peer_path.dentry)
>  				path_put(&peer_path);
>  		} else {

[Severity: Critical]
This problem wasn't introduced by this patch, but in the else branch right
below, can passing pctx->label directly to aa_get_newest_label() cause a
use-after-free [1]?

security/apparmor/af_unix.c:aa_unix_file_perm() {
    ...
		} else {
			struct aa_sk_ctx *pctx =3D aa_sock(peer_sk);

			rcu_read_lock();
			plabel =3D aa_get_newest_label(pctx->label);
			rcu_read_unlock();
    ...
}

aa_get_newest_label() assumes the caller already holds a reference to the
label and calls aa_get_label() (an unconditional kref_get()) when
label_is_stale() is false.  Because pctx->label is only RCU-protected here,
a concurrent profile update and socket label update can drop its refcount
to zero before kref_get() runs:

CPU0                                  CPU1
aa_unix_file_perm()
  rcu_read_lock()
  aa_get_newest_label(pctx->label)
    label_is_stale(l) -> false
                                      __aa_proxy_redirect()
                                        l->flags |=3D FLAG_STALE
                                        aa_put_label(l)
                                      update_sk_ctx()
                                        aa_put_label(sk_ctx->label)
                                          /* refcount reaches 0 */
    aa_get_label(l)
      kref_get()  <-- refcount addition on zero
  rcu_read_unlock()
  /* plabel used after RCU grace period <-- use-after-free */

Should this use aa_get_newest_rcu_label(&pctx->label) instead?

[1] https://sashiko.dev/#/bug/linux-43381a05-e5da-4626-9e59-010765c6af53

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-apparmor-u=
nix-peer-v1-1-99dd1cdb1e27@gmail.com?part=3D1
