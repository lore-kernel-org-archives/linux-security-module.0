Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BB33507D
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593314; cv=pass; b=KjZb6HF/fEA+mK3e8sPN49cvFJxB8P6R0LszzAzNXMSWCOmEO92hUT2YEOaGnj/J1hIH/wnRxxPKXJRGZ87nmnF7t8r7jTZVgSwV7KETIm+HV59XNegTSxYkd4sKFP9TLBWPDxRwv0238cBx9cw+NWKwqx59uV+nMbdFIGwQMDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593314; c=relaxed/simple;
	bh=s8r+Vr1ig1OhurHXWjJkYiIRQ8nvrWmPw/5iPQbFVX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovH01Wc+xE51dbD0Bi2TbE2M2tAN13Mg0iD1q/UOHmUD/GRliEmqve7zZhNgpEjwW6n5OP0Z9nVduKw2ccC6O0Pz1j+yLvmCwXTzgpeO9iCGd+QaQtgsMBbvldAjfgTWbPQ+OJ/fyLLYOhzo1DjJodFw5Q2DV/WEEjXJU4ND93c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IC2Mf/76; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IC2Mf/76"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so2393195b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593312; cv=none;
        d=google.com; s=arc-20240605;
        b=cHit1R/ore57pH0nzekJFi31kIC2y01BBUiWSzne9S3LiY1VciWj5Tf3C7vdo0qizQ
         ErOMeyjk88KXxySMfbBgx95IzBSmia37kyEFMQ2qnCliI7h5xpNI0vRzIph5wh77XR5f
         YYODHAtD+4JNnZdwkCi1n4sPOJzqKEaipDQBQzX5dFOqE1FbIZvouKAjzBfXrne/TLB8
         CIhr6d/kho3IfdBkAd1JUB1/ImbMxkSC5biPtLUxn/ryT2rrEcaDWw4kAa6YDCyAIsnz
         97kOlqQaOLtKeKHuuxrojBfFawGMjQUiPEiZOonUYmiCiRtD8gzcN/BKp7hRfXCijidJ
         nLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8nRFvW3dvzP0f1HI4A52To34cw9HB6EK5c+K6burZQ=;
        fh=3oh8n6yZpbF/YOt84yKH4TqMrRt7AB/5oV2yiS8RIGI=;
        b=BqmqOBKBfKJksuWxlNOl5r99lIMB8hMoXa3AztPNzLmLuzG5tLAWQSUb3yGgyYJ3la
         pWWg3661c03pscVIVircjg+GBzq+NYieT9B0F6vU8SvWY+AhCAgCDYH5K8b52iUUd5f+
         JgrSN+a+zB35+Nf5FP4E/HnFOybYUZ/Ejun+K43ShcxfVBehC530BnsGRWWcxSt3x2Xu
         J9sq0QkFn6mVmHYfSAKuZaWkX4D2pCjSFDRrs36yXRCYwN76DVGEh4Le1Avw8jsTVto9
         S9JphIclpyT9pECG2/nMJXRYBGhZmZc6nyq1Ua42XcBxXJitx23PZfvxgQ8/VY2QQR3X
         /Z7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775593312; x=1776198112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8nRFvW3dvzP0f1HI4A52To34cw9HB6EK5c+K6burZQ=;
        b=IC2Mf/76v9d/4+Vh6KzdO1wOwI2ty3/6KLd9aw31Jtecua/uQWbW5+nbP4siULJXMu
         6WeZ1BfHZ68bJ22X9VtLypqRXjl5TwOS05KNkt2SbxiZchp30K2/GorVjvcNyKmbIPU9
         nnnIuWJeqVhuZJmechP9u8OQX238BxxuBGR8k+bJosBBkwvg1eOOAIWdz02ujgKD2EnO
         QXSsuX0SyQ2T+plZugFMZaXTvgf8v3+ULApDpbgmCr/IcrTr3eslMgmePJRq0n+iZO0c
         pqfSpiQEmQlmb0/EhCC8SEAUleZLDhRSmcB0Exsg60oNRTQyjVLuIEgm4TsxM8845Nuf
         ccvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593312; x=1776198112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8nRFvW3dvzP0f1HI4A52To34cw9HB6EK5c+K6burZQ=;
        b=g/S5tz3QyZwN2UeW0BOSN8ZxSKFLuCkC3pbmLOS1g/58GbTpxmhYPvyO3t5O9c9r77
         WiNIYpDZcVU/FPNAextiAccd7ZDtvyXpfviKwbCVUBVKwXU0xGHEom9r2hjn6VfhoVIm
         1zSU0qsYTHKRdIksOSfiJAXrRg35y43rH8VvALhrCn86I5tCRQ85BYLCrlCIlm2Oiqce
         8NfrpgVQu40vbfc47IyDXLs3Dy7Hd4ypQfP4XPbHiJvSEn8ZouQIH90ugpSsh2f8xqGe
         Chg2B0m9hS50VYFmIGnPb+CkEnxvsc/wGMXoGspJ2d3lM2xYFmk0Jj70cbm0Q4LaKGb/
         5Nag==
