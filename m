Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECED3B4EB0
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835624; cv=pass; b=rzgAXlcQE+zw9afbb3Y3nR5ety3pwVxIWzkPTObwZ/WoUFzS9eWvFkCckG++keGTLGbs29ZBkWtF0VzeGiK7i725y6nh7G2aagQLmX5EoJW3BLMlmt3aBJuzqEuYNxER9xxYN1IJsjpeGeF3Yg8rAasO6JI/tgEXbYe/r/YZx/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835624; c=relaxed/simple;
	bh=xXOwv5xxQP+z3NMAooG7oWXJ2IstPlgwcLJ969ih5hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9qmw+PbuaBRTt8dQaVrFen48kLE1T1t5atZoIZHaZyesxZMLp7pj2a5sZ8n4JyJu9/Pl6+d9qk2wefDCYNvq8PN9FWRKyBtVN7xps0XFHFhtKahtBzD/JHxx11wQ6aybG/ehtxyv44UUFx5ODcMGYW54C3/sBO54KsT0Dj8wNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOSUbFR4; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOSUbFR4"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9773abf811so795736566b.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 05:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773835621; cv=none;
        d=google.com; s=arc-20240605;
        b=kUOsO5zMTrzzd5avsP9iw2QVd1Zmdga32+DQDJGkolCe77sFikPBWS0SWkE8H7rAMG
         OIczNI+CrLv5Tg5ySWx0Y4vSurqD7ABPS6UxtSEMR/M8cZAAfOdhn0mQW9Nv4CamYHEC
         0v4QWsExsFm4SKMqbzICJp3WMU9Puo7B+w37Rzbc8FtxcUTZE76UaE+a6jR0Q/ucKiYu
         z6rdFmNGhvBpiy7JZrNPjvCOXgSOzBdPu4SIhrT+x/jfAQ0ZXSx4aHagdDEq5j4/WkGJ
         Tkg5hq7k1cjnKtGKmrmy6XEtBwOGLH5N2p1Rys2nYIudS6qFLyk1TFCU4F65SPnUUnb4
         vd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
        fh=Hp8ZPOn5sywRWoGEfcX1hoOl1vmyFAMmjoH2jAZfAT4=;
        b=j1FlKIxYAyzv3v6bC+IKljMAQgMwye5vvEZyO0wqer92mzEr4sokitQNS5VeQZL5Ju
         BdfH/ZbnkgFp6sUYOb8/v4Si/jijsEb8hJQMY8djhGm5l1VxJhbaVtuVe/N7r+peYLs2
         MJO/XPq01367h+exgzKxprEV+XH8mYo/PBUOeE9qIkg7L4HfibPETMf/XSF4A0M7dkhz
         BEaAtCpLYUrL6KjlVJ6Tp0cq/7DvJpHC3CS8/YMsj77RUdRQuL/LLB32HQbTRs/GKC/W
         nMFDKkDsTr8hsw9/6yybwPyR9/2b+NrpI3rn7CQ3kDzB2+j1+bUBh8frYOfIqg95autJ
         6pkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773835621; x=1774440421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
        b=bOSUbFR4pUElv87QPJby9DyIzars7OHB/G98km3AKgcAiiP3bnw8rMSGPBbPZXy4b2
         Qu1f4YM8CukZcnOdc0gnxZ8I3feTJUFtweZ6KtgPtx4wuTu82mKkIqcV9S/bndsrMtXO
         kMHyhQkTZjkqGK249wMVBYgfMnRspTcKot0ysmbQmYYitJwVRiTx7MzwHzI9lU+qLISh
         4ask/V+18+GMpF3kszuBBLztX6/mZkmrLqS5oZ8lft0UCbYXxz7qYrLZ7ZjUNzY/hSSy
         xStOL6AOAiN+qRu4h6nDAu7zyVn2hFoX1X+hY/awO/PcQ02oGqobPQDCYQp0K3qa5ffr
         2y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773835621; x=1774440421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
        b=EzreUCS8owkaaKy8wsLdDSGhQqwO5s7YtpoouxtJtZ/Uil0QuFPqQfaQvZenlw4Xw8
         iSZzwUQxiSTxkYwH4gk0kxWNZ1ltOssJKz/K2IgBkoQ915P3fRfoHq/fgaPMTBBrJiLo
         /h7zrYC3wSd+BvgBd0ID+YTGOe/a40kFUkCYG7FpVm36b2cm5nyI8rCttkAVu21Mi7wa
         zoduwk6l3xxR9SQ6w0XCpWphCqeV8S7vkCqlZ/Yahi9pTfHYvKsiFVRbaI9TZANMcoCr
         OvvzDHz7HibEmRQEzTjUnt8gM86U3FsBP/HxI80nU+RRlw7RDVC/GXB/HxNojUZ9eW9i
         rgVw==
