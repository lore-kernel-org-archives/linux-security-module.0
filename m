Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F63A3E7E
	for <linux-security-module@vger.kernel.org>; Sat, 28 Mar 2026 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774715704; cv=pass; b=jdxSmZqJnlqqCklLVjcv1oNjDKHckjiyUKAY+9xxbnjelq5p6e3G27mCCywB4zFPTPdBsqXLC3VPtpBbwVjwjI4/taxDdDeooV5gu7ZYSzxm3IYrL8iGawWL4jNVQZy6uTVBIYzZKQfJ6QFXLvDx/s9BvnUdpAhJaDOJcr9lno8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774715704; c=relaxed/simple;
	bh=s5sN6iliewGZRbUgKiX31JEhzt9vXzLoxPGBEq1Xqlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msegRwoCSOJm0lrn3nN/LU44FpQHNF/7HBU+6UirCq+fGSLLKZEZciAt5rIQOkhjG0ETheI35o+oiGJIB7DA7j4ECCv9PGtZn8Hs2aVvRmpx9AcHeXK7BnDCm8Xu07ydPmDNcZFIZVrsJrzCIpUNxQyv5va7J7Yfr2GpWv2yA7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CegqdAB+; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CegqdAB+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a8fba3f769so12795825ad.2
        for <linux-security-module@vger.kernel.org>; Sat, 28 Mar 2026 09:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774715702; cv=none;
        d=google.com; s=arc-20240605;
        b=TRX+6QuRD9ToG9aLRrxv64tAHCDrWR1+XezjYOV3/D8kz8CN1BPsq3C1v7jD/kd2JW
         2eVVy3kOQS3a3AvbmkEEilRR9kZstEfoUqqfMepNYUcTuQuKi5+dJmzEX7BQs1XEpg9T
         0F6QbvbIg2fwwdfgTN79Grej8dvTFYSXOQRy09uU6fi+pnky76AFZHRHim/SS6Ki40Qu
         tO0dUN+gpLKV/zn1Hk1NdkEdUcBxv8TahxXLNV5oOVVffu9cHZmM7zhL6jkPhrZsgrBI
         JR89MwQPyk5QeQXS9d2KfF8DoQVahkvf2TFD86Ni8f3WyfX76aA0OX65zJHALwXX0hwO
         LKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ususnq+NIOoRs4YDsb/bU1UpkObKkRjHaCrFz3SAoog=;
        fh=0ZO04qxFkQdmROAkPS9lFyMG5VtxUn87TY/IZ6gxk44=;
        b=cw3G1QNlo/ZnUiY1ds1nIvTLjiRpq0jVpqYWMaf7E1Rd+84M6tSDxqu+hhediAldos
         29MhHTHf7f6wCASN93XSye7z5F3jvF0HitWtmEMpo1tkjwSbShZO0ToJp5aJ+B8DaAGW
         AzEftIIRcTHkZHrn1zwvsa6X4o5RANRAUIfog7Rl2J4DyKdkm2h6fO9QAgtjSXivTv//
         CnO8sHYGItVfDzyWD7w9YMh2lTDu8Vk3oYvKVAhRcxM7zey7f2fRd/1IPXzRzQKGdlMe
         jygU0R4VrLHtCsTTDE4ChiPqEtEjzznAicgszfWcwKBnPW88OSzBg2zlMfix3yy5g+j/
         8cZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774715702; x=1775320502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ususnq+NIOoRs4YDsb/bU1UpkObKkRjHaCrFz3SAoog=;
        b=CegqdAB+sl9TfUQ4dDMQci0nnVilGKQCgnPCE4xPJj4OJBbq/VkiqCEK964ANx2AZx
         bq6pCsjiFQ6sY8aMUWy78n/lcSj44inN6oD2sglNt/hsmyoaNgMMyvafcOT5qnvyAIu9
         y8qv9dcV3cQ7CAvPojR9lINOoXp48aFsQOTqXQ7RGo/1aBIla+uwPn9n/o4DE0/oNroh
         XO/8Vww7w6XxOl27j8QIF6Jqbl6IpHmYUhO8p7q365l+VXqjTmbNxv1tU8zqMS5Kp1OL
         ZmbBvtExI7z3CDPofUisX67mAZj9C/Pbqy7I8PiCyWKNhyuQusUWIRJTojmy2s945urc
         hJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774715702; x=1775320502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ususnq+NIOoRs4YDsb/bU1UpkObKkRjHaCrFz3SAoog=;
        b=SQBcriW00hvk2BjhZm/vYOBbqAbW+oXy5Bp9Zw41+PM1NxI3Q9up4LsNOoYT3b4+9D
         R9lxx1Re2l8USH6e3mBmWN4OQ7LGFyShy2gq5Owmf5lSGOaHjAxiqI8JdW57jeLRyI2a
         rYeW/EVBve3OZ+VQDSARLFrEto0ikc84bIxfo+cpR2M0C8IFVNHu9xW+Nz04d8D0Lp+9
         6AUJTdHnsGfVdGCrzJtsKK4SvEcPAgU7jqJ9KtHZcJX1TqFPKMdC6w9TVZXMZ+Uw+VMN
         O/j+5Ymlnkxxng3VgYom6LdcN2eBd/ROTJFRjGVIUc4/T1RV2K4bn30xrtwgkLCk+PHA
         /hFA==
