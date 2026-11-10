Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342968;
	b=zh9jB/RUj1tKCi2lHTZBN/cZDH/p4AIzdvavObi4jTNpt3eXgPBY+V7S3KCQH93D30fd
	 rDf0TBk9+d7V87kd2Iv0lF/wqCK6NWP6V+Jpu5nIol+MFpiDSh2LLb/Sua0s5x7hVGmNp
	 Cvbqp5QUegQ155q20PftVZOa/e5UDPDLcpS/HY4T51fBlAAD+2GmQhEP0LfDvmhRzCiFV
	 hWg9Y4a/RhDjuVvLy2wKc+gtOXnkjlnJRqPzhoEGlrY2rxybZ4uqT3B769nGLs8Yjtgcd
	 aXSaeEX7w69NWD+Uuq0B6Mv4d5jSdPaNRKosSIBF7BiMzmpIdeT+2E4EpxxqXguw3bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342968;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZUgz3Zj4l1X+7pLJOjMeK6znxMPodZgNhJVee3GIBpY=;
	b=k1vzgNVJIi3A8RYPKrsJn9Kf5eqxEb7l4pL8EVbzc0MyB+Vali61QQWapp1uzt5r/AA2
	 BVHQ0Kln1EXnyPyrY4Lj8xyLxRgA6RNIzLieHzB3fRBTlRvlyhGwWhDdQUJi7sUrjwkWB
	 rf9KVdRXzBI6wbl5agunPNWLGqgi62EArj6a2G0QKIOXLZ3zGeBbr+B1gxwifhSVvQci0
	 JlRWfVVHhrFlvFYtX2pnev2ZskPuv8Thx5w68r702d0MkOyIt88aJhGK24ChjU38lvkde
	 cXjsZXvF8xVcVxGA10Oi4hrcJV1JEoUYPiWNOWRnSTBO3g/9ed/NDFdnmEV01sGtAag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZNk0F2A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DD606A321;
	Tue, 10 Nov 2026 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZNk0F2A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A6D1F0089F;
	Tue, 10 Nov 2026 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342967;
	bh=ZUgz3Zj4l1X+7pLJOjMeK6znxMPodZgNhJVee3GIBpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZNk0F2ArbqLF1NOLT+6cm2uesJciY53GvhbThDnVJqf1bZG2MCJ5/Nrvy7loZ1gW
	 C9022AnNNRoYBC7ugXktDd2Ax7Ds7ztythfHq4vhKFNW/pTR6kxv1Y+P0P+iGmikmf
	 WJvHD+eaEiquCd2Hf97MvozEmhoE0Um3tZRf45KlTN+rQgn3TuUunqH2NEQ2aE01wn
	 yvFqIIAs51d+VKHVl5fKqUVNcqsC0W+3NNc1LgmpPs48SxghJ6AhbdkBq7ZaHF6JKr
	 ozcEymvuAGr3RILoBqmRXXhSrMbt/S3EWqw9rb2DmvT5Dp8eo73DjBgL4tWEVE4wkU
	 s85LmRmmAK0Qg==
Message-ID: <sashiko-outbox-207715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 5/6] kernel: add KAP checks for unshare and setns
Reply-To: sashiko-reviews@lists.linux.dev
To: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>, linux-security-module@vger.kernel.org, "Paul
 Moore" <paul@paul-moore.com>, "Kees Cook" <kees@kernel.org>, "James Morris" <jmorris@namei.org>, "Serge
 E . Hallyn" <serge@hallyn.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Jonathan Corbet" <corbet@lwn.net>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Liam R
 . Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "David Hildenbrand" <david@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Mel Gorman" <mgorman@suse.de>, "Suren
 Baghdasaryan" <surenb@google.com>, "Ben Segall" <bsegall@google.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Juri Lelli" <juri.lelli@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Valentin Schneider" <vschneid@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Ketan
 Bhardwaj" <ketan@armoriq.io>, bpf@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261110202246.274-6-harisudhan@armoriq.io>
References: <20261110202246.274-1-harisudhan@armoriq.io>
 <20261110202246.274-6-harisudhan@armoriq.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:36:04 +0000
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
- [High] security: kap: CLONE_NEWUSER skip in
  kap_check_namespace_flags() breaks user:unshare rules
--

commit 9adc8e1a3a53f48cafa9cf1ec8d4bd24d0a65150
Author: HARIHARA SUDHAN. R <harisudhan@armoriq.io>

kernel: add KAP checks for unshare and setns

This commit adds KAP namespace flag checks to ksys_unshare() and the setns
syscall.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 33760ece3bb30..3dda9f211ceae 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
[ ... ]
> @@ -3286,6 +3287,9 @@ int ksys_unshare(unsigned long unshare_flags)
>  			 current->fs !=3D current->real_fs);
> =20
>  	err =3D check_unshare_flags(unshare_flags);
> +	if (err)
> +		goto bad_unshare_out;
> +	err =3D kap_check_namespace_flags(unshare_flags, "unshare");
>  	if (err)
>  		goto bad_unshare_out;
>  	/*

[Severity: High]
Does kap_check_namespace_flags() fail to enforce "user:unshare" and "user:*"
predicates when unshare() is called with CLONE_NEWUSER?

security/kap/kap_lsm.c:kap_check_namespace_flags() {
	...
		if (kap_namespaces[i].flag =3D=3D CLONE_NEWUSER &&
		    strcmp(operation, "setns"))
			continue;
	...
}

Because kap_check_namespace_flags() skips CLONE_NEWUSER for "unshare", the
check is deferred to kap_userns_create(), which passes the bare target stri=
ng
"user" to kap_check_static_target().  In kap_string_match(), "user" does not
match "user:unshare" or "user:*", so allow rules using the documented
TYPE:OPERATION syntax reject unshare(CLONE_NEWUSER) with -EACCES, while deny
rules for "user:unshare" or "user:*" paired with a broad allow rule such as
"*" are bypassed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202246.274-=
1-harisudhan@armoriq.io?part=3D5
