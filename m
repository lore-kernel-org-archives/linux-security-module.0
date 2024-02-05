Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37427376E1
	for <linux-security-module@vger.kernel.org>; Mon,  5 Feb 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149382; cv=none; b=WA2SufyzUqsfiTuo46QYG233AgVnUMCY9i1QEv3g9rE13/ZyR1285EfkO7H87+PXQh2kiJl0Io+KCv8MsQwqrImgOKC1Io90sbCdCAeF3g7NoPbG/p3z/P72/M7RsiGqmOR/42H1SMfa22CGKby3buXDdRsztugSIs9emZqzdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149382; c=relaxed/simple;
	bh=03g8YYzWTRdjkVfeAcqvzZPU42Q430iY00QziolvaYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkLYItQdEVxNlFF7ZaIXOXT0eH5wFi+cPwcav/pfTKWLryxnaq1rf72irHR5UDPlhCtyz90BtkwhguKZlzgcpSNeX56FO+R7s7nuGioUxQAB/92Lc4WXRPw9lEEgkU8meFCXUtKV2JMS4QxC95nPgz/V0NXUubQSdZyRxda2gkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XN5GyoFt; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XN5GyoFt"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so2396033276.1
        for <linux-security-module@vger.kernel.org>; Mon, 05 Feb 2024 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707149379; x=1707754179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDax4K7QGWSqZTbEFiDmrgrp84G1TitrDt4HTH4cP+s=;
        b=XN5GyoFt9wsWWVCrgl3h3CjdU0LFQHJs7Dit8yKsLFQOavl/AA/h22XsB/TdjyEgpa
         exKQrW2pe99N0Jn1A6BKTbNTbdybz31sRhSKbeqgTBZhhMpJsFU/CQ5/wiwA9jPDucSa
         KbR1kFMbpmheY3dXBAcWEV8zndAzR0tpIYgoAg5T/hDIDiXZ4GP9dcibH7xO2zNTnYab
         5Qz7ZXbAsWD1YM2ByclymA+oQxSFkDCfwFqEhgJut98kOrmwVUiJsRbvQk3M/Rmmdpza
         sFjhfaj8Skw99RYMuZNfsFdNek8PrP9etYc7nJ+qXVFPaj2ofCGb3/P4+jz2bfvZThZM
         eE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149379; x=1707754179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDax4K7QGWSqZTbEFiDmrgrp84G1TitrDt4HTH4cP+s=;
        b=RjDXbNZhM4+WDylyqK5tdFXrWqumQnvzQSTxAdOrfhiC7krwzBnXmspfGcvOxloEXh
         UZMSHH59LRSScyo2Wxcr7CrT5sVGzYadYPFSOwdJLT5KJhnXI/CfQdtwN1qXUCeGdNn0
         AhxRJL1rpFLx2qKkobt9499NpHCKRM/kYyAMR1s0cA3/5eMBenzEM/JpsGLO0TsHXozw
         B09SeV/MwYnb06l3oQj1X/wLDNbsAGf7L7d6RuSWg4mwth2rB2dICajE376pqItkNfgv
         jNKlAPBaz46manMPGsysHaDXWqagBWd0ok99j55BQFSTjw8HPsfdbhLGo9owZ2vAy0iW
         wXjg==
X-Gm-Message-State: AOJu0YyaVjoErl1P9+qfSVbh2wH78xRxjCBu3Z7/Ni+HlhZiJmEdTqYK
	+FL317nbKsuoF/TH2Thl6idZqgtKtpDOfkNfdYIeCgWUCRGGhZo+7LqeCJ3Go/v5ZaYDtYNCKd1
	I5FMmwQoWwJQQysmOZTkgMCXDmLB6/OT7QPUGECQl+y9wmiA=
X-Google-Smtp-Source: AGHT+IH0iNAzlR0TiH1t90UubQVEwvYs282KbJ8bF5sKnw0TNASMdqJyBO1nGxH65klPYK6tRlDsPpaDf1Ysl4t3qDA=
X-Received: by 2002:a25:df06:0:b0:dc6:bbb9:5dc with SMTP id
 w6-20020a25df06000000b00dc6bbb905dcmr186303ybg.6.1707149379072; Mon, 05 Feb
 2024 08:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710102319.19716-3-greg@enjellic.com> <ffdd5e4d10865da5f767df53b12bb6db@paul-moore.com>
 <20240108114324.GA4085@wind.enjellic.com>
In-Reply-To: <20240108114324.GA4085@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 Feb 2024 11:09:28 -0500
Message-ID: <CAHC9VhR+Sukfi+-7TTxK2Paxon6i+zDxaELzXUZ=eBOUMf9nwA@mail.gmail.com>
Subject: Re: [PATCH 2/13] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 6:43=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Wed, Jan 03, 2024 at 11:00:33PM -0500, Paul Moore wrote:
> > On Jul 10, 2023 "Dr. Greg" <greg@enjellic.com> wrote:
> > >
> > > An entry was added to the ABI testing documentation to document
> > > the files in the TSEM management filesystem.
> > >
> > > The file documenting the kernel command-line parameters was
> > > updated to document the TSEM specific command-line parameters
> > >
> > > The primary TSEM documentation file was added to the LSM
> > > administration guide and the file was linked to the index of LSM
> > > documentation.
> > >
> > > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > > ---
> > >  Documentation/ABI/testing/tsem                |  828 +++++++++
> > >  Documentation/admin-guide/LSM/index.rst       |    1 +
> > >  Documentation/admin-guide/LSM/tsem.rst        | 1526 +++++++++++++++=
++
> > >  .../admin-guide/kernel-parameters.txt         |   18 +
> > >  4 files changed, 2373 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/tsem
> > >  create mode 100644 Documentation/admin-guide/LSM/tsem.rst

...

> > I don't want to assume too much about the TSEM design, but I'm
> > guessing the aggregate is intended to be a deterministic value based
> > on the PCRs and therefore it seems like there is value in providing
> > a clear explanation of how it is calculated.
>
> The aggregate is the linear extension sum over PCR registers 0 through
> 8 using the namespace hash function, we will cook up a generic
> description, although it should be a common enough concept for anyone
> working on trusted system implementations.

The Linux kernel documentation is used by a wide variety of
administrators, users, and developers with varying backgrounds, I
would recommend assuming very little about the documentation's
audience.  This is not to say that you need to explain everything
yourself, referring interested readers to established, publicly
available sources of background information can be acceptable.

> > > +           trusted pid=3DPID key=3DHEXID
> > > +                   The trusted keyword is used by a trust
> > > +                   orchestrator to indicate that the process
> > > +                   identified by the PID argument should be
> > > +                   allowed to run in trusted status after the
> > > +                   modeling of a security event.
>
> > I mentioned this quite a few times in my review of the previous
> > patchset, PIDs are not a safe way to identify a process in the
> > system.  PID reuse/recycling is a real danger and you need to
> > account for this risk.
>
> We will defer that discussion to our previous e-mail where we
> discussed how this is addressed.

Adding a secret key/token/etc. may provide some additional
authentication benefits, but it doesn't entirely solve the PID
identification issue, it only reduces the likelihood of a process
misidentification.  We need to do better for new
designs/implementations; look at the pidfd work as an example of work
that has gone into reducing/eliminating the use of PIDs to identify
processes.

--=20
paul-moore.com
