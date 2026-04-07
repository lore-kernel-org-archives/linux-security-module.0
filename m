Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637C1FBEBC
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589620; cv=pass; b=cgoP+k9RIYIYSG6aS9QOEcuR8uFG6Y3Nc1WjB8ycMzpeAzSfrxokOLA4oKYzf51BWslMSeE5FpIX/ZB9G22pzAiDylzwWaYmd0euAt3zxtkMsu2L5cUuDh6mvlgH9DgY8kj7ydr6RAkU8OVHE/lOhg5m46JiCm8L46ja4bAnqV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589620; c=relaxed/simple;
	bh=i6c6Uhklk6n23W8x1AxzLaFh13KM9OwbxJ2yYTpwf54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frpL8aoP3Sp0uM7x0the83Nfx2Z3ULomVtbE6GI/m1TfZ14+XX4Y1hLRjeZa1qTN9HSQDeamtYPI2iRDJtW7x/kC3Jd1dvwSCwGgV9D2SZaKVi4TJcbQyRafFvrv7MXxfpzU0+8UBNuhQSYyYzdT9Agi5U25DobfRgVWFOSDvAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyZUiWWI; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyZUiWWI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35c206f0481so5208442a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 12:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775589618; cv=none;
        d=google.com; s=arc-20240605;
        b=XOOVV5pQkjP5yyu/g4lAOZy1ieWqMYMu3l7qVkeYkEqwf9+kjI1rycHu6cftik4U8d
         OB14hMquypCRDdlxD2Xh+3rwBcdU+Ucqoak8leaFEDkqr8zhJL7oUDAv40J3izPBLnYi
         Bj+Sm5VbBNfeTQDZYehkI568sYUqATc9e1k3p8/DFrQvxLrLxqkRrdYymXj1YUGeHZut
         pU2nshEbzylJCF6X6jgjiHHDYRMIJo5yP/XvpPaXHSYQIsVwrESRO6+ENqJB3My0E/3z
         D8vzWop8xQAzkwxBFjzN91ck/tIDlvStj2UAz6Dni+YNp+wpblDi5QqxKRBfdE/gF9yl
         EYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        fh=4SrVkpNSJpEU9OkE2HS0z9fkCDLCGswzpS521i0TqJE=;
        b=EvlKz2Rrgt75sWvDmt41zHwPOnMZ6SM8dvyX1ES5gUYbL9IUhLXuhzTmJi3u8nhzeA
         RoGbk0PgBhVzmGHAYdXsrFUj9Kwi0sRrqc8DkhzT+pw7RSpT8nwvQgsMBrO8xifopvwS
         TMw8sAUaOfCVfkEAuOKbvHM3VoyOLdeuMETrW27SzPHz/ACsUwwjDF+4wxZpv9tavJtU
         /GuXQSosvc+64SAbGpa4Ji0Q8oyMzOkm9AcLxgXfb5c7y0XRwyd2h7fvFKsoRB0llmIO
         8rvHMRNuQoN/z7fp23fK235jkyyzgtfqb3BW4DJ0gVFUY47Jfl8LwtR2fcDCA6uSd69l
         1LAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589618; x=1776194418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        b=eyZUiWWILQVMtoM7LN+je344gEOI2bb+oTPGGw49fR/pLvre5XwIY3Y0OQq9XQlglO
         v7pGURmjkXPNSZujNTn/TSK1p3EfZ/5/ErzUyGBS8vgxDCfTWo2s7mBUKa7HRTzS4mZD
         mSGaa+mqRr4mLpoltEgg53+qacArS0qWR0T6VJl1GsbYJRLQal2fit2uyn2S6BBWurER
         dl7wceAy/RmA6U3CKIUbd+We8HdJbAsRml8wBQpatHpRcpBJwpwMU2h4gY9rF5Tpo8My
         FeXEc/FKtXPEp+Sp+foOWr+lrurKCZtmaOIbqepRdcZN2SZ9n0VdOOPEOdLrT9IB7QBy
         WkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589618; x=1776194418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        b=fZLvLbLPH+mzBUrzLOd4kH9vCT4a5AXr1W2I5AYcyVyDuC7E2ddDg1qtOE6ZqaLcPm
         y4GoiPlqWPMZMBCJM1NTX6NJAC/Ff0sYdulyHZy6nJPOQkDybc7kaLdzAUA9WtcTSnsn
         rG7Z406JEodLF9ywMF/M+QAk9t2E500ZN8aDcYhPVbkrm/Hk48y/9fPulzXTjlyJAGJg
         Xys+iXgJON5Du7gat6tniWKvcC+NH2vSuaiO/30DDKEtiINpuR6lr19BFk0pMqbQE9As
         A3I8rlSp/A6i+sqLxOPly+0RAe7KuPrQ/vDNDraYtDddJA4iwWrRcdvx4OpCzgu0mQqe
         IGXw==
