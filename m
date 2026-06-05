Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAE165F16
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2026 02:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628042; cv=pass; b=r1yenT/xGBmJbxLc//JsXqP2N8LrUiYK3vQJSvIbtTbIo+MllOOW3MpDiBgDA/A2fqRNEVQ58iBJ5YOUayvDBp+8kxKIDYpciIawVC0G+2Al6N//Nthn1v8L8YRS05IRoM47DwVmwHlweXp/i9SuwB5+a5qzhOIdMzNy19rtSHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628042; c=relaxed/simple;
	bh=ME43NpyRYHdtufwk/rMYavSDkIRCYV716D75fzY8bgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwDwo9pJFDbq09Yz7efCv2UeX0cXl3456ov0vZEKMKlIOivtqoyO04ZG1lno+l7m4EJ/X2LowfDVuRrV/ZSSkzR7bSc7xfK9kjn9bp+n+WE9cW5x5AsQ3iYhRA3fRU1+WuMY/y+KiiaAw8hrc5sGRGAKzkdj3033yab9ouTy2EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AbbeEFJU; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AbbeEFJU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c2a68d01so9802825ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jun 2026 19:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780628037; cv=none;
        d=google.com; s=arc-20240605;
        b=CnoedX7RpXG0Aknbgmr6ycQo6pGUnoWfeFhfRWiQBBwgjTNN81HY9MJeKkmNGiQGkB
         uBjsisf7RzTPD7BR8MxtpAV9WN5FM1I4u/Zx6M3hXbCENA48EEPMME5J8JwXja97Z9fc
         7mCdwCSvEa/pwb+eQHn9eFfKD/3zPxCkABKGNMI/RbXLSMqaDvKLD3YXNn6br7/erFho
         OVEz4ZUpjJemyWpKeOqBfQwRtouVkydl2mBjj3R5+6AqU78jYoieWCTq5Xa7tdFbFH5E
         YB6nKK5Dz0qt6Xd63dISirJeYZrFcNUXyJ/9PTrgaZuWk6T3kxb+PIWAo+iplpNMhAxz
         CMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zVKdyiFZUuhwgR/wN5SQI+AZRhERkIUiyYokvuYk4uo=;
        fh=/xaH0XAXfxmZ3p4tN06SRmUz9b0W7YCNeLuwhGO5uVM=;
        b=AqQb7VR+qyK2oCaUYmDCCYJPM4ImWXd36IJ8PcePKP5A8Ay2iqlUxmVlatUOU8jN81
         scUYtw1MHPrIYm2lv5FpmA9SFQdk9V2r8FAE/O3mp/Fv98FnxaMC7nmZM4Tvk5QQixzQ
         bM4xL/cmI1gOhRya2m0fAJbmxTd6RtskQ6Zehy1GZXHy9byzWN6a2x+DRE4Y6cZNtAOF
         SI+T9XfhClvSaa/QPH9G1saMYICKgJf/ZOKFBRWbdRbAFCZcO0qx+ybZyza5JNlCmAEU
         Np3m02LCqHntozpTP9cv21noc0UvwHwqO2KdQn5bvmETA1Kf/m4U36SCK/GuWWkxzWv1
         sjGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780628037; x=1781232837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVKdyiFZUuhwgR/wN5SQI+AZRhERkIUiyYokvuYk4uo=;
        b=AbbeEFJUJqAtMTEVvCxsy+DkX8j3uXUg+GDc3FCMPBgL/3MjTyjXQA/46H3WZoukwf
         Pk3LBJMjgby5iJLdzR97iq90rUBGv1pUhUVU/WpDFR/KB0rAhhoClMhTIzRAqkQi2gIg
         L/ujM2v6mPLc+mZd+P/gzlLGXvP7hIAgUKaFLKNbcrRmZttZWamNCn8Fa9jGvs1tNwTx
         AyRfCHYWpTvmKq0Ffq01XSiipgCw3OldNFGKKULzpQn3XiRndOAkrz2Ckgcblk5st0Dm
         hK/wqwr06MVs3rV3eA35rTGR/fWsFK+Od8Os5VK9NOEdOm7/7hE/NPiJA/GFub5LPr5A
         yQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780628037; x=1781232837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zVKdyiFZUuhwgR/wN5SQI+AZRhERkIUiyYokvuYk4uo=;
        b=BONnmDwg0UI6avBkKwpXXB/Qyt1wqgJ/ilIvdrTeCMUz3N19HOYkdxZrwhbZoMBFff
         3c6hkmvP5RDXLl5nwdM7vdxz4viaoDyuyGblmRGaBhHPvNXVXgg14ddZUiLWYzadBEG+
         B6dDntwyyroald4nE0j9G6CwEVoC+PBByjVcnn9494AaZ3eOAw42Ixl3rkMkVwKT0jjI
         JiK2dsAWMgDhXkwm7FyMtEqzF32+HMp6Wz0k+9l8tSory4ps5DQB7JQ+/uzsJsU7s5kT
         VZCVoqIaXs4cr9O7wPu4YmsTLi0tEOMsTiIv4w5pGBJhlgUBkMYhjoFJD5j7bwQWzO1O
         2pxw==
