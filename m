Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7193DDDD0
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088193; cv=pass; b=PZl38DlTGIRSR29R6G1IWU8f6ghuT0lys4vOMij55JTkA6tJsOGyV8+1YQJkqUjaQisVk9+Wfhvl8ywhoFinYroIt7DxX6FI6/mFD+EwpV6AMcqlDcZB55+Sxc5qz4wTYtVVMMGBBn/hYJFqBgfX0waWt10PXXvogHO8/PWosq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088193; c=relaxed/simple;
	bh=smTzgLunUme0eoIvUNmix5Dg0CIit+hiYdX4wzwspKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3fnVTe9DmeRdCj8spgAFWrdpSTbXLeoWBeis0YRyvk9srC3hcSs+RZVIYXuFsng2cEX0AP2gH4YgH2aN5RthBHrkyE7oCsStXPLLhIezkF5GQ788oeqKJ5YBusS3lKCpNSS2Y+kFuQHNRiB3oG0sJD1AaU7ilEXieR/1ClMi48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RZQ9SUcL; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RZQ9SUcL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85773f46b5so467234a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 13:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780088189; cv=none;
        d=google.com; s=arc-20240605;
        b=NCA+YrWdhTzZKt/W/K7iBJgnWaCGvdoYh56cIH+tE3HFtRxyYHDyY3SxVJPN/nfZxk
         0qnbbsI5LFL6v5n7gc7ZXUM7MZl9AW56ufQxMY3Ar+vNHxTWbIAhWsuBVUXYQxIf4YqR
         B5gfC6ZLeXmWPEWauU6wjEsqqnJvIunAAxrPBDNU8kuQAbkn2DJhmxZN254xaVNRKhXd
         nxlqBfTGCepfhRYPAQmLAZgibwpMHMkkHXk2EGedB8BRt8jie8Ha9TkKyzUw2tySiBXE
         d+DKBZZv3CCwyvIi/Cc7CZHXN02nkx1VEdd8JDGiTetJHd2v2TZ2CI5tfhtf0VwzZ9HW
         FROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gp17DDHpDrQCYtkBO9wV4U/G41EKHx7vsZ5TJQ15dv4=;
        fh=H0UPvU64rYsOHFbmMPhqJgGHg2feECvC3N/d54GOdP8=;
        b=LfTVSms4Ejg/5Y4AW9j/orh5ixnz4WFSAVE7Z8nMtug13WsTGwpeG96yWyWc2/YUHl
         0N1TXaJH3yOr9OGLf+yZVKabpfbAjfVqT4zpFxK2SnjRnZCB8vYGSa5ogssM8a826IKc
         1L8lWQC2fot65f1oUfXljzkURWxKWs5L7qUHgodqyOGf88XfeDHi4kkhSvpQu2Gw+AHD
         cLu0/C/91F3PokZsA8B64nyeslQrcaKWh3fLFUINcCVCfzBiIX75pHN9iTtEmarXKSVz
         196fy0hlhLDGMkjEnUu8wVNkoZ/Nx0MDy0U6vCM+9n/Yxf1TUJe5/fM/Y8joaS3avQic
         owIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780088189; x=1780692989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp17DDHpDrQCYtkBO9wV4U/G41EKHx7vsZ5TJQ15dv4=;
        b=RZQ9SUcLnNnGI0993ldelv45UxNt24LfHHnZWoZb7pvmVAp05pfQf7qwHrmFT0KO5l
         7k6S2PSm9gp7tO7oBd4QT1xrpUiU5i7b5UeEGiDVPccb6URREc+ZOmi7Xmr7CF8V313K
         KaE5OAsMcnno2czGllh+/C4ZsMQvDq7P5+xhD9ZY+nWTH7EDT8KJdUldS59keHjHb5Qd
         vz0mVTJ7fBQ3Z2zje4zx8172f4KhsGICbtxYsHqQrHQNXJXlBNf7ousgrPGVqoOPgUek
         f8nqqqil9I+cUP90HDmuNNFSubYGY3vPkZSh01e4bK1oqGidpF75h4i32y0wLFake329
         ShJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780088189; x=1780692989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gp17DDHpDrQCYtkBO9wV4U/G41EKHx7vsZ5TJQ15dv4=;
        b=UEGfMsvYwryZxKnY/80bugDVdqNEOmg10Z8v9VCUpbMtjLUbtpTv3YkzrCTRO0bs5+
         um/V7EvzIcWnUsKJGltYzA7+PWQVd8bXS9yxXc5tTCPvN6u55S1djmrDtYRgkd7C8vEp
         lvfZwBsicc824qCa4HDGzAp4Sgm0ZMoyjINZ13rViu4sk1E8J7DS66SqZ+urVSTMhw9r
         k3Zrg+dcE52oIW10lwUTC6Df8Zr2Ca/43qbse6N0h3pFELmT2j4Hge/FQX2VCkhNpMcg
         b8dlJG3Fs3kcu9/LDcr1PIcfnK/5evI4TQwATqKhqPBoT3gdNfGr9iNZGidbvvhtO3iH
         679A==
X-Forwarded-Encrypted: i=1; AFNElJ8acgwCbUD2UWqApDJqroXgMLrvXPCyBFHE5uFD3xlBDth5pPFiuxnUu6vTSNBNoLQ3dxJxT0CIAHRGb8Y32gq3VLZnpYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqNyu6qVbSRKh2HXyTCIkQYGlZiR/GWq44+hC4YD74Bb7+ZAL
	ntENiizoMQpOcDYJq0EVk41Hs+UiEfzf1xZmx9ucQY8k9gBrKuBlb6cAblJ+XgfGgOkvF8ou8sU
	tqQUIzqfJ3b7u/qy6DfYwOWBIJ64cTDa5VwsNl0AVdcHeZ3YseJnTwQ==
