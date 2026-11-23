Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795465298;
	b=m2dH7Jk/RioPgfHDn0QCKgZovCaXcBmCbMpnzctIfdSOwrLKZHRDHIygOhftKF62+TVX
	 qdPkdFyN4NlT7qrO2hheO33mjG0B+PIAXl/9lLyyDa2nV2lrpEOYSXZmwieGQD+l2fjMY
	 jmKdwB7dp85QGOFpRkS2vOhgXZaCCMw9lg9LEqS2eRIFvHsDNFqIckQHvVDc97sB5XLPg
	 mpNo/Kk/ztZnXuVRf0KKVpNsynWqD/AtzvDKcZhTX1LqeevgPBudYSXeAqpb7jPM4PG30
	 Jjv4jjKdp244vZsjKb+kyBoh7aFrW4W12Sy3XpcsUgaF+cfSOdq/q6pol/9BT6HcJOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LEUZIAOLddGL7x7aQvXVvqPgmEr8lXGuohw1ryERaEI=;
	b=IEu8/r1Tx3Q7s6eeK6s6iGLIRBKqcnwwy7IFAMbhG0yMnZAYX6mdwxTE2IJGvgzNh0U7
	 wu18yRxEcD6v2kpm+y2uPVdBiKBTQ2bP0nLrjm4XqW4UlMZzKfdioTf9gyB/zb42vqJaO
	 4Tir1YAigfxCf8UfrBnvvmnwol9VYSqLAbhJbe1VrbOX2tnx7dbUvwf2ydPthSTSFb/Zs
	 2XZ9EEFJ0AffRb+W74rp/LNKXWLewKl83cHzEAUgC7Hov2vPLaX55n4x6lUVrCvDMUZEE
	 Ngh1f6McEcH+DsWFMX6jqiCGoID7D4OkDQdSCSXUVygTUawqVd9lOcWdMVwTl5dAA4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=c2gq+laq;
	arc=fail smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFC606A321
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 20:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EFC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=c2gq+laq
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so2176579a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 12:21:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795465297; cv=none;
        d=google.com; s=arc-20260327;
        b=paRMlok046lsHNoYM4dk8gcFrgoUeauPLAWP+JSDxF3gpyxHT7IGox2OPg4YuQiS0K
         BHxBDJLJ6odNziEPFZkYMZaY54XXkMlLv6u/g8OIFCgruXnLVXtavmxnZ1DZTcvEtjQF
         QWzjqKC1kkR40C4QhJbYrlGpj0Rxds1SjxHlhs2TfGk8U4nWKnuY1bybb2u8bsTyHvgA
         7xNSXysstDNJLhsnsgIWZjzSUe/Gk06vDfsKKm6UERSTKs3aTe0BGyEzWSUzaIceUvc4
         hOYq55pA+24VcOi0FMOP9HWAB5sgZrTkaTMJhKoMzjV7g7XCQgG8qShRjdLXfF4L6jvH
         FRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LEUZIAOLddGL7x7aQvXVvqPgmEr8lXGuohw1ryERaEI=;
        fh=5Ohmz3VSp0uoQfrdCQxyn7Jk9tNITPYnKZhIDAb2aEQ=;
        b=mJPWMZcoaTk+0MQMeP2kzYhRq9yqgvkgHfsreirhGlObiKkjy/Wm+jr+lN8Y4MFecq
         AptK1uPKdoS/naTWZcDdaadRLivb+VWJmdDDse1+YIlbv4Jc0bejoX7W3YUBNeuNzoBh
         SO3TxadmqN7zp2BGIiH6O+19uZQCMjHrE7pBe75vL5HgxTri1YXYFJ88Mkn/GIMNMK3x
         c+/qxI37oikXZLgmwlymY6PMl1zigc1m989pOqm4Mk022bZHn8k2PDeHazizuJ7KajBv
         e/z2+RTfezEc5MlIZ/cGouWLlSCM6zhZbN2wuYD0rFJ+EkWVVvPKzvRTKmLb5ZXk9+Gw
         BFWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795465297; x=1796070097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LEUZIAOLddGL7x7aQvXVvqPgmEr8lXGuohw1ryERaEI=;
        b=c2gq+laq0yhqp6FF1Vf947qPiE0Z5VfoHe+mggi5Ga9ubu4f4hV81J96iQAbuIZq1L
         3JHWBPlWzOPhLjMRN+Q168fHx8VZQwUSN20XWFGjhVlrtlDFTQpPy/JQOmNK6mqkCM4b
         4xerMMl5+iUABeqLcepD5C/uOmfg/WsJbin9q5Oo3YZv/Y50wEt74u2cZmcPrw1UpOEJ
         GvJ6MU5HF0KnwUevXCTb0SqNtPCuLh53gxMDkKmycj2psn1X6Z/3dxtC3DRm8Q/+eqYm
         WQZCzYcpGWw9wMUrBdZgmMmYcAW3hURjuvmeUGtZnNtaDQaLQoATrhyDTFpjwjrcMA5c
         ZOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465297; x=1796070097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEUZIAOLddGL7x7aQvXVvqPgmEr8lXGuohw1ryERaEI=;
        b=s7yHj2Wao7V2YqhG5yTOTKOcAg4QvP1qNFs6ZZtCLj99BFF6eeZ1zfljZwkhUG8Dig
         ct7R98qj8UXjkGl/ydDOr6IS9EdipuY4hUW1r+tJYDwgROjStsZUYAuQryw7UHjAmd8/
         +K9zQFH2JxyLZO8GfkOS3ovFwUbTBiCKAl08mkLP4mZujZACGmAnNMldGjpUA7pihdd7
         OB+IGlDjPhh55tUAU8WhGSWsG2XWpt6cdI1W9u2T/dKsd6KkToMZt3Q5JJUCNJho3mm0
         C1IzNNJjPntFtzvF1BdYoXm2Xu1blY6eNI+CEGSFn9kVS3oGY92+evjFVLr9BBigvR6A
         duxQ==
