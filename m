Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F9E30F7FA
	for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418195; cv=none; b=ueYXLX+x/hq2JFjdsC54eRprSuaU7lnPQmAYJY6M9wIU8wzGoWVOGxTVBwzOBlSiwJJS5RiItoOD6TpHwIkj8tcC0H/15n52qO1K+QrCNmeg7o5bUpX3Kwh3Oamo5zCXZDmZ02g+IaMuMni4XvMS9aSW80oLeo3VGMyOt/1h1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418195; c=relaxed/simple;
	bh=0fG8sI+zWvMFlOr7IghYSSJ1KnweFDqAywl+kGXxNz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6r63gpNQGsf6Gj5Hn9LULMbw8qujsE6gzWhN5ZK5gH5Q0IIx8Fsc6uGAvzheVzuy+Y+dF+btQw+KYufYo7wVjskVsyWld5zobV+VNulICEKnwZ4zwi39Hu+RsWDs+zcgsxMWL3louqQJf3bfTzJEQdWjCrdyY2bTqpQD2U8jho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3dIbMAd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3dIbMAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771418193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
	b=R3dIbMAdE1WDrVuzn8p7w4oEVLiUat2W5aWGrBr59Aa+aEK9/DIe3HoeOVVDLKrWC/rufG
	L0zr6XAzzq9N+XPVplX8QxlTHZShIFaYF6/R6r8r9C+vzOeipaKyq+FTEMrHhCoVzNoLpv
	OCrEyu3cEV8pn5VjI3bJ5sSLv1Pzn1w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-jaj5voZwOd-5vq7DrDph7A-1; Wed, 18 Feb 2026 07:36:32 -0500
X-MC-Unique: jaj5voZwOd-5vq7DrDph7A-1
X-Mimecast-MFC-AGG-ID: jaj5voZwOd-5vq7DrDph7A_1771418191
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a7d7b87977so61694785ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 04:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771418191; x=1772022991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
        b=La1h8gosebzV0FtgsY+qLrsZHPYOGi7ywJl5vlw89b5+uUv02lhwSNKcA/U4aS/hOF
         NeRr1s+wnmH5lvMr+KoNZ5N5mNYzf/c1ZtNpKOA+zfMcSq2201MRxa3ph0UuWFrtqeBU
         UdMiECyltvukS7IFKpNFFFsQn8EyKflqz5ARrvGjnaq2vMkh7t9gkmIl5GW/lGf9pKHN
         /wmLFWiZhcU5kM+wlX53bFAIqDMOJoKafsTGlT6nu7CiDnCBHD3eH2DFfi5Lz53GtBPe
         OuwlKaO/wqXClGG/h64XZ3iectcriyvGQqXeg2SB8FEzmuaf3XfiDCcMpH/MP1UDaC0F
         GoUw==
X-Forwarded-Encrypted: i=1; AJvYcCWcGM+iDGIf32dqtV9eM2yp3nunTut2r+/g2MM0X1o8G5644uCqLBddNAePhBNkVz9sjEreddpT8fgpEvkWu309exhWkhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vGi5LKyz2tDEn6ROwEQFox3WEWe3QjkvnBJ8hV2QFSUJqBFX
	AvhHrNLgAORtcDModVw8vkFmajwfvljXK1rvu5m89WY6FUdaJab465SkkCHyC+EhwBEUK5KyOVi
	kfgFfHiU/jlnB6qzdDsLUnTKf+21LN5keWMvR0cugMGQz4guW4sXJGtFWioLWB/5UD/B8BnvunN
	NXcK9ihHbDIT3nGaihbMhU8l+buadyk54zTFE2j6RlXyq1T85btCdV
X-Gm-Gg: AZuq6aJSQZL1E1Bha9Cx1LudIFE4rQ2UAmnhuAwjWEuWN51i5LWCAhrISFSR6UuirZP
	ZQZ9hLDxEULsjd1Xyl3AwQ+0uFy5YT4/5ZJtbig5K1FocsrysOETk1VpUDIiS3uLICaFAq8/gnc
	VVnaWS6XZvKSawrL0+rS3PyVze99OG4/NaQo1WFEF6xRvDLEerdzjkGJ5MDON/OyKF8eAEilNuT
	Hdr
X-Received: by 2002:a17:903:1a10:b0:29d:a26c:34b6 with SMTP id d9443c01a7336-2ad50fbc316mr16329895ad.50.1771418191214;
        Wed, 18 Feb 2026 04:36:31 -0800 (PST)
X-Received: by 2002:a17:903:1a10:b0:29d:a26c:34b6 with SMTP id
 d9443c01a7336-2ad50fbc316mr16329765ad.50.1771418190809; Wed, 18 Feb 2026
 04:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
In-Reply-To: <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 18 Feb 2026 13:36:18 +0100
X-Gm-Features: AaiRm51HYWR6w0-EcsphJc410XncNKnjGKv9rOIgL6E3XvZhdcve7uAr9h1HcsM
Message-ID: <CAFqZXNswp_bKq_78PgVpToK1Zm36ZL4atqiid2Lstaqa0sKnBA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fanotify: avid some premature LSM checks
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pe9D73LFxi1_JDtB5nIEBe3lXJhH876ZD7_1MnBG0zs_1771418191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 12:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 16-02-26 16:06:23, Ondrej Mosnacek wrote:
> > Restructure some of the validity and security checks in
> > fs/notify/fanotify/fanotify_user.c to avoid generating LSM access
> > denials in the audit log where hey shouldn't be.
> >
> > Ondrej Mosnacek (2):
> >   fanotify: avoid/silence premature LSM capability checks
> >   fanotify: call fanotify_events_supported() before path_permission()
> >     and security_path_notify()
> >
> >  fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 27 deletions(-)
>
> The series looks good to me as well. Thanks! I'll commit the series to my
> tree once the merge window closes and fixup the comment formatting on
> commit. No need to resend.

Great, thanks!

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