X-Forwarded-Encrypted: i=1; AJvYcCVPYJVFKX5fov/UCHVLIpuseeCA187tFhF8BE3YcoJxNQwa5eaMEisPahJL43Ev6AWC9XvxF+qESGugNemoU/kadkazCBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMomolJIMenjOC2RnGTNp+Yz/ZRrSk9n4rJU1mC7IqwYeBeAlX
	6bcwgQXrabdlFZJkI133ZpWi/nskADjsYvRdEIkAN1L6dBCsKeyI+5mXzHvbjT22e7mnVbw4ZZ2
	xo3wT+681Qf41Y1U1SlHTi5AmFx+pYEk=
X-Gm-Gg: ATEYQzwyg9XRMwGbFYIqwWDvse+Im7dR6LMALMtj6XHQ6Y1ck7ZutkBf/KMWWR1fGFe
	3bYz/wqR4b9cjvCcY70UsM/5qoH4Y6rZ2tfSkciL9VSyJmT3jLl47j0MSyx5NqDMiI7zfrS5vdu
	XTy9T7jH2zNoZ9+bt7xqjJRlxYCVlg647YhUDLLPdlK256Z+q/96uz7Kf6FLUtYJrPHC7yBq+0Y
	psJMUmZg3bgredD2baXJFURLV2nIBDfQ7as9bq9S0y3cd4LZ2hMWaPfhClSfLIhMcvyFIlOgK1m
	9EBj0KTjy4Nv326KyHdi9byemh39Z9Q/kRuJVvDm2vlxtguD03Q=
X-Received: by 2002:a17:906:6a01:b0:b97:fe6d:2e4a with SMTP id
 a640c23a62f3a-b97fe6d3a3fmr112673966b.10.1773835620414; Wed, 18 Mar 2026
 05:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-6-paul@paul-moore.com>
 <20260318-einsam-sellerie-2d547dd338ee@brauner>
