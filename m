Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3769361DD3
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773832513; cv=none; b=bw5H2/IYinhIi6ywizYj0xuCa0K9DuVEDkf0MbdjuK/9RIdR1e0Gtv8c+sjIRD4Uq2xhGT4Ng7l4bJKxW/3Yk0g1wlgSujI8YwMLjRUmTzxJTSFvzjnl6kun7nQAnEdqt59arpBwZvMlSePUAt6ozq+1vfnTfe6897j2iaJ+q2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773832513; c=relaxed/simple;
	bh=FUzvM8lxi8PS+Ct1c9EN4D9fxN6/p2KirvWjVLeq3vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2riSzT8TImApYs0UUhBiOa1CDplaoxhol23GIfuMqM+397ybriHCWZc7RkZ9h8rG4OatlJsSXpPpD59J9JvM0XFd1YqneYZJpRfjpiiExiT0lLcYYWQfbDSRwS8vBUl2LBOw0bCvTM7g6hhsh6SeLObSC46pVv0UwOBua6Wc70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jfDtYpd4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9vVxJOMZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jfDtYpd4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9vVxJOMZ"
Date: Wed, 18 Mar 2026 12:15:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773832509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4G4K3DqXkb2EKqcdeCcHeym57PCJhvS2KCbzXWfE/vo=;
	b=jfDtYpd4qkt3qsYwh2OsTffpuZ6o8bTPJSWWRNq+EXWL9+EfJrZgRCJn9uJC5EQI+EGogo
	kh1yCtM7oZS02e1z5NmSzTH0+b0ZqFr50ncCrFZhPdsVrkUL5F/3QzAO2cHwHOuyXz3Yc9
	UbA3L2fakFb18wJSyrqDlYVO9bkFDu7WfyS7vkeXA6ikAsbf+97BWDeNqjqKt1U/6GXC4m
	4z/FA9npEo2FXxnFhCzp+FRHktBqyS2/BvpDsk5Avwm/LNVrji/et2QJNvaS3X5bzcB4Fb
	y1Veb0yj4TeJ/bwsl3CQWb/pPi1SHJG/9ecLNS+lHpgCOs9q8HwtPJB4iGGAgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773832509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4G4K3DqXkb2EKqcdeCcHeym57PCJhvS2KCbzXWfE/vo=;
	b=9vVxJOMZj0yQVoMmWXv5IRxIcpZD4KW4rbQoEV9dtR/QmS+Td/UJknX7MfhJZl5LpfWP9c
	bDvePHMrTNjQn3BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260318111507.1nr6rAki@linutronix.de>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260315222150.121952-4-gnoack3000@gmail.com>

On 2026-03-15 23:21:44 [+0100], G=C3=BCnther Noack wrote:
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
=E2=80=A6
> @@ -1557,6 +1560,110 @@ static int hook_path_truncate(const struct path *=
const path)
=E2=80=A6
> +static int hook_unix_find(const struct path *const path, struct sock *ot=
her,
> +			  int flags)
> +{
=E2=80=A6
> +	/* Checks the layers in which we are connecting within the same domain.=
 */
> +	unix_state_lock(other);
> +	if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket ||
> +		     !other->sk_socket->file)) {
> +		unix_state_unlock(other);
> +		return 0;
> +	}
> +	dom_other =3D landlock_cred(other->sk_socket->file->f_cred)->domain;
> +	unix_state_unlock(other);
> +
> +	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
> +			     fs_resolve_unix.fs);

This might be obvious but in case it is not: You obtain the domain
pointer from f_cred->security. Within the unix_state_lock() block the fd
can not be closed. Once you drop the lock, the fd can be closed. What
guarantees that the domain/ dom_other point remains valid between
unix_state_unlock() and after unmask_scoped_access()?
Is this invoked within a RCU section which would delay put_cred_rcu() or
is there other magic involved?

Sebastian
