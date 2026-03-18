Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09E3F7E7D
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864054; cv=pass; b=ULt/b8T6gyi2rIfT+m+vTXnBlU1jKsOObUZimIKAogRkS7rWv6KIaYFCNdj0nD2WoFKd8BYJRnWq8Idw5AtBVUNos/0/6lYcJ2kaTz//HKh/xk+5Yv5O6foy6gc+/HSjhsPq3Z1xrieaLjKOdLNwjEI1QJizBk+L2X6kOYipBxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864054; c=relaxed/simple;
	bh=HHWKUxL2f5dmXpuQep9FKj2ZGNOpjWa4Ggq5Y+nPWh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGy1X4QGn9C2bpshyXJfeL6cohrRh1JJdMUhBLxuzikaT/Uuz+pUAlGM3FdcM3/xcDG8mgxHAR3XIL3WVLo0dJqlMpZUnMtt/YB4hTIYvJK3grQJHCh9A5ce5zPbsMvF4B1gpfUENTmQnJfZxsZ+rUoeyI0bTlH7T/m+jRXsobE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NtwOi+jN; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NtwOi+jN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0603ee486so1561645ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 13:00:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773864051; cv=none;
        d=google.com; s=arc-20240605;
        b=ZUg0jlS858i+88IRNyIa6M7teMNziecD9wNNRMgw5RcjctC/sowrythfKDcbUHZm06
         5GNG7V/mMxf9e2DFIpopM+jI5COdnoZgTZOEPkFVUlKT9ig6jdb02ckly0Bs/QI8Et+F
         7a01Ld2UaOpFPTJrPpGPv0B2Rymuqhr6mADouaFxyNHdkFchH6TC28Q3U2s21IExzTj5
         D1Ob3q2In6/gODUsQXLWmbgohU8Ma+pXUSy4XSUSisET5zK8x3rVCAqHW+8CKoXMZkVG
         VJvFFwDUC6yoHnbavysSDrVK0sWulYtwlYYZkNjzbTasgSpP9j6B/Bua9dgLkrfLxCDQ
         RoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
        fh=h5PbycRlo9tHjA5pRFpehTSJcR7r8Nby5ebGBBJrCmc=;
        b=CCMeTuP+AP9ZaeBNw/NTZY0MU8zYDqaf5y+ug9PNcO5aoNulD1WeRT+6kVmd74LwTi
         RzMdJTypIlDUqadBJ7jeFbhFtE1EeacmfBZVw7bkzuHVcbkKEra2LLTV3PJ2sfgRmAG5
         SFQJFZIZr4Xd+z71uASTIqatm0dEEETeLP/Fkayip8RvoLEzn2ATcKAzDNfOK9WLpBt5
         8TEqtXj4JjtsyBckM8TKxgfxnWutQEn8nlemtHEYHpsuk62Iff/durQylKHnMEMlQoTJ
         4oXEijJZjpY8h7youLiEmie3vNBJgY0s0Q7fQtBgRDof9z/2s66HEOFdnrD02IFQsZek
         4wUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773864051; x=1774468851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
        b=NtwOi+jNDtF28Lhp8zGgTXUoZzr9e02O6NwxhSgbyWpLMh0MupV0xrLqemnvKhLS3J
         rtyyDMWJSCQhHtqkRPtdZxjfzYIYUM74b2KcbuePULFo19uyVNn5uynjiB2q9ZITTDTS
         2iLUShgjm9S1UTUxzM2pHSUAR2UrdAS7ZDs8HiWNL/4wGmYTHhNDL9hPJYt3kr+BlQu+
         NiP/F9WLBbVaygTC5oayHgRS32WWHywEpUfj4AuICWV78LkO+zHe2bcSG71MtnNEgVBR
         EGVRRiOp7aKS/N5iNqHgIba5qLwpg35V14/As+qmTFQw/4Y5UXrbV4nccbqL8QVsN99V
         84gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864051; x=1774468851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
        b=Ati90gSAtrZ5jlXC5c30ZygsTeZBHNc4ilXRy7vMvJmXUTlJAgTTU1i3PFXfPlkr8v
         5T7bxA1ZLEFCHfJQg42lc/bsElk7yUuNCBCNxqtPhmnWJQyJK/R8iRyd/DcW6yWOnE7n
         CvK9oI38xr5aUh5IV/NvTSmxKSRLUsm1ayRJxg6uaG1CrU8qJP0BsjzJgG7o2j9PU2hW
         wnZuqRj6eKWJ4zcGsxkvenwGVCj9QoyYUAOD9mN96WHAPt2YbRfE63BLLOzSH3Z8J3hO
         dQqwXP3GDThw4xcluYWjUALIcBwJpvY7mE/THbRrjpwMPtyPzlDyilNm6ZRXJQdT5PNd
         Dk0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOGwc3buYgFWKtdF7iv26OENoNMru2D6BlauBZVlrmJH9cNDZ4iGp3RoxvOX4YsZPMCs8gcMFGze5zY9uMwsmWqxoeQoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWnblx4qnelZ8hXc1uxbjrng/fp7wsrq097dxhiSP036RRXgXe
	VlNJ1Hu3jjy1mw+/Tx+fH2rmMqt4j7fI+KbNv7FpTTdqHLC1yRWSPCUkcPBTZFvPlWWTTHzeKCz
	/yfzOD9P4Lbr4TL0GoVtLOiyiQ+/BXv499bQanMG5
