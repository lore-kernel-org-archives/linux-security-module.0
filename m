Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794934315;
	b=KXXdwFFgQmgFoQolqYm9X+LNLBtFolU6BxEt12ei4/VoZWOXmKiEa40nHNGoyt+EDDVd
	 hCdlLYb9YKoS138LEns4p8tnkhz0tS3eynTtTBfvZEshVV6bnWpzepV0CdDkN1h1PTx+q
	 yMePhMidG07hpE2zqYbGsm5HQWKoseDmRpLIxyCrS/6KyL8n8EoOdAQNMD/esVLMIweKr
	 uED1WltPJM+Vvzldi0gHo1j/4/85slgNZ7oCBXnHGJh/ZPsP/vJtd6c/RVS4ZcpzFegZU
	 EvNkvq4h1Uc4tgnIKJIiu3GK8imLK93hxcQQRK5+HTBfNh9ud4EAuoY9Z7VPho5pG2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7JRaWtwwi9S7Z5KFGKcQeTS6a+RchtYr83xPGWINYgo=;
	b=HBPWzvhSSDKdNiNUbrqiEfY+5FqzJ9AQ2qsKi8i9gSEzvVEyzCBDzw2lH7BIlzZ/dEAh
	 HFUrOqAO5WYLSIXMAGDKy38UkwwoktS5lOUpUPTBFZeCymght8Gf0QBWzHfHjFgpJ9/o1
	 BDf/visoJEp/RVImuvyMCcYzbWaFj/TNRGbuZ3EVNifxU/klofCx/XxWQkJnm4DkS0OcF
	 Hgwgf6Qg7kF0DnXUa0yqwfXYry73QRtmgLuQn2knSTuvdnxXaI/vlWbQa5aJs21yRyv9s
	 RZzCnqH1guko70UtXn+HSE/+tMcb6DjVCikHEHQl9HL5UnTRsqY8ArwLlXhFDTgwbtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cG9HEID;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3533606A32F
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 16:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3533606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cG9HEID
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so925585e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:51:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794934313; cv=none;
        d=google.com; s=arc-20260327;
        b=oDcX1K4SjDdtvFblyePxmfv2Lb7Ntl9S0B0sLH0IpjgSJ/GHcMQjZ0o6oUtF2/QjvQ
         eBx9mxr/BM7Y2h2K5lg/FlA+h0mFGGO96CbQsjUUGp+qqmvfubgBGSUNkBe50sPxPEaW
         0RYezsCGerKlDuJdV3wv8O0Ym1owKsFmGTLZKYYHcfJSP1XKSiYCqoBQ8IVCNmC8y65j
         H5JHN7mJ0976mwM9Oj0f/q/mUVwZES1w2kTcMv7RyvpvgOYSHri8Bq83d5zQtjOMYLbJ
         AgM1YpBzkf/Qm7kIRuMFN8RRiXvlX2xZHA71/JCQA9lZjv3lTTFeRAezORpGA6CbECNs
         0agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7JRaWtwwi9S7Z5KFGKcQeTS6a+RchtYr83xPGWINYgo=;
        fh=kM0CxCpCXMVxySMsBi/quA8pCQCTkYj5QO3Da7pNrWQ=;
        b=s9+DNlhpmpeUiynlVdw1XUhUfVNibxbX24qwioXAvfQITWB6mhPHRuID6CDjsOD6Xx
         SZ9TTJjVQzniHYXc79eswSEIlTGIf3gVqx6z80E6hvHcp2pnzG3NWFbRzReTQy4nf1qR
         6PVH+sF2u/7tLkbStBLJsnJUhteflxsg39iJdDDDhVA7wPEcTeyVBb00OJOZwIW014J+
         Xre5+EIz4uIPlD7yOezPefhr2DvcCGG0JqV+HMadikRpzTb1jEjiEkzMz87RfzcMMZom
         9oRfbDuX5l36oc4OFs8w2oIwEH1/TvYtgHqhzPvzOp7ZqgbtKK/Z7dZ87McJir7lntx5
         uhMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794934313; x=1795539113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7JRaWtwwi9S7Z5KFGKcQeTS6a+RchtYr83xPGWINYgo=;
        b=0cG9HEIDKPN1IRLjWvhck/vln6wEcHrnV5TJWeVj5j0UGAlYiT9dy4RQ4G83AKqrBO
         wfsqNqc0iqHE8NzVxg0qUKPI8/LOLteUkakQPojwzPDBrP2C3rLnPG9CT6GwlMZEYofq
         tcqpIIhzFLtMFED//3XgkKb66wWor2VcJ8LUpV75RqG0Saq1eJdRPJqb3tku52GJg+oi
         xkk85GAhMopSY6zJmS2QPb0i9y4L/erFssmbWusTmAx2d+sIDjCFIY3R2Rxrb0aAhMkD
         KpoRygRV23IzbzvfZBw0Gt3VetYHpCk+74d5nQybBylkvNjT5fcJqhmbGpbe2s7Tu5oK
         7UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794934313; x=1795539113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JRaWtwwi9S7Z5KFGKcQeTS6a+RchtYr83xPGWINYgo=;
        b=ILN/aCI1FpjzR5olZKuFcXZfiQuS1A8zY3NuzGz1rc4uEITETZa81qxdhZB8NTNMPc
         z96Xpdiq64fUAgW9bB13Q8oGgdRCsivghjKSHFutApJM/wuZCCe1WKvCi7vttuPFenj4
         EpwI+mt1kLWimxBycTQZXRZSLczmdjQkOQ8CFuS3DAhfqfBTNdJcLYLQlE6ltxNF4baK
         m1zkb+svQ7T28vUbTv83rnkv/tUpaStEaT8aS5NKA2FrWRRI5crDuYoWfDljqVzvMgEP
         S9/Vz2sFBdAdDYmsW2pGyvCfKcjyFrR0Ivo+Uh5ZLdp0Tq3nnc/KVCSIiGrWhq+VeF9c
         ozZQ==
