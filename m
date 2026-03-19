Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF83EE1CA
	for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935811; cv=pass; b=HlRSbiU7ztPbf+YS/HFIgtgm26hNcDp+KjzlU8LMsssw+u7mHluICfv7LqML/Js8djnEjWnA6BmOYqp+SBBv5mo4FHKAZcYJqaHkl67JtMSKco2tvYwnUEgsSnz/bSam8xnl6tqzoi+CDxXf8qwY4zvL6aXxgeQ9kMb9NruoY3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935811; c=relaxed/simple;
	bh=venfIdcDoNMJAHTl0dBp32zf9R0qjSHwm3If9NHEtBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKF4NQUIfQDD1dadnyY3XJcGh9Zvvzc4h6IeGm5mFIUpUsQ5hKx9FRS97MnW0eC5au/+jWi/zFTafV/DhlBbCm9aOmpx0axXU2f8MzsPQJHNGMyb7FZHKeNa5ZUi2pbb0MDj3PE+FUhPTo9psk3erAQE8QECmsyQQN5NVcIsnbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DykLok8S; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DykLok8S"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c742bc88d87so413077a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 08:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773935810; cv=none;
        d=google.com; s=arc-20240605;
        b=T5IwdhTV1N4jdCY37LMzuWMfRSkReMSh6a4qs5ufyCsNpNFYLFvG1+QdtyxkQzUl8j
         st3orsiyLTCXrJR3Hc4spxolvDvZkLvbNUhXdDrmdNsXlQ99FvWjVwNJDnfaC0u07M5B
         tY/E0CUlMwdCHxrZPo7xhP+/q4z3rSR0T+CoEH5Q//tO9ApEf/4BfSCGRAS6NUcKA/0y
         Q/I7F+Xj3bNnh3mTtqcpzRGVdPaMCTDc3EZYBK6aprvgefAOerATBVgS46v5LTx42O6T
         0uazuoqNf1GL1dJGDNxwDrAHl4Wipga39digAQ9JTuiB8b/zc4QG1aBSVFjhiMdwVSlm
         0/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
        fh=lwYT071r5C5QRznmYtdTe8kojmJRyT80xnVHxkCJjMU=;
        b=MUO+iQySBP9WfE6NIohikSDjlzYZhc7SBngDYxrhBbuPmcrOXucYLHfkxcV8XFiVq0
         2nLwf/lgCdqdCQMITWJr2E9wJN/ZUOICyhFXez9KuQOq9ltT1PBMzvzTfbFSpl8iHPJN
         zmRmfydHY7RnDMjzZaw2mKvAO4b9Avp6hNxZ6pbN6Pka9RW0kCAFwz7FRlrZOykfN9xH
         6B8n4QpL83u8gQsCAVVjlI5M02Dzi73YeCx1e0e3lDPK/CLtn6fzNIVDwUkX7QoZtwwL
         K16h4mi2uicQstlzyCl9ZqRIAOUH5biS43UNnhmDihoxNH9k7ZE2035l0JQqWES4G5Mp
         Uvjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773935810; x=1774540610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
        b=DykLok8SsbPuq+JrybVVuynmBc8i6t1bhey9okzn1CetJdy9MzCBXvv4ZfsvnlyFwh
         qWh4iHHNLfOzlH60EadF7cwaVNVZ55yFjuUWkCFtr6mrDRffjdYC/nF7lTMZ1EMNY7/a
         jNEvFB6mlX4v9Vyrtp++TcJ2fdxVY2okPOmOp+TptqhCJrfJTGY4im+/N5RUHF8l4/2A
         Fpq9ISSsGQvoPlkHJNMhlabngLG8Xkn0lUfQAtFCxuj7y0fFHRKoq4XgdriTZndnT5d6
         DZg/WcxcP/TVZedeaT6tufUe1FKDfcXtnkElvzrqpBM2Ynyu7X5Hk6ZH4U6IIGCsJf70
         tUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935810; x=1774540610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
        b=jwp1VUYoqPp7SArAlb4ksCK6hjNIu4h4Imqohxp+Qfah0KhMd7L6GGbkCiH5Rhh9mQ
         NM03SfKeNnjDFMWO+Cuuee8dHzAr3uV/voH0+6qE+ZCTfWO8MPHFS+MOHx8QX6Hdj7+C
         5ZLYd0hNWEcALGZO+OvrnPXJWPg0v4TfsfHVGA6S88LyuvUe6v6GbyoApgr9DGoAWz9h
         0XPWI4kkVXtB+o3q6QDy0QVnHWDWBGy4J4uH+zj6YFnAJWCd5Q3eCOk20GSKXqtNj7tT
         Ijmwt7BLeL9shG291qNGbSVFjemckFYasZ4ySAS4Ybnz0hqTYHM5/9M40GnQ0egAp9NT
         IZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcwOWNRgIDav+S9N6fRSxZfkT+o1prWnSANcsYshH36Dmq0tgv2InpUDzKWGfnb077QBUXhtF1BPZ09ZO4EsjhGaPKRVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwZ6H5+zIMpCx4/XVUgFOg7sVH/BEb3aPBp7BshEC50Rd32jh
	+kwP3O52vuZJ5GRg4aFlrunPBxKgM73VvKFfZbTxs3MPHr0gcupeiTOaYefZ2NdJbjko5Taag8Y
	x4yrVNOlckYbROnY27cWzxoHpMeMZ/XrVngYwiA03
