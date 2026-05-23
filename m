Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57667263F34
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779509275; cv=pass; b=OJQVlezbMJAo1ndY10ETZe1m0ekwcxsuXLCFKXwaLLDJzQfyztzEwjg3HT9csHfUEMRNXhiivsP+7PPMfGJAxZbUnfpWiyvnfqFYPd2I+JODbuKOLd8kjyTIiTuux150/dlAaqFv8EzpvY1hMJQ2yYCpCMjSewcDps0BNT4Qv6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779509275; c=relaxed/simple;
	bh=vGEb5VSmkEMcF3xQd5x9evuFv/txRodMq6g69B9qaM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZbG0sui9ru7UC74WyR4OR/j84eez0DbNmvrKO7jBUB+bM1jj+/N+RFJl1SipW6wGPK3/LwlEoeN1J5WthTWfi6mro2r5GUfinYsJicr+5Z6EWtpO3tQzif0TeOlz1WDdIhbE+1yYptHSr21gXH8E+4pMzyxRXCJ2GDvCHtBNxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aAZG2YcH; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aAZG2YcH"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so5672370b3a.1
        for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 21:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779509273; cv=none;
        d=google.com; s=arc-20240605;
        b=C2mf2Z6YhDxGQnLc0UUSJ77XL5++9oSSNhjMeokfMLHNRAhwtwWkqc0cyqsG4iWm05
         d6Q9+vHRVXoR3MRQ6irM9ttdAVO1PSiV6bE/14I6J9VUO/iIoFgogMojj7v0tJfXFdE0
         WSTfvEDv7wQZugPkMUFL7pAEZihbzhy8PbIE3QJm9Q451mwJxO+smCoxeOl4k94lJtfA
         51lTmrgI5DIKSLJi2AyFsWx/7sodZMuyZe+mBrarkheTzNNM22gHANhaVKvEnMD4oXGq
         KurX/VDmfX4fIcrvUEdc4YAuQON5JioxmN1t8w+wQsMFecOCWi/ZSciWd4NuHhSazRhK
         I4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NN+b2sfzxNXDXzV7TDm7hE5fzlrLYeypS0aOQYewte0=;
        fh=S5FTryvHQD8giRZI57jd0FM1Li6tdC7LBpwa1SFcmmw=;
        b=Ypg5+bJvk9cIDBjzBYpkuChErmEcWtxbIhzJafSic14YZhiX+C7Aph+5zCRGwsXhiv
         Uj2z3MkYnQ8xDrI10ROj7lwf+2W4OGyAmTZEZRk7tqo51IUkeA+Pqktdc+ZkP7x5ZsMv
         YmTzyMkiE/Vm+u+S/IpxE+xIX5pj6/fFDIEl/5yqdehh1+IfcYEg6h5mRyNe/AypvfMD
         imy2Ep1ScARbNTeOSkvmT2p9frxtrkQC3RXXpt1fP3Z2dpWw/kVGf9zY+uEPrRvC1NRl
         zc7EBO/roc5VVXezynOJtM2RVvZBXMcB+0N3JpZBOMBk0tfUj64+chGN5QKKfKVk679c
         /9cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779509273; x=1780114073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN+b2sfzxNXDXzV7TDm7hE5fzlrLYeypS0aOQYewte0=;
        b=aAZG2YcHkvqZqx0R9D0Yf8PAwjGMvjS2Q1yXVnZW/QcJsKG7e7u2yVJTQ8LkSA59RK
         x8cEgwwrfmdg0/TgovS8Ius8gJ3nLsQXfsLvtSnSarEwXINoIe8WW8u5dMG/Q3Gs0t27
         JIx5mMP3RoexXDAht1bfIXw/UxDlBD0ZC9tjzBGKFU0oKCfd8au0OqXSCOX8/ycnec8x
         iiK4R9DSnGW+v1feM6/VKFF03/29HQx72XTBbg/SJdhRqE7NLtQN4ti+C+rSOdfeNHaJ
         5A0nX6RXQkPzQPNPQZpCAGd5BS4OQFhJkQfuTFhCOO/fsFj3CJk/rIkZE1n1f+AMt6+N
         CdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779509273; x=1780114073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NN+b2sfzxNXDXzV7TDm7hE5fzlrLYeypS0aOQYewte0=;
        b=G+xonXRiRhbkwl9DJvJta6/sdSq/fz0bv+J2InHMu3x2ZvKJfzrTlh+2EE/9kXvc6V
         Pj/qJxSbWN/kQe3d0WqyJYgdIiu3TdhBjZb6lXuyvaakYQIICmli3no+e63AVkeKjo8W
         UKb0FnAFzM6qCaY6CTVNTJXX9GaHzOufn17n0UsjtE1PXzT7U0LHneyxlIhB2natKY2e
         jiakWmqicL0d6g9doJdAfS70ItAjEpSqdgowRVECVsWLJDuhy6a/IkSMCrJB4/7HSVj1
         BiJ+tgtSmekb/+6DK7rLkcqtwnAsT77u5rTxpJewH30wXTfaTjWROKq5OQ1dVvE7zk1u
         7GBQ==