X-Gm-Gg: ATEYQzy9WERM9imcvf33nI6mg5LkAGr/40WqZqDh3S9rz5OTni7inZxyv0M+f9rmVL7
	PhzSP0xGfi+CnbUMwqQsY+Xm1F6J4WGQeCMMvdwjZ2+326Y79lOU2kYJgGEM/i2j/DKOejj/NxP
	1gx8j7IWKFF7wt4O48NnkvxTXLMycnnduPlqRM+RK6zDY//t4pAT4p4iebAk1X49x0bpRDdzdlD
	BJ/VxVnSEFfad5GDUis1Pk2yVJFeGUAV4oBNaoC2K/6YAxYrHAFJASe0Vmm1xky8ssaf1zTNsuq
	/qKLzRwthczKH2fofg==
X-Received: by 2002:a17:903:2a90:b0:2b0:4158:c9d1 with SMTP id
 d9443c01a7336-2b06e3e5bacmr54910065ad.36.1773864050852; Wed, 18 Mar 2026
 13:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-6-paul@paul-moore.com>
 <20260318-einsam-sellerie-2d547dd338ee@brauner> <CAOQ4uxhfvS1SCkp504uDuBmgqSEBYaQDDVAm+JY=w_2fKLbQsQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhfvS1SCkp504uDuBmgqSEBYaQDDVAm+JY=w_2fKLbQsQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 16:00:39 -0400
X-Gm-Features: AaiRm50bTirLC51vuYEkGlExlBIJP04T2IlKkXqzaEFW_Rpzh7aQ_TFopQtvPJk
Message-ID: <CAHC9VhS+83FZoyVOV_tKHOBtVSwK76TS-gbc=cKzL5QK1P21Mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 8:07=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Wed, Mar 18, 2026 at 11:57=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > On Mon, Mar 16, 2026 at 05:35:56PM -0400, Paul Moore wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Instead of storing the user_path, store an O_PATH file for the
> > > user_path with the original user file creds and a security context.
> > >
> > > The user_path_file is only exported as a const pointer and its refcnt
> > > is initialized to FILE_REF_DEAD, because it is not a refcounted objec=
t.
> > >
> > > The only caller of file_ref_init() is now open coded, so the helper
> > > is removed.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > Tested-by: Paul Moore <paul@paul-moore.com> (SELinux)
> > > Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com> (EROFS)
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  fs/backing-file.c            | 20 ++++++++------
> > >  fs/erofs/ishare.c            |  6 ++--
> > >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++------=
--
> > >  fs/fuse/passthrough.c        |  3 +-
> > >  fs/internal.h                |  5 ++--
> > >  fs/overlayfs/dir.c           |  3 +-
> > >  fs/overlayfs/file.c          |  1 +
> > >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> > >  include/linux/file_ref.h     | 10 -------
> > >  9 files changed, 90 insertions(+), 40 deletions(-)

