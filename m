Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214678;
	b=sLZUez4StwkUchQC/uOjGxPyaEk/5P7Iqyo4vD/+PCgnaoyKMCA0+N4Hwkwtu5xsZIU3
	 QFixBNAhKN3GSOh8GiNG6ivmsZezZ76DXHxz7WWCjlfAck8XvVsUir4wz+j6driHzTcUR
	 5J7lfDKzagE/gwr9yr1c+Mf5AiT5E1i+nj2t1WVOdSKxFGVfUkjHrqdQYnhLeDp3XJEt7
	 pDpZMvt8xQzhsL8uMP0amj99U4qAFR0QpIw67+kZLXPdyxtEPL2zGlQ2H5L32K9jnv0+k
	 Ah31Uwd4vC8AAVWVhCiQmhjNjqC0mx9606FtEA022Yqls0Ap6fwMgOd0DxVqFietQVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pSzNYLdaadW2jyufCcL13Oj3VYC0HwF6Ept2g9RqzPg=;
	b=Ye4bHpmkr2jxHlOlHVBmh65xe4AcgGsprZf7StGXHqckxK0w2Iwtl0NZen/PlX09paI2
	 A3etnZdxzrMgjaaoQpq5hYZo/KxzaZ876M9fTh6YWnt5Z5s6sOEGliagcjggtIppNbBZ/
	 F3ZuUimA1chdXGEcdAofPOmfxZ336JG5ZAX9JPGxykdr5kr2NySTXgXyAHtpQ+ptg+TpL
	 0XHkZLY+6f/5S3piE78pdbegiWvKPsH45g5CazXHFfOMCkOaIYCCGwNIzJVSXuX+ifhlQ
	 Xj+PsVDndgordkn8HlluHMNIcOhc02eXqtQCRcRTH+mHpodp3TaEpC+fGMiiAhd1E8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qup3hZLM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B7606A699
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qup3hZLM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C860C1F000C6;
	Fri, 20 Nov 2026 22:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214677;
	bh=pSzNYLdaadW2jyufCcL13Oj3VYC0HwF6Ept2g9RqzPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qup3hZLMjJGy5Lby+02cC0Ks/w7DT7TF3QjQNKtLYIrpYBfrZFUyGinpDBZuHfkAi
	 goJrpXp+gmkyCkj2JGhkb1jpnlX++Ja7j/A0y3YyPT1+NmGWQHVbUctnH/DTeGipYr
	 cGfwI4AoENAdwdU0aF5VIdJLrOXZ8+3U76DRE12JxoCHMAbfJD27kbX9glPmUmwoVv
	 x4pgmw3sdleN3TVxBg/sktHSOTGoErQgtvQ/2hZ+V6tNnxeys73mlAdroPHMmL/o2s
	 CKQbuo4r4FV4JwF2Idjbka4Xb0uMahKxADIfW4RwvlkUYkwS2MkHZ17TDxpTswtEwA
	 +ubPXlAFfK0LQ==
