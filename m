Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4EC2D4B40
	for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931865; cv=pass; b=UDOkv17YPCPwZUy5rJ4fUnxdXStM1iFpiOgWNpU4vZ6yVt1Am0h/qF3ioz/4C72Zcs5JDYH3iySYnM/1c7nzBf748YBkrK/rQCDJho71ERcNCkFe+4fjFe9QHqDMM5jsGwL6BMOOIFyEiPqZ2TzOHWrwEecsFN4Enw1XPS+FH4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931865; c=relaxed/simple;
	bh=H6hSfyl/3hQMznCb6ljYtpusInK9NAqhtfiVbDB/PnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTlnqYhUgUZ1pU4DGrloqeG3D7uSfuaZbBCSmBH7cm7y4q+jGedgTAA7uBQ+h0aIa+KP3NRWO0vNEkzkjJgSIEgUN2xFK3NqztN/5Gbh6o54SIi0s9eJnlz1BHJd4CEtHKnR6I79It4sSaMKa4peB8tKNZyr2U8rHnjwd/JJgok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg5Te2FI; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg5Te2FI"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b982a80317fso30360766b.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 07:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773931856; cv=none;
        d=google.com; s=arc-20240605;
        b=iMqm9HbA3ERVJBpat5NdNk2zm6iWXiFE+++/5xZLrdJsbvng/cRu+sOaTzNzvxERCO
         FMOs1BiPXusHg/pEnzUSi5YIDl8EBu3zgU5yb5y7KwJJOGa3eU/u+a/B8VUzzjRJ7CWz
         GeTHoF8ziyWjNyLPcSau54OOBXktC/kf+TXPr2fabvc1AzLQzrskjOomuxjgOHv1NUuR
         WfV3wWzD+AY4c7W4zqfXR8ORcs4hdgSbauzvVY81DndQ8+BZGyZAcGMTi3fOd1PvQO9v
         4GIWSZP780XdVYJf85QuwsOOaHEEcvLoog/SkMAGNVYY48AB05K3MTL6eqCpNcoaqLLu
         OWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        fh=4vcP5VHuGEmn54b67heNWxdBK4Dfx1vP4hixXdAAMsQ=;
        b=FQz3Y+kLVeWfeQG10NgRkzIBNchHJ6vcJdbJKOJjIJiVIZ0zvL3vCiWiemfJwgcMa/
         xHLWW3aZiF14hPEbrraqhKmnilz/vwVP5dUMWXCVNXhU8ZdfYvCOaRr5zSYFAp9O2QTr
         ItMIKxPERhGTNfe47d+Wp1CnEc3GmU6puDJUfj4uQACi4sS4KaXS3yBm3mReOAnmE9xi
         9uAVlEfVMypKpLmfQER8Zv3pYa1iYxAHRh2WChcD1GMJq5sfBTz5QrKJAyKlAq29Id24
         h66+BMbZgEVgpS3+w/Rw2lGfODie3SUF7RYREPlfYxdewOGlvpuwplDiAUG8U3ejaxvm
         mQBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773931856; x=1774536656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        b=Wg5Te2FIL+Zl2jNxs/ZAhXPzndGtbGUHGjqvngec5teIxWvdWKMQyQf6nJ0fgvvMh6
         tIqApBZdWMl288cehQz+j9P9XRMyhKag1+3x/WkGdOy0aQE8/s2QB7SMPW5r0qb6cvPf
         pJyu0JNh9Ho6ylPDJiXLaZvtSnf/7QEuE745zQbrNYJMuvCcNR/IJ6VCBWFvjgPuvQq1
         ggu5XDiJV4zwF8Q4wFM2CiZBySHQXmd/IUEIVBZNHI4hFRIJAN3hZHBD6UQqY89IDmH5
         pp5Ph/clzdpsMOX9bcYFKgQojKLwmRYAlKevMF5+b0evAxOQXjKzovWVWIo+UCJudabz
         kfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931856; x=1774536656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        b=B9ZE7QLT2AX14BGJMw9R/RSlhxcEheXOh5ftImml1yE3bZ0p7yUxIXDpBcC5HB4xc9
         5t1nxYWtWYFXm6nojS/iweC3FsVV42y8mfQuJWZmXdPjSRVJVU7Llhpel5xMpIyWnC/o
         aDcnV16Bj2E2YuMz4Q1wBVI/+E0G2i25EkuaEdG9T3N2Ixqwxwst+MSDwVhwC2w+L+OG
         L4h2Y7zgNcrWZCqk7EtNmJLxe+gqyMnyBAskz7Z9vyP/UV1JcrdY2hKL2dehCVK9HOxv
         f4dy7bCHyweZwW37EeTW3uef3eDOdHXMz9DVI/6zTL/d4b/A+Z2pLXIyUTWAGCro8+WH
         1Rxw==