X-Forwarded-Encrypted: i=1; AL+hErHy9LyrskCDUq3XisGnNh26qwG/eSlKEHMTWY7TuOiLKHcW6Ti9kBfnsry6xqw/KoKsgCQlMvGfAarFhU/Eu2nSZuM2XLo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rpBthgLBuN3/kCTC+ILSlVeNG+HkefzMi1zaXYrM5fVCZ6ga1
	yIDRbPZm3MITuFoAstiuOW2mXqicas21B0jeHpQugCHLaRVF8W1GBLEYnkpDrbH/V5W3jleCbMt
	rSkH3rFVZMShBD9B5+kCZTjsr9QigGc/qL8wxnksg
X-Gm-Gg: AZFdTZcd1cu1XhwCeOI97JScwUJ7+027PlflUiWJkMoPwTD/xm7M7tLDMOkJLyv5qaW
	p1fP1V8tP6tga4dssCLNdj6hw/o/cRwFir51jEgifJ6TC44XLaBJbqIlfhfRl7Et0rOpcgRklfn
	RGCEMNp4IGdrnrpt2IOJHuSd9DjF3J8dYCC19nvF/Tur9mWaRM9c5HFDRsmppUtDrqiiO2K5G27
	UMehT5PTioAAvwsDedrqF0SD9uJhnz6mLC4hYXAkb2ceVOEKbqLR5JK5HWy5jCpc5FFSknBU2lw
	8MGqLh/lwOUv9cSGXxlWVlKmmYw3lReQn6VfZX1sMo62zVcv2Yru//knl3SCch+kk3rDIcLr4cn
	R9qfhpkmBwMpJPQbNJCBF/ht1jPdO5xecB8Zyq9CjpHWZOYkA2TEsMt3mik+WBvBAtwZumA==
