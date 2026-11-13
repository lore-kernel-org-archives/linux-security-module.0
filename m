Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794537715;
	b=bVw2T3wA3P1GJY/jpMK7elJ0/JWD4tsTvCp+1IgEWwPm1GeWZsNFFo//ycUL6+FVXmVB
	 QPAkBFYI82gVjGDsS8/qJrUxHmBIuyXMqhP6rXf18udrNHljle/kAlphk+FSPfnL31tA0
	 6Vz1gVy6zQH1y07Vq0yfiz5BlPvH4lIqwnw96HLLE/EWtCWNrw3R8z4TjAXKNzRWXgzb/
	 av74dawSEFDk+qqEmmkIr5gPvS5R0LCqVCPZxeaTutZJ7Al/qleAxz2G5IVjgZVAvUKfk
	 l39HbtIfVcAF+QRweU2cs2CM744mrVlhCFScc3/ksDn9l/R/BgO57IWPpqr/3nz1cNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jAKaL6ziK4SU3uYWDKIwk2j64mElGB9GfkW4ERNhraA=;
	b=q1Itl1uayhhACH9hplBnkloJx+G35+UXYME9qjDm4GJCCxMWOCNfts6dkYeiwsFvbS5S
	 rvCaWCf6WnsnOeGrXV9vrbdaToFgeqWXVj9668o0unnIPDZl7PKT8SU2DTEIJMLe1z61m
	 6foVrxqmhAArLx2TYHTDNGSec43QRpfchIBKv0xwASAr1cG+I9CsSbFGzZF+1asDK0gzv
	 xjcO6TCuKYQKVi3FS1PIE9VMC/wwtujkNcuGCJR1XCgvXM77LxuApqg1WKSj671/chVbP
	 EslDK4ENWqSmUaP2C66g4ugXHayOucIncPkwhTyjtNEACvDXwa2TdpJ3utHzjSQvdng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XHLr4Ebq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147A60A3820
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5147A60A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XHLr4Ebq
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed08b07213so3013505ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 18:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794537714; cv=none;
        d=google.com; s=arc-20260327;
        b=jYr3BDepnqKSv6Do4kgD0RtnqcapWofcYK5Hql684NRsmsI3ovf01cGKsjifMSuqDa
         dBbiDAvO8MpjAT+oYAkdCqL6NiE07kvaUD1S8tKgrq4d4dZshtin2si5+7y6xYXmrZ7+
         tsrAvLPiB7dGvVyGwOcdyeSzIuD+XlYZXrSy6+Ki0wGA/y9YLHBv8jyAvE+JLEiVc8w6
         lzYaERJ3NkOzE53eUxLM4O5qfl15F6k3z2PPp7EOrdQojJU+RfrCImE+qrnneRT2+B+O
         ruQcosmAYEy0xNCj1IWURWqheqsO8XA3zXDAFe6T/14VPd80sPf6YBH3MgVdB2oTzbnD
         iaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jAKaL6ziK4SU3uYWDKIwk2j64mElGB9GfkW4ERNhraA=;
        fh=lQ6FXe1GhJp1NFUj352VaVVLg58XqgWbdFfUCqmu9Gc=;
        b=Gnq4SMkfah4W66Bg/+xUPjAEnOefAemIj6F/0vZM61MJSnGp4waZOYTSVJlq8d2qok
         q2CXFDrB809L5lXcfXulnJelKejb0v0yNlaZUa8eIogAK4o4kTKdnr1uiEvVCZ7m74eM
         uFwfZXcSkTg5XZfXMmZe7EIdpYcbYiOF4GD3VeACazr1EBmNL4wUBwA0TuCdODxe78Ok
         EuVQ+KEI+oQE5TnKJllaacDgDaPX7SHkfafuknWU4j6K7Kprqe3UhqjRxz4ykUhxSUbK
         5EeGujgoMQjc8rz50oOTlBjIIgwhnnBgIBmibHuStOrtkL8ppl0zOieyZiU4v+8yL5Ch
         9KxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794537714; x=1795142514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jAKaL6ziK4SU3uYWDKIwk2j64mElGB9GfkW4ERNhraA=;
        b=XHLr4Ebq5HLkuLIfnhLPMx5ugv3Xsm/b9CrFFdTNc381Y+3R1DG4UnRb4SMJPUQX/n
         ngfxcKauznwrSl+fiVyaM3bmGu310q4x/AW/f3Lc1H3erul5CeL3GkUWaKn1XIzycPHJ
         /AuCnAKHKKJm2CvanqMb5+0vOCUszWF6CrEtpPEplUMnkh91rwbKa9ydV64YPao7WsjL
         SFpGXGF2hfax3ktt0+wm6KLqAKWnlYXyAi4lW1tH5XZfmWzxV87bVyx0dLaLu+5DcBTq
         26XqL/EzUksAUVuk8gtZa5J5uFcJwdPTdamZ50XBjhuQzM5fBCo9EFZzKbEa9ANC05eT
         SfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537714; x=1795142514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAKaL6ziK4SU3uYWDKIwk2j64mElGB9GfkW4ERNhraA=;
        b=S9vjKmvVSe9VGxIKcD8dsYsleB70f6tqLtHTFa9YLQ/qroSilPIlQWaEhlgJ5nIsPQ
         RXOuTm9fPqJwaDLXLoN2zfrzIU3jRxPuJxQiP6wwjijDtWbU1BNjtm7Ck3HFGENP/j9G
         MeMGXwC5RsvhVdkotp738qJJjIyYiQkx5vm0l/2pmVtPOLsy76OTrNdIBcyV73s5ew5B
         /bJuwtjkLJ1EIWoN1H/9PIf+2Qdz2uXbUM8wel8IVovHRzd/RtZUIiXOLRdSXZbg2hPk
         5LMuINuC/ElkTTJ5XAb7OMB+W1BMEZDt1TUyhvX8GH0EdkBkce+rgbPmlxuou0xZaY8M
         GMLw==
