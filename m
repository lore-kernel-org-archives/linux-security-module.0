Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168C33509A
	for <linux-security-module@vger.kernel.org>; Thu,  9 Apr 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726241; cv=none; b=GCI3Y86WA5/+4UHROOGkSp0ZuXpZljOVf0xfP2Wg5VSRgBGDxzKt9qTy5dYVs2J2ovB25GpLBqqRI5fRocu5vvA6Fr99AGuZOZjOkzWybzKmbUVEVXANQT4XiP+nt6M9k95FYl77wFhGSJwntSvHRZKN9Df3/zfi1TwzNTISEIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726241; c=relaxed/simple;
	bh=nI3PY2U+NLmKCLed6WuZA5K6L7ksvUfb+p4DaYOUmTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXUoP80xPzncE9iiBttAiWMVpJAxb8FbL4YyYaomPivkvWI5JI3SjUesPq8erNEZTD1ZNfPToHtV94T0V88bNiDOgQvXnSW6skQzW4jGXlu85PvNWPBg12ExQf9HcFgmkBZgZgGseg11+TfPClAobqejeTd1WGhiujlDgGAlQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fb8RXS/y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fb8RXS/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775726228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
	b=Fb8RXS/y4aSReffzZL3nvEE5PLpG41gJMEtWGsYTO4CmgYNhtmjknWsQ5y2BBtjON5k4pq
	+b3cE5WrC+Dyd/i6RmQahh5u0Qb6+gc0RTYDk1qZhRQMzMkzZenSdXUw//DM8wF9japCMs
	iUkM9TBKNEudyQCtzWprl6YRbd8d2HA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-iKa0YfPFMtCp62GT0-xlOw-1; Thu, 09 Apr 2026 05:17:07 -0400
X-MC-Unique: iKa0YfPFMtCp62GT0-xlOw-1
X-Mimecast-MFC-AGG-ID: iKa0YfPFMtCp62GT0-xlOw_1775726226
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2adef9d486bso7130735ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 Apr 2026 02:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775726226; x=1776331026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOFN+O8LoAuBnttisvbugWhgm03yTpszy9FkfI9dIFo=;
        b=bEjbCMvwluxUAGFzvtH5kD9mp22Dj0zq8QUJlJSqdzSh7E+0MMjitlThQ0+0bnoMn/
         v9o3Nt9eIF69oj1rgcuAHzU6NMDCbnEnFhgrkU2dDDMkTbCbpG7QVcpQICsLDX5+Qgaq
         KM6T71oP83H8u14EHcFIMV/Wd6vYCDNn6seyYnG71+wHOGbhpM1aUeY2vs8fJCr3thoJ
         LeUou7tnpsXBFHf1EH3uOrMhB+tVN3YvuincKxTh5H+ry6P8YhpsgWihZgmvVMmpk8Rk
         YgV9vjsLBMyV5t1MP4rDAdiY3SHrP4leBu1WTgLl++TtqePhBaHyx9UqBEJJxWVHvrap
         8heg==
X-Forwarded-Encrypted: i=1; AJvYcCUAvcsOh09Cd1eUHVHd324pxBbtsI/bqnjQQxn6vd9ZActiopWmJYGWhlYv13ZvdMP246AqvpjvwtadzKw+1eEeigKLOTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/icLCkX886/7i1vgq3gc8bYMUatBFRuvDHNUBiq4bxKLPCo+n
	Rkl3BwE0L2ih2cPVWfGmOeYaslfperHDKooEJfSmhtmMgmovASsHtscdYmhhipfOxRKvkdhYTSS
	P+oWRKyZ9Yvude09OiQgJUatHb85mtKblpYkcij+I5yctDyiAu69azOdH4Y/iFmDPWI2g+F8SQA
	Rx2DFJJQoidWjn+8cdh1tK2ZZDIn4UYAnHOnP0hYJoFTY5g7+FMDsS
X-Gm-Gg: AeBDiet94I5ZNmQVu6zxu6E89c2RaH0aV1MbFajlVV8xkxaxTY3sjQjmJ/HA6/IYPVH
	ts/Z4rdN/HSFev3rke7D0Rcrfa/58la+uaZmjmamktv768CNeU8t6Z6UyDRKk/86Irm95uMqvPc
	7lxmHrg0Jl3Jbj2udCbLU55RFDg1hjiWf3bW6n6H6xVHtf5FHF0WOEmSxCz452KKv99/BLAOVjr
	/TsLQ==
X-Received: by 2002:a17:903:4b46:b0:2b0:606b:6fd3 with SMTP id d9443c01a7336-2b2c72d51famr29334145ad.5.1775726225913;
        Thu, 09 Apr 2026 02:17:05 -0700 (PDT)
X-Received: by 2002:a17:903:4b46:b0:2b0:606b:6fd3 with SMTP id
 d9443c01a7336-2b2c72d51famr29333645ad.5.1775726225399; Thu, 09 Apr 2026
 02:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
 <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
 <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com> <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 9 Apr 2026 11:16:53 +0200
X-Gm-Features: AQROBzC2DVx5qKVA4ihG0eixfkIbnn_9pZw2Pb18PXvqySFVij5lkBTtbkuLvjk
Message-ID: <CAFqZXNu3t2G6rUDToAH5CCRkHj-n_RVF4L51cmg0J+4W6T4D6Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OmpXV-7Z61RVXpON8qLlw6VXiHBH9An3YXAr1mtfwgc_1775726226
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 7, 2026 at 3:20=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > >
> > > > > The existing SELinux security model for overlayfs is to allow acc=
ess if
> > > > > the current task is able to access the top level file (the "user"=
 file)
> > > > > and the mounter's credentials are sufficient to access the lower
> > > > > level file (the "backing" file).  Unfortunately, the current code=
 does
> > > > > not properly enforce these access controls for both mmap() and mp=
rotect()
> > > > > operations on overlayfs filesystems.
> > > > >
> > > > > This patch makes use of the newly created security_mmap_backing_f=
ile()
> > > > > LSM hook to provide the missing backing file enforcement for mmap=
()
> > > > > operations, and leverages the backing file API and new LSM blob t=
o
> > > > > provide the necessary information to properly enforce the mprotec=
t()
> > > > > access controls.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Do you have tests for these changes showing the before and after (i=
.e.
> > > > failing without your patches, passing with them)? I tried running a=
n
> > > > earlier set from Ondrej but they failed.
> > >
> > > A few months ago I sent you and Ondrej some feedback on those early
> > > tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> > > I've been using a hacked up combination of the existing tests, some o=
f
> > > Ondrej's additions, and an additional debug/test patch to ensure the
> > > labeling is correct.  It's far from ideal, but I didn't invest time i=
n
> > > test development as I assumed Ondrej would continue his efforts there
> > > (unfortunately it doesn't appear that he has?), and I wanted to focus
> > > on getting a solution as soon as possible for obvious reasons.
> >
> > Ok, I'm happy to look at even unpolished tests - just want something I
> > can use to exercise the before and after states.
>
> Hopefully Ondrej can provide an updated patch.

Sorry for the radio silence... I just posted the fixed patch to the list.

I also pushed a more targeted standalone TMT/beakerlib test here,
which also tests the dynamic transition situation:
https://src.fedoraproject.org/fork/omos/tests/selinux/blob/overlayfs-mmap-b=
ugs/f/kernel/overlayfs-mmap-bugs

To run it on Fedora, it should be enough to `dnf install -y beakerlib
selinux-policy-devel gcc` and run the runtest.sh script directly.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

