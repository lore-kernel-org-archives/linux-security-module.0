Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A815D5B3
	for <linux-security-module@vger.kernel.org>; Tue,  2 Apr 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089705; cv=none; b=aYV/TueitXDRpoXaL7ITTDwvinE5C3L1PGeWMa2cb8k9SNqEiiIueHFu6tbVJamt3/DyYNAZvBShZnsfmbUvQLNUVLjDJ4JhgAhmV7prfITXNQcj3zLhSJBHGCOMbrqLKQmSgSjvB5zeoZno6HULpfMma1S5/Vow8e+O1lECbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089705; c=relaxed/simple;
	bh=LfVYX8aS+uGvfYiFPza5xfpJggy3wA1TMy/HX9tJed4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ+JjT5SLIw1c4OX4+xNK9lzD2uvcthyp6gg4RlsPd7tIXlL47/Jv+7tixico6IDvaII1CVT8MQo52gi9wMOyzW0WRqimbAgJ+cAunX6RU6KiD/1DRl5mHWu+tZwwLnaFyfdn5Yn2iV+hj3CbR0oDLn1pkVcwOl2M2ZYXJgUoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CW9yCGB4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CW9yCGB4"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6147942ae18so34006527b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2024 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712089702; x=1712694502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoSv33fHX+PiwFO/k1mr+DGe32nj0k4cYvUK0De9J/g=;
        b=CW9yCGB4NsT7Ls+jy9a6DbYdVWYC6HEPWhP+LRjpxT8xZbfmT/2MlJpXWm41hFvCdP
         zJcJJbaBAJUmVDzLx+hbesZBDJqjxEXn44gC0Jz6qf5Q1jK9t7SmMdIWQtYqGGSg6nTt
         hwsNtV1wVZp12mAgDmTDKqNY/9b/yc+RBs82dlEuWi5kyKpFqVzlmrnUqznGfzPQ/XU8
         ntcMqkXDQamfcIVrut1I+Siwehow7GjMTqsb50uULbCq0hX9vWVPwwhvE3vqZJ2UU+hZ
         wlpdv5vqjuG+5w4Tik6p1gB66uVC+iXGqaJAmKZVpCoep2DV72fT3+g61GehW+I14v7W
         F4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089702; x=1712694502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoSv33fHX+PiwFO/k1mr+DGe32nj0k4cYvUK0De9J/g=;
        b=Q1nvkENz1B7UW/ukDf2rPsdkZEywoz4Kzc9fZb0u3Pcwg4jbEeuwK+JQderziZb6Af
         IXQc+kFiMY380H36GbiBHfhjHlLN8ouvWAI5BENmYS0G+U+520d+g2QptesaYVVJTkzk
         hoos7TukYLkCgLeVOJx5WbVf6iHwrYZFAljDoEzbEc5T8Av7N6R92lwqVLIKQ3crIsx0
         Tl7fAIDt73hChqKwsU0cXqOh+t28T3bQUrYV/YBuTMgeivTYsAvEybPjLsw6jtuZ1VXO
         mKjfsRlEK9S2R9WzuOUOelRpqsXOf5pFPo1x12xO6JC8+/i9PmtNUdakQfa+8YrMHAxI
         mkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU8FJGDIdQp9fU1a1ivO91rcrWjSswNCLVpHqvvBfSPY0tXW74kT5Hh8YcvnZTm6DzbTXo5vW9JpR2rGc+iJGOLINiRLypILYtkSP9vIbSzmu5sImG
X-Gm-Message-State: AOJu0YwouL078iAvSikCvEgdf/1hw6PCZ1ZSnADJjWGQHpNS2kiHbkv6
	61CcwBBN8h6CkHuiCDINYBo0rczPkTkm2dvungDVlb/3aF+CgdpUK+ts/+jUy+pT/4xAuoXA7DU
	sOb9zIIJXt+qdNbIvtPU1VpRbdiQZ9v5Tg8oYRmHfR76WJcg=
X-Google-Smtp-Source: AGHT+IEVBN+nZl8MKEmvtUo5GMbK7xeKkzls5qXpx0s2OutO7Jvpps2qS6SsUR1HM2jxzRpzT7CFKW3Wf3o/srFXHhw=
X-Received: by 2002:a81:5342:0:b0:611:2eb4:2402 with SMTP id
 h63-20020a815342000000b006112eb42402mr12634897ywb.21.1712089702684; Tue, 02
 Apr 2024 13:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com> <CAHC9VhTt71JUeef5W8LCASKoH8DvstJr+kEZn2wqOaBGSiiprw@mail.gmail.com>
In-Reply-To: <CAHC9VhTt71JUeef5W8LCASKoH8DvstJr+kEZn2wqOaBGSiiprw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Apr 2024 16:28:12 -0400
Message-ID: <CAHC9VhSt0GkTe8ho2yyP8Bp1rbtiFbp6dNY6m93cvBXJ=aKtSQ@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 4:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Apr 2, 2024 at 3:39=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
>
> ...
>
> > But if we really want to do this ("if mknod creates a positive dentry,
> > I won't see it in lookup, so I want to appraise it now"), then we
> > should just deal with this in the generic layer with some hack like
> > this:
> >
> >   --- a/security/security.c
> >   +++ b/security/security.c
> >   @@ -1801,7 +1801,8 @@ EXPORT_SYMBOL(security_path_mknod);
> >     */
> >    void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry=
 *dentry)
> >    {
> >   -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> >   +     struct inode *inode =3D d_backing_inode(dentry);
> >   +     if (unlikely(!inode || IS_PRIVATE(inode)))
> >                 return;
> >         call_void_hook(path_post_mknod, idmap, dentry);
> >    }
>
> Other than your snippet wrapping both the inode/NULL and
> inode/IS_PRIVATE checks with an unlikely(), that's what Roberto
> submitted (his patch only wrapped the inode/IS_PRIVATE with unlikely).

Nevermind, I missed the obvious OR / AND diff ... sorry for the noise.

--=20
paul-moore.com