X-Gm-Message-State: AOJu0YyUh5ACNl5LG59S7FjSKlTTjdKx/FuUvA1+d5FSJF90XYbkYVQR
	hthIgbOz3hHI0f80BPpiZgUUrud4f5tw1NFV86FVFsL3gB63rGmVuoVqjIqG+Yolx6t9k2VHLBO
	C0rwbDG+vcbWickR7S9PlH186aEgO6DckntciTr9m
X-Gm-Gg: Acq92OFifySFVh6VcXuscx50atrHCwCpPvksv/nY+9PFvLTf5L9jsVWmNDZLoi3E1NZ
	1DqVMFV9Pv8JgzhHTpCAsUsOkbFB9fz7YQjOoRLOV399zt0BAJzWARIoauOx6HoQPvud5MIfJVL
	c+mjPUHjgLf2a+/Q7Ap4xiE0BPitpGbgX1YXxmgAq0mLaKEKsDEQ10Gc2jKKteGFiLCsENvuL2D
	SyO5rc4u4NcBn7QoKDf3sbR0GKDI98NczGb87NOlKoweoPi6GJrlv3ZxXUA/2Tbv9JmVztN6ZUK
	LUPqL+w4jhAVKwH2ew==
X-Received: by 2002:a17:903:3807:b0:2bf:281c:d2d3 with SMTP id
 d9443c01a7336-2c1e7b073eemr13561925ad.9.1780628037130; Thu, 04 Jun 2026
 19:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83f77b2b-8c00-424d-b6f9-b044e7ea1ee7@sirena.org.uk>
 <CAHk-=wj6CtZS9hbwFjQcoNkPwQLoyKmk8czaBF6=bBOCYuXEUQ@mail.gmail.com>
 <CAHC9VhRX1=tx4+arzuH76kirYFFJozexa5L=41Bb2QbgWZXOkQ@mail.gmail.com>
 <CAHk-=wj_rtiufEEVudMCSbh86HYrnmEa9NhYfKeWHs1SOzJVnA@mail.gmail.com>
 <CAHC9VhRXW_kyWXgYBqW3K-jSr5yN9wp1EPos1c=BFmiebxLiUQ@mail.gmail.com> <CAHk-=wij4nkMRcshzEGsxvjwP2RBQyaiQ4-vQrYTOqvQusxu9g@mail.gmail.com>
In-Reply-To: <CAHk-=wij4nkMRcshzEGsxvjwP2RBQyaiQ4-vQrYTOqvQusxu9g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Jun 2026 22:53:44 -0400
X-Gm-Features: AVHnY4INK8NtMj-R7SeMSEzhh7NqBFWKeHLFLV-z5CLbKKoFGl6DKtLxUhuZ0k0
Message-ID: <CAHC9VhTsqVSxog5xZm994kUDa2-LgAQu7uaLyrQU2F11J7ZuNA@mail.gmail.com>
Subject: Re: -next status as at v7.1-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 7:19=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, 4 Jun 2026 at 15:23, Paul Moore <paul@paul-moore.com> wrote:
> >
> > While you didn't reply to any of my comments explaining how Hornet
> > works, specifically how it ties into the kernel, I'm assuming you've
> > read the overview.  Can you help those of us in the LSM space
> > understand why a BPF dev's NACK on code that lives strictly under
> > security/ is sufficient grounds to reject an LSM patch?
>
> Honestly, I'm not competent to make a judgment call between two
> different models for hash chain verification, so I basically *have* to
> go by maintainer opinions.

I appreciate the explanation, thank you.

I'll admit it's not particularly satisfying, as it doesn't appear to
identify any specific failing other than two groups having differing
opinions.

> So that's basically where I stand - I've seen disagreement, and I've
> seen what looks to me like reasonable push-back, and I've not really
> seen the LSM response as taking it into account.

I would point out the several different attempts Blaise made to work
and compromise with the BPF devs before Hornet was even an idea.
Hornet came into existence only because the BPF devs refused to accept
any use cases other than their own.

Regardless, I think that's about it on this topic.  Thanks for the discussi=
on.

... and of course the invitation to the security summit in Prague (or
any future instance for that matter) still stands.

--=20
paul-moore.com