X-Forwarded-Encrypted: i=1; AL+hErGZFv8lV0/5Tc4DWRs8CQ2aB1yEm6IyyYTlSWZE5+x52kNlFHphKKUqdBgarwOLHGtg9qUOG+/MquyQUbt5uRF83lx4ANM=@vger.kernel.org
X-Gm-Message-State: APuU4Z82eA4rAds9ft5DzPIiqH/jMhV2l05AQx5wXDZMm4uqMBVujHcJ
	bC05yLxV+qI9b62ObuG9b+9GSbiJI/Il+p2v7HtOkNTI7EJYXL6bFHHrz1sKtBlUKVy6X+BhOc2
	QTyyJLiHTbcJjQnSgAhYV5vXYT5mOebde9Ky2brQw0PZWtqHcsoc=
X-Gm-Gg: AYBFou2/ZeEXGOl3n/tlIuNcSCPTlknFjqSZeENxN9oRaKcf430X3VYTV0FEHccBkOl
	GXdb9+YXv2tQg37vmnqUa/AhJ78HNTZzClO+aEx6gu8DatJw5CYA6ZFowHK6wUTLIJquvSwRzgK
	Ew8mFUzyyqFlXASf1vWH9drg+1JRMQzJixLcCQWmweO5umtT3njZoEnnKYfxfc/tvIE5rb6GGbY
	DszSqS/zazDqHib6CilUATD5MWtNM8whrOtOGWMUkz3MzBvBxCOuU3UROiOHyyq31/FM2T8fl5X
	C90IVUd3LuEByf0lRqHGUwwdOKZi7jSeGPTvOEHFeLVdb2PGTyi/9AmjsYWgjRxWrdWMxiKYfUn
	p+17vpjkWIHY8t0jhtYR6CKmV2D91qmm2Qu6aB1yZuEfAWUc/KkZCFKIuKAn0BDhXbpfO
X-Received: by 2002:a17:902:d58a:b0:2e9:9a19:c43 with SMTP id
 d9443c01a7336-2ee0dc92381mr10406915ad.15.1794537714397; Thu, 12 Nov 2026
 18:41:54 -0800 (PST)
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
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Nov 2026 21:41:41 -0500
X-Gm-Features: AclHuK_hptpm5wmZcDCZpYaTcjHynA9uzBvoUM-dSQMe8mTEMVFigRMkrd49BmM
Message-ID: <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, roblabla <linux@roblab.la>
Cc: Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:00=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> wrote:
> >
> > Hi,
> >
> > Thanks for the replies!
> >
> > > LSMs that need to provide a stable API must provide an abstraction
> > > layer between the LSM hook callbacks and their stable API.  The LSM
> > > framework is not responsible for the stability of individual LSM APIs=
.
> >
> > Understood, that lines up with my expectations. I think the biggest
> > thing here would not necessarily be stability guarantees, but rather to
> > make sure that the eBPFs fail to load when the compatibility is broken.
> > But that's probably a problem for the eBPF side, and not LSM, I assume.
> >
> > > So, in short, would it be possible to send a follow up to Daan's
> > > commit and move `struct mnt_idmap *idmap` to the end of LSM argument
> > > list?
> >
> > If this is possible, that'd be nice so that we avoid this breakage in
> > the short term, since the change isn't in a released kernel yet.
>
> can you please send a patch proposing that and we can continue
> discussion there? please cc me so I can follow along

Considering the original patch was submitted, reviewed, and merged
with the BPF LSM being the only user (none of the existing in-tree
LSMs use the idmap parameter at present), I'm a little surprised this
wasn't brought up earlier.

Beyond that, from a style perspective, I think I prefer the idmap at
the front of the parameter list in most (all?) of the hooks where it
was added.  I'm not interested in moving it at this point in time.

--=20
paul-moore.com
