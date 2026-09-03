Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D6476CD2
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458085; cv=pass; b=C8vqUHDiJcOgz2WvyUHmlj5LaX4Rn/KGsCYCgXkETSJkyT82rqqkvPXkLj8u9VqjTbLC1No6NpuoOSwc+jI3Me88Gbp4NUdALNub4Abm5usMM51YLsfjwhvrw5ft6c04XokhBJkzfkUqrQrC9yYPE6nt66oSihrQeKW/mm6m/Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458085; c=relaxed/simple;
	bh=Eb/KhBPYrVdCZVZnXYUBQP7PX6xwvKjmsmjk45O53BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZd0rc5hr64lFj3BJiQjyLaamTGiOujjSOkdQEfH6uhN/c5iJOWTMgnwldl7OXOQKnyr83XxBUKF936AqiFwHKdga/Z312DZV0jopQNgCaaRHz3cQFLN5w9ZXYX+Eb7DNMtzWVFiP/s8FVXrvc30mACmtfD79b0G1TfRuLR+v6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxy5o8Ae; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxy5o8Ae"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c96c92c0980so151505a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 10:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788458083; cv=none;
        d=google.com; s=arc-20260327;
        b=KadC/Nkqv3q+VgT/B33qoWxNsXLd4eStUTU3LqmtjaMdDZgVq1Q8k4oV/B1u2RyKL5
         Y/7HRk9xQGNlaX3TDjstPXgrdk9/p0GQhVvhQlXdIfiLmbh4y7IDTOJ5/cvNvXOjetGE
         nGao1Vm26y0adEGQe2mSOyTccTc0uyv5vUyqRh3PNybs2iVTQM7TDMw7u+l8oCLiq5Qt
         EX44i80SltHLWqUflXCCNTLw+sSnKWNq8ZznbqlBhLq2U8THcZQP4jFwoRZd8/lC+D8L
         D6lUl/GFwc1M0I9G1i+ECAG0wLg8rFT9YtFKUqnLPGHMCwUsEz3gg6w7XnO3KlTXpPkr
         IOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDI4hMnJGcLesPQ/jL9UZwM4DiKEnVIKEk2punA20fc=;
        fh=rMvHlWmSzBEkDECU7z1mrGFL0CDeqYKS0zAJkjaIFUs=;
        b=dr/wRmN0ZSNFHV099AzOvcISja4x2eqEKnQTNvimIrXy9PxcpQ6+56HcNuid81lSHr
         ic63VSoN0tnFZpZmbMxhRfzbAWdqsaRgjZ/FOX0ujDsM+KnjDVshmZ4iBvfBMBcgpW7u
         1TJaYfOJSjuJ+HRYp8ihcGzlknwBHroJvhhmp2YmjKozq+tnvOqO+svJ7XMobmGCm7gb
         QFWj/osmWiyS/v5kXBkwZjx80VcUUBcLJ4w6Odn3GeEqlYCQPPxO67SMwBTcjfCB6PIo
         WonpIcfil/kmYlYxGhey/cNROBYnwrH9AlPbzLUBt4LrVg0WghWKl1xVJWonoUc++h3y
         xuww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788458083; x=1789062883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vDI4hMnJGcLesPQ/jL9UZwM4DiKEnVIKEk2punA20fc=;
        b=cxy5o8Ae8pbher6ijED6ifRIiibu5IlBWet83We/V2pz6tE4+pP+0jVQqnMCf4KfUk
         CVxRBpqAqDbo8LVjBRqtOnU5M5+D6+/cue7XsHSeX1l7N7HKC5fqEG1AjT4D1uw6L7gx
         RHYJmmLJLOkxDlsRSOPyT74+L5RC1fj+mshawveJYEiIG4GAvNmDB0EzbjarcHGyrLHZ
         RV0zzcjuffUUqi2mw3yLhjEwgTZDSmJikegfp41eyap3sB6YdFu//rZmccsl/8+fhbbP
         vfh+bBL1zGCPHq4MAK1uT2BgfZm7jtgXEIMpq96ZRGxLNLiXltFuR/G2/35B4GDG/uVO
         xD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458083; x=1789062883;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDI4hMnJGcLesPQ/jL9UZwM4DiKEnVIKEk2punA20fc=;
        b=EcJJz7zEs3z1x0iB7/k6lmgi78pm5PJXbROP6S8MUWPt4aSIQGvalqtrRCGdfltqNR
         3lCGN5WMfkmArBB+b9y2E/MQWAlApDtqxOcXW9JcCTY7oehXB6KCvOHg1/Op3MEtLrYh
         hp4fbS6fv1NQttn/ofD/+fGdIZRgt7Izamc2vVX2rawTvqvlWe05JapjF36Z9VAUggXR
         5sJIiXFCD08Q0X5qSjjppNqHQWVuDf6rwjiYBm1cLp/r/s5wvLeSGV8s8vKJOBxv5SsC
         eAJlLyCjUFoarDMiRZ/VhsGPWGZzGKEoaS121fqsewC6YqHAGXMZg42i+vsRgYJrVrZo
         4gCw==