Message-ID: <sashiko-outbox-226297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 05/14] rootns: Add ROOTNS_WAIT ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Andreas Larsson" <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Andy Lutomirski" <luto@amacapital.net>, "Andy
 Lutomirski" <luto@kernel.org>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>, "Arnd
 Bergmann" <arnd@arndb.de>, "Ben Segall" <bsegall@google.com>, "Borislav
 Petkov" <bp@alien8.de>, "Casey Schaufler" <casey@schaufler-ca.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Christian
 Brauner" <brauner@kernel.org>, =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1Mg?=
 =?utf-8?b?R1JPVVAp?= <chleroy@kernel.org>, "Chris Zankel" <chris@zankel.net>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Davidlohr Bueso" <dave@stgolabs.net>, "David
 S. Miller" <davem@davemloft.net>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Hallgrimur
 H. Gunnarsson" <halg@google.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Helge
 Deller" <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Jan Kara" <jack@suse.cz>, "John
 Johansen" <john.johansen@canonical.com>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Josef Bacik" <josef@toxicpanda.com>, "Juri Lelli" <juri.lelli@redhat.com>, "Kees
 Cook" <kees@kernel.org>, "K Prateek Nayak" <kprateek.nayak@amd.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Magnus Lindholm" <linmag7@gmail.com>, "Manfred
 Spraul" <manfred@colorfullife.com>, "Mark Rutland" <mark.rutland@arm.com>, "Matt
 Turner" <mattst88@gmail.com>, "Max Filippov" <jcmvbkbc@gmail.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michael Ellerman" <mpe@ellerman.id.au>, "Michal
 Hocko" <mhocko@suse.com>, "Michal Simek" <monstr@monstr.eu>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Nicholas Piggin" <npiggin@gmail.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Paul Moore" <paul@paul-moore.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Rich Felker" <dalias@libc.org>,
 =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, "Serge Hallyn" <sergeh@kernel.org>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Suren Baghdasaryan" <surenb@google.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Thomas
 Gleixner" <tglx@kernel.org>, "Valentin Schneider" <vschneid@redhat.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261119224312.1037966-6-jarkko@kernel.org>
References: <20261119224312.1037966-1-jarkko@kernel.org>
 <20261119224312.1037966-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:44:33 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] rootns: delayed PID namespace visibility check in
  rootns_wait()
--

commit 68c6e4532ee164e48940d00824536de847b1c5d0
Author: Jarkko Sakkinen <jarkko@kernel.org>

rootns: Add ROOTNS_WAIT ioctl

This commit adds the ROOTNS_WAIT ioctl to wait for a root namespace's init
thread group to exit and retrieve its wait status and TGID.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index d9ef68d603a24..5f03b6ba4a543 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
> @@ -115,6 +115,45 @@ static long rootns_get_nsfd(struct rootns *rootns, u=
nsigned long nstype)
>  	return nsproxy_open_namespace(rootns->ns, rootns->user_ns, nstype);
>  }
> =20
> +static long rootns_wait(struct rootns *rootns, void __user *uarg)
> +{
> +	struct pid_namespace *pid_ns =3D task_active_pid_ns(current);
> +	struct rootns_wait_args args;
> +	long ret;
> +
> +	if (!uarg)
> +		return -EINVAL;
> +	if (copy_from_user(&args, uarg, sizeof(args)))
> +		return -EFAULT;
> +	if (args.flags & ~WNOHANG)
> +		return -EINVAL;
> +	if (READ_ONCE(rootns->state) =3D=3D ROOTNS_INIT)
> +		return -ECHILD;
> +
> +	if (!(args.flags & WNOHANG)) {
> +		ret =3D wait_event_freezable(rootns->waitq,
> +					   READ_ONCE(rootns->state) =3D=3D ROOTNS_DEAD ||
> +					   READ_ONCE(rootns->state) =3D=3D ROOTNS_INIT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	scoped_guard(spinlock, &rootns->lock) {
> +		if (rootns->state =3D=3D ROOTNS_INIT)
> +			return -ECHILD;
> +		if (rootns->state !=3D ROOTNS_DEAD)
> +			return 0;
> +		ret =3D pid_nr_ns(rootns->init_pid, pid_ns);
> +		if (ret <=3D 0)
> +			return -ECHILD;

[Severity: Medium]
Should rootns_wait() check whether the rootns PID namespace is visible in
pid_ns before waiting or returning 0 for WNOHANG?

Because pid_nr_ns() is only checked after rootns->state reaches
ROOTNS_DEAD, a caller in a non-ancestor PID namespace gets 0 instead of
-ECHILD when calling ROOTNS_WAIT with WNOHANG on a running rootns, and a
blocking call sleeps in wait_event_freezable() until init exits before
failing with -ECHILD.  Checking
pidns_is_ancestor(rootns->ns->pid_ns_for_children, pid_ns) upfront (as in
rootns_get_nsfd()) would reject invisible targets immediately.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119224312.1037=
966-1-jarkko@kernel.org?part=3D5
