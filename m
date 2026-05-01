Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C923FA5E7
	for <linux-security-module@vger.kernel.org>; Fri,  1 May 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654387; cv=pass; b=d84LmxTOudtil1ifP+VfMFWkXc1tigB7YgJkO+tUN+Jq+vgI/CNeMNgPxZ29kvF5XX3SN+TRowldTZ5c/GzEcgdsjJH+3ttruHiW3B9SleezEtmcGTxT/dkKaE0Z8gJOHvcyEgII1k0OKzdKhUNAljo8iHypSFJoPfSMyNVKz5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654387; c=relaxed/simple;
	bh=WSrgqxvCEtEbSAkkq6kSmJHoDqoYrXnYhDZynqlvszA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh8uSJO36mDSm30BS5PX4tGrAqyWB/5Ho1i9Dy6Xrel+iVLT3Cd/wXo+Tnp+h8K/Cyl3osGdK8+95CJk99sdju9WmN8fEvs/51ivzelVv0sNkgNsZHSig5pS+g4LTcm2ZbKAAfFoIDKqP8MkKizwQybMmb219w+CoU4wZO8P6tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzJE3hvT; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzJE3hvT"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7b248750279so21912807b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 01 May 2026 09:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777654383; cv=none;
        d=google.com; s=arc-20240605;
        b=jyI67kgvF2uFmG+ATDE8EMXVWT958lfcv4E3OSAhSP40gjrU772tJDkz4q0Bvxvcxj
         40mgORM4Ruj6qG/sg9i6RfF+WR/oWC3TgO8UgpSN/29VDHHmxnQU3P4x9gFZWUiU+K5F
         l70d/8LeJk0/qNLOiDbhQizYzly76fV0jouYc6yAEiiEGVm5eVpZZL1pWL8WeA8UBtpr
         INJHTjyx7+ZBJFw/kMDyprDsxjKY0hnImNnTCl1nlcqZFN4woOFy/UJVt6SBdagH1iha
         HRJoOBfiQWX4ks8njtNm7JjKL9Uiau0WUat/EgkPbDnJxyfa+TQwcHKstD6097Q723zb
         ZClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m2pmJ+PIvMF9iZdCIqPnjJW6ZghDHC4WOLVBAyACT7E=;
        fh=B86MDnoemBaTe/b0MfTFPwUMVvsRZB6blFpAUT5kgbQ=;
        b=LndBwsJdbbTNwNSf7zFdaf6B3+rftdGDynIU8GlTg3btzENhOK48VRpfgvIa6SYMaX
         C42tSZDBSN/daCBPOmukmgfhgb0hitNoX9IdDG0S1NZBio0TedG661Nkf76hvQj4uyBv
         dPHwNEDjrs0Rg62sXi5dNwFkmf7N4MPWkpeF8LDgDWAt+m3Loq3eCasMnP/YVtxyE0d3
         PaRZlwLyLcWMmcGyjrGCG7AYwt+vPppd7wXGd7dJCjE09mxGjQOWjcgDJtls1XX+GM2Y
         qMh0EEGKp0IDKJjKYchXIWLYIghTNZ+n7uH4cKom1BFg0MyndNDsuRT/Ka2QS5ZNvhiR
         r2Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777654383; x=1778259183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2pmJ+PIvMF9iZdCIqPnjJW6ZghDHC4WOLVBAyACT7E=;
        b=GzJE3hvTLQj6cb4ENPG1LoElqZx2MsBvO9nZTs8EUJTC37sZjromNUT6OcGnb+ddc6
         d6PJxhHiXE1SeyQkrxVQ7Jrs3Uepb66G3Z7GMkwd3kbmBDNofuoh0rjaEB/rCMwPvYvu
         kj4aVzo7VEFqXzzwhDAlF0lCnuJ3sUFJZGlol7m/aKk4cggYoIthHeM6a6U3weq5F/Xc
         f3i1TfUTzi6F+GTMZ4+LAHwT7k0o1PbjI3a8ffHgbSTdpfS2p0tWxhjveAXU6CPrGkXh
         BHVLWXYfIh8Rv/FKKbMwgiApRrHyRj/IlSGwjyGzn+pzcvK1tsH04IdSYz1nfTTun8NJ
         pIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654383; x=1778259183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2pmJ+PIvMF9iZdCIqPnjJW6ZghDHC4WOLVBAyACT7E=;
        b=cRU2q3Afx5Uw47uRG5UK5yln+ozu6eX8XKFZ7tdI12CVOIOMC0rjlfwojcGptbih8B
         t9vIYw/D7DOKSZ4+F4O/5oT0Fd/M7bygMNXO2icsk+tf2YGNjB6MCX3wyAHd2V6cVJDv
         C4kYDoSRyXFjQT6xx44QFnaIK3Zblq/aIzaQKZepUfiiExC/0FL4T93ifW8M6JX1IyA2
         Kthf+mNW0SZBoKN6wQH2gd/s83icdM9GlLJxfh6WQKAFMW5DHdveQLkIVknMpvS4Y3Hu
         /5SyeeEPmb0PlFpBFWVM54oe1Ag3+hyw1D0RF4NgnRLgFbGYkkCZv115FPdZ8naDbS19
         pGYA==