X-Gm-Gg: ATEYQzy3LTMXKk+4VVAVKsG3xm6Ygusmb3WfIEtelM7q04FypW2pDwZyoqJaC4qsEsD
	PBVj2ut2ilgeqO7AebAVkfTpU6Sq5/lkHE8Vq9ts1gzMFkXlHCNmSAIowmqYGsA4TR25rVGBOvx
	3TSFn+ALWB8OblzUwCWGUAHWARjRzvsZ8gF3h1pyxpANKFz3fsdtyPI42lKzkFYfxS1wvEMBeNU
	FbriN70N2fFXA7scnvNOy4swE9W+3/q0iClPPD4/PZczaw92G08G6flKU+SkSaWbQnDak97bly8
	1SlCC2k=
X-Received: by 2002:a17:903:1c3:b0:2ae:478f:2ec with SMTP id
 d9443c01a7336-2b06e3dd59emr76386305ad.29.1773935809817; Thu, 19 Mar 2026
 08:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318131258.1457101-1-amir73il@gmail.com> <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
 <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
In-Reply-To: <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Mar 2026 11:56:37 -0400
X-Gm-Features: AaiRm50nhjVBL81kDULwvCn8PsB2aebm_MIqZayk9nG17bPp4IlB5KlFJeWc6p4
Message-ID: <CAHC9VhTXfiENo3MVSv+LZFx4VJGTDqErMBKx0wx+jKNOc=NjSQ@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 10:54=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
> On Thu, Mar 19, 2026 at 12:47=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > Instead of storing the user_path, store an O_PATH file for the
> > > user_path with the original user file creds and a security context.
> > >
> > > The user_path_file is only exported as a const pointer and its refcnt
> > > is initialized to FILE_REF_DEAD, because it is not a refcounted objec=
t.
> > >
> > > The file_ref_init() helper was changed to accept the FILE_REF_ consta=
nt
> > > instead of the fake +1 integer count.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Christian,
> > >
> > > My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> > > Here are the changes you requested.
> > >
> > > I removed the ACKs and Tested-by because of the changes.
> > >
> > > Thanks,
> > > Amir.
> > >
> > > Changes since v5:
> > > - Restore file_ref_init() helper without refcnt -1 offset
> > > - Future proofing errors from backing_file_open_user_path()
> > >
> > > [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore=
.com/
> > >
> > >  fs/backing-file.c            | 26 ++++++++++--------
> > >  fs/erofs/ishare.c            | 13 +++++++--
> > >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++------=
--
> > >  fs/fuse/passthrough.c        |  3 +-
> > >  fs/internal.h                |  5 ++--
> > >  fs/overlayfs/dir.c           |  3 +-
> > >  fs/overlayfs/file.c          |  1 +
> > >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> > >  include/linux/file_ref.h     |  4 +--
> > >  9 files changed, 103 insertions(+), 34 deletions(-)
> >
> > Still works for me.  I'm going to update lsm/stable-7.0 with this
> > patch so we can get some more linux-next testing.
> >
> > Tested-by: Paul Moore <paul@paul-moore.com>
> >
>
> Paul,
>
> As you saw, syzbot found a nasty bug in this patch and it is too hard
> to fix it without introducing more hazards.
>
> Therefore, per Christian's request I am withdrawing this patch.
>
> Please see compile tested alternative solution for selinux without
> intrusive vfs change at:
> https://github.com/amir73il/linux/commits/user_path_file/

Let's let this thread die in favor of the other.  I'll already
commented there, but the quick summary is that pushing the ugliness
into an individual LSM, or the LSM framework itself, is not a
solution.

--=20
paul-moore.com