X-Forwarded-Encrypted: i=1; AJvYcCVMFPzN0jogUDTY/F7N7yUrLGgeSGpsUlyekdOfUQi7iUxZTi0f70UdaVlYvQ4JkJWRng4k48djcABAY0a/6kWfu2Ofj6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvKjcqKJR5cJiD+XqEXq82PEixHB+Ip1xE0CMfKG073OmAddPl
	UZ0z0TP9i1QM3CdP3/dUc086H10uBNI4Sp/9u1Sun1WcU+ZQYWlNLCZfLn+zrRflv44vgUnjdcV
	Y0dae6e+XgjLWsfGgjxGfa5BSuRv3YqA=
X-Gm-Gg: ATEYQzzKvQepyE9Nv4cGwPgPp9I/lDUrRxSdDFBg4bNXc9L1mKyf7OL9a8CZiz8YNGK
	5VOmAoYFYcz3KW1+jfFfxpfhWdCV+ky7RLbnly5c/5VUDv9GNX5m18u/g6FTdRCt79JIzTOV/fr
	2MrmYaac231BHE9nnnM1ckySYSfvfj0R86wYVMCUHRGzRxxxT8uW0DwnsQL5Lg5/EEdUiu+kO/V
	SAybpxbG3TVe1fimdjonGom91g++uoaEk+IgJWmHm+5rsiAlA48aQOfgI6FIaX6dKn5OD4OtV3m
	WF8kflDaELCd5WBFXva1PTC0XglUvL71raJgrdgT3fBJdTpMp90G
X-Received: by 2002:a17:907:1b06:b0:b97:aea3:86dc with SMTP id
 a640c23a62f3a-b97f48e0c86mr555307866b.15.1773931856096; Thu, 19 Mar 2026
 07:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319124616.1544415-1-amir73il@gmail.com> <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
In-Reply-To: <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 15:50:44 +0100
X-Gm-Features: AaiRm50Tod8HscrjlQUl55658cqI4Ii7lNI4-xMEI5BRod0xGVsfCDlxh5_S6TI
Message-ID: <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Gao Xiang <xiang@kernel.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH file=
.
> > Skip setting them for O_PATH file, so that the O_PATH file could be
> > opened with a negative dentry.
> >
> > This is not something that a user should be able to do, but vfs code,
> > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
> > before instantiating the dentry.
> >
> > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Christian,
> >
> > This patch fixes the syzbot report [1] that the
> > backing_file_user_path_file() patch [2] introduces.
> >
> > This is not the only possible fix, but it is the cleanest one IMO.
> > There is a small risk in introducing a state of an O_PATH file with
> > NULL f_inode, but I (and the bots that I asked) did not find any
> > obvious risk in this state.
> >
> > Note that specifically, the user path inode is accessed via d_inode()
> > and not via file_inode(), which makes this safe for file_user_inode()
> > callers.
> >
> > BTW, I missed this regression with the original patch because I
> > only ran the quick overlayfs sanity test.
> >
> > Now I ran a full quick fstest cycle and verified that the O_TMPFILE
> > test case is covered and that the bug is detected.
> >
> > WDYT?
> >
> > Thanks,
> > Amir.
> >
> > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2be
> > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir=
73il@gmail.com/
> >
> >  fs/open.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/open.c b/fs/open.c
> > index 91f1139591abe..2004a8c0d9c97 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> >
> >       path_get(&f->f_path);
> >       f->f_inode =3D inode;
> > -     f->f_mapping =3D inode->i_mapping;
> > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > -     f->f_sb_err =3D file_sample_sb_err(f);
> >
> >       if (unlikely(f->f_flags & O_PATH)) {
> >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> >               return 0;
> >       }
> >
> > +     f->f_mapping =3D inode->i_mapping;
> > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > +     f->f_sb_err =3D file_sample_sb_err(f);
> > +
> >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ) {
> >               i_readcount_inc(inode);
> >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode=
)) {
>
> I think this is really ugly and I'm really unhappy that we should adjust
> initialization of generic vfs code for this. My preference is to push
> the pain into the backing file stuff. And my ultimate preference is for
> this backing file stuff to be removed again for a simple struct path.
> We're working around some more fundamental cleanup here imho.

Fair enough, we can rip the entire thing from vfs if you don't like it.
The user path file can be opened and stored internally by selinux
without adding all the associated risks in vfs.

Paul,

Please see compile tested code at:
https://github.com/amir73il/linux/commits/user_path_file/

Feel free to use my patch as is or reorder/squash/rebase as you see fit.
Feel free to attribute my contribution any way you see fit, just pls cc me =
for
review when you post v2.

Thanks,
Amir.
