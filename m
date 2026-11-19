Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795111176;
	b=GyFXwSg2124DFtfhX/j0QBqGaT7kzhs5ZRwRMPinN4ZnGNZf/LHCKTKd/FWm9h9QZuQw
	 LDzwXYFWHrt8oKxilMBlodMQmkG+8JewntV20pHwDgyB5EixV/AdnT9E76AWRGnE5ykNs
	 mbCtLA9O42MGV1asLS19sJPDury7Dm/H3Z7ziJM2q8ImKgoyI+Rfw5SOgOyS8y6vNyUVs
	 wLxth9IjP/JVASJlrxNbKmkoGOc8qkUGPW/Ms1Am3Jv5/Sz81CGs5/mF6tPbgJBAeuAPa
	 4PIaGXs04hzfA9/i7+Kp9uBiFWW8s410ZBT2r/GWh+5K/flROoP05KP2om5aAjs5LXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZgscMLiDCOadJrkoKP6gtckWa0KBy7jbuT5m663Neug=;
	b=HiUwynRPCZx6H8msWxxAQnFdanfJifFefpvp8gnsNa8zD4oBFj+29VrvRjXGqehe64eu
	 fMPzojmNexPWFmYnWmvdSXCvoXNrm7xM5JPvbfADZa/himidFpyCF9CvB6Yk6MM6b4stD
	 iD4ZsAhWs4OvDhxZpFQOA7DpvtVRHpSOBb4H/cMl2i3ins7Rq4MlJz1VqKQjdbIVgqNiF
	 uXpJuFnqrgU3Pw4B4Q6jfR3Te43XpS9WsL8RTDZ+mEfb6UN3LXyt66eA/RvuA+RBGSjm6
	 BAjd2eW25fMmA1bqKSN51VzwdzBhliH7G/C4ZZGIwQwNJx1kF2Durc9xP4EqRGBFF+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gks4Fbnt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560A60A2619
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 17:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8560A60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gks4Fbnt
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso1683115f8f.2
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 09:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795111175; cv=none;
        d=google.com; s=arc-20260327;
        b=fbVFi6uYT8QXuK31p0da8o+/+2ax9tHoLbittmGSTaRZ/x5Vjw7pUvSpJmseTxogQk
         x/84gRUPTAJVw+2zjZtlZ22QnKx1JfVnX0/MiJc88f74vcVDsKDPgc8neVe1FndVMKSl
         58ULLUctuS3l59Wo1gjZn3AI7OCpI1ae141oqimql8JYYW03PuNHdn6M2CBCEj0XqPpt
         MwaHQihMB3mD8f+w5JxomCPNx0ueJfYx4NwRvKtOhaZBFBD5GGdHUylXx7YaBT03B4Jc
         6wacP7xQaQfw2x1hW5t97C4ZlTtDwGVFZRlbA6w5WZzqX08PgOwEq553ZSHY6/nzyH7Y
         0qZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZgscMLiDCOadJrkoKP6gtckWa0KBy7jbuT5m663Neug=;
        fh=fdonvtgsea1lpFGjcZtt+99+s/68mk3DNv7Xti/KIFM=;
        b=P8DKYAVfb3YY2QdV+JKacZPNdNVUTzVM74g9orwp+zfLl5mR3v6Hb1bRCy3pP8fB6O
         3d3TWyTZgeSNEDV0DuxWkxD9UtWZGAOJ9kDQ7X332uHwDX5E3cARNAMy1OZ6aQcdswYS
         mzTSlII1KN2guE7zOfcrm4wlnTgPh+uMDcIJL4HE9asGx4Y+j+oZDMhgKw6UFKzSz+U9
         XgDzvk4fFmsEiizX7cpOFRC9fw6F5lTzKGcbo+8mF6PhDpvO3PfSi9+pgQAO0M5f6jYs
         w3Nd4u+QfCT4QijgrIvVCmIlFX+JlKVI8bctZap8yOSSJojVCPT0rmlJVJgfqCgHioBr
         Ql0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795111175; x=1795715975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZgscMLiDCOadJrkoKP6gtckWa0KBy7jbuT5m663Neug=;
        b=gks4FbntYhBepMkUAWOCVysyoFVCB3MxTbmyA6XQTxARUjb3+KntQakgQGz9jazu38
         5P9vRaQ5F5ArZZSBoE20WjOdCInkmX+/USedyvOg4j9sIczowVMQYD/APJv1NSH3nOXq
         1pjP8nftNohrYfWdxD1hwfczb6n5zVqQt23SYEghm3+vNETJHOIe++s2pZA5IA4F0MnV
         UwHCBTc8p55S4igq32dqbiex8ONzUvRJqAAtrXgVSrErdOTxcdYlIk4+v1RZkqY8ONa2
         2wvwEE8rn2ztEOEjF4SlG9b7Ef+ckWaZNIbrsbBspEzu41XJGRkVNirO1ZWfAQkPLX/9
         2HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795111175; x=1795715975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgscMLiDCOadJrkoKP6gtckWa0KBy7jbuT5m663Neug=;
        b=NCdLFuqHvZfkkwitvm7r+Yk8O8oazwy/GaJaSMxjPDKZWXwu4UqI8T3fQx+xaK82VK
         we//F1vN9xYPvsVVz11/gTg/zzZTtSuYubk3FA9vyvH9wJ75v1ymFfPKioqO+5EhpUXE
         fXjXlgbO5gdlM6nWKlzN1cZ48gt8Ts5mzABHHgKytFi5qw6Itac4E8s4JVvBshl0BWWG
         PnzpPnD0fcUO4/Bz6nkUGlrOY8PAXVyTNpZtmz8UTJiy05uK4aRAkRxib8re/Ur7/Wiu
         RPU5lZUNYHdgndsQaPBQkrPMNCTWoN5OcFtRFlFqoLIKsmlWmSGUE3VQbnpbEc2ktREr
         OXhA==
