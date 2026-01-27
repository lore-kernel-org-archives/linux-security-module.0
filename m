Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3D2580EE
	for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501131; cv=none; b=VjYgBT+ZgbuC6qzccvgE0+k6kGFkmIECyNp8bfdZ5CR2sZ3rDiTlXQfQZEZEzzUU6LsM/NPM+0MpluwhAIXUS418WGWl+gSB5P0rXx7oHdT8MioL6mQmRLLJQ38WLxy3I82UiGLoAFxEEn+Eh9Qx7PJ23gXHoUuo10VDP/txyKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501131; c=relaxed/simple;
	bh=G4lGxEVi8DaJdnFVFXySNwy7fmRjl5ytu108BNBK6LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMjo2APHH8FfyxZb5zkZviweqfIno6ezMBcfGc+vyyQY2sCbV590p8fNiTGE5m/83ympmdKVDmbTXaIG9+65fxT9qZkNK91aIr2UVkjbr7+RtA+xX7/H856e0C0IYdILeS4nVjMMTmJE3lghZXU3Yans/rc+643jj2qrZarKddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eT4tQopT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eT4tQopT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769501128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyBS2urlrz3YTfQuUYzzTwivIYXn3/eEJMd3wGNCydw=;
	b=eT4tQopTY0ycx70+Qt1X0k7vz5wp3aLXzE8XsmL9bllJpne6VBVZeJHB0zNI95TIHidulf
	dF1MsVztziYXInbSvNKHN4CTX4YOxZz9gnNnnfnkuDgQ7IvCyCXch8yDOa+rOvEpJ8iv4z
	o/tzqpPIkiaVGzGfGKkDX0aENdxkLJY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-L5LwKInsNXa9Wsejt2dtFA-1; Tue, 27 Jan 2026 03:05:19 -0500
X-MC-Unique: L5LwKInsNXa9Wsejt2dtFA-1
X-Mimecast-MFC-AGG-ID: L5LwKInsNXa9Wsejt2dtFA_1769501119
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ab459c051so10602245a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 00:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769501119; x=1770105919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yyBS2urlrz3YTfQuUYzzTwivIYXn3/eEJMd3wGNCydw=;
        b=DXQntXpPfPh3KbZMGkOm2vR/G5aP2kcLeQlGXneLO+YTt3m2brxdP2RpSqIbVbzsg5
         yO1Nz/0iDp8ppIdHyCrIcJ2YH5b6O4J1u+4j1FxewsTAmkcoZ/H6LWLfNxuPmWzgA/ME
         fIvoXRXFe8JWURbp8XKx/9nAeqfkKe484YTDj3JlKs0WZBBG0g3HThanv4dxAYHSCDMZ
         u78qTiOvvc0VwP7kyRcp+BJsq6AlpzgQzwalGF0eomdhOTlJBKaOxGXjVgrja2ZHF0TU
         QcRnX3he/RUnXXga9V2Fu+PMskm7PkxsGpvma+HzRLLC6LacDOmCTueQfxc+oQPyj4Df
         lcqg==
X-Forwarded-Encrypted: i=1; AJvYcCXV39spP0kErJ59BKbBP4/bbui50oA5uuGwh+Gi1OuH79omkEzYoczTqo5u585akX4sQW/jHxY4CFUMsfYNyl2yBrA/5Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Vj2suxn1wRm4vDjKHLAODVqdJgvPMtW1YZch9bsBUf577rxn
	Sp7ow3QZif8Qu6VfxL/b9KR/CtxA0L9rHvNSUyZdmu9HaLyJuznaoKhPxpD8NdbUbJ5AyDgm+G7
	b5oq+hcYShDI8CRB8qhAyxZcfYecGqOhSzDCLd4WeeT/kniDaRlvIE370Zx3DNpfVsTAlWApmVZ
	ejRWUYam/Mqqz81UkJAxUCoOhtyx+W+4ure08bmih0G2yw71t/ZcBO
X-Gm-Gg: AZuq6aI8H/nngtS4QoebPEREE1eaM3ACkFmqJcm3aK/gpKry3AGewE31XIlBvp/dnQC
	zAlBkZtk9hu3Swa3HFcJdcKgHMKhbFI2c5IO/Flr3EXI4hl7adcOGlD9Re6cSitEqEq03UOOcGZ
	KQrDQGx7V8cOhGEwwdZgDvxZI/i6wQqwmkqaUuozDjMgws0xpVqfoahu+YDu+yTVnLyg==
X-Received: by 2002:a17:90b:528e:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-353fecdcfbemr1169746a91.6.1769501118697;
        Tue, 27 Jan 2026 00:05:18 -0800 (PST)
X-Received: by 2002:a17:90b:528e:b0:33e:2d0f:479b with SMTP id
 98e67ed59e1d1-353fecdcfbemr1169721a91.6.1769501118342; Tue, 27 Jan 2026
 00:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122140745.239428-1-omosnace@redhat.com> <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
 <aXgZI1td0Hremulj@mail.hallyn.com>
In-Reply-To: <aXgZI1td0Hremulj@mail.hallyn.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 27 Jan 2026 09:05:06 +0100
X-Gm-Features: AZwV_QjIdWSNFQjfHOtFcjMZ9aCAgQ0MC7O6Wyqr_Wu_Rw0dFaUOh0s70eRf9-A
Message-ID: <CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r5mS447V8JUDGtr1WbiTfM-dtGY5HUiZS0BwXqERtA4_1769501119
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 2:55=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Mon, Jan 26, 2026 at 05:52:03PM -0500, Paul Moore wrote:
> > On Thu, Jan 22, 2026 at 9:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > The user.* sysctls implement the ctl_table_root::permissions hook and
> > > they override the file access mode based on the CAP_SYS_RESOURCE
> > > capability (at most rwx if capable, at most r-- if not). The capabili=
ty
> > > is being checked unconditionally, so if an LSM denies the capability,=
 an
> > > audit record may be logged even when access is in fact granted.
> > >
> > > Given the logic in the set_permissions() function in kernel/ucount.c =
and
> > > the unfortunate way the permission checking is implemented, it doesn'=
t
> > > seem viable to avoid false positive denials by deferring the capabili=
ty
> > > check. Thus, do the same as in net_ctl_permissions() (net/sysctl_net.=
c)
> > > - switch from ns_capable() to ns_capable_noaudit(), so that the check
> > > never logs an audit record.
> > >
> > > Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  kernel/ucount.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Serge Hallyn <serge@hallyn.com>
>
> Looks good to me.  What tree should this go through?  Network?

Andrew has already applied the two patches I posted into his
mm-nonmm-unstable branch, so I assume they are set to go through his
tree.

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=3Dmm-non=
mm-unstable

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

