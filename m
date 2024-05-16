Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9408914EC62
	for <linux-security-module@vger.kernel.org>; Thu, 16 May 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876630; cv=none; b=OBiZixhJ/5twBOYi+qrtH/LC1+zicJJxiP7mweque1350gg19f8LVi+5NRJZ2BXlTJ5zkcXJCDqZzRR0AN/AT6AOAqMF/ju/c55ucFjsNhjGlxZtiRm0vKcJFhYWdbrRv/SL3Ot5yK6uDLvzPfko8yCALX4STTuKdoDBtt9O1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876630; c=relaxed/simple;
	bh=EZ7K4NzPBe6mgvmzDvgcN0o2b/NCkPR6fbfbuMDf1ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT6QNfrCdIGattIS0DMfhrmQjP65ANHbZuielL+QfMwlffkEHpLOdrPYkEDubDK21LgF29Es96PBre+Wto3qMfUCCa8cxph1Muvxrl+bRLxxav6dTromA09+sSKXF41PzQFg2wyba5kxOBkhZUKCNc266BJ+tuB2/AKoWdsTm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YrVEFcX1; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YrVEFcX1"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df457d734abso1172527276.0
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2024 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715876626; x=1716481426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Razho7lHGpyap1v7dPaP5qSSISsR7xC/uw6XBXBKDDs=;
        b=YrVEFcX1ds2TXr7XCZ5Fzp/kPwxTFs9f70qlsY7O0tR1s3pk7uoWBqDKnlqm7TdF3A
         CgAwIvtI9e1GzcSarlc1Z1YlgQmC0ZX/v8R3TQANXQddY8NiRSDggauIINJbBJ0Iczpz
         lMA709PVe5DCeKreg6yFIWlK1ceEEOINXkvutC3N3ClIByNvxJHHktZbCppgco7VocEQ
         wcbaksZwQtESir+rhGAsuKMbpk+95a7W7ODxrfoo7Z614SZzjzJd3/W4Q+HyXywn49CG
         tAgvnx4f3fpDjXR4CBJfglcTrAXsLHgZsdGw70QYisGLauQc0yRzF2aL0Wrrb+Hi6q4K
         cgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876626; x=1716481426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Razho7lHGpyap1v7dPaP5qSSISsR7xC/uw6XBXBKDDs=;
        b=lyOqGM1IaYo+xX5r5wja6iQumBZEOHBjW10ctZxc0ulC69yOqTZtsBkDrVA6ZWjmI8
         fTammjt6YARpn0UnM9e7zku/EMHUrKVA04XU8QqqrY+ZeDi+ddKvgdF+7ThNybWVOVX+
         nj5pH7AEyD1AH1yaU9pH6YAxmYslOlcmF9iFhU8E2j7Yp0V5LHd2M5uIAXk0SwZ0UZ/Y
         0jHiykXUQJ2e4n6hMfFX41B+sINV+2jxXW4gSGNfUPprnAUdEpTrvf1UrWm0HsYVBEY5
         Odx3QwhCT2qnNTImtDjyKSByvdddGUhfGkKjFW4PQRiFIqE27r0Sxo8QEvGdhr9BOMib
         egrA==
X-Forwarded-Encrypted: i=1; AJvYcCVGX4AkdXGesKNdtqC0XJUuf1lRrbiUU954skBUaQ9fHQBhV0AMdN9OpRIGtUDagGVAPqv5tNx/codUEOGCleTcJ8wOUU69nkoA2mUs3UB2XQZE86ek
X-Gm-Message-State: AOJu0YwqvyVMDmm+qlahQdDwnkkjJ4FDjHUugBogVCo5l4mrrjQKVAC8
	xCnhoDqFI6L6zZNcOvE5c99S8q2mwRRfeUZ5v8G2ZkUXxtBFBBAb4hclNu1pbDYbrIErwy7SaU1
	GeD5Lp4p3/DmBO6UMiebr6l4CBx9pctDjGSpC
X-Google-Smtp-Source: AGHT+IEe/+V1bbRxOWwuKMKyGJUCyojV3Orv/M9T3K8RKww9g1UJdluzqC20c4o+/xI6Shg9MmTrzyhw8zyqu2pFzkc=
X-Received: by 2002:a25:ade7:0:b0:dcd:5c7:8466 with SMTP id
 3f1490d57ef6-dee4f3a9f30mr20073221276.44.1715876626618; Thu, 16 May 2024
 09:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
In-Reply-To: <20240516092213.6799-1-jcalmels@3xx0.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 May 2024 12:23:35 -0400
Message-ID: <CAHC9VhQ=nNPLRHF8RAMxArT1CESei+qYsnGse6--ixPhACAWTA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
To: Jonathan Calmels <jcalmels@3xx0.net>, Serge Hallyn <serge@hallyn.com>
Cc: brauner@kernel.org, ebiederm@xmission.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:21=E2=80=AFAM Jonathan Calmels <jcalmels@3xx0.net=
> wrote:
>
> It's that time of the year again where we debate security settings for us=
er
> namespaces ;)
>
> I=E2=80=99ve been experimenting with different approaches to address the =
gripe
> around user namespaces being used as attack vectors.
> After invaluable feedback from Serge and Christian offline, this is what =
I
> came up with.

As Serge is the capabilities maintainer it would be good to hear his
thoughts on-list about this proposal.

> There are obviously a lot of things we could do differently but I feel th=
is
> is the right balance between functionality, simplicity and security. This
> also serves as a good foundation and could always be extended if the need
> arises in the future.
>
> Notes:
>
> - Adding a new capability set is far from ideal, but trying to reuse the
>   existing capability framework was deemed both impractical and
>   questionable security-wise, so here we are.
>
> - We might want to add new capabilities for some of the checks instead of
>   reusing CAP_SETPCAP every time. Serge mentioned something like
>   CAP_SYS_LIMIT?
>
> - In the last patch, we could decide to have stronger requirements and
>   perform checks inside cap_capable() in case we want to retroactively
>   prevent capabilities in old namespaces, this might be an overreach thou=
gh
>   so I left it out.
>
>   I'm also not fond of the ulong logic for setting the sysctl parameter, =
on
>   the other hand, the usermodhelper code always uses two u32s which makes=
 it
>   very confusing to set in userspace.
>
>
> Jonathan Calmels (3):
>   capabilities: user namespace capabilities
>   capabilities: add securebit for strict userns caps
>   capabilities: add cap userns sysctl mask
>
>  fs/proc/array.c                 |  9 ++++
>  include/linux/cred.h            |  3 ++
>  include/linux/securebits.h      |  1 +
>  include/linux/user_namespace.h  |  7 +++
>  include/uapi/linux/prctl.h      |  7 +++
>  include/uapi/linux/securebits.h | 11 ++++-
>  kernel/cred.c                   |  3 ++
>  kernel/sysctl.c                 | 10 ++++
>  kernel/umh.c                    | 16 +++++++
>  kernel/user_namespace.c         | 83 ++++++++++++++++++++++++++++++---
>  security/commoncap.c            | 59 +++++++++++++++++++++++
>  security/keys/process_keys.c    |  3 ++
>  12 files changed, 204 insertions(+), 8 deletions(-)

--=20
paul-moore.com
