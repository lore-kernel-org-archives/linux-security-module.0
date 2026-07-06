Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D12D8391
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2026 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357297; cv=pass; b=GerO4Y2HB5mMP4Zy98oV6c/E4gXt2RrhTkgHXLBK1/Aa/siXmkI2zNE97PrthmwHDwZI2fSsh/Igx2bxqNzILRtlWRP8LClmuDd9BhbgELErbZGQwPu3lo3YYedQq8yxnj4NBF2yp7+a6hsPd+YzSMCkbjsoChRGXAClgQlA1EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357297; c=relaxed/simple;
	bh=/fbiPozIgE/BcMKR8ypJKRnzXzWLVslZg5WE58Fd4gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWL58hmWK9KzipHG3EyZFnlM70bhPM9x9sMI2Yldm49mSHzjD9jU4sHMkLqsuviHMFcf5tdDe0GTMCiY/unVJZ3v7LkL/lY/lZOofdX8vKgTmOWg2Mb0EYv2Vknfb7uJra0/nP71GPADCWQ86rLOcYezISF1E8dvbuGubZYHlzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BJrZT5L4; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BJrZT5L4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ca70925c25so41646385ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jul 2026 10:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783357295; cv=none;
        d=google.com; s=arc-20260327;
        b=OdjPN0NHIk5aD0tkMI2aIguuOHVzJ5l6R7+vYjrREnG+ui/MLEs9qb0t0dvU593Knk
         f7tijFGCHfmtFFxFAWb/QS2BbQrliVrQJIvY48vqr68GQdrMdj3MwJgdRzfMqNOYsbrC
         88xN/ST1FYR2qrYQ9NTKhttfMdbBQtDe/hPJGyDJmQaD7ictglEncwS5lBGU7CLPgFyb
         8isZy4zfxyhRY2WCULYcfWLXRg1Q3UNZOunVFMXsgSHuwmFCIUPSkwPekH2c39ciHBxu
         PkoDQO3IW5HjG7BTB8bsBjGZO1SoiiT8sZrufZblLqq01fZsHH0wpeHs9RmoTtaVSXDZ
         Qg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zq2b1QVorb+bhiFECEfSOsi7qpZoF1nziG3KnKBTCwo=;
        fh=7A4a0SpM1XuxgpZcnneq9oIz0qDcGBioMc3Cd6I4OXE=;
        b=AZ2Y2ff2tjhLUH44TcGrCD6tZb4Eb3xLmuKMUDGfBhnaQAZgiLYOon08Huom4ouPTo
         Bb3cRmFpFWmPmqJGRf1dZ8aiuAL4+OwAiR+6rSY5K0jY/ALsKUJr6jLosC3E3vRB6f7s
         nrfThd02PJvWlDOWJNJGg6hA4xNgXjL4kM7ipRL5UMZe13E6dsWQS5FYPAGuQzRDI4oS
         wSYr/W92gmX3yetP7TUHZ502RKzAETiN2IiVKE1wSUQjJAx8SN6ZvYoiXVFWf3wZd5E8
         jQY4urA/pgvtJlSMvxIhw4exyHy8Z4jwV5boNGrHkYQLJwQoh/3VKxjzVaMkFRJ9dOxE
         IZdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783357295; x=1783962095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zq2b1QVorb+bhiFECEfSOsi7qpZoF1nziG3KnKBTCwo=;
        b=BJrZT5L4kB8+03O1XUB065bWaMO6CeNpCHtMAPoW8aMEgEncyMUoesoamFJAzo6/vr
         xzFX2EKrRK/h1VpYHmxo95Z6xAt4LI6vU5Gq3nLhekeolmZUWnmdD2+sCYDylDZfqh5M
         ef40H339QSNtrNlL9Zu78iR/jAevuekNXrQeZjBmko3u4f/ycffJa++AqYP/ZApFPja/
         S1xxHq0bYnjdr1w1JLjP2ywC77Ja9+/rt2xuZk5JmcQn4L+pS+AHbpfxthWxT5fSPbH1
         LVdeJvf1PgP0w2/2UJI+L2pkYV7IT6zuoAxUwy1nPhkVmVl0sZOePgCyfZXUa96gISR2
         KRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357295; x=1783962095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zq2b1QVorb+bhiFECEfSOsi7qpZoF1nziG3KnKBTCwo=;
        b=Fjxa9dTr8w35ienWAYgdmXl5SgpBQyJNhbH/FLPod7LKnVUwPxKJPH9ePhpbfh3oyt
         emLL7j0+oiy75psBjmnAzngdPV4EmHkwRy86SdlhsnjewpRvPmoxCpE5MfIBZUV/a5Uw
         DAEZtKfkHpANy1aaODWH6Tdm4qBzQy0uPqERj6R2GVMaba0AJyU6ZQ5MbGuKrpyRJN7o
         W6yCmF7EyyM2MaXt/SbHUiwGD6mcceE/c3n282+B9qsvGo7ST/n8CB6JXcwgMc2DO16F
         wBSmwcPUw3g3V0B8dcCw/6u9MknkFeyiTWSCvkyMU1WGuEYwlefGhh4/7/5gId7L9Jnr
         04kg==