X-Gm-Message-State: AOJu0YymYNKevUc/nmhQfLQKpI3ugtwP7Q7neKuNnP33bXvRbhhsgVYe
	FAGH/YZMS9Dv6JyeAqzZDRcc+ApNi4VZwO/1+U1toA1keXiLQTZGJ0dkCRVXWX5e9OEP+XiHpY2
	0TnCTFjn/5qRRP9gziPjLoI22bQdSi2VbKJlrZEpe
X-Gm-Gg: ATEYQzxKC+CS2Pp/fG9jj5Ft/7hDuk0mkrcaay65BBuhajbVJ1fgRQa+8kGAt0Y3ENR
	RHbZTA66JICYJAk1aEMYGqvQ9QrXbDDp6GlQJZ4indmOBENRHlKSZUcmH/oAQtR1vWaeSb2WR+I
	qOIvx6qYYFcpFm20A0NHuChdM4OTQvtBg/XQvWtsh0WlgKh4i6g35HD6xqZiuiNfacHUNjTganR
	8pCO6sQCnljDEENTauhBqVcEJUskD8QIzHcV92738EicuJY3/Zsxb9L93GA4QoVRVz8VC6LZoB3
	3XPHT7o=
X-Received: by 2002:a17:902:e812:b0:2b0:5fa0:3afa with SMTP id
 d9443c01a7336-2b0cdc9ef75mr73151175ad.27.1774715702275; Sat, 28 Mar 2026
 09:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327220446.353103-4-paul@paul-moore.com> <20260327220446.353103-5-paul@paul-moore.com>
 <CAOQ4uxjvCYRLcRM-JGgtCPXKRB1agCBacN1tmR7hDR9TLdVS4w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjvCYRLcRM-JGgtCPXKRB1agCBacN1tmR7hDR9TLdVS4w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 28 Mar 2026 12:34:50 -0400
X-Gm-Features: AQROBzCPb0SK1-R-ZrfrAvua_40DjlegqsKhZho-n3cMPQ3__jjQot92OFc74FM
Message-ID: <CAHC9VhQQZ69LAGZE2DSyM_qidTJ8oGfqSSvysrO6r9BAXW9mkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: add backing_file LSM hooks
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 4:29=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Fri, Mar 27, 2026 at 11:05=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Stacked filesystems such as overlayfs do not currently provide the
> > necessary mechanisms for LSMs to properly enforce access controls on th=
e
> > mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> > security blob is being added to the backing_file struct and the followi=
ng
> > new LSM hooks are being created:
> >
> >  security_backing_file_alloc()
> >  security_backing_file_free()
> >  security_mmap_backing_file()
> >
> > The first two hooks are to manage the lifecycle of the LSM security blo=
b
> > in the backing_file struct, while the third provides a new mmap() acces=
s
> > control point for the underlying backing file.  It is also expected tha=
t
> > LSMs will likely want to update their security_file_mprotect() callback
> > to address issues with their mprotect() controls, but that does not
> > require a change to the security_file_mprotect() LSM hook.
> >
> > There are a two other small changes to support these new LSM hooks.  We
> > pass the user file associated with a backing file down to
> > alloc_empty_backing_file() so it can be included in the
> > security_backing_file_alloc() hook, and we constify the file struct fie=
ld
> > in the LSM common_audit_data struct to better support LSMs that need to
> > pass a const file struct pointer into the common LSM audit code.
> >
> > Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
> > and supplying a fixup.
> >
> > Cc: stable@vger.kernel.org
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
>
> I 100% agree with Christian.
> This is much better than my O_PATH file hack

I'm not surprised that both you and Christian prefer this solution, it
moves all the pain of resolving this issue to the individual LSMs.
Just look at how the SELinux code has changed, even trying to pretty
it up as best as possible, it's objectively much uglier now, not to
mention more complicated.

From my perspective the root cause of this issue lies in the
overlayfs/backing-file design, specifically how overlayfs hides
multiple files under a single file so that it can plug into the
existing VFS/userspace paradigm of a single file.  While the design
and abstraction are no doubt very clever things, and for the most part
they "just work", there are definitely some corner cases that require
special handling, e.g. LSM access controls around mprotect().  In my
opinion, the burden of hiding any ugliness associated with this
special handling lies with the subsystem implementing the abstraction,
which is why I was pushing for a solution where the VFS and/or
backing-file layer would provide the user file (or a stand-in) for the
LSMs to use.  Unfortunately, that was not something the overlayfs and
VFS communities were willing to tolerate, so those of us in the LSM
space were left with a terrible choice: accept that the overlayfs/VFS
folks don't care and hack around the shortcomings of overlayfs, or
leave a public vulnerability for an unknown period of time while the
overlayfs/VFS folks argue over a solution, with the a non-trivial
chance that the LSMs would need to hack around the problem anyway.