In-Reply-To: <20260318-einsam-sellerie-2d547dd338ee@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Mar 2026 13:06:48 +0100
X-Gm-Features: AaiRm52zvCWb40EW5edB_L-EubZhlbZT4WB8o_i5sTfBey92Yh1WyoQQt0_imPE
Message-ID: <CAOQ4uxhfvS1SCkp504uDuBmgqSEBYaQDDVAm+JY=w_2fKLbQsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] backing_file: store user_path_file
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 11:57=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Mar 16, 2026 at 05:35:56PM -0400, Paul Moore wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > Instead of storing the user_path, store an O_PATH file for the
> > user_path with the original user file creds and a security context.
> >
> > The user_path_file is only exported as a const pointer and its refcnt
> > is initialized to FILE_REF_DEAD, because it is not a refcounted object.
> >
> > The only caller of file_ref_init() is now open coded, so the helper
> > is removed.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Tested-by: Paul Moore <paul@paul-moore.com> (SELinux)
> > Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com> (EROFS)
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  fs/backing-file.c            | 20 ++++++++------
> >  fs/erofs/ishare.c            |  6 ++--
> >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
> >  fs/fuse/passthrough.c        |  3 +-
> >  fs/internal.h                |  5 ++--
> >  fs/overlayfs/dir.c           |  3 +-
> >  fs/overlayfs/file.c          |  1 +
> >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> >  include/linux/file_ref.h     | 10 -------
> >  9 files changed, 90 insertions(+), 40 deletions(-)
> >
> > diff --git a/fs/backing-file.c b/fs/backing-file.c
> > index 45da8600d564..acabeea7efff 100644
> > --- a/fs/backing-file.c
> > +++ b/fs/backing-file.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/backing-file.h>
> >  #include <linux/splice.h>
> > +#include <linux/uio.h>
> >  #include <linux/mm.h>
> >
> >  #include "internal.h"
> > @@ -18,9 +19,10 @@
> >  /**
> >   * backing_file_open - open a backing file for kernel internal use
> >   * @user_path:       path that the user reuqested to open
> > + * @user_cred:       credentials that the user used for open
> >   * @flags:   open flags
> >   * @real_path:       path of the backing file
> > - * @cred:    credentials for open
> > + * @cred:    credentials for open of the backing file
> >   *
> >   * Open a backing file for a stackable filesystem (e.g., overlayfs).
> >   * @user_path may be on the stackable filesystem and @real_path on the
> > @@ -29,19 +31,19 @@
> >   * returned file into a container structure that also stores the stack=
ed
> >   * file's path, which can be retrieved using backing_file_user_path().
> >   */
> > -struct file *backing_file_open(const struct path *user_path, int flags=
,
> > +struct file *backing_file_open(const struct path *user_path,
> > +                            const struct cred *user_cred, int flags,
> >                              const struct path *real_path,
> >                              const struct cred *cred)
> >  {
> >       struct file *f;
> >       int error;
> >
> > -     f =3D alloc_empty_backing_file(flags, cred);
> > +     f =3D alloc_empty_backing_file(flags, cred, user_cred);
> >       if (IS_ERR(f))
> >               return f;
> >
> > -     path_get(user_path);
> > -     backing_file_set_user_path(f, user_path);
> > +     backing_file_open_user_path(f, user_path);
> >       error =3D vfs_open(real_path, f);
> >       if (error) {
> >               fput(f);
> > @@ -52,7 +54,8 @@ struct file *backing_file_open(const struct path *use=
r_path, int flags,
> >  }
> >  EXPORT_SYMBOL_GPL(backing_file_open);
> >
> > -struct file *backing_tmpfile_open(const struct path *user_path, int fl=
ags,
> > +struct file *backing_tmpfile_open(const struct path *user_path,
> > +                               const struct cred *user_cred, int flags=
,
> >                                 const struct path *real_parentpath,
> >                                 umode_t mode, const struct cred *cred)
> >  {
> > @@ -60,12 +63,11 @@ struct file *backing_tmpfile_open(const struct path=
 *user_path, int flags,
> >       struct file *f;
> >       int error;
> >
> > -     f =3D alloc_empty_backing_file(flags, cred);
> > +     f =3D alloc_empty_backing_file(flags, cred, user_cred);
> >       if (IS_ERR(f))
> >               return f;
> >
> > -     path_get(user_path);
> > -     backing_file_set_user_path(f, user_path);
> > +     backing_file_open_user_path(f, user_path);
> >       error =3D vfs_tmpfile(real_idmap, real_parentpath, f, mode);
> >       if (error) {
> >               fput(f);
> > diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> > index 829d50d5c717..17a4941d4518 100644
> > --- a/fs/erofs/ishare.c
> > +++ b/fs/erofs/ishare.c
> > @@ -106,15 +106,15 @@ static int erofs_ishare_file_open(struct inode *i=
node, struct file *file)
> >
> >       if (file->f_flags & O_DIRECT)
> >               return -EINVAL;
> > -     realfile =3D alloc_empty_backing_file(O_RDONLY|O_NOATIME, current=
_cred());
> > +     realfile =3D alloc_empty_backing_file(O_RDONLY|O_NOATIME, current=
_cred(),
> > +                                         file->f_cred);
> >       if (IS_ERR(realfile))
> >               return PTR_ERR(realfile);
> >       ihold(sharedinode);
> >       realfile->f_op =3D &erofs_file_fops;
> >       realfile->f_inode =3D sharedinode;
> >       realfile->f_mapping =3D sharedinode->i_mapping;
> > -     path_get(&file->f_path);
> > -     backing_file_set_user_path(realfile, &file->f_path);
> > +     backing_file_open_user_path(realfile, &file->f_path);
> >
> >       file_ra_state_init(&realfile->f_ra, file->f_mapping);
> >       realfile->private_data =3D EROFS_I(inode);
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index aaa5faaace1e..b7dc94656c44 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/task_work.h>
> >  #include <linux/swap.h>
> >  #include <linux/kmemleak.h>
> > +#include <linux/backing-file.h>
> >
> >  #include <linux/atomic.h>
> >
> > @@ -43,11 +44,11 @@ static struct kmem_cache *bfilp_cachep __ro_after_i=
nit;
> >
> >  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> >
> > -/* Container for backing file with optional user path */
> > +/* Container for backing file with optional user path file */
> >  struct backing_file {
> >       struct file file;
> >       union {
> > -             struct path user_path;
> > +             struct file user_path_file;
> >               freeptr_t bf_freeptr;
> >       };
> >  };
> > @@ -56,24 +57,44 @@ struct backing_file {
> >
> >  const struct path *backing_file_user_path(const struct file *f)
> >  {
> > -     return &backing_file(f)->user_path;
> > +     return &backing_file(f)->user_path_file.f_path;
> >  }
> >  EXPORT_SYMBOL_GPL(backing_file_user_path);
> >
> > -void backing_file_set_user_path(struct file *f, const struct path *pat=
h)
> > +const struct file *backing_file_user_path_file(const struct file *f)
> >  {
> > -     backing_file(f)->user_path =3D *path;
> > +     return &backing_file(f)->user_path_file;
> > +}
> > +EXPORT_SYMBOL_GPL(backing_file_user_path_file);
> > +
> > +void backing_file_open_user_path(struct file *f, const struct path *pa=
th)
>
> I think this is a bad idea. This should return an error but still
> WARN_ON(). Just make callers handle that error just like we do
> everywhere else.

OK.

>
> > +{
> > +     /* open an O_PATH file to reference the user path - cannot fail *=
/
> > +     WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
> > +}
> > +EXPORT_SYMBOL_GPL(backing_file_open_user_path);
> > +
> > +static void destroy_file(struct file *f)
> > +{
> > +     security_file_free(f);
> > +     put_cred(f->f_cred);
>
> Note that calling destroy_file() in this way bypasses
> security_file_release(). Presumably this doesn't matter because no LSM
> does a security_alloc_file() for this but it adds a nother wrinkly into
> the cleanup path.
>

This is for Paul to comment on.
The way I see it, security_file_open() was not called on the user path file=
,
so no reason to call security_file_release()?

It is very much a possibility that LSM would want to allocate security
context for the user path file during backing_file_mmap, when both files
are available in context, so that later mprotect() will have this stored
information in the user path file security context.

But in this case, wouldn't security_file_free() be enough?

>
> >  }
> > -EXPORT_SYMBOL_GPL(backing_file_set_user_path);
> >
> >  static inline void file_free(struct file *f)
> >  {
> > -     security_file_free(f);
> > +     destroy_file(f);
> >       if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
> >               percpu_counter_dec(&nr_files);
> > -     put_cred(f->f_cred);
> >       if (unlikely(f->f_mode & FMODE_BACKING)) {
> > -             path_put(backing_file_user_path(f));
> > +             struct file *user_path_file =3D &backing_file(f)->user_pa=
th_file;
> > +
> > +             /*
> > +              * no refcount on the user_path_file - they die together,
> > +              * so __fput() is not called for user_path_file. path_put=
()
> > +              * is the only relevant cleanup from __fput().
> > +              */
> > +             destroy_file(user_path_file);
> > +             path_put(&user_path_file->__f_path);
> >               kmem_cache_free(bfilp_cachep, backing_file(f));
> >       } else {
> >               kmem_cache_free(filp_cachep, f);
> > @@ -201,7 +222,7 @@ static int init_file(struct file *f, int flags, con=
st struct cred *cred)
> >        * fget-rcu pattern users need to be able to handle spurious
> >        * refcount bumps we should reinitialize the reused file first.
> >        */
> > -     file_ref_init(&f->f_ref, 1);
> > +     atomic_long_set(&f->f_ref.refcnt, FILE_REF_ONEREF);
>
> No, please don't open-code this. The point is to stop any open-access to
> f_ref. And also below you introduce another atomic_long_set() open-coded
> call as well. Simply adapt file_ref_init() to not do the -1 subtraction
> and use the constants directly.
>

OK.

> >       return 0;
> >  }
> >
> > @@ -290,7 +311,8 @@ struct file *alloc_empty_file_noaccount(int flags, =
const struct cred *cred)
> >   * This is only for kernel internal use, and the allocate file must no=
t be
> >   * installed into file tables or such.
> >   */
> > -struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed)
> > +struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed,
> > +                                   const struct cred *user_cred)
> >  {
> >       struct backing_file *ff;
> >       int error;
> > @@ -305,6 +327,15 @@ struct file *alloc_empty_backing_file(int flags, c=
onst struct cred *cred)
> >               return ERR_PTR(error);
> >       }
> >
> > +     error =3D init_file(&ff->user_path_file, O_PATH, user_cred);
> > +     /* user_path_file is not refcounterd - it dies with the backing f=
ile */
> > +     atomic_long_set(&ff->user_path_file.f_ref.refcnt, FILE_REF_DEAD);
>
> Please massage this and send that patch. I'll stuff it into a stable vfs
> branch that both Paul and I can merge. Paul can then send his PR.

Sure. I'll try to send it later today.

Thanks,
Amir.