X-Forwarded-Encrypted: i=1; AHgh+RrefM9Ztsfjy3MJbB3H7hkhYReP3UuL8BBRq/meTh3tqVu+8ujrUYFAY1x8AlD/afPzGSOWar+dl0MMJaVvdLm36PAQ8lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8DRWpcB2IOvQzOXhL3zDaJhYLZSIDubQlDf+g0E7/238kLLX
	AwuU0lif7ZREEvxJs7kmX/u4V+jhJ52mlhPcOUjuDdo8/lMV2nl8jcExQArj72p7mWb3jETzUP+
	9+xp6NZ5eHNT3p+7+45pnDb0otBtvvEqw1UCAM3MD
X-Gm-Gg: AfdE7cmVFFgkl+cymP7ybG1NxptOTPd71YGySdyhdkdYbJcD/hRb2c8swKoL+qRL3am
	hWU3dkUFQV61DDlZgNWsL2nepy9hWB/PHjI+zcgPMVNSfxLf5Lzg+1elqmrN0bejcJF5frklepj
	3FvAnn7UpYJdUUBolksb8rtTio57krLp5tXk+LkQhkaSYTos7xtslzWJCWMXhr4hXvy/CDWrSlw
	phVfnJnumuG6QZ3RYxXoFpwy5kceSRaTsJ+d0J+UvEjZ1098YtVGTX0G6K0jjql4TYD39yIdyMa
	FLqAZPY=
X-Received: by 2002:a17:902:d58f:b0:2c0:b6c7:2271 with SMTP id
 d9443c01a7336-2ccbe607239mr17075695ad.4.1783357295265; Mon, 06 Jul 2026
 10:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702143605.252797-1-daniel@iogearbox.net> <20260702143605.252797-3-daniel@iogearbox.net>
 <CAHC9VhQD4RHsGiTMVCCTN+eB71-Ueopke8XghExpNJ2PSNa_jQ@mail.gmail.com> <DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com>
In-Reply-To: <DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jul 2026 13:01:23 -0400
X-Gm-Features: AVVi8CfE0QwDBed6yHQcGtrwFOqh1sJ73kXaa2-AIzBqCn9zlWXgtMH2cudzbRI
Message-ID: <CAHC9VhRk=j4_cNH5v+iCvSpJXz2g=dTK_+1O-kgT=E+OESENiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Verify signed loader metadata at
 load time
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, kpsingh@kernel.org, 
	James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com, 
	memxor@gmail.com, torvalds@linux-foundation.org, a.s.protopopov@gmail.com, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 6:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu Jul 2, 2026 at 3:05 PM PDT, Paul Moore wrote:

...

> > With this patch, even in cases where SELinux will prevent the BPF
> > program load operation, it is not able to do so before the process
> > triggers a potential sizable memory allocation, opening the door for a
> > local DoS attack.
>
> Not true either. Worst case is 1M which is 8Mbyte.
> Not even close to anything DoS worthy.

That's 8MB in a single allocation that can be triggered directly by
userspace.  I suspect most systems allow a fair number of processes
per user; that 8MB allocation can quickly multiply into a big number,
especially for more modest, non-server systems/VMs.

--=20
paul-moore.com
