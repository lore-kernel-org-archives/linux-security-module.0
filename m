Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793099251;
	b=ZBjq6Bf4PU8j1sbfOezAAk72VHyiw75vIS8Emx0Y4hVKS5YV+O0aN/jjwO+dW+pu6nRV
	 Y5MsUYWmHfc2KiPZBvkoHfJzJTxkKhtIqq/wW3aKFvUGxadtXnBvnS4d3bwlRt72Nc3XI
	 X1VRO6cIg7C9rXahiIHOSJO1KaVrnpfPzAyS43TB+eLfdHO/BHpNBfvR+cOSv0ZIbTSAx
	 0aBYRXDo3DGSzJsrbnFv5pkXb+IAq5f2yNxYm+9BFaXW+ZkhkEYpKkNg5Ope6u7MTm48n
	 DyObWbTVWiB9NH0hbSi0/j4R9yByLEehDHNJsqZraLRuIJ3QRVYzSSLz68Q5FHClwBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
	b=kGmWM8x2MaqUa3zbM1X06VtQCqcdB/YnXMlcxraT8IIi1DvIxiv8enbFHShpMivNtPt8
	 +AIhuyNK7JmsDuc144rxf/BtMl/T0QLgU6yIHVRvNj3iobqzzf3Cn63Fb9aQEaXz8RYxe
	 IlRg/bxpFxYN2ifoLTxkzwkNH0/cFM2YbR6HJHrchiwoQNsVdoeXn75Q2Kc1TeVkxQ6a9
	 8ebJP3dGvbYLzZJ9tFYQYDHhXsKprJEFtyv1WOO1MipMTMYN2wh6RsjcfWwwjxDUXIm05
	 jjGim+nDASHTl05l33w9aL4LrgfyOsbRidcY+7dUm8DZxyx7VdlWklXT+qJr2T4anTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rafMftuQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F13606E7FC
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 11:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66F13606E7FC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rafMftuQ
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ab3d3c5761so34659867b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 04:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793099250; cv=none;
        d=google.com; s=arc-20260327;
        b=Vv2rq/GHpxDZfDun0Y8gqtWAmw6uMAlaRJpG+bBnME+jxc/Io9ICZf5pPF5nNiwXI3
         dWkXX3pzRx3tLKZfdkS+8YYoElT8lWDRjGiLlBhflgpgm5RnWY/r8YwQ1LkudbIuFozB
         YWyJMwiadZ5X7/Hi/a/TKZ8DHqWR2n+ZVIfK1EIEUddmNITEnUTSyCKQfyQ/I2+PWljK
         yYEm0WfFzePVkQF0TuibpSSGwLgCbihY/iA2B1bAGdx0IX6s0zKpA0INEQEse1I43VAO
         i3ykA+HTtgXnhitkKm1/+9BJmI5fJdNCnjbXT4JXjBlijcInw1AbsuWr6WWfL1bgz0eW
         IYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
        fh=88Qrz4yPq/5bPKjeoVjft39YAoIfhL9tblFG5eEOUNI=;
        b=JLvMtEV+fCGTsog9wW9osgBl32Vzrvr/dCSLr3EJNHMz67wN0cKfPyEf3XfU6bSAtR
         fWDBvC7RuFzaZFnT/1itVmutMe2YOeIzVYXVIMHix3IllQvm5nJNmWw9PAdKc3PUQI2n
         ydQtrV9PR38KQS9g7aN87sk1RrCjiLvhmjlwRlR/9xxpD2GTx20bcD0emwIpQq8538Ul
         raT2u0dC81h+y3MqyzP3eaFBPF1HLMvYiVkjd3w9tqC6hcas+vmp+S3tK7UdE3vJLnyh
         07ca0h4UtfAT5wsCazVeTqOThFZSNIdoyAmSvTy9ccTLLrGrbZfcrNjV9iPOacj2K1EW
         OFhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793099250; x=1793704050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
        b=rafMftuQv37CSy2M2Z/LH0hT/6DD0vGHUViVQ6T/2pBqq0vwGrX2YGcRoIcmcOv4s6
         SMcJucaaNjmzzPrXps1BoaeD8Cl6C9H2GHiJCPeyGCtwNwb88BNppyXDjselR1KNPCku
         8F35G64svydgJL8Y/oG0I0Ucgn2ku0SfagELKzWrvQtZM/dVV8oUvSypYn96tZr2V5V/
         3TljiEX37a9dMSR/+QJ/osJ3pzIq0OE7Aa4U8yEdUP4KFEDbACZ1edh8+h7BRtQcV5Yi
         NA3T3nYJOW1nd74KFGe7Iq5HRuo3ehWFKE73CRZdFIFfna9/Oz/9q2rknT61GvRgoycl
         +dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099250; x=1793704050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
        b=sooXFr7a5v5+RaEvsIurEK8D8YZ7190UiUeFYBK+R5ZMWbY3tv4BWCTRpDCvlmwq8w
         cY6V1WMFkaPpaF/OPvlRniaFbOQDmHdwDodHQ0QAdvJ8JSTuWm2l+ZBZrSAq0Rof6fcI
         OLlsYQwVcxpacVpju4YDt7PKowZseoAgZXwspKRmO+zxdTinmSuoT3B+tdOoSlPvrDI5
         RWwyIORfIkZSzI2it2D0CuWmZznR9oGfoFm2M9naQSxBa93swIF2momPQZumKFkgouU8
         Tq0C2W5DZR6pYJN015eSfm/ECr7bKjckAOhs4SeSkqxvXEUVPoLvXdqnYEhBL1/D5Yu3
         ybZQ==