X-Forwarded-Encrypted: i=1; AFNElJ80Zv82UQ3oljKnFApzQ3eLnKbvf8mQUO9we7++JSap9pYNvnwdaF7UpejQWYuoUgqVtop2srGmr1Wl8WoUql/x36zfN5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIh7yTM0utZUlIq8bT7SHU6Lc1B4KX5FwPdyqeRzH1bNktWmh
	YQJxUVOIDm+8CSsX5sz9wzaTYguAKr6av+s8e5qcAdWZ7pp4RAwSyUHDf1e1ObLk6+q4XD3VAvV
	hXnhU72mzuAEPkAgkGfu6PDouglpBong=
X-Gm-Gg: AeBDiesdiCZrtrl2Dxk48JPosay2UxMO5nGhFB+vw5y1jFfPBszMGSEwmLF6QIrpvAr
	YIFcavXOw9NWuxNRaCiY/QtHwRtGOwUkCywd7P1SUMm8BK3ZQKc/BJRwqfeuZLl0o8zlCn124Lo
	SD4lLPre9bV1lZ44+T9Zs2TAWN0A+SArnudseh3hi6znlJBgAVMfsuFxgwaSaGL7B/h/Xh7RB8L
	KiI/zQcBDJ1w8sb0NnEla4x8YdOCeeSvUGDZRQxjBBa3qttsRoWkdfS3zbrFKUM2EWW3hHlfVWg
	z930s4pZXUG41PROcXVQMjU0Ptrl0m/Pz2YRQ8kAljfqy1f6VuhROgxAkJ68KxWH6B8bt4POxah
	m4KY+XG3Xq+/Ld7AGyjtY8X+OxYe3p8Q=
X-Received: by 2002:a05:690c:c4e9:b0:79a:b1e1:49cd with SMTP id
 00721157ae682-7bd77126443mr1403037b3.33.1777654382869; Fri, 01 May 2026
 09:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777036497.git.noodles@meta.com> <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com> <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
In-Reply-To: <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
From: David Safford <david.safford@gmail.com>
Date: Fri, 1 May 2026 12:52:51 -0400
X-Gm-Features: AVHnY4JVldFvGpRy8AVR9UIjGcDa3SwPwwl5jSipOcT4G7P3qCyc6tJtsxpRfB0
Message-ID: <CAGWfHUW+AX0Hpuw5Vr5iTSaJKQJ+O_4nWWmU1UR8Z_3XFctHZg@mail.gmail.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca, 
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
	sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 5:43=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> > With above change I confirmed there is no meaurement log
> > between boot_aggregate and boot_aggregate_late except "kernel_version"
> > But this is ignorable since this UTS measurement is done in
> > "ima_init_core() (old: ima_init())" and it is part of ima initialisatio=
n.
> >
> > 1. ima_policy=3Dtcb
> >
> >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate
> >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate_late
> >   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6ae3d3=
5cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
snip
> >
> > 2. ima_policy=3Dcritical_data
> >
> >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate
> >   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907aab32=
61194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 372e3=
12e302d7263312b // Ignorable since it's generated by ima_init(_core)().
> >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:00000000000=
00000000000000000000000000000000000000000000000000000 boot_aggregate_late
> >
> > Therefore, init_ima() could move into late_initcall_sync like v1 did:
> >   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yun@ar=
m.com/
>
> Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to move the
> initcall.  Hopefully others will respond.
>
> Mimi

I have also run with this patch on a number of bare metal and virtual machi=
nes,
running everything from default Fedora 44 to a version with everything turn=
ed on
(uefi secure boot, UKI with sdboot stub measurements, IMA measurement
and appraisal enabled,
all systemd measurements on, and systemd using the TPM for root
partition decryption.)
I too see only the kernel_version event between the normal and late
calls, if ima_policy=3Dcritical_data.

dave