X-Forwarded-Encrypted: i=1; AJvYcCUG7YNfUaZenzloLMnKUWvyDZnp+lYyM47hssSNcyi/QHp9B1k8MXJlkGSEr0HmjOsiTBoOQs4X/5+f0IbhBcRq5aXAzJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLv7PnaWupr+MxgOe3cg6iQHk5VkpB7OBstHRO/7sFk3oBrL2G
	X0qxJabPpPVZ78WQ57hIX3Qw/QqlnJtWxsz7j3tNxZkFiLI/1Fsyf1k3NGaVMxRbXqR0tNAwUeH
	yB3L1zd6EStpFsVFY4H1vwVnd6EyXzcv1P5NnJ1mbZIUfPKkHJkw=
X-Gm-Gg: AeBDietqyL+1Xb9izTzNMmFpggMSRY4nLOFayYknaLOg7JQiud2xtcVgRl/xylFkIGH
	OhH76ezijbJvIbFsJ8ztnGydtjFjWDQ2viE3dIzwQ3VPyDPqW+bZdnYZjsJSZpwuNHbr8DTVrv+
	V7p1PVLhF+rkbJgwiFeppq0Lm/iK6Hm1A/rHVoXwPqbj7p5603EAePzjpQ3QYTYvHem36S8Tkp/
	dShbyJjdpL07MvFDVkRA5dvDib3zjkoguiNZoh5wmBTj3Hr52/FXtAFnxLIWZL3mEfERh/NViyj
	YbIZBg5JCiTB/tcKTQ==
X-Received: by 2002:a05:6a00:1a89:b0:81f:4a36:1c7c with SMTP id
 d2e1a72fcca58-82d0da74ce9mr18411507b3a.23.1775593312517; Tue, 07 Apr 2026
 13:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
 <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com> <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
In-Reply-To: <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Apr 2026 16:21:40 -0400
X-Gm-Features: AQROBzC_mkg1V6Olu64dm2ucorBxgS86oz5XW-KOWVbdzobSFYHPihrj_73P3oU
Message-ID: <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 3:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > The existing SELinux security model for overlayfs is to allow acces=
s if
> > > > the current task is able to access the top level file (the "user" f=
ile)
> > > > and the mounter's credentials are sufficient to access the lower
> > > > level file (the "backing" file).  Unfortunately, the current code d=
oes
> > > > not properly enforce these access controls for both mmap() and mpro=
tect()
> > > > operations on overlayfs filesystems.
> > > >
> > > > This patch makes use of the newly created security_mmap_backing_fil=
e()
> > > > LSM hook to provide the missing backing file enforcement for mmap()
> > > > operations, and leverages the backing file API and new LSM blob to
> > > > provide the necessary information to properly enforce the mprotect(=
)
> > > > access controls.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Do you have tests for these changes showing the before and after (i.e=
.
> > > failing without your patches, passing with them)? I tried running an
> > > earlier set from Ondrej but they failed.
> >
> > A few months ago I sent you and Ondrej some feedback on those early
> > tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> > I've been using a hacked up combination of the existing tests, some of
> > Ondrej's additions, and an additional debug/test patch to ensure the
> > labeling is correct.  It's far from ideal, but I didn't invest time in
> > test development as I assumed Ondrej would continue his efforts there
> > (unfortunately it doesn't appear that he has?), and I wanted to focus
> > on getting a solution as soon as possible for obvious reasons.
>
> Ok, I'm happy to look at even unpolished tests - just want something I
> can use to exercise the before and after states.

Hopefully Ondrej can provide an updated patch.

--=20
paul-moore.com