That's my view of were things were at, and why I begrudgingly took
this approach.  I'm sure you have your own perspecitve, and I'm not
going to be surprised if you view this primarily as a LSM problem;
it's a common viewpoint amongst Linux kernel maintainers not
responsible for a LSM.

> It is also what Miklos had initially suggested.

Perhaps I've lost the mail, but going back to when this issue was
first discovered, I don't see anything from Miklos relating to this in
either my inbox or the mailing lists.

> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index aaa5faaace1e..0bdc26cae138 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -50,6 +50,7 @@ struct backing_file {
> >                 struct path user_path;
> >                 freeptr_t bf_freeptr;
> >         };
>
> Shouldn't we wrap this with
> #ifdef CONFIG_SECURITY

Sure, I'll change that.

> > +       void *security;
>
> please initialize it in init_file()

We lack a clean way to access the backing_file struct in init_file().
I placed the security_backing_file_alloc() initializer in
alloc_empty_backing_file() as it was the first place where we could
both allocate the necessary LSM blob and initialize it with the data
from the user file at the same time.

If you want to intialize backing_file->security in init_file(),
init_file() we will need to add a FMODE_BACKING check in init_file and
split the security_backing_file_alloc() hook into two: one in
init_file() to do the allocation and basic init, one in
alloc_empty_backing_file() to capture the necessary user file data.

Do you still prefer to move the backing_file->security initializtion
into init_file()?

> > +void *backing_file_security(const struct file *f)
> > +{
> > +       return backing_file(f)->security;
>
> I think LSM code should be completely responsible for this ptr
> assignment/free so you should export
>
> void **backing_file_security_ptr(const struct file *f)
> {
>        return &backing_file(f)->security;
> }

Doing so would require us to also move the backing_file struct
definition into include/linux/backing-file.h (or similar), which I
tried very hard to avoid as I suspected you would not approve of that.
I figured if you had wanted to expose the struct definition you would
have defined it in backing-file.h as opposed to file_table.c.

Would you like me to move the backing_file struct definition into
include/linux/backing-file.h?

> > @@ -73,8 +79,11 @@ static inline void file_free(struct file *f)
> >                 percpu_counter_dec(&nr_files);
> >         put_cred(f->f_cred);
> >         if (unlikely(f->f_mode & FMODE_BACKING)) {
> > -               path_put(backing_file_user_path(f));
> > -               kmem_cache_free(bfilp_cachep, backing_file(f));
> > +               struct backing_file *ff =3D backing_file(f);
> > +
> > +               security_backing_file_free(&ff->security);
>
> Why do you need to add this in vfs code?
>
> Can't you do the same in security_file_free(f)?
>         if (unlikely(f->f_mode & FMODE_BACKING))
>                 security_backing_file_free(backing_file_security_ptr(f));

See my comments above regarding the visibility of the backing_file struct.

> > +               path_put(&ff->user_path);
> > +               kmem_cache_free(bfilp_cachep, ff);
> >         } else {
> >                 kmem_cache_free(filp_cachep, f);
> >         }
> > @@ -290,7 +299,8 @@ struct file *alloc_empty_file_noaccount(int flags, =
const struct cred *cred)
> >   * This is only for kernel internal use, and the allocate file must no=
t be
> >   * installed into file tables or such.
> >   */
> > -struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed)
> > +struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed,
> > +                                     const struct file *user_file)
> >  {
> >         struct backing_file *ff;
> >         int error;
> > @@ -306,6 +316,11 @@ struct file *alloc_empty_backing_file(int flags, c=
onst struct cred *cred)
> >         }
> >
> >         ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> > +       error =3D security_backing_file_alloc(&ff->security, user_file)=
;> +       if (unlikely(error)) {
> > +               fput(&ff->file);
> > +               return ERR_PTR(error);
> > +       }
> >         return &ff->file;
> >  }
> >  EXPORT_SYMBOL_GPL(alloc_empty_backing_file);
>
> Maybe, and I am not sure,
> alloc_empty_backing_file() should call ONLY
>             error =3D security_backing_file_alloc(&ff->file, user_file);
>
> Instead of security_file_alloc() AND security_backing_file_alloc()
> and security_backing_file_alloc() can make use of
> backing_file_security_ptr() accessor internally?

This is another case of the code being structured so that we don't
need to expose the backing_file struct definition to the LSMs.  If you
would prefer to expose the backing_file struct in include/linux I can
probably make a few additional simplifications to the code.

--=20
paul-moore.com
