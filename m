Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DE3C3F4E
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245211; cv=none; b=DTY+I2C3xsie9axwPR29VCmHl2q7WSgBoUNcKJGbbVQCGAD169TzuGtBoXeHjTB8ljhJtrL7yXdQuK72J7TSPyk94D2lMEuz3NCtzD7BKp89AjN9T6SsoNa1WBE9F/fZUDu+OZTZRcWZauyeGMynmO2zq4VSIHQIN1Rqyr4qwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245211; c=relaxed/simple;
	bh=NBauxmPzB3bIjDUy4c+SYQMN+QpfVz2QXry5xYH1/Pc=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VqrMw+nO6A4ErlHQ5ZRj35hWazLFhIU3HW6kkA0jCqQZTWZsKrqvA2TN5PLRs0SqICG9ie/TJ59mbv8NvUBn2iDXh1TYsHf725t4UGetmfhyjj8ein9Bgn7YcJXI9Evg+f1XHYTswDZeP9A8oTbTvXs1qPk712REFOo3wmmcgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL34sbbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL34sbbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784C51F000FF
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245206;
	bh=sQKQ7Rzka973N/1/FyfnG21h6Mez4CtIczxEUI5p3rE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mL34sbbf1KOknWPcxQ4/rGUFyH1rrKukof9zBU5AAin2zNti8MgARyt4+jFuuEO/0
	 sYe4qTjl6Yl/SIUDl7kkrfsPZUHMnFS11yjqt+D/UgRG31/k7C93ztacKTJqZUEDa1
	 ZXEvoFd9aP+ieeyTc06tIIzr7ooogfIGpPaYQILJrLpieOybIXDtcGwfTWRgv57rus
	 6XD9uzUCetdD/9wVbV8pZNpxob4qgs1xsVRWWKek1sH3+2GeDrTZa1FQ7pbcMbQwwN
	 +wUbKMbUDSgyNrlwTymMeGzmLsOj0KQu9a+H3nfYV6nvCT0N5oON4u4iiwFrwh1UyS
	 wqDtdwrj/XZRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] landlock: Fix domain leak on concurrent F_SETOWN and
 file release
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260924100206.173523-1-xujiakai24@mails.ucas.ac.cn>
References: <20260924100206.173523-1-xujiakai24@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:20:06 +0000
Message-Id: <20260924102006.784C51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] landlock: signal restriction bypass via concurrent FASYNC SIGI=
O and fput
- [Medium] landlock: dead code introduced to fix impossible F_SETOWN vs fpu=
t race
--

commit 051033b270aa84fe01c7dc8386b6ca0bc9d32596
Author: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>

landlock: Fix domain leak on concurrent F_SETOWN and file release

This commit adds a file_release hook to synchronously clear Landlock domain
references during file release. It attempts to prevent a domain leak caused
by a concurrent F_SETOWN operation and the final fput().

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index f7e5e4ef9eac3..8261aa55b0127 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
[ ... ]
> @@ -1971,8 +1971,49 @@ static void hook_file_set_fowner(struct file *file)
>  	put_pid(prev_tg);
>  }
> =20
> +/*
> + * Drops the Landlock references saved by hook_file_set_fowner(), in a
> + * critical section serialized with it thanks to file->f_owner->lock, and
> + * before file_f_owner_release() frees this lock.  Without this mutual
> + * exclusion, a concurrent F_SETOWN could store a new domain reference i=
nto a
> + * file being released (the last fput() made it unreachable to future F_=
SETOWN
> + * users), which would then never be dropped, leaking the whole domain.
> + */
> +static void hook_file_release(struct file *file)
> +{

[Severity: Medium]
Is it possible for sys_fcntl(F_SETOWN) and the final __fput() to actually
run concurrently?

sys_fcntl() uses fdget(), which acquires a reference on the struct file,
ensuring f_count > 0. __fput() is only executed when f_count drops to 0. It
appears these paths cannot execute concurrently.

If they could execute concurrently, wouldn't __fput() freeing f_owner
while F_SETOWN is locking it cause a massive VFS Use-After-Free,
independent of Landlock? This hook might be dead code addressing an
impossible race condition.

> +	struct landlock_ruleset *prev_dom;
> +	struct pid *prev_tg;
> +	struct fown_struct *fown;
> +
> +	fown =3D file_f_owner(file);
> +	if (!fown)
> +		/* No owner was ever recorded, cf. hook_file_set_fowner(). */
> +		return;
> +
> +	/*
> +	 * __fput() calls this hook before file_f_owner_release(), so the
> +	 * fown_struct is still alive here.
> +	 */
> +	write_lock_irq(&fown->lock);
> +	prev_dom =3D landlock_file(file)->fown_subject.domain;
> +	prev_tg =3D landlock_file(file)->fown_tg;
> +	landlock_file(file)->fown_subject.domain =3D NULL;
> +	landlock_file(file)->fown_tg =3D NULL;

[Severity: Critical]
Could clearing the domain here introduce a signal restriction bypass?

In __fput(), security_file_release() is called before the file is safely
removed from the asynchronous signal delivery mechanism:

fs/file_table.c:__fput() {
    ...
	security_file_release(file);
	if (unlikely(file->f_flags & FASYNC)) {
		if (file->f_op->fasync)
			file->f_op->fasync(-1, file, 0);
	}
    ...
}

Because hook_file_release() clears fown_subject.domain here, the file
remains on the device's fasync list without its domain restrictions until
file->f_op->fasync() is called.

If a hardware interrupt (such as a network packet or TTY input) occurs in
this window, kill_fasync() will send a SIGIO. hook_file_send_sigiotask()
will see subject->domain =3D=3D NULL and incorrectly allow the restricted
signal to be delivered to a sandboxed process.

> +	write_unlock_irq(&fown->lock);
> +
> +	/* May be called in an RCU read-side critical section. */
> +	landlock_put_ruleset_deferred(prev_dom);
> +	put_pid(prev_tg);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924100206.1735=
23-1-xujiakai24@mails.ucas.ac.cn?part=3D1
