Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E34349B0A
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629982; cv=none; b=qNhpPPEPJ9GgeYIgGYlCHPcgQz7sig7t/cijxJYykJR1ZB8NeHka/qxZ8jxNiKqiJ/mVf1wyzeJPMyF9MUtgCb/EwhA298Xsi58IN9feMALIs9oSvl9qYYVr41Dl/32FyclAGXkcdL6QEgGUQNpAXLVKoeTtKIrGA9raUijXvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629982; c=relaxed/simple;
	bh=v+0uur+3TR9PXt/Ebw6V13q2Q8aAckxTXAi+vKx9ywM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EucCim8l0dDXT+DBYbT3OA6T3CAnu4gDcQ8lDaIE1iadQU5ZFKs238afNhd/qAoeK4So4G4tx2uWkA70KtDifyIf+nFuyKXxeSYVt8EexA1dW+v028RGjSn4D+HmhDWY31IH08I7EUPepyjgaOliXpdLZWO1pN3wBHOwkpYxtCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmhcWmYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmhcWmYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8987BC2BCB3
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774629982;
	bh=v+0uur+3TR9PXt/Ebw6V13q2Q8aAckxTXAi+vKx9ywM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hmhcWmYCPahq3IBjjbiexbLv6fEgnbXPlhWMM6GHEbL6/K3wTbCuQgOXW3lbKsMqH
	 sy0C4UYu0NeBP/eg00OBerCuhj6IDW8DY+U+PWuvY3oFOIXFweW2FRCWEzdSf+V64A
	 rgzZ5P2vdt8+ch1Hlc5E9upfZRMvqFm3Q9Sz3WAkemLtpdrSgi+K/FKzW/r4WZpuuO
	 bz7uXI1RJtp5J4wFS7sSHNGgJv8TKigVfTpqbrA0DhSU6H6oGoS8jTeIBJCKUuuXVH
	 +wcXDyw0ST6d9jpEDB7rPx/jecb3qBhAgNwlTTZwl55muVdHD5nvEtunS5hjT2hh5L
	 MmWBHlOYpcJEQ==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89c5446f3caso27533976d6.2
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:46:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwUjZBd5lxF99zVlQXfd2lBFQohHXZgHXzi3Js/ZXsTTMYJ5FdfWetfMqwfWFlDQA51eRCKwc9OmCSFOHFFfm47yIGFEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUx18rivRLFuckw+IQ/dmA7hVbkWyqjR2hWfRkCgiaKpJjHxbV
	/er4HZxGnWoaA8B1w1smmcdAVAfZZ5SyoGGpEsZQ+8/U3U2XYfYRNaWGdZZjYIXlth8iVCiFdxo
	jVU1aEYsq00pNMESYVO9KTTXrFRITMG0=
X-Received: by 2002:a05:6214:8083:b0:89c:dc96:cac8 with SMTP id
 6a1803df08f44-89ce8ee0ba0mr43604716d6.38.1774629981579; Fri, 27 Mar 2026
 09:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326060655.2550595-1-bboscaccy@linux.microsoft.com> <20260326060655.2550595-5-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260326060655.2550595-5-bboscaccy@linux.microsoft.com>
From: Song Liu <song@kernel.org>
Date: Fri, 27 Mar 2026 09:46:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6P-K=nTPxBk0_Wd0E1wDCBqb=uUQzmzpEg2NJub=L+dg@mail.gmail.com>
X-Gm-Features: AQROBzDxe7TPS6SGt9aE2F5r16ic7IZsl-4uxinICfPcq0j6a9HxJVwABoMjxGo
Message-ID: <CAPhsuW6P-K=nTPxBk0_Wd0E1wDCBqb=uUQzmzpEg2NJub=L+dg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] lsm: framework for BPF integrity verification
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 11:07=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
[...]
> The first new callback, bpf_prog_load_integrity(), located within the
> security_bpf_prog_load() hook, is necessary to ensure that the integrity
> verification callbacks are executed before any of the existing LSMs
> are executed via the bpf_prog_load() callback.  Reusing the existing
> bpf_prog_load() callback for integrity verification could result in LSMs
> not having access to the integrity verification results when asked to
> authorize the BPF program load in the bpf_prog_load() callback.
>
> The new LSM hook, security_bpf_prog_load_post_integrity(), is intended
> to be called from within LSMs performing BPF program integrity
> verification.  It is used to report the verdict of the integrity
> verification to other LSMs enforcing access control policy on BPF
> program loads.  LSMs enforcing such access controls should register a
> bpf_prog_load_post_integrity() callback to receive integrity verdicts.

bpf_prog_load_post_integrity() is weird. Some questions about it:

1. Is it possible to call it from other LSMs (not hornet)? Specifically, is=
 it
   possible to call it from BPF LSM?
2. This set does not include any LSMs that attach functions to
   bpf_prog_load_post_integrity. This is against the new LSM hook policy.
   I guess the plan is to add LSM users in follow up patches? Could you
   please include at least some of such code in this patchset? This will
   help folks understand the use case.

Thanks,
Song

[...]
