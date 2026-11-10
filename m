Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342815;
	b=oUNN2nMJVZoKWZ2dmuAauReyvPXnKPt42HC5kYPsoNG/2gh+ZDlMP0BMmWXbvEDWpWs9
	 1DR77QRpwB/6f9ofVDMWE/kypCLn77BlGncRsDZMOd46bLRtK+AAFko2qxhaDXWikQmtf
	 eWFGTeLJOT8ctk5dnxU9kirj5wYRaoo0O/PsTVRw03m+bvGV7wZAYaInP8sBjHpcepngX
	 ZiofJChXo4ZR1m58VRr4BdTz724N5xM1BS7Ar66HsLszVw+cVseDYdKIJkqplM0ehoJ8t
	 CDNkUxJ6lxPFmUf0vsbcgA6uV7tG4X1mJB/Z4/GloCMfxOl8nKM8zd8JXQ+kbJiN5rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342815;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/8ocYQBe3YFFmUUoCd3DPsEeCobQ/m4s1lpafYEhyRg=;
	b=X9EOAID8DdGFcoeil1CTesvIx6/NGwxE6dflt97+Z0VKmpetc+6DIbfpgrHZKOu9i1zN
	 SR25xOiiUkhoegxd3mUv6eB5qUihRvM0MPYjNyDChC3SU6RT7wAjGTJpBN8JRe9dRmKr8
	 p7INRaVBAEJfrw6Dtw6PiMfxM1ciJFb6IgrNUr/L1DekIRg+zOHykE0B0rrCjW/ohcwJK
	 H6no8N7Bvb0fhHQ8U8GYP563LOJuNlkDprmc6Q6onK2LQgVj7KhMZBcSfV2Bi+iK12eNk
	 B2LeRHoQgNQqD8rKPSRCA3810IIz6r7ejgPNs0Jpu53SjWUmLGjoXxBhH24zIkVbPag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mi6pzJbm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D03606AD47;
	Tue, 10 Nov 2026 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mi6pzJbm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FAE1F0089F;
	Tue, 10 Nov 2026 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342815;
	bh=/8ocYQBe3YFFmUUoCd3DPsEeCobQ/m4s1lpafYEhyRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mi6pzJbmGbk+Y7lwP1y+fgu4twMGHVAMHHT1GHNSzeJCGFPvQY06WGUh0F8gG2d9B
	 /46tdmMsmHUyjAa5hnJT820kJxQZpxX3Op1/JyjtNwjI1DdQs62lE+2EBrNXcaitWH
	 voiG/bXJV3FyiQ3xLYvqu8YrDTYvbmT6E3mNzNYEfh1ZGZyOJPFQ5SN3KXspVAvYbe
	 C8VwynMbJH3tkME+dSdl17rZ1/txeiLoBCXe9GCVQQ6+b7Q/MFDHi+WSvNvKCLJfOW
	 EvgMKyHovR3fJ2W47FvmVHz8977Xi3TqMnyedOdXiIFANjpHXT33kCvtB1UL1Epsw/
	 PIkgit8f9BXUg==
Message-ID: <sashiko-outbox-207712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/6] docs: security: Describe the Kernel
 Assurance Plane design
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
In-Reply-To: <20261110202246.274-2-harisudhan@armoriq.io>
References: <20261110202246.274-1-harisudhan@armoriq.io>
 <20261110202246.274-2-harisudhan@armoriq.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:33:30 +0000
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
- [Low] docs: security: kap: contradictory epoch semantics for bound
  tasks
--

commit 77da64268c0c9921ecf4f2c4a0222c86b4687cb2
Author: HARIHARA SUDHAN. R <harisudhan@armoriq.io>

docs: security: Describe the Kernel Assurance Plane design

This commit adds security documentation and securityfs ABI documentation
describing the Kernel Assurance Plane (KAP) design, Intent Lineage Groups,
and control plane files.

> diff --git a/Documentation/security/kap.rst b/Documentation/security/kap.=
rst
> new file mode 100644
> index 0000000000000..e002a081c6607
> --- /dev/null
> +++ b/Documentation/security/kap.rst

[ ... ]

> +O1 finishes its first stage. The controller advances O1 to a new authori=
ty
> +generation that is narrower: no package cache, no network. It writes the=
 new
> +authority and a higher epoch to O1's igroup. O2's igroup is untouched.
> +
> +From its next check, an already running O1 worker is held to the new aut=
hority.
> +It cannot reach the cache or the network even though it could a moment a=
go, it
> +was not asked to drop anything, it was not restarted, and O2 is unaffect=
ed. If
> +instead the controller revokes O1, the next O1 check fails closed.

[ ... ]

> +``epoch``
> +  Monotonic authority generation. Installing a higher epoch fails every =
task
> +  still bound to an older one closed from its next check.

[Severity: Low]
Does advancing an igroup's authority_epoch hold already-bound tasks to the
new authority, or does it cause them to fail every check closed?

The motivating example above states that writing a new authority and a
higher epoch to O1's igroup holds an already-running O1 worker to the
narrower authority, whereas the epoch definition here and the
kap.authority_epoch entry in Documentation/ABI/testing/securityfs-kap say
that installing a higher epoch causes tasks bound to an older epoch to
fail KAP checks closed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202246.274-=
1-harisudhan@armoriq.io?part=3D1
