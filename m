Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247F312831
	for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666962; cv=pass; b=bycXU2Z2qrji0y8iDo4GzfhVDTAcccQyBsFmGEXSxo+RLnUXDF14NQKzTCPAuegWPAaNCcQMZEDetjsCmeNCZRufwPxRdI4hAjH6DYuMjm0F6dsjnf6sf92T6M3Pd1/Zq8C3WNF2c/VqEMLppPVVsGabHcN8YGXx60qNQ9Awetw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666962; c=relaxed/simple;
	bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyr7Vi7ca5FhlQRMm4+QWlWOTcDoGyILVOQFwXMUgXXFgYk7dQWjXQA4290ssf0DJA5LWMG2CgYF6QGNegxgJFIpNq+Xtpy8C47EZiA0gJ+LfEIPARCqePTgPpOMan7GMhV2j2WIUfxM+Mdq0q+5iso7R3OdtDTj7SvqUy+zexc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJLKBMn+; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJLKBMn+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d3b440b97aso107435ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 07:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787666960; cv=none;
        d=google.com; s=arc-20260327;
        b=NeOaL2Pr4SM2QbAbirertYEiGPUk2lAYtVbhFHrt3uoGxloTryaMrwV0JHe0z9+MQr
         RdDdLJdLcn3aqns9IAdP9nz8lgQurFt3X4XqH2r0Z4pooeagyi+ltWRfELXz4PiC/Frf
         WtAn7eFESmCIV7iHmt/PbLcQgzXjun8SBFPVPWvjN9F4Q1OfxOLCWtXCr0vYJLm6TN4t
         Wc0Jdi5pQiaISEHfalgvoegbd+HTjk2FNGSxuko6lhKcGyCEmg3eDROVNT8TnFr9o56V
         HNkln3Q3s8w1E01O+le0YI/Y+/Nk5q0X8hyaP5ew81TLPx2bZBPuAgIgXQZ/626oD6dC
         NY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
        fh=QvN5H3NbYhk8WLBD4Dik2RuUMhSdqFVajin2eRQrw6I=;
        b=UsTKvfWA7nrb0wnCq064KQTjXRkavcGsbC/XdYX9mSAfqpMo+wgJBx/q0lMxbINHjq
         yS/kUEtMZyzKuG4wQud48buu73LlHjXpLSvLcy0Njsgpx4AJas4wyRj+EDnL4P/9pqK/
         QtCn7fPpKj0MD/aC20iWIalUGeUiufNBw3pNDDWGNgu3Vd9kHFfsrUpyg+IpX7/QgExb
         0/c2ru2EfOZv3yoy5+QHfyGD5KX5zKASoFyjp6CZphRWSC95RXpKWoEcV5B15doSdFih
         kbDBHu0F6m5ocwJcI8FL46jz3olI9sdAaBzDhgi3pkm9dAOX6fKMZdrqcE2l9KU342IP
         +krQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787666960; x=1788271760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
        b=nJLKBMn+gbqeBXi6yW6UE/2QTPoaDNWSvx6T7SdOn/yYq8fLbj45nUOydbT8Qokm1n
         YMaZLzYl7hZGcQNu4U13RRqLucKw+z4dW0fYfqovPPaZ9QcnqL5RzE4Z5uKkH8mT8/65
         r+lzEhQYtuTM4HjQ97fb/bN/r2u3GuQcHdd+/4hyyeh9bpR+NrADxss7350OmM9fSppa
         K23QdQwkSx08B0W81dumVO8tSJqpZpJdYupiVEQImqknw242BRAA6Kx/5fx+nkOEkBI1
         QUtNxEr5APYXIunFN1J+9oozXKVq05KLGSYHOWV1R4V+4dzkiMZAuxEAP92toQ/AIhiy
         7jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666960; x=1788271760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
        b=nCgQG8hucH5xx3e4S6co30X+dyYmXEd2reKxRokAgsh1KJ1Rgy3mHK6VgSBTusXj7i
         3CcQ4rqCW9h4/qR16fPafcb/vhRrR0uYAdrS8bXABNYej03NHQwqnj8DiougEQNUj737
         lM+nNgxD3sFUY5IEYggHptQmm3SZQ8LxgLj2W48P1228K97NDLmBII49mWkIQP0aceIT
         4DdffUjOnSiKp6WSusftZQQyvO7o7sjTu7UYWBeSHxK1NhMelpshEVZ7fXkkES5qnjUP
         RRIwRNFQnsaf0x2N7UUjj1L8M66b/InvHOnpt8Li2aChr5O/dLTX3qmtCqrJgmYUCNFL
         3BSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/lSlwphUgbUjnq84f0ERzAhheBd4zlSwtUW+jx6YR6KWrCu8Q3WSnuy/UzdiFLddjueRioeXJHIe9wQUnei9yclhCiZM=@vger.kernel.org