X-Gm-Gg: Acq92OFFq86p2JOKZGLenI0K2cK1Ar5Q+VACrrh/WXiS2gT7MKNjS1jBnJaMH5Ohrqa
	HZybmcPUlm2oL4+Ly5nB1F2uQ8Bc995QJ4jvWp1Z5vwyT3cRNWt6Ljo8Ujl/6c9WSjMJcjf6ajP
	ULUOxM/+hxymao2UM7k70np1BQnw3MRgBppVmVv0SqJVr4zLnXlu3aFuCvfPK5SfkN0dEs83RG+
	i4u2vgrbWkbTCa6FC5jkXBeaTh0yjgPLxPGaEHI/aV8OkKn9DaK95AOEqB2V4XbDQ5VP7/FW5mR
	0PiRwcntoLYosZZWWg==
X-Received: by 2002:a05:6a21:492:b0:3b3:edf:9efc with SMTP id
 adf61e73a8af0-3b426ae88cfmr937037637.21.1780088189259; Fri, 29 May 2026
 13:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com> <CAHC9VhSQzV0xZPFwkNdUJ5Lz8Mw6gppBhR6QyRdrY8xCTohHDw@mail.gmail.com>
In-Reply-To: <CAHC9VhSQzV0xZPFwkNdUJ5Lz8Mw6gppBhR6QyRdrY8xCTohHDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 May 2026 16:56:17 -0400
X-Gm-Features: AVHnY4InBv2VNLG7wcVKejjs8IJRkz7oJuZoqfyR3Kf35dBYrfX9C0d5V81Tzh8
Message-ID: <CAHC9VhShFjEMyN7Z878j437_c6toLZrhgxrag88U795jAA+2Nw@mail.gmail.com>
Subject: Re: [PATCH 00/11] hornet: security, tooling and selftest fixes
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
	Fan Wu <wufan@kernel.org>, James.Bottomley@hansenpartnership.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 9:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, May 27, 2026 at 11:09=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > Patch 1 closes a TOCTOU race in signature verification. Map
> > contents were hashed at the program-load hook and re-hashed at
> > the program-run hook, leaving a window in which a sufficiently
> > privileged attacker could mutate a map between the two checks
> > and run a program whose maps no longer matched what was signed.
> > The fix records the verified hashes on the prog at load time
> > and, in security_bpf_prog, checks them against
> > prog->aux->used_maps =E2=80=94 the same map set the verifier and
> > runtime resolve against =E2=80=94 so the verified and executed sets
> > cannot diverge. The per-map index in the signature format is no
> > longer needed and is dropped; the check becomes a subset test.
> > Reported by Eric Biggers.
> >
> > Patches 2-3 fix two counting bugs in the same area: duplicate maps
> > could satisfy the required hash count, and an off-by-one capped
> > accepted maps at MAX_USED_MAPS.
> >
> > Patches 4-11 are in response to sashiko feedback found here:
> > https://sashiko.dev/#/patchset/20260507191416.2984054-1-bboscaccy%40lin=
ux.microsoft.com
> >
> > They provide some correctness fixes in the hornet tooling along with
> > making the selftest behave under cross-compilation and skip cleanly
> > when signing keys / bpftool / vmlinux BTF are unavailable, instead of
> > breaking the global selftest build.
> >
> > Blaise Boscaccy (11):
> >   hornet: fix TOCTOU in signed program verification
> >   hornet: invert map set check logic
> >   hornet: fix off-by-one bug in max used maps check
> >   selftests: hornet: handle cross compilation and test skipping
> >   hornet: gen_sig: fix off-by-one check for used maps
> >   hornet: gen_sig: fix error string allocations
> >   hornet: gen_sig: check for bad allocations
> >   hornet: gen_sig: fix missing command line switches
> >   hornet: scripts: set a non-zero error code for usage
> >   hornet: scripts: harden scripts to handle trailing whitespace
> >   hornet: scripts: Improve argument handling and error messages
> >
> >  Documentation/admin-guide/LSM/Hornet.rst |  39 +++---
> >  scripts/hornet/extract-insn.sh           |  24 ++--
> >  scripts/hornet/extract-map.sh            |  25 ++--
> >  scripts/hornet/extract-skel.sh           |  35 ++++--
> >  scripts/hornet/gen_sig.c                 |  61 ++++++----
> >  scripts/hornet/write-sig.sh              |  10 +-
> >  security/hornet/hornet.asn1              |   1 -
> >  security/hornet/hornet_lsm.c             | 148 ++++-------------------
> >  tools/testing/selftests/hornet/Makefile  | 114 +++++++++++++----
> >  9 files changed, 235 insertions(+), 222 deletions(-)
>
> Aside from a possible (?) typo in patch 5/11, this patchset looks okay
> to me so I'm going to merge it to lsm/dev-staging now with the idea of
> moving it to lsm/dev once Blaise provides some clarity on patch-5.

With the typo in 5/11 sorted out, I've gone ahead and moved these
fixes over to lsm/dev.  I also took the liberty of adding the
associated 'Fixes:' tags, not critical in this case, but nice to have.

--=20
paul-moore.com
