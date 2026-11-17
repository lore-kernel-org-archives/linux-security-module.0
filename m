Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794951887;
	b=kZQ5RICzG8FLf9rAUSkcumNjCBVF4gpYqqyY4CDzBqtHOuZj1QnVODtPyrRS/qQDN3qc
	 HEpbEhtdHi8+5R99F2zn7ziPsKhkd992z5Y2F2sQLylwAHuLei4gwYNgwTD6NvoSnClDM
	 kQ45aW5zSH5Jh5DNFWydysyPEKYtAj7j+FoCKP5jPme0A0jdFdFM1GuKic8yO3VlsbVC1
	 3sS+pj0C6zcCi5R9DoNo3+w14AfGSKfvr25ethXXuj+luUkbS2rEF5t2wJ1v6K+HaVfYW
	 IDppa+MQZHIz1MJalC8a4WTQ78bJXfBjEOoDvet4AFgOZivKdBN51BF4HFHXDRgKsCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QCHf0rhDeEETaZD4vNh0xBLfMvMYAYCFBm3oqRl3Mdw=;
	b=YXuEjZbcfrb7kUdObuephha87538/Luhtt9ODxZz8IoW+MCUpuGo8Fn8y4mwIXyq8NWX
	 +dU7zkzVFSZF7Mx9RnSvuN2lRfsnXH0HuuDXF7TdP9RJDthhMQFmWdtk9aRNQ0HO3aYXi
	 vM4/rXjnKtayHkPip3E9YegoYBv7mAZQxyGm58QiMhO4UDxUTcHfuZ/FGNQI99lgXAD+I
	 W/8l2EkhJNGlFkChtl2ZZC/7Bg3Ic+UdKnX2q2RcNRlpqBNkvebDCIVmIrM8zuTX+npx5
	 VpNVy0w56jE7JjgV3Fg3fTKEiN0P4R2WhkAIP2Nm1yowPXhIRpEW2d+2JTrDOsIrUAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q4akuTuj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1D606A336
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 21:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD1D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q4akuTuj
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dee593f18so181677f8f.3
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:44:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794951886; cv=none;
        d=google.com; s=arc-20260327;
        b=iHvW8kquGrFXkgFivSH0bCShrba2L3js6Kne0jFnh7GIa/9xX8trvNOJ/ujQfSWJ6W
         14G1lBkSfnxPny/tJJjDycishOzb9afhDdmqPB4m+dsf6udOnHD3fE0TcawveNrE9Rb8
         8E+m+uDB6hpswDmnCkTxYTbFVCgwb0fapqyr7i1zCfBdCZDiQlehIzd9t/vHGFkRvg+W
         Hx9QZMysNMP9OCFucaaVx/9bb6lksbUbXjEnfNzYObqYg8eRIjpRDflvRx0A0c3YKVfA
         sdscDAhN7y7uDdBAGOAUuWOnZKwyDf2uhWxDJkFibuWO2gDICSyT2JkXyjVzmb9XHQ9/
         AtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QCHf0rhDeEETaZD4vNh0xBLfMvMYAYCFBm3oqRl3Mdw=;
        fh=ouLYdJ5ZYk2AY31Be0icU0S1Miyv5S8bUyWgFTw2KZU=;
        b=YzWkq17ZGKFf39Mc7JmDNWDFEl+75RYEoYAOyLgxQhG6OX4EspabFvhICcnM4Asnle
         Vpv2P+B9/K+ymlYH7vdcz11mrd2ne6yUBclGAA5Mz1tKw/+Pknc9ITZsoemr68tXIqrj
         tydSBfv1Ds7YdAZqc6PMt1n5iGdcH/8vDrAJFQLTb9ywCQ1aXVtyGZrMuHj042dT9C3y
         bqZaaDTkTfGGMNpygzvJ7RDKovl3pAPbFVgb4Wdozr3SuSsfYn4pxub7p4sJaB1UerwI
         iWaaSz9cNo3CY/udiCo/om7W2GOrMPdj3WYckBOV7+MPGgj7PpfY2nJ2ZIJst3JjRqcW
         +ypA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794951886; x=1795556686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QCHf0rhDeEETaZD4vNh0xBLfMvMYAYCFBm3oqRl3Mdw=;
        b=Q4akuTujr5pbvaLa0lhDO0YCADGQAgjj8c2bG0N995NS/8kAVFkkoWtJjNIQKLY5fT
         4ickiyj2FfqJOk8tH16u9eywWyjjuOmFE2Z76cJqYpJth3IvCSP6L/HCPzEW3Ho9Hm9R
         tVV8fupVGdTK9lKvreeZp+la3khqvF/seI5TtqQYoDGbT3AdKpvkVfS4+/OLrjJtWqFm
         UtMTRjJm6oOzhtgyNQyGNCyQanScn66u9qQY/VN7Qc05wwVkkDuuToTv5Je99B09RCnZ
         qaWDLTWuUDigZ0f0SuJLY+eUXdEfA0Fv2meq2PbnYvGEcToaK1tcPcGI2VgejyWZ0b6Q
         Li5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794951886; x=1795556686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCHf0rhDeEETaZD4vNh0xBLfMvMYAYCFBm3oqRl3Mdw=;
        b=Lt99pRolSrXuks47VMalOm0N2LRLuoijE2h+adaAKICIcyOwnVbhAvMa4U4/K8HMrt
         rcbmwY5KREJYkVJsyMCaMSg2pjZT1vEvhHkU9YPDxBJQ9ln4/gPQQIi4mpLe1T0n3LG2
         Vk+MhD/bO+g//kiv6ns2qJ7uOxCA33mxa4JpQBN1y7UdToxJLvY9ibeSAJwIhR8Ur4rA
         DyB+DqmzftlwCY4ZEgmNuSI85TdC0b7H7yLw8KHs3sFUj2iOxa+MGOTZnCij+v8Gk5g0
         5bcfc+7wVX7Q48ZaY/wDVo9pYIosICI/YGgWKBEAITgx3pa09OJ7HB7+xvbjF5Hq41ts
         VAYg==
