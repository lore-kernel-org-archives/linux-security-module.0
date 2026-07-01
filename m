Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA94963DC
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910534; cv=pass; b=kcOm6aSOUl0HGGf5iyKCgxF8gvP5gOtQo7onuPrS//P76UQWuYisde/q7HRd1c8Nr9NLLfFXGhJ9E5nX/P4p38UWe2mKdD2ItMjIxp6zpIq7PjByZG25dyTZxeJuRFaOwbrojszHgHuhAjWg65Tvkm4i8ENlYUTrUuQx9LFJhjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910534; c=relaxed/simple;
	bh=wA34yog5D3zzm0E4fzCRQgoVkgu33TRvDEqJe+rugrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xc9yjA1+5sqA55wPPgZNgblk6p7wZaukClLL/MuNvXbbYGm3KPeo+NJgDGL2PZVe4+nlcP9ZbKzninLTC5FZLIwFsc1u+GEI799urDPpzf/J40fHgrlstM1VjJnXDV7NpIJ3aLQszsLYLy+cI75XDFVeaJaZm+m6gmzDKaCK8iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XJOeGYL2; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XJOeGYL2"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37fc01881f2so555098a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 05:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782910532; cv=none;
        d=google.com; s=arc-20260327;
        b=EX99Tgzg5mw3LBhpezSKPFbrdVRaIeZXAJ5EXG1ES1LFfosQ6a3BL8WPIwZdKeFxeh
         syOvlNFOkgX8hVFPDbaAuglISqoYt2xM6caKubTLrjDNPdtgPaHikWkb+AZnu6fE1KzA
         Ws1xO+ZaHq67V2tFL5hNo9TkUXk1aK5Hnn8aW+IVn4tVeM/PCpu1FoGwFFe3NU3Rrlzk
         jtDf7/0PfWlwtBDSSshccegHhzQwgp6RSYq8tM+PxvCuL8IeAdNBtmNqHzyxRPE/L9V3
         vo0kf+/Wa887/FsxnjpKhgc25UYJLSlJpJfQ6dZ66WM7fZCuD4uEG1TwvYQCQgB7D7Fh
         S3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h90qlgRkzmvvEIOKUZmmGycJu0XT3aZbSOeN9EPvQ6Q=;
        fh=rUx6dPBILfZobYEOFM7j47FM9V7SSGOO8BU77RoYUD8=;
        b=le1x5qPOb0CKnis9HSYzh36oJhF4fK8UYQvzz8SKNC3gki6UY6BndpwJCRyfxs0jA6
         NCHqTk72TjnADxg8GbMOhrg5HFB4jSkQRrtunZKY0GDXI2s5vfB8OOrXIL9DX4nD1mpP
         g9ec5rGxbJ09g7ud1z2+FVnUfeaelBLGz404NAXr56yJ9Sl1OIEmoS9M/KJYz037q1Nk
         nsg5pSc7pnl8x3my1CTNku5p3Bb/PpHqRb3XQ1ytfIx3aLEj3/5/Aamg7CnsRaaU/3cY
         ezgOyduuzTUZLZ1/iGjyb0lD+ovp+3m6Mr9FGBhi04uA/pr//iSgz0ZfA8TERuHfUdRp
         jSdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782910532; x=1783515332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h90qlgRkzmvvEIOKUZmmGycJu0XT3aZbSOeN9EPvQ6Q=;
        b=XJOeGYL2vnZ3JRE/Es/sxl+AEl6mmciMEHV8WocRMoqDSpvCRiZLTHCKfagxX0jsjp
         rZ1/Pgg440tx5WIodjMLHp7WFDhpKee6Cw3+MyK+IVYRb5y4DJnUwVWwH2Ykvu0mYEMa
         UuS9z2EawbiuzRBLbcZfqMtjyEMAQ5o9EFYqKgmvlM7vjk1h0rNIvCKNT9iTouvpeSO/
         Ix89Eab4y1vxTcJV/c3YpT8YkT5/p3wXGdYJ8OsgLpf1ypdvzdGRwpjDjpeFcm3F9OxG
         ZrGRMLWMXUdNaN6PvZXcRLBPym5egq3X+PWeqsoM+e4sTqOxKToNcgGXWhzthx5NPnD6
         BdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910532; x=1783515332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h90qlgRkzmvvEIOKUZmmGycJu0XT3aZbSOeN9EPvQ6Q=;
        b=JLt6RoRzEQeda0pYC01ABD4zL9U99wu4gInrYouslGrzZnoiX8v2hndMnFaJBOPSX+
         ZmQBr9aABuxeE++1ClTTmPEPNBtUbefnAaneNOm80A7PIMhkWBrvf8jdgJa6mvVcpqgh
         tl02VMj64RnncKlYBfSk97COGxvs/CeA0QZTGjqut4s3gIihKIXq4HYw/ZbV0Wfpd5c9
         brG/1T+iY9LXwslLJOhZxT8YNGek32OQrAPNbDWyRZbpfu23J8kjXvFaYYKi+CsVrRYl
         qjP3WbXf/eEO+zDggq28nQafZxZP2jTmp7hNWmsYGYJe8xPOwW5PIPNaQCJ/wvfS7Oz5
         2glA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/HCHlJy6b9lt7I7RBENQZ6fZI7ncgLt23+13sURshfIDcADA2owvoYBBYo2OuRmA00aR+xakX/SORE1buNBVWddI9ifk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDsYFTb9jwCwXV4Vw11pXV9042RouiK2EbrWqI8ReQEKezZNs
	VJFpDlhybTEPhJ/3HsnNuu3nZIWWM2ibiWWtVy5ZLICGQT2du+llogNKsN2qKcXtw/SQ9UzOC+Z
	5GR5nhKOt7ViKCgU6QCeqKCEta+s8GZJBWIuvGWB3