X-Forwarded-Encrypted: i=1; AL+hErFoYYXJggLORCcl+xTW1NdDVi6GpW7YBZWuNpq00U/z86mTFQ2cJ7SDZc4bagTCeOaI0RmfBTPhbSzrTyTVFgNQRClFMjg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xAjjBAOV7Qmiyq9AnD7kLwg8t/4eW8txkc3lXqjalKtyzMQ1N
	+Z5jiO4z07RI71+5bog7G+q7EdtzOh4iX9qIhg00Lpj903Y6K3/79C7RpbUOfJl3Dbccv52lG8M
	w6ElPlRgbT4YcN9vTqw/aQN7QVDXx1CU=
X-Gm-Gg: AZFdTZfVTeH208Ajc/k7gy0Meo5ooRT2MKPlZiFycsScSzZNSSxZvpKeI3Owd5Ih47T
	guwgvflGLz6rUOFoWerOc/GyQ3ooCAeTUBOFCYkouFJxMzzz/yKRiQMZ03t+d9L0eYtnpZXYYAa
	xKkUO4dsnx0LhGBDrRUH8nR7LEGIC1f8+u6GMdoF7nIu4IZ8qvldXtZCyc7o5iLALr+jqHisJFi
	WhSvWe3Z3lPOta33wG5mfY0Rnk7lcEUX42JUjS9vInxeIBq7TMa2lBmCtOJOn+mL6MvGZtZsDV/
	Nmleqmcy0pU3x2xL//OZdHLT1+PgxlJTLaEETmSPlhigU9sQ+760gIk1Z6d157aiqzpKrBiEEEH
	qJqYltCrACDjzFZQFdAVEB/qVC+CbXx7QmU1KlPELnAsmGRKyPKBZs5zYa+2/XgymJEQz+jBcvd
	VZ18NWbMJl3fRgXgdvvg5LY5y/jqehwB4iMg==
X-Received: by 2002:a05:6000:460e:b0:4a7:790c:4a34 with SMTP id
 ffacd0b85a97d-4abb3b42a90mr312581f8f.20.1795111174618; Thu, 19 Nov 2026
 09:59:34 -0800 (PST)
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
 <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com> <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 19 Nov 2026 09:59:22 -0800