X-Gm-Message-State: AFuF++mavxXzHe/6avCcs88mISAYrF0PKPsybFO6eFi2W3EtEcVENp5d
	HuRUKnPq5XhI2x1NN8WXB9/aZGgb2I6WM2yxHZUp7aZrBhLOnK4ELpLeNHIOel//GJSKCDfO71O
	Zs1sWfPj6ot3U6NV0dZ2ADJBEHfcUMVOuiYOQup/U
X-Gm-Gg: AR+sD130tzOwtuDCtR+o3B7k/lzxn4bwxg2nC9FSxGfwGaEASQtvzGxu102ZH/eBXT1
	jijOeqw8kwr/qEL6JMvHmHp4uBXsoUJuBuTrZz4u1AQ7mmbhhvdTJeR1LYpEsBslbv+jhnal25J
	6uN1zysWFKXMhpri40bu8kbQ69dansZ9XFIgvFaNmmZUyNfvSoMjWeYy0J/2vZWWfYzYZUh1a6k
	IPxbqPaIG6EqGQfRvNO5yGgMIzxmtpA+zw6kOTWiqjICcQZwABc2igtJC4pxSS3njjSLomQqzk3
	c6SZP5gR0ZN926VfcL3fPk03UXf93h2eKs3qIHNFGL56k8C5SxVTl4fBPSYsKxCWPXz4Ra56dtZ
	vIDULp10tnWDB1CrMroYDhVmy79DvcQ==
X-Received: by 2002:a17:902:ef4c:b0:2d5:db38:8010 with SMTP id
 d9443c01a7336-2d6f2f25ba3mr341215ad.15.1787666958726; Tue, 25 Aug 2026
 07:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin> <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin> <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
 <ao2a33Xf3U0kQmM_@gremlin>
In-Reply-To: <ao2a33Xf3U0kQmM_@gremlin>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 16:08:42 +0200
X-Gm-Features: AcwNN1WtvUE6nvnD4lMNaCfocLK-DLM3bUJQe4WrdBFVB5gGe4Bk4AlrWw9e41Y
Message-ID: <CAG48ez00PjoaXt4xJn1DCNdZfmFn4faya++=U2EeW0_vcYXcqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:42=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Mon, Aug 24, 2026 at 07:43:02PM +0200, Jann Horn wrote:
> > On Mon, Aug 24, 2026 at 7:33=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > > On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > > > On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@=
kernel.org> wrote:
> > > > > The sharing a /proc/mem fd seems like that's a pretty dumb thing =
to do in
> > > > > general :) but I guess you have to protect against that.
> > > >
> > > > Yeah, it's a kinda weird thing to do...
> > >
> > > Yup :)) but I guess we have to account for people doing weird stuff..=
.
> > >
> > > In this case (I do mention it in a reply elsewhere I think) it does s=
eem
> > > like perhaps you should separately check for current->mm !=3D mm of (=
what was
> > > originally /proc/self/mm)?
> >
> > I wouldn't want to do it for this access check, since that could lead
> > to "confused deputy" problems.
>
> I guess if it got the decision wrong somehow that'd be a problem? Or wron=
gly
> OK'd it on one level but then that led to the fd being passed on assumpti=
on it
> was OK to do it or something?

The problematic scenario would be something like:

1. process A opens fd1=3Dopen("/proc/self/mem",O_RDWR)
2. process A does lseek(fd1, <address of libc>, SEEK_SET)
3. A sends fd1 to privileged daemon B as a "log output" FD
4. privileged daemon B write()s into fd1

In this scenario, daemon B is just trying to write log output into a
file descriptor. If we checked the current credentials on write(), we
might enable FOLL_FORCE just because daemon B is generally permitted
to use ptrace.

This illustrates why, in general, the "ambient privilege" that a
process has must not influence write() access decisions.

For a similar historical example, see
https://project-zero.issues.chromium.org/issues/42450869 where we used
to do capability checks in the old expand_downwards() logic, which
could be reached by writing into /proc/$pid/mem. That made it possible
for an unprivileged process to map virtual address 0 by providing
/proc/$pid/mem as stderr to a setuid root binary.