X-Forwarded-Encrypted: i=1; AL+hErFU2ECD+2xNimEg/GkoxmuQyTMBkLuNUn0Itb/XZ4wFaefnpNhd8hl8yzla6moLq2j2P0iBLUOTBppw0+SpWRUBgUJp7aI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+es0iubJZ6DLzI36nHu3W0SsrYExPx94h+9lmh/hSswxWXk50o
	2sH+TBEXtHUWaBph71JdXKMfFhaslGE4LKVfhaBnbEcZeBSBzKvlCjqxe+8FfO76qYtfUCfrLxB
	fmKwdUVUMhRHMB6e1eynKZXM8+q+hUts=
X-Gm-Gg: AYBFou0dMkwtLovC7GDDXmdEvUkH2jcrPzTWIewI/2aQq78uKZEwqVebb1nnQRs8LC/
	GH9jZvVM0qwL/rpBaWJkqFcuvIftAkXXtYRNgUfsJ7zEzAF+qGijv1CczYHh5NNQW3na1ox9bY+
	uW1I9ZnAMMzqMklekKRUutStSgQJpBxZPYI12Rl4QCtFiUPR5iZi0IP/6Gl5G0pqlhscnRm4RMo
	Buz9y+1gj/x7q1tJE2DpVm+fmzjWl6kIw/mm/6T6RZJcFp5RYXaCfb6IKiQqmXYawkKBfcpuUGv
	m0oh4sp/H3fexkYxzDadukq5NDBjIO5gigMZ3od4f0YWYFkBquHsDez1QQuth2vD3KorFB2+t8s
	xThrPoHf3M56VPkZfUzCeseiqLf7Ifyj7XMkCeUKqEUmDm0boOsc01XtRC8m5b5O/W3Rjwv/b9B
	9uZeYHq9qLIW6oxyGdhlZVFtf+ymK9+bZCKQ==
X-Received: by 2002:a05:600c:3e1a:b0:4a2:191f:7cbd with SMTP id
 5b1f17b1804b1-4bb55a3e31emr267364685e9.11.1794934312966; Tue, 17 Nov 2026
 08:51:52 -0800 (PST)
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
 <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Nov 2026 08:51:40 -0800
X-Gm-Features: Aa3M54rjJelQoMCxfJbdMIri9nRD0cwaH3YE08B27J2GSDu0HswQ_b0L7fMjvps
Message-ID: <CAEf4BzZ120age2-M-a_TJ07xohb7-s=xn3e1W_-V0kopnATq6A@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: roblabla <linux@roblab.la>, Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Nov 12, 2026 at 6:00=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> wrote=
:
> > >
> > > Hi,
> > >
> > > Thanks for the replies!
> > >
> > > > LSMs that need to provide a stable API must provide an abstraction
> > > > layer between the LSM hook callbacks and their stable API.  The LSM
> > > > framework is not responsible for the stability of individual LSM AP=
Is.
> > >
> > > Understood, that lines up with my expectations. I think the biggest
> > > thing here would not necessarily be stability guarantees, but rather =
to
> > > make sure that the eBPFs fail to load when the compatibility is broke=
n.
> > > But that's probably a problem for the eBPF side, and not LSM, I assum=
e.
> > >
> > > > So, in short, would it be possible to send a follow up to Daan's
> > > > commit and move `struct mnt_idmap *idmap` to the end of LSM argumen=
t
> > > > list?
> > >
> > > If this is possible, that'd be nice so that we avoid this breakage in
> > > the short term, since the change isn't in a released kernel yet.
> >
> > can you please send a patch proposing that and we can continue
> > discussion there? please cc me so I can follow along
>
> Considering the original patch was submitted, reviewed, and merged
> with the BPF LSM being the only user (none of the existing in-tree
> LSMs use the idmap parameter at present), I'm a little surprised this
> wasn't brought up earlier.

Yeah, unfortunately this was missed. Not sure it's surprising that it
wasn't detected immediately, though, because unlikely someone tested
an unreleased kernel in production. Luckily, this was still detected
early enough before the final release and this gives us a chance to
fix a mistake.

>
> Beyond that, from a style perspective, I think I prefer the idmap at
> the front of the parameter list in most (all?) of the hooks where it
> was added.  I'm not interested in moving it at this point in time.

So on one hand we have a real user pain which is easily fixable
without burdening kernel and LSM subsystem in particular, right? On
the other hand there is a minor issue of argument ordering with
mnt_idmap preferably as a first argument. I get the preference, but I
think fixing an unnecessary (but easily fixable!) user pain should
come first, don't you agree?

Can you please reconsider?

>
> --
> paul-moore.com