X-Forwarded-Encrypted: i=1; AKwUvByCeoCrM/SMA3KqvJcMek+noE13cuj9wFQwAG6ahNaXJF2Dt2cI+Zd0+roKLqSy2xVCrsUKQIU52Sb18vGKSfI9OwerADM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRu6NqJLAatGE8f4E5PgpOTCba5n8T/rxWVguF7tZr0NpgCbYh
	tLRpLtk+zkiZwNIFe7ZaoESBle/9APDn452BIbHo5/LPDYN/EPbwExn3V+3cvZUni7SELyDmdKV
	qNh4h/QlNJb0nOoKq6wumfCLaDq7BYPY=
X-Gm-Gg: AYBFou2Vmc6r08fqU0C8A2oQJnBgQ7571olKOVL1mEQjPldC9EfZEFqgvOWFipbvpFe
	oBbvA5CUNFjsiw2PzOT5Qu3Qy12JET/JTTzSxI/zvi/kFR/1tHQl0hkbxPzdRcX+hNTWK/STuuP
	BdKIIgC6qYhlhYDjXHlIyq7oBr0ybPr1QkfAOxmr/qqIUo0WbgRK2WE21IzXCK2w4HKi8VmKfav
	hEVXdnmmaTQviJS/kwmPqVyXuNbZc5XuvqZp9M878d19Gz37PS31484vyNV16saaiHz+Yib4QxC
	3+tgfBfL8v3k7/Z2Fy3qlZeywSSp6TR6v2nRnqFHa/ktmVMAq47wcWNrNiq2mEzoPWGgZf1+nmn
	kW8LIFbUvQmTHTdY8HZouAbEScV/Do5Ams8YI5u1M0eSUnIm2WDMpO9WZa3EZ+mxRUdpnqg==
X-Received: by 2002:a05:690c:89:b0:8b0:e13c:2854 with SMTP id
 00721157ae682-8b1669e55a4mr81209407b3.5.1793099249996; Tue, 27 Oct 2026
 04:07:29 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner> <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
 <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
In-Reply-To: <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 27 Oct 2026 11:07:17 +0000
X-Gm-Features: AclHuK-M6AykdLUZqQa3ChCCBvY0LYTQ7GR53YsAPnqddFlyo8iJeyhlphI-4Do
Message-ID: <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Manuel Huber <manuelh@nvidia.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
>
> On Thu, 2026-10-22 at 13:18 -0400, Paul Moore wrote:
> > On Thu, Oct 22, 2026 at 6:19=E2=80=AFAM Christian Brauner
> > <brauner@kernel.org> wrote:
> > > On Wed, Oct 21, 2026 at 12:51:35PM -0400, Paul Moore wrote:
> > >
> >
> > ...
> >
> > >
> > > > Of course, fitting in with existing norms is important,
> > > > but if it causes IPE or existing IPE uses a lot of pain, that can
> > > > a
> > > > good reason to diverge from those solutions.
> > >
> > > Which pain?
> >
> > As I said before, (emphasis now added for claification) "... *if* it
> > causes IPE or existing IPE uses a lot of pain ...".  I intentionally
> > did not make a claim either way.  Once again, I wanted to provide Fan
> > some support in case there was an issue and he found himself in a
> > position where he had to push back to preserve IPE's model.
>
> I think there is one issue with the design pattern where keyrings are
> set up in userspace, that I have mentioned a few times already and I
> got documented in
> https://www.freedesktop.org/software/systemd/man/latest/systemd-system.co=
nf.html#RestrictFileSystemAccess=3D
> as well: they are trivially bypassable if the kernel has kexec enabled
> and it is signed. The security model relies on the "good" userspace
> running first, but if kexec is enabled, there's no guarantee that will
> be the case, and as far as I can tell it gives root trivial capability
> of overriding it and extending the trust chain as the attacker wishes.
>
> IPE specifically was designed to avoid exactly that, and ensure
> userspace could not execute untrusted code, even with root privileges.
> With this enabled by default, userspace can just load the same signed
> kernel image, passing in compromised initrd and command line, and gain
> arbitrary code execution on the host, since only the kernel binary
> itself is verified, and anything goes for the rest of the kexec
> parameters.
>
> This is of course not to say this new IPE keyring shouldn't be added.
> But perhaps it would be nicer if the default build flag was mutually
> exclusive with kexec being enabled? Not sure if that can be expressed
> in Kconfig though? default: yes-if-kexec-off, no-if-kexec-on
>
> At the very least IMHO this relationship should be documented
> explicitly in the kconfig blurb, as it seems to me it's a major footgun
> to leave laying around, and users might not necessarily be aware of it.

KHO/keyring folks, what would you think about preserving sealed
keyrings across kexec via KHO so that the chain of trust can't be
reset by userspace? Good idea/bad idea/yes send patches/no go
away/etc?
