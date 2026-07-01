Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B9481FAD
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918581; cv=pass; b=h+EXLHqKnPneWcbnjKqPX9nhYEQZfBOfVooSKt8pQA4JTrPWeeDYnwbKQI7gmSjapmy2QFl9PfbtoK9eW2r4t3xVUmOGq6wWb0uCACBm65XK3aUa//YrKEuvgPp7hLgcOE+hHbORYmtV0pYo7+A/kX4eD7+7epb8101Us1dWneU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918581; c=relaxed/simple;
	bh=7M2c8VTJCknMV3dlvitg2YbEGnXAzIGFFQtNc7mfEiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plYR3kPxzdCbI6yUkqCq+C/Ipa5h7MN483sSk7BAfJxZxNGZAOFsP0fvgA1eLmhH7H7lqEVGv/CFUWINLpTlsYd2hGSLlj6+F4v2BBpkxIrQ8NYH8ftjzwuqziOD4eZB6y5UCQ5QI6PDsDuCE0EwjUwvhc7uSaRwPdEkhFhO/zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EA1350GK; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EA1350GK"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37ffdc718f8so463486a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 08:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782918576; cv=none;
        d=google.com; s=arc-20260327;
        b=nvQJBqc+CM4On9Rzqpxkbw3QYxPhfRVYcFrEEXSW5LNsL2Cy7HhyXDvyN6jQ46AInj
         6i8X0Bi9ONbXAJuzmA7DMbP8U8mBQgeC5Sd7NIt/BEDePa5Dp3hPlaweEr9QOfvKJypv
         jMB9bdEMY3FjXO/d7nSmqyfK5qcS7gegep0nkN+6hIHM92eN6NN+glzdgTm7+UvLVqdL
         fbvUjUbRs2mRG6qFjIu8Zy84i0YO02kRUxPNJE+X2Ks4izM+0xh/KWbze6J9EQvH8DA6
         gIGKuwAnJhP1PdMW5tX0IT3syRF+KqGBuys0l19QM9/MXoNCKrH7KzhLAI4WHQS1mfEh
         3LLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EiDHBob2ABPUTvdRmOeqDRgvjmRDWIfShl42n0T52g0=;
        fh=tBYtb4qtozYVrVjE9GcwO9iQs/kIGzNq2jGgOcp5E6c=;
        b=Kr3V0Xl99IJL2PEo434nbc7J7cahJeHoRqb0d3NhbdQP6zSVwyBP6zuDRzkSsbxcIT
         pgBhGC9WZiU1c/TyI1ktjcm7PiPTL/NHobd4qV2LdBkB2/LgoqBsZ3TyFVy4+EdwsBhh
         GIgD+r6kE/1aV+Bl54Ahwk0ArNGRhF3vruDLzQ3YLuJHeY6lRkClfo8ZxG5pHJ7fIU8l
         eGqSlUjeAIRDDgm8uMaXBcTiAJOrAVFTHt1/C8qcNAn1F/IkaZuRkoKnFNc6sE0WVPLA
         mSeT0p3JclcYgOq4rmkhvrCATqt+Li83Qc+llO33j9n3l6LGg4VBCIVkSRUse/PVODu9
         K+GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782918576; x=1783523376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiDHBob2ABPUTvdRmOeqDRgvjmRDWIfShl42n0T52g0=;
        b=EA1350GK7TBvwQjRPxtTmy0xOLK6+1ocpKMN/s3yCUZoPqzoI1izrKktlLbr4iMk9r
         xbGaco5NJ8ZuRerWfuse4SrvNb5yFm8Wo/2Nt+QWaXbdqQjFqLgl3ZG3z89t5q1tM7o7
         0IqWZQtts8lxFuW1JoOO0sQAvVCB9VnGnXrUUdj1qf7/5lyF8yBzIHENte4XHZ0sFsGw
         t5xrgXNaYYtAD/T8Mes8p8dOs2aTw6uMpS5uQpHKMHLxOohxaGfh2f6ImPT4LrHlT69m
         HgLjt1hlyv5scAn6JaJA0j0yiAc8615T+lyCM/MV+UVxx94HslHRYXLMzviaxTXuIwQG
         reow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918576; x=1783523376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EiDHBob2ABPUTvdRmOeqDRgvjmRDWIfShl42n0T52g0=;
        b=dVQOXXyWbCfydC80afsXkzA6sJZDWDOSBgkNpq6ZiBs90aKgDTAHXMW8aj4NopEzMj
         XWOv8nnSMvg0jdyxpSW7JY261eEb+j7amGhGoREzJXTfPf0Xe4Q1zA5Sjn3zn+NL6h6D
         fdaYXeG0R+CCA7Oe56yp01j0OH27TJ/zLM3ZBRwNAjFlu3MTssqZT51Zb14Dbg3U0V26
         nc/VsFccHJzAua1YkCun8dGq1SX936k5ttKMBwyPQAM4UHC8Ac2F/UkEa7ERXa1cHUJG
         eaV8FvMqRcOzN+CBhbe5Ng1CDHpo6Y29lPRYcmHIv20Y5/96s4v+aH7Txwj7Zu0bBwMS
         9Spw==
X-Forwarded-Encrypted: i=1; AHgh+RqznNf7Sw8NSMR+LMu62E36VmjZZeiK7ECrgsx+O9qtVsZteqT8miVR5DDkpJ8eWm6bkwYlVldowSGI3q3Yq3jS2GulVoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbwrfCYGJ6FKaclWj7V5oV0KQJn7rMG7m1x+JEbP2nk6VPmaFK
	XFvi4BRWc8VEhqMh+Qxj+xkMFhQN9uPGlj+teAkbeLYZ3Wesh+eGAmhG9gPxDZpxQh4yIdVWKdq
	47IqTz5rYuwYOMhKfYmm5cvEN+zlLPiFW64jhDa7c