X-Gm-Gg: AfdE7cmM/CPfQNi8fWaNPX9DhFG2WNL/BUnxp0kTMVzRVo1wZiuO9JkrVCxD2+KSCnc
	gXoChSasbXUYnvbtJ0gpld0JXr1cl4ShmC4bjJo5iMSJ+DcH/P+XOXbS9On+11JNSoh1XRCy+Tw
	dnx4kaYkUPgsI64tEWPt4LxYwX9jJpN6XwJGPVJhyPMbr1yr8cmpnuxxaEBtwZQGhJMEPd4YKhS
	Xpa4eL+BUNiqwWwyAgrTYYaroq6te4A4FY0I445IPSxMaLYRhSL2O8VNtvNBWyIXd3Ivs7l
X-Received: by 2002:a17:90b:2d90:b0:380:9d0d:7af4 with SMTP id
 98e67ed59e1d1-380ba86979fmr662539a91.12.1782910531759; Wed, 01 Jul 2026
 05:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com> <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com>
In-Reply-To: <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 08:55:19 -0400
X-Gm-Features: AVVi8CflgdtI8eLFled3oYp6VOVsv_lBHqIjUE5-aLf2A4hxkcukFfwR6m0D7v8
Message-ID: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 2:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue Jun 30, 2026 at 12:20 PM PDT, Paul Moore wrote:
> >> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> >> +                                    const char *name__str,
> >> +                                    const struct bpf_dynptr *value_p)
> >> +{
> >> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern =
*)value_p;
> >> +       size_t name_len;
> >> +       void *xattr_value;
> >> +       struct xattr *xattr;
> >> +       const void *value;
> >> +       u32 value_len;
> >> +
> >> +       if (!xattrs || !xattrs->xattrs || !name__str)
> >> +               return -EINVAL;
> >> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
> >> +               return -ENOSPC;
> >> +
> >> +       name_len =3D strlen(name__str);
> >> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> >> +               return -EINVAL;
> >> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> >> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> >> +               return -EPERM;
> >> +
> >> +       value_len =3D __bpf_dynptr_size(value_ptr);
> >> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> >> +               return -EINVAL;
> >> +
> >> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> >> +       if (!value)
> >> +               return -EINVAL;
> >> +
> >> +       /* Combine xattr value + name into one allocation. */
> >> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
> >> +       if (!xattr_value)
> >> +               return -ENOMEM;
> >> +
> >> +       memcpy(xattr_value, value, value_len);
> >> +       memcpy(xattr_value + value_len, name__str, name_len);
> >> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> >> +
> >> +       xattr =3D lsm_get_xattr_slot(xattrs);
> >> +       if (!xattr) {
> >> +               kfree(xattr_value);
> >> +               return -ENOSPC;
> >> +       }
> >> +
> >> +       xattr->value =3D xattr_value;
> >> +       xattr->name =3D (const char *)xattr_value + value_len;
> >> +       xattr->value_len =3D value_len;
> >> +
> >> +       return 0;
> >> +}
> >
> > This is not a generic VFS function, it is a LSM specific function, it
> > belongs under security/, please move the code as discussed previously.
>
> Paul,
> Not quite. It's all about xattrs.
> Having "struct lsm_xattrs" in the arguments doesn't make it lsm related.
> You needs to study existing kfuncs and tracepoints.
> A bunch of them have "*lsm*" in the arguments.

Alexei,

I'm sorry you don't understand the basics of the LSM concept, but
please look at evm_inode_init_security(), xattr_dupval(), and
selinux_inode_init_security() for some background.  There should not
be any usage of lsm_get_xattr_slot() or BPF_LSM_INODE_INIT_XATTRS
outside of security/; you argued a similar idea to justify your NACK
of Hornet, I'm simply applying the same logic here.  We also have the
very recent security issue caused by the BPF subsystem which failed to
acknowledge that the admin disabled the BPF LSM and then walked all
over kernel memory when it shouldn't.  Moving LSM internals outside of
the LSM creates an environment where flaws like this can go
undetected.

As I said previously, if you absolutely insist on the kfunc being in
the VFS kfunc file, the LSM specific bits need to be abstracted out
into an LSM function.

  kfunc bpf_init_inode_xattr(...)
  {
    /* sanity check params */
    if (!xattrs ...)
      return -EINVAL;

   /* get value/len from bpf dynptr */

   /* hook will check for LSM specific xattr count/limits, allocate,
copy value*/
   rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
   if (rc)
     return rc;
  }

David, if you like I can provide you a patch that implements the
security_lsmxattr_add() hook above if you aren't comfortable writing
that, but if you want to give it a shot that's all the better :)

--=20
paul-moore.com