X-Forwarded-Encrypted: i=1; AL+hErFz80GsIjn3gI+CK5BxeHAaIy/2C7QNupmRbJqxyFYznJdZjBsyMQgUbLa81sPF5G9blvf53pgR9tsgNXKaxIGAbJHTylQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kCV3x3nF7uIyJpWDsOP+IoO8sJ1LlsNbNJVtu8SEnPAAAbq+d
	cEN1CsNH9/Rj1/9KhyEfu67Q43KD58izu4yASRo+jpiUD0G2HsGUGoxBdVMTArQztGYmOrp4e33
	duiYnYjPcGb0AotzoICA/JNp85Cu7OJQ=
X-Gm-Gg: AZFdTZdNO0A44VfzX5nMmBFVljp01pj820N1A7DEy35M7QaWPpyiJEei8acxSri7m3a
	qHCT3uWpnYY4Fv/X7I3Oqxw5PpHJ7nj2G2FtEg7BdDFzHdVaK7ZFpVYF7biNF88eBlebb5fWfcm
	yUuOdJCJUpLowstu0qJPTqXB5UlcXefs4dWEgInj0hlfi4rvDXE1AKabtjY6LH5+WqEv33Ml3Pj
	5Umd/kz6IH09R2O0uW1WIeGxAAU7fTraF1W+4paeIb4HGMJkJohbopREmtU5SfnDKzpHLaMQYN+
	855AU+tI81Im0tZqfNp9+aLCDg/Bnyuco0MQDnkONW3lkAreFMqaVTKtrx95Y7oFzIzOaDwF/hw
	mUgqtG5ZZJGsURdOjAPmzu1gQflZCVRyQuQ6mBb1EZS/N/f4XC2EaMnmIxzxfzb7EZYc4aiORAw
	dWcCzYy523Yvs0On7bksxwqU1DbsN9f1dcxkI4gZgM1yIp4LvRiCTW5Sk=
X-Received: by 2002:a5d:5f05:0:b0:48f:cb37:3ec3 with SMTP id
 ffacd0b85a97d-4a63b22de8emr1573091f8f.41.1794951885727; Tue, 17 Nov 2026
 13:44:45 -0800 (PST)
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
 <CAEf4BzZ120age2-M-a_TJ07xohb7-s=xn3e1W_-V0kopnATq6A@mail.gmail.com> <CAHC9VhThV9xiXr8j5_+W__CBKn0JqUiZ-RGZpF4Nz-i_RZprAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhThV9xiXr8j5_+W__CBKn0JqUiZ-RGZpF4Nz-i_RZprAQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Nov 2026 13:44:33 -0800