X-Gm-Gg: AfdE7clWi0yOQynXqsBiz3BnHbMz23r8qKrD4UUEzUSYGBajbO3HJeOSwkY0lRW/LlB
	F6vvrshT6oyI4GzQFB3OBZvUN4IbFkhfEkHwt2XrZCKgVdD5ndWz2IZAvlhiDdTghV65S3ezVhB
	kA+Czt8RXyLPCjaJ+6cg0GmAYJaAaBG0tDZRdhrHUUPpIr5pc7UGYJDwjsaBUzlIWcYMdcAqSAu
	uzaRCb1d3W+U5Pevwilz+OzVUJN0XEj9gtT2NMa++wfYhNpVEKMMyw0cjlqi58GSR4N/cLW
X-Received: by 2002:a17:90b:4f4b:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-380aa1427e9mr2152660a91.15.1782918575927; Wed, 01 Jul 2026
 08:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
 <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com> <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
In-Reply-To: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 11:09:24 -0400
X-Gm-Features: AVVi8CcBAyyRDQX1axrqRUEsD0mhbBnmDeJwn8TvqCnNRpyrxWdbtlabDC-kdt0
Message-ID: <CAHC9VhQd0-N1g=g8gspeV7bhLz0LA6DF5HZyB7mW6VW_7oSt2w@mail.gmail.com>
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

On Wed, Jul 1, 2026 at 8:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
> On Wed, Jul 1, 2026 at 2:09=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue Jun 30, 2026 at 12:20 PM PDT, Paul Moore wrote:
> > >> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> > >> +                                    const char *name__str,
> > >> +                                    const struct bpf_dynptr *value_=
p)
> > >> +{
> > >> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_ker=
n *)value_p;
> > >> +       size_t name_len;
> > >> +       void *xattr_value;
> > >> +       struct xattr *xattr;
> > >> +       const void *value;
> > >> +       u32 value_len;
> > >> +
> > >> +       if (!xattrs || !xattrs->xattrs || !name__str)
> > >> +               return -EINVAL;
> > >> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > >> +               return -ENOSPC;
> > >> +
> > >> +       name_len =3D strlen(name__str);
> > >> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> > >> +               return -EINVAL;
> > >> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> > >> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> > >> +               return -EPERM;
> > >> +
> > >> +       value_len =3D __bpf_dynptr_size(value_ptr);
> > >> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> > >> +               return -EINVAL;
> > >> +
> > >> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> > >> +       if (!value)
> > >> +               return -EINVAL;
> > >> +
> > >> +       /* Combine xattr value + name into one allocation. */
> > >> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
> > >> +       if (!xattr_value)
> > >> +               return -ENOMEM;
> > >> +
> > >> +       memcpy(xattr_value, value, value_len);
> > >> +       memcpy(xattr_value + value_len, name__str, name_len);
> > >> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> > >> +
> > >> +       xattr =3D lsm_get_xattr_slot(xattrs);
> > >> +       if (!xattr) {
> > >> +               kfree(xattr_value);
> > >> +               return -ENOSPC;
> > >> +       }
> > >> +
> > >> +       xattr->value =3D xattr_value;
> > >> +       xattr->name =3D (const char *)xattr_value + value_len;
> > >> +       xattr->value_len =3D value_len;
> > >> +
> > >> +       return 0;
> > >> +}
> > >
> > > This is not a generic VFS function, it is a LSM specific function, it
> > > belongs under security/, please move the code as discussed previously=
.
> >
> > Paul,
> > Not quite. It's all about xattrs.
> > Having "struct lsm_xattrs" in the arguments doesn't make it lsm related=
.
> > You needs to study existing kfuncs and tracepoints.
> > A bunch of them have "*lsm*" in the arguments.
>
> Alexei,
>
> I'm sorry you don't understand the basics of the LSM concept, but
> please look at evm_inode_init_security(), xattr_dupval(), and
> selinux_inode_init_security() for some background.  There should not
> be any usage of lsm_get_xattr_slot() or BPF_LSM_INODE_INIT_XATTRS
> outside of security/; you argued a similar idea to justify your NACK
> of Hornet, I'm simply applying the same logic here.  We also have the
> very recent security issue caused by the BPF subsystem which failed to
> acknowledge that the admin disabled the BPF LSM and then walked all
> over kernel memory when it shouldn't.  Moving LSM internals outside of
> the LSM creates an environment where flaws like this can go
> undetected.
>
> As I said previously, if you absolutely insist on the kfunc being in
> the VFS kfunc file, the LSM specific bits need to be abstracted out
> into an LSM function.
>
>   kfunc bpf_init_inode_xattr(...)
>   {
>     /* sanity check params */
>     if (!xattrs ...)
>       return -EINVAL;
>
>    /* get value/len from bpf dynptr */
>
>    /* hook will check for LSM specific xattr count/limits, allocate,
> copy value*/
>    rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
>    if (rc)
>      return rc;
>   }
>
> David, if you like I can provide you a patch that implements the
> security_lsmxattr_add() hook above if you aren't comfortable writing
> that, but if you want to give it a shot that's all the better :)

One other thing - as this patchset is primarily LSM related, it needs
to be merged via the LSM tree.  If Alexei can't tolerate the LSM tree
merging a minor BPF patch he can either choose to pull from an LSM
tree topic branch or we can merge the LSM infrastructure bits now and
he can merge the BPF changes when the LSM bits hit Linus' tree.

--=20
paul-moore.com