X-Gm-Features: Aa3M54rI23MKqBWHsKCyo3oqXGgxsyN6jYM1v0m1--b9Se0lLJrl3D4bMloAJWc
Message-ID: <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Mabileau <paul.mabileau@harfanglab.fr>, Paul Moore <paul@paul-moore.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daan De Meyer <daan@amutable.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	roblabla <linux@roblab.la>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 7:14=E2=80=AFAM Paul Mabileau
<paul.mabileau@harfanglab.fr> wrote:
>
> Hello,
>
> On our end, we also have already merged code to adapt our eBPFs to the ar=
gument order change. However, we would still prefer if this easily-avoidabl=
e breakage could be fixed by moving the argument to the end, even if it mea=
ns having to revert our fix.
>
> This is motivated by the fact that such a change is not made in place on =
our end because we ship our software to environments we don't control, mean=
ing that any and potentially all versions ranging from 4.11 to the very lat=
est should be supported, so the change is made by compiling and shipping a =
new variant of the concerned eBPFs for the version interval it is valid for=
 (7.4+ in this case). And that has to be done every time there is an upstre=
am change like this, so the total installation size and overall complexity =
grows accordingly.
>
> If we could avoid that, especially for such trivial root causes, it would=
 be nice.
>

I agree, and that's why I'm asking Paul to accept the patch reordering
the newly added argument before 7.4 final is released.

I do not think that the maintainer's personal preference for argument
ordering beats real user pain.

> Best regards,
> Paul.
>
> ________________________________________
> From: Daan De Meyer <daan@amutable.com>
> Sent: Wednesday, November 18, 2026 3:18 PM
> To: Ihor Solodrai
> Cc: roblabla; Andrii Nakryiko; Paul Moore; bpf@vger.kernel.org; linux-sec=
urity-module@vger.kernel.org; Paul Mabileau; linux-kernel@vger.kernel.org; =
Andrii Nakryiko
> Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silent=
ly breaks BPF LSMs
>
> Note that we've already merged code in systemd that depends on the
> current argument order, so I'd really prefer if it didn't change. If
> it does, do cc me on the patch so I can fix the issue in systemd.
>
> Cheers,
>
> Daan
>
> On Wed, Nov 18, 2026 at 1:52=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linu=
x.dev> wrote:
> >
> > On 11/9/26 8:07 AM, roblabla wrote:
> > > Hi,
> > >
> > > Thanks for the replies!
> > >
> > >> [...]
> > >
> > > So what would be really nice is a way to make eBPF code robust agains=
t
> > > kernel changes such that it either works, or fails to load, but doesn=
't
> > > do the halfway "loads but silently misbehaves". Here are two ideas th=
at
> > > have been in the back of my mind that could help solve this issue (th=
ough
> > > I understand that they may be rather large changes, I'm putting them =
out
> > > there mostly as a conversation starter):
> > >
> > > 1. Could libbpf/the kernel have a mismatch check on hook arguments? I
> > >    understand that libbpf and the verifier don't know the types a
> > >    program expects, since BPF_PROG() only casts u64s. But the macro
> > >    does know the types at compile time. Could it (or an opt-in varian=
t)
> > >    record the expected prototype in the program's BTF, so that libbpf
> > >    can compare it against the LSM hook's prototype in vmlinux BTF and
> > >    refuse to load on a mismatch?
> > >
> > > 2. Since kernel BTF has parameter names for the bpf_lsm_* functions,
> > >    could we maybe have CO-RE-style relocation to resolve "the argumen=
t
> > >    named dentry" to the argument index at load time? This way, adding=
 a
> > >    new argument could happen anywhere in the argument list without
> > >    breaking eBPFs, and removing an argument will (correctly) cause ou=
r
> > >    eBPF to stop loading. It does mean the eBPF programs must provide =
the
> > >    same argument names, but maybe that's an acceptable tradeoff?
> >

[...]

> >
> > ---
> >
> > And just my 2c re argument ordering:
> >
> > Paul, with all due respect, prioritizing code style and personal
> > preferences over backwards compatibility is unreasonable even for
> > unimportant applications. And here we are talking about apps
> > implementing security policies, which many organizations (not just
> > companies) in the world rely on. Given the recent flood of
> > cybersecurity issues (in Linux and beyond), I don't see why would we,
> > as in kernel devs, intentionally make the defenders' job harder.
> >
> >
> > >
> > > Thanks,
> > > roblabla
> >