...

> > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > index aaa5faaace1e..b7dc94656c44 100644
> > > --- a/fs/file_table.c
> > > +++ b/fs/file_table.c
> > > @@ -56,24 +57,44 @@ struct backing_file {
> > >
> > >  const struct path *backing_file_user_path(const struct file *f)
> > >  {
> > > -     return &backing_file(f)->user_path;
> > > +     return &backing_file(f)->user_path_file.f_path;
> > >  }
> > >  EXPORT_SYMBOL_GPL(backing_file_user_path);
> > >
> > > -void backing_file_set_user_path(struct file *f, const struct path *p=
ath)
> > > +const struct file *backing_file_user_path_file(const struct file *f)
> > >  {
> > > -     backing_file(f)->user_path =3D *path;
> > > +     return &backing_file(f)->user_path_file;
> > > +}
> > > +EXPORT_SYMBOL_GPL(backing_file_user_path_file);
> > > +
> > > +void backing_file_open_user_path(struct file *f, const struct path *=
path)
> >
> > I think this is a bad idea. This should return an error but still
> > WARN_ON(). Just make callers handle that error just like we do
> > everywhere else.
>
> OK.

That's good, I can remove the FMODE_OPENED sanity check in
selinux_file_mprotect() now.

> > > +{
> > > +     /* open an O_PATH file to reference the user path - cannot fail=
 */
> > > +     WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
> > > +}
> > > +EXPORT_SYMBOL_GPL(backing_file_open_user_path);
> > > +
> > > +static void destroy_file(struct file *f)
> > > +{
> > > +     security_file_free(f);
> > > +     put_cred(f->f_cred);
> >
> > Note that calling destroy_file() in this way bypasses
> > security_file_release(). Presumably this doesn't matter because no LSM
> > does a security_alloc_file() for this but it adds a nother wrinkly into
> > the cleanup path.

The alloc_empty_backing_file() function will call init_file() on the
O_PATH file which in turnwill call security_file_alloc().  We depend
on that behavior as we need to set the creds properly on the file.

The tricky bit is that security_file_release() is currently only used
by IMA/EVM; it was created when we folded IMA/EVM into the LSM
framework, making them proper LSMs and cleaning up a lot of the hook
calls in the VFS.  The commit description provides some info on the
hook:

   IMA calculates at file close the new digest of the file content
   and writes it to security.ima, so that appraisal at next file
   access succeeds.

   The new hook cannot return an error and cannot cause the operation
   to be reverted.

As O_PATH files never go through the
security_file_open()/security_file_post_open() path, O_PATH files
should be ignored by IMA/EVM (which makes sense, as there is no data
or xattrs to measure, update, etc.).  For that reason, skipping
security_file_release() should be okay in this particular case.

Other LSMs which allocate file specific state, e.g. AppArmor, in
security_file_alloc() should free that state in security_file_free()
which is handled in Amir's patch.

> This is for Paul to comment on.
> The way I see it, security_file_open() was not called on the user path fi=
le,
> so no reason to call security_file_release()?
>
> It is very much a possibility that LSM would want to allocate security
> context for the user path file during backing_file_mmap, when both files
> are available in context, so that later mprotect() will have this stored
> information in the user path file security context.
>
> But in this case, wouldn't security_file_free() be enough?

See my comments above.  If we wanted to look into removing the
destroy_file() special case for the user_path file hanging off the
backing file I'm happy to work with you guys in the future to sort
that out, but I'd prefer to tackle that at a later date as it could
potentially have a much larger footprint than this patchset.

--=20
paul-moore.com