X-Gm-Message-State: AOJu0YyHvfIeop2yrVOlHYy4ucHDz3MoMlbXNnHbagZNuxE3iFXscsC+
	c6oXZUQMMsUGydLyv6AXNwqCqerKJNmPc3dtl/+b5vPOCuQ4sfg+j5adBPpaEcCxAQE76V5agPp
	AtHiPn5OQRQsJs0R42hCyt7l5dr/7CuOkvTwkWfCF
X-Gm-Gg: Acq92OELsP4zJmTjkb41YWqxCKrsu5oqFlTs+7TQpMVxd2DHRtcPBdwjYdNqAY2VtYT
	CuIZi5CUcldpEMEJondI9jDbwdP+3BKML+wN/sH/yOFTaSRzpnKXTCNzyoPmEkscpftPk86HEmp
	wpmD599D6HZtr0wjfo8tReOu2Szinayv1UTNzSHf0woz3dAOFUgsz5UszEo+Ce60BWbcYPwlupw
	Z3WwXOuvNYszfM16qoToRWNxtq+suqyN8TK468LMLg+rV+kx+YUZG2Z9EcErVfMNtYPKtJ9l+rx
	Uke/
X-Received: by 2002:a05:6a00:2da4:b0:82a:6ef8:cb43 with SMTP id
 d2e1a72fcca58-8415f53dbe4mr6009724b3a.19.1779509273360; Fri, 22 May 2026
 21:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
 <CACYkzJ6e4LSPr9pbjAMze9-CpXvFMKdm9xXHepvjhMxMAw+=RQ@mail.gmail.com>
In-Reply-To: <CACYkzJ6e4LSPr9pbjAMze9-CpXvFMKdm9xXHepvjhMxMAw+=RQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 23 May 2026 00:07:41 -0400
X-Gm-Features: AVHnY4LH13W4v-QECn_JRP_dXtczIsWCYDboQl6EfJ4JTRf8VAQqGMzOrZLpzzg
Message-ID: <CAHC9VhToAU=pj3eFsNswot_JAmujguuUCArHAhpqvqjmSJxPSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:46=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Fri, May 22, 2026 at 8:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, May 21, 2026 at 10:32=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> > >
> > > This series continues the "Signed BPF programs" work and adds
> > > the missing pieces needed for an LSM to do policy enforcement
> > > and addresses the concerns raised by the developers of Hornet.
> > >
> > > One signing scheme, please.
> >
> > This is why we tried working with you and Alexei for quite some time,
> > providing requirements, patches, reviews, and code suggestions.
> > Unfortunately, our input was not reflected in the signing scheme that
> > was merged into Linus' tree, so we have had to get creative to meet
> > our our needs and those of others.
>
> Is your idea of creativity to circumvent working with the BPF
> maintainers and community?

My previous comment should answer that.

> > Once again, if one signs BPF programs using the Hornet signing tools
> > provided in Blaise's patches, the resulting signed BPF can be loaded
> > and verified using both the existing BPF signature verification code
> > and Hornet.  It is also easy to disable Hornet and/or IPE at kernel
> > boot using the "lsm=3D" command line parameter, and of course one can
> > always tailor the IPE policy to meet specific needs.  Although you
> > surely must be aware of that as your own patchset borrows heavily from
> > Blaise's original code, albeit without any attribution.
> >
> > > Hornet has been NACK'd repeatedly by the BPF maintainers [1][2]
> > > on layering and TOCTOU grounds.
> >
> > Blaise has recorded Alexei's NACK on the Hornet patchset and addressed
>
> Please record the NACK from Daniel and me.

Send me the commit IDs of the patch(es) you wish to NACK and I'll add
it.  Daniel will need to do the same; I generally don't accept
metadata tags from third parties, whether positive or negative.

> > > - security_bpf_prog_load_post_integrity LSM hook, fired by the
> > >   kfunc on a successful metadata check.
> >
> > Does a kfunc calling a LSM hook open the door to a potential recursion
> > issue involving a BPF LSM?
>
> What's the concern here? LSM hooks can fire from BPF kfuncs and
> helpers for a while now.

I was under the impression that BPF wanted to prevent things like
infinite recursion, from a safety/security perspective, perhaps not.

> > > - IPE properties (bpf_signature, bpf_keyring, bpf_kernel) and
> > >   two ops (BPF_PROG_LOAD, BPF_PROG_LOAD_POST_INTEGRITY).
> > >
> > > This series address concerns raised by the Hornet developers:
> > >
> > > * The metadata hash check should be in kernel C, not BPF
> > >   bytecode -- Blaise Boscaccy [3]:
> > >
> > >   The bpf_loader_verify_metadata kfunc moves the hash check from
> > >   inline BPF instructions into kernel C code.
> >
> > Please see my comments above.  While the kfunc is written in C, it is
> > still reliant on the loader calling that kfunc.
>
> Yes, that's the idea of transitive trust here. Ultimately you signed
> the loader with your key. The mechanism proposed here allows
> verification of any dynamic metadata, it does not need to be hermetic
> to the loader, provided the digest of the metadata is incorporated
> into the loader's signed payload.

We've talked about this many, many times already and the differences
in our security requirements are well established.  You've satisfied
your security goals with the signing scheme Alexei merged, we are
working to satisfy our security requirements with Hornet.  While
Hornet requires compliance with your signing scheme, there is no
requirement for you to use Hornet to utilize your signing scheme.

--=20
paul-moore.com
