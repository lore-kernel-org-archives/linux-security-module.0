Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D376082
	for <linux-security-module@vger.kernel.org>; Mon, 18 Dec 2023 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F95aym8v"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbd4a10735eso717486276.1
        for <linux-security-module@vger.kernel.org>; Mon, 18 Dec 2023 15:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702940798; x=1703545598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ISbTIIGiRfCmq/xufZ2VhS6krg/p4Uisq2A0AgAr0o=;
        b=F95aym8v+e/B7FHOGKUzdNBrNJ4LU0XQODj6QLv6aSqDo1YrmjywRZfTWtthIi/ZnJ
         jl7fUBacAyUKKNaR90UvTFVrgI6O+zFHCl+UshXYXmm2XAoZM6c2YTDYOaHG+yHBmNQm
         pc3gkptqarYRjJZ0xul48F98hspNKqpHejgIx2CBCyDfIzV3oP+bB3Fi4ucGqdc+pJf3
         Z+kZW/W5fxp5zHLSN/YcyXQXqBkvKzK4Fcc35XGLiF7tRat+DrACuduTn0O6ZtRmbs87
         akAL6FDi5+Z8/ghkg8TMsod+4G5PwvaH1cokErMCuDQhoUYJQ0fjhAYtgDEGIpQ7ZcB5
         oGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702940798; x=1703545598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ISbTIIGiRfCmq/xufZ2VhS6krg/p4Uisq2A0AgAr0o=;
        b=LNIyNlV/HD/cY8fVCDqNo/FjAFahyV1iFoGrGXys4Sn+EJNUUOWc4fD2Foy4H+gOJ3
         lbPt1o/2YNdoa7piewRxZ4IYjutbUkPKk7l+Q3m/xXMyFheuP9rPg0tZQzd1KAbi7TUD
         qYU+tDEh4xJyU6eFCxaKNX0sp4qNysyx1HRBN+u2gotK7PS4VkFRERwti7C6+Gy1eDv1
         O2UrIG5KqbjRuT0M8Akq8mh0yhEvQw45SgGGpWfh0PdGsL4W6fY6WGXw/OGLx/BIus6C
         idxfMjHNHU05sztKDNc3TEhy9LEqalOhZ3+AbvU8xEk7T5/9u7jOUIyEuScSY7RITX7d
         zkHA==
X-Gm-Message-State: AOJu0YxyIhiBJXNoJ/0k7lEijtynQltCAKpDtusYOt9niC/JN5JU3n0Z
	71dKi3OntFoH+nUvk7FXkEA9Cqpl2gbDOV30CJQYTmo9Yq5FjfVzWA==
X-Google-Smtp-Source: AGHT+IF9tvbbBtBESqqHaSUt2obipOpR1nDsNFSA0VBd9FiKyVi8ta2GbNjZyjCOzpO6p39Z4BPWa3ZnsyADLzk/ssU=
X-Received: by 2002:a5b:5cf:0:b0:db5:4532:8ea6 with SMTP id
 w15-20020a5b05cf000000b00db545328ea6mr10626822ybp.51.1702940798137; Mon, 18
 Dec 2023 15:06:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADN=F_ke996vNXDNz6vZ_As0Ms5Q2X7aT3t-SSGRiqdeKd6gCQ@mail.gmail.com>
 <20231216041116.GA78578@mail.hallyn.com>
In-Reply-To: <20231216041116.GA78578@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Dec 2023 18:06:27 -0500
Message-ID: <CAHC9VhRmaT=gYM1qNaZ2D=9mz7vyhZLxU32gx11SpS2dNj_w5Q@mail.gmail.com>
Subject: Re: [PATCH] fixing userspace memory dereference in security.c
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "T. Williams" <tdwilliamsiv@gmail.com>, jmorris@namei.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 11:11=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Wed, Oct 06, 2021 at 07:03:56PM -0400, T. Williams wrote:
> >  security/security.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 9ffa9e9c5c55..7c41b5d732ab 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1737,6 +1737,8 @@ int security_kernel_read_file(struct file *file, =
enum
> > kernel_read_file_id id,
> >         int ret;
> >
> >         ret =3D call_int_hook(kernel_read_file, 0, file, id, contents);
> > +       if (ret > 0)
> > +               return -EINVAL;
> >         if (ret)
> >                 return ret;
> >         return ima_read_file(file, id, contents);
> > --
> > 2.25.1
> >
> > This commit is to fix a userspace address dereference found by
> > syzkaller.
> > The crash is triggered by passing a file descriptor to an incorrectly
> > formed kernel module to finit_module.
> >
> > Kernel/module.c:4175 : Within the finit_module, info.len is set to the
> > return value from kernel_read_file_from_fd. This value is then
> > dereferenced by memcmp within module_sig_check from inside load_module.
> > The value is 0xb000000 so the kernel dereferences user memory and kerne=
l
> > panics.
>
> Hi,
>
> thanks for sending this.  For some reason, I can't seem to find this
> message-id in lore.kernel.org to see if there were ever any replies.

I'm not sure where the original email/patch was sent, but I don't seem
to have a copy in my inbox either.  Odd.

> There is indeed a problem, although I think a more concise explanation
> is:
>
> 1. security_kernel_read_file() returns any non-zero return value to mean
> permission denied
> 2. kernel_read_file() returns > 0 meaning number of bytes read
> 3. hen kernel_read_file() gets any non-zero rv from security_kernel_read_=
file(),
> it returns that value unchanged.
>
> Since kernel_read_file() is the only caller of security_kernel_read_file(=
),
> I think your patch is good, except you should also change the comment abo=
ve
> it to read
>
>  * Return: Returns 0 if permission is granted, < 0 on error.
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> I think the reason it's not been a practical problem is because while
> security_kernel_read_file() will honor a >0 error from an LSM, no
> LSM implementation of that hook does that.  (Only loadpin and selinux
> implement it)

The SELinux implementation should only ever return 0 or a negative
value, and based on a quick look at Loadpin I would say the same
applies there as well.  This patch doesn't address the IMA hook, but
according to the comments in the IMA code, it too should only return 0
or a negative value.  While it is theoretically possible that
security_kernel_read_file() could return a positive value, I'm missing
where/how that might happen.  Help?

That said, I agree with Serge that this is worth fixing, and in
addition to the comment suggestion from Serge, I would ask that you
fix the IMA hook too.  I would expect the patch to look something like
this:

diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..dd8bdda166f3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3043,7 +3043,7 @@ int security_kernel_module_request(char *kmod_name)
 *
 * Read a file specified by userspace.
 *
- * Return: Returns 0 if permission is granted.
+ * Return: Returns 0 if permission is granted, negative values on failure.
 */
int security_kernel_read_file(struct file *file, enum kernel_read_file_id i=
d,
                             bool contents)
@@ -3052,8 +3052,15 @@ int security_kernel_read_file(struct file *file, enu=
m ker
nel_read_file_id id,

       ret =3D call_int_hook(kernel_read_file, 0, file, id, contents);
       if (ret)
+               goto out;
+       ret =3D ima_read_file(file, id, contents);
+
+out:
+       if (ret > 0)
+               return -EINVAL;
+       if (ret < 0)
               return ret;
-       return ima_read_file(file, id, contents);
+       return 0;
}
EXPORT_SYMBOL_GPL(security_kernel_read_file);

--=20
paul-moore.com