X-Forwarded-Encrypted: i=1; AKwUvByRqieEjP02IkSfYQTrewOKJ7smvar89EL2mv15Ol9csiDDPaWTQRuEGDj1FlSge1xRbM1YtsD+dpTi6cQJVjHJnP29epY=@vger.kernel.org
X-Gm-Message-State: AFuF++nMS9tWah65Uz+3du6if1B4tNdXobfYQ6S3RAIicvnGBC1GPz4L
	TAC2vG/YgQe9nIYqczJXZI1QZIR6yGtTDferskX2Zl/Luw0J8YHC2gnWOv17v3sRaRdc0sQhDoK
	NPTmhT5szSlM+VNB8s80uIYxZNrJJZ/s=
X-Gm-Gg: AYBFou0ikkKGq5goThJzFAQqWquKvvsXy2BGLSU1dS1vLRP9erBPuhknRf8E1wEjTV3
	UXra5L0qM6HJcli/N+fQTe2/HpRobE5IaEL4RN8r/PHmGh5Kzn00Gm3maS3IPfTsd2O32h+zA/m
	aJVgX5j3oFOwsoMrukXBDiApaSHZwwdF1bbbMGEX2spTTpmmgOLD8LHSqXGrLsrPelLlnETsotL
	5CyqDTAvKCtAt+Mjt/NcX7k46xd/4knYEerSNTLhQGRCIuVJsoQEsSOknbDKeO/hudOtmTf0mSA
	rVxImLCAMJg42wORl679/Y2981Ql6waeymsjowAw9WGC2lfqa/FVrmg6mvEw7ff9V1q4wiZdF4h
	CXcwrNyFmPmIXLw==
X-Received: by 2002:a17:90b:2e52:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-39b260dd3efmr358365a91.1.1788458083081; Thu, 03 Sep 2026
 10:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903155615.516010-1-omosnacek@gmail.com> <CAHC9VhQSoWBfWrf97Ch3ZZJXkOvhbwNOGmq8rMxLFzq+a-CkQg@mail.gmail.com>
In-Reply-To: <CAHC9VhQSoWBfWrf97Ch3ZZJXkOvhbwNOGmq8rMxLFzq+a-CkQg@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Thu, 3 Sep 2026 19:54:31 +0200
X-Gm-Features: AcwNN1VZckJ80AmrXNyT2zeNvIrDg0xBBi5yci3USYnxHaD1VlvQhO3H_tXYCmE
Message-ID: <CAAUqJDuPN4_qaCKhAfUz9xQ61NVhf=z-VAG_8Oe+QJeqqgi=SA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_MAINTAINERS=2C_mailmap=3A_update_email_addre?=
	=?UTF-8?Q?ss_for_Ondrej_Mosn=C3=A1=C4=8Dek?=
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Sept 2026 at 18:50, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Sep 3, 2026 at 11:56=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosna=
cek@gmail.com> wrote:
> >
> > I'm going to use my personal email for kernel contributions from now on=
.
> > Update MAINTAINERS and .mailmap to reflect this.
> >
> > Also switch to use proper spelling with diacritics, since I normally us=
e
> > the full Unicode name with my personal email address. I'm leaving
> > in-code occurences unchanged though, as that would be just unnecessary
> > churn.
> >
> > Link: https://lore.kernel.org/lkml/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VY=
pK8KuseMQS-9tNA@mail.gmail.com/
> > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > ---
> >
> > Hoping for this to get picked up via the SELinux tree, since the main
> > change is in the SELinux MAINTAINERS entry.
> >
> >  .mailmap    | 1 +
> >  MAINTAINERS | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
>
> Of course, I'll take this via the SELinux tree.  Since I'm going to be
> sending up a pull request to Linus soon with a v7.3-rcX fix, do you
> have any objection to me sending this up with that fix, or would you
> prefer this to wait for the next merge window?

No objections, sooner is probably better than later for me.

Thanks!

>
> > diff --git a/.mailmap b/.mailmap
> > index 6803f3bd2865..0e672a60afdc 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -699,6 +699,7 @@ Oliver Hartkopp <socketcan@hartkopp.net> <oliver.ha=
rtkopp@volkswagen.de>
> >  Oliver Hartkopp <socketcan@hartkopp.net> <oliver@hartkopp.net>
> >  Oliver Upton <oupton@kernel.org> <oupton@google.com>
> >  Oliver Upton <oupton@kernel.org> <oliver.upton@linux.dev>
> > +Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com> <omosnace@redhat.com>
> >  Ond=C5=99ej Jirman <megi@xff.cz> <megous@megous.com>
> >  Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
> >  Pali Roh=C3=A1r <pali@kernel.org> <pali.rohar@gmail.com>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fc320b373656..875d0baed8b9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24772,7 +24772,7 @@ K:      \bsecurity_[a-z_0-9]\+\b
> >  SELINUX SECURITY MODULE
> >  M:     Paul Moore <paul@paul-moore.com>
> >  M:     Stephen Smalley <stephen.smalley.work@gmail.com>
> > -R:     Ondrej Mosnacek <omosnace@redhat.com>
> > +R:     Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> >  L:     selinux@vger.kernel.org
> >  S:     Supported
> >  W:     https://github.com/SELinuxProject
> > --
> > 2.54.0
>
> --
> paul-moore.com