X-Received: by 2002:a17:90b:2e8c:b0:3b3:b373:6a6a with SMTP id
 98e67ed59e1d1-3b41c9e45c3mr11852486a91.28.1795465297053; Mon, 23 Nov 2026
 12:21:37 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
 <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com>
 <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
 <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com>
 <CAHC9VhSFvOiP5Tyt=rOFMwg=Ro1jRw+hfcw4AdCkEyftZJHQCQ@mail.gmail.com> <CAEf4BzZqjiWR4EzBFdV-czH-GnxqOeOAsMLgXtQ6TwN2ZiiT8w@mail.gmail.com>
In-Reply-To: <CAEf4BzZqjiWR4EzBFdV-czH-GnxqOeOAsMLgXtQ6TwN2ZiiT8w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 15:21:24 -0500
X-Gm-Features: Aa3M54qJwPl-ABfK7B5B7-sJCPY_acwvpvVOTnL9PsRVe-QdqJj1wCPpuoy-tHw
Message-ID: <CAHC9VhSOz-ThxXL+5MkScd6Yj2thCqE565zXg80K_cWHkViH0g@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Paul Mabileau <paul.mabileau@harfanglab.fr>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daan De Meyer <daan@amutable.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, roblabla <linux@roblab.la>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:55=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Thu, Nov 19, 2026 at 11:37=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Thu, Nov 19, 2026 at 12:59=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Wed, Nov 18, 2026 at 7:14=E2=80=AFAM Paul Mabileau
> > > <paul.mabileau@harfanglab.fr> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On our end, we also have already merged code to adapt our eBPFs to =
the argument order change. However, we would still prefer if this easily-av=
oidable breakage could be fixed by moving the argument to the end, even if =
it means having to revert our fix.
> > > >
> > > > This is motivated by the fact that such a change is not made in pla=
ce on our end because we ship our software to environments we don't control=
, meaning that any and potentially all versions ranging from 4.11 to the ve=
ry latest should be supported, so the change is made by compiling and shipp=
ing a new variant of the concerned eBPFs for the version interval it is val=
id for (7.4+ in this case). And that has to be done every time there is an =
upstream change like this, so the total installation size and overall compl=
exity grows accordingly.
> > > >
> > > > If we could avoid that, especially for such trivial root causes, it=
 would be nice.
> > > >
> > >
> > > I agree, and that's why I'm asking Paul to accept the patch reorderin=
g
> > > the newly added argument before 7.4 final is released.
> > >
> > > I do not think that the maintainer's personal preference for argument
> > > ordering beats real user pain.
> >
> > As stated several times in the past, the problem lies not with the LSM
> > framework but with the lack of an abstraction layer in the BPF LSM
> > providing a stable API.  As far as I can tell the lack of an
>
> I think the problem lies neither in the LSM framework itself nor in
> the BPF LSM in particular. Neither have any abstractions built on top
> of LSM hook prototypes to guard against argument reshuffling. And
> that's fine and basically inevitable. If you change LSM hook
> prototype, you'd need to adjust source code of all LSM frameworks
> relying on that LSM hook (which is easy for in-tree source code, of
> course). For BPF LSM, if argument is added at the end, that pain can
> be avoided completely.

We're both repeating ourselves at this point, so I'll refer you back
to my previous comments about the LSM framework not being a stable
API.  If there is an expectation of API stability or specific
extensibility in an individual LSM it is up to that LSM to provide
those guarantees, not the LSM framework.  Considering the current
design of the BPF LSM, any breakage caused by this change with
existing BPF LSM programs is solely the BPF LSM's responsibility, as
far as I'm concerned.

> > abstraction layer in the BPF LSM is by design, and while that does
> > provide some advantages, one of the notable disadvantages is that the
> > API is unstable.  If you want to be upset at anyone, direct your
> > frustrations towards the design and current implementation of the BPF
> > LSM.
>
> What upsets me is that your personal grudges against BPF community
> (or, perhaps, just particular members of it, doesn't matter) gets in
> the way of doing the right thing as a maintainer and putting Linux
> users' pain above your personal preferences and/or dislikes. And
> hiding this behind "I like this specific order of arguments" or "BPF
> LSM should have better architecture" is just petty.

What upsets me is your assumptions.  Try to be better next time Andrii.

--=20
paul-moore.com