X-Forwarded-Encrypted: i=1; AJvYcCXMunNTPTw13Dv1Bl8Duj93/CrdHPfZzQgwqYjRIfmh+IwX16bfzsqW4lWFY/biY0RcuseW6QcDDAml7mzjx0krtz2u3xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxapAGexYRUMDSlMpMT/9zg+PenUlmyJLKlJZBtodJHqmnRegha
	Rb/SMOs5xfRQ+5N2S8gFWgOY9XsEXOM/5KfeWNoj2PJBr/p6oaKtGIU6KSkqLdpEcYCGbzndGLQ
	g23auomfZ/oAX8iGvXC3aO+XexpT/hHE=
X-Gm-Gg: AeBDieu02/RKBUykC5FDM7rypcZHzugMfdoqBMrdyXari6JBEwQWCKlYngBXfQ+r0hO
	pAR2zp6Q9TXuDBRyc8hHK6QZ4/HKO1NZIjoHvOffz7wVbsJZKd2xLnLtZ5tLicSAtjPFQTNarUm
	rxS+nqGW9wOysZMt5ik/6spmmRZBoREIT+FYjTnjkQh7NDOKNXbUdUryYwYPBXuoioZqdIdHyG+
	O6FgEI7qT+CODwuIxDWcgxTLfVLO9Ap2UE+9D06dApfzatw6bDGf/MXK4o1yPvrk/UEkimouC0d
	uakqBL0=
X-Received: by 2002:a17:90b:3d4d:b0:35b:aca5:db39 with SMTP id
 98e67ed59e1d1-35de67ee6bemr17005316a91.9.1775589618190; Tue, 07 Apr 2026
 12:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com> <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
In-Reply-To: <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Apr 2026 15:20:06 -0400
X-Gm-Features: AQROBzC7o3Va4ubfSL9DMqzx-1hfP9_BswdLqwBtMsXc3haoHViWO4Xh57-I6OU
Message-ID: <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > The existing SELinux security model for overlayfs is to allow access =
if
> > > the current task is able to access the top level file (the "user" fil=
e)
> > > and the mounter's credentials are sufficient to access the lower
> > > level file (the "backing" file).  Unfortunately, the current code doe=
s
> > > not properly enforce these access controls for both mmap() and mprote=
ct()
> > > operations on overlayfs filesystems.
> > >
> > > This patch makes use of the newly created security_mmap_backing_file(=
)
> > > LSM hook to provide the missing backing file enforcement for mmap()
> > > operations, and leverages the backing file API and new LSM blob to
> > > provide the necessary information to properly enforce the mprotect()
> > > access controls.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Do you have tests for these changes showing the before and after (i.e.
> > failing without your patches, passing with them)? I tried running an
> > earlier set from Ondrej but they failed.
>
> A few months ago I sent you and Ondrej some feedback on those early
> tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> I've been using a hacked up combination of the existing tests, some of
> Ondrej's additions, and an additional debug/test patch to ensure the
> labeling is correct.  It's far from ideal, but I didn't invest time in
> test development as I assumed Ondrej would continue his efforts there
> (unfortunately it doesn't appear that he has?), and I wanted to focus
> on getting a solution as soon as possible for obvious reasons.

Ok, I'm happy to look at even unpolished tests - just want something I
can use to exercise the before and after states.