X-Gm-Features: Aa3M54qGP8nd7yA_gOyJhY4In2fLuAhhx8Joode7Q3Ty5mdfX54Ucq86pk3FqTg
Message-ID: <CAEf4Bzb5Y5TUbN3kLBJNPn5Ae+_nbc7YhJice_wUzqdvpjFr_A@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: roblabla <linux@roblab.la>, Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Tue, Nov 17, 2026 at 11:51=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Thu, Nov 12, 2026 at 6:41=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Thu, Nov 12, 2026 at 6:00=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> w=
rote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Thanks for the replies!
> > > > >
> > > > > > LSMs that need to provide a stable API must provide an abstract=
ion
> > > > > > layer between the LSM hook callbacks and their stable API.  The=
 LSM
> > > > > > framework is not responsible for the stability of individual LS=
M APIs.
> > > > >
> > > > > Understood, that lines up with my expectations. I think the bigge=
st
> > > > > thing here would not necessarily be stability guarantees, but rat=
her to
> > > > > make sure that the eBPFs fail to load when the compatibility is b=
roken.
> > > > > But that's probably a problem for the eBPF side, and not LSM, I a=
ssume.
> > > > >
> > > > > > So, in short, would it be possible to send a follow up to Daan'=
s
> > > > > > commit and move `struct mnt_idmap *idmap` to the end of LSM arg=
ument
> > > > > > list?
> > > > >
> > > > > If this is possible, that'd be nice so that we avoid this breakag=
e in
> > > > > the short term, since the change isn't in a released kernel yet.
> > > >
> > > > can you please send a patch proposing that and we can continue
> > > > discussion there? please cc me so I can follow along
> > >
> > > Considering the original patch was submitted, reviewed, and merged
> > > with the BPF LSM being the only user (none of the existing in-tree
> > > LSMs use the idmap parameter at present), I'm a little surprised this
> > > wasn't brought up earlier.
> >
> > Yeah, unfortunately this was missed. Not sure it's surprising that it
> > wasn't detected immediately, though, because unlikely someone tested
> > an unreleased kernel in production. Luckily, this was still detected
> > early enough before the final release and this gives us a chance to
> > fix a mistake.
>
> I've been surprised lately by apparently how little the BPF LSM
> program interface is tested with real BPF programs before landing in
> Linus' tree.  I know the BPF folks have a pretty good set of CI tests,
> bots, etc. but there do seem to be gaps relating to real world usage.

I think it's a hard problem, yes. BPF selftests test latest kernel, so
this issue we are discussing here just won't come up there. Then,
e.g., for Meta, we do have internal tests that validate existing BPF
LSM programs across different kernel versions, but unless our internal
BPF LSM programs utilize specific LSMs, this won't be caught either.

>
> > > Beyond that, from a style perspective, I think I prefer the idmap at
> > > the front of the parameter list in most (all?) of the hooks where it
> > > was added.  I'm not interested in moving it at this point in time.
> >
> > So on one hand we have a real user pain which is easily fixable
> > without burdening kernel and LSM subsystem in particular, right?
>
> Arguably changes that negatively impact code style and readability do
> affect developers and maintainers.

I agree, but argument order is not that big of an issue

>
> > On
> > the other hand there is a minor issue of argument ordering with
> > mnt_idmap preferably as a first argument. I get the preference, but I
> > think fixing an unnecessary (but easily fixable!) user pain should
> > come first, don't you agree?
> >
> > Can you please reconsider?
>
> The user pain exists because there is no abstraction layer between the
> LSM hook callbacks and what the BPF LSM makes available to BPF
> programs.  That's a choice made by the BPF LSM devs, and while it's a
> valid choice, it does have drawbacks like we are seeing here.  Changes
> to the callback arguments and/or the semantic behavior of the LSM
> hooks are going to continue to happen regardless of what we do here.

Yes, just like it will for tracepoints, kprobes, etc. Sometimes it's
inevitable and BPF ecosystem does have tools to deal with. It's still
a friction and pain and burden to do this, so if it's avoidable at low
cost to the kernel, we should try to minimize unnecessary pain.

That's really what I'm asking about here. We did do that with
scheduling tracepoints, I think it's reasonable to do this here as
well.

> It's better if the BPF LSM figures out how to deal with problems like
> these rather than relying on a set of bandaids at the LSM framework
> layer.  If the decision is to push the pain up to the user to keep the
> BPF program interface thin and flexible, that is their choice.

Yes, thin (and thus performant) and flexible is the design choice and
I think it's fine. That's not really the crux of the problem here. As
I mentioned, users have tools to work around changing unstable kernel
interfaces that BPF programs rely on.

But in this case we are discussing reordering a few arguments *before
they even get into final release* just to avoid unnecessary pain and
workaround. *Unnecessary* is the key here.

I really don't think that's too much to ask in this situation.

>
> --
> paul-moore.com
