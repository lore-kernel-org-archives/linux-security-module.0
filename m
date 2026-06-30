Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8837382F3C
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847252; cv=pass; b=VunCbYMouY+j1O01oXS7k2WqSFa2MCmEojTKmo9l064IYXMyzQ0tUK0JUELhyeZlOxTU0ZIyrQxem9UwVu8lRwqH/ZdPPrZboqCod+Ff4NGZHmfQOpr5iO+JyJmLk906bcYcj85iXCNQZVQAldEJLfQkl6czpth3H/JPvqBkxVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847252; c=relaxed/simple;
	bh=65J+i3G6p5lcoZBTC4phByocAAxY190VmOFW7omB01o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnrl4P8tROSjmOy96LEMWrSdErUalRcDH60mTomCm04NEQJRuKmO9wf21tQ0/ji2yHE4rHZCLpGjH0YTOSE50xRdWOX1r9lR4s/katfFeEx+hAXRSiRMw8qrF1ZZ5tmZ26qa6WiAmltGtncBs8fyeZeMoQAZ9IYLo3qisd5HMBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X5MxhvYP; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X5MxhvYP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37e0fb87b75so3996758a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2026 12:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782847250; cv=none;
        d=google.com; s=arc-20260327;
        b=JB2SXYsUU/LJ+2njFFcRPoIFOGB0LY+50z8KsBGv7w8wzN0MIfYD/+ugPLFtU+r3cf
         2uYsD5B7vpuP93zij5PnaoiCk8vf+tZQ+mrtxP8oW3iZ4cHh9u04FJ3kQNe+7MfhoDRr
         i1cxv84ANRW94oD500rYJwubsat2tWfA93ilr9mw2ir2tW9BWPtmsCcoWziSTHllRzii
         TzM3wFmwT9ig237A/ZWX1xj+kSEEVofDvDmoleiQrgq9Lly2y8buJqhkferp7LrxDHwC
         bLvT+7Y3HGa5OSwESK1JRhoDZtPTVGjEnsgF+vUqVayreBsWMWIDJ/jLrthyX6QgEPhD
         xsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        fh=v8EcHzQYC4STp7DpEuXHklBdc6tuQ9nBliJRsfxnjYo=;
        b=IsHuF/EfmnhilMHL11PfnVKJgHqX+aN5yUwYqTQ0TPlDvvU3gf0wm2pedxrBwR2Lgz
         RdQGJ/O762V+e0BcIks/EhuL8NPU4T0e+Ao1UB0Fh9zphh78k+U8wbRzZg+dQI3Z/1Op
         LS6rJvC76X54Q13UpTySjZwk68ddqAK3y2wxli1V1qLTBUEK6g5RJ0yE6FWQjeyL31Iq
         GvDSnDPL2+VzYKaN8cJW5u/Kg9pOl1UeQG5PJeIB5BeCIzsv7lv/pG0Q6Yd7UJ0CDn86
         pJiTQNf+PUifCrAn5UB0N5AhAOC91EqEHzKOsIVmKSZV2sWJFWDIK8FOx5wjqmLskxFd
         vXTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782847250; x=1783452050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        b=X5MxhvYPRN3WA2wN8tL/ZYk9NZEiQbt3zp7jjJgltzxvrPhMcgDbMg5S+ghGO6JFrV
         O1yiHUL8HLKhu//+JGJnCXi8eneIZaFMBhsfmu5xEyywT94F+72Bu6ykex5UZwL8hC7Y
         x9DHn2EONIrEHKr+zJRocw3ZO6DRVypGamAqAhU47sT6463F2xW51r6rTRektZ8qZs58
         e7c7/MJZFGQ2SLMW7XGcoPsGAHxHtixGOMzTpbI6bkqY+TSgjJ8aoDaBdqw5170xOh/K
         C7n1uxfzAR1/ftJDft78tixUKOMmdPxBEu5FgTwR1H8tgsPowu45eEy5Gat235dRyPTg
         EeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782847250; x=1783452050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        b=FiLGayI6Zhly0G7rXuO19drvwk2NAMg0Ts7LJZBtIqGYOFUSpaYyEZjsWfgug+TlGb
         SnoSwNVw7ppngAIlu9QAnLcxnO/Js9KAtp2A00q40MhXP7lMosQTEApNm5D6+mCeLwSa
         6LSd2v6A/byWavezl6aby4d5VdrGOvNlq9jYMaN30YzmXTRXiK2sLKz5lg/DjducwIjV
         Fgs6lY9gFOucNy/jqtHDcXGF/EjjObi3UM+57xT5x5RsDSkaGO/8RayBc8eFSNOuTC0w
         u5W1Z6GmQpooBHh5AKVXp0djAaC3BtyJ6/cFKdKdAWvVP1VdEsRB9cu/FVmj0x5aMTWP
         cFDw==
X-Forwarded-Encrypted: i=1; AFNElJ9itewKxb4cG71FErpMjzHK8qpuXWUXgrgSbUDGgRapJ+V+rjuqQ2bGMexOmjsQLdHOfdNSRoT6HI3XVnpJUU11RBIIwmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgVm656p44CsDTSRG28o9TFOAVjkLDPq0obAqZI371hJ+APufF
	TwLIGJFkzCuqOCphbrFCnhapIw5ijouWJ5MRwg4pktExGXqHHvCCltmoQSC0btwKC0hgp1yzd06
	v3BcPf2fSm3U7obp9LWb3MqCxvwwjX3C6snAcG+wW
X-Gm-Gg: AfdE7ckLFxGM0ZEtJjDRHL0GXCkSMsIqHhC7Utjd2vYQw0Gg/yIuWM+2/GgGmGykdxx
	z2Pmj+7eY7ok7B7YzOHT+/IZHlgC2Jf8Kp4/Yu/hXmmjJiVFpGuFMf/IgoDQd2JVAjz+xB0ksOs
	Zd/qZShEjsuZJgz5i/TWsDwtpfZo7GI+BorZvG4QcDnPPARlmpy7JADQWWGZXx8DmGU46WDEBKU
	Imrgn/9E4t1FzZuY6nHurr0YoggrTpTzfrKGeiQi2R+bBSnYoDE6SxVuJtwvuIs3wgeEmYM
X-Received: by 2002:a05:6a21:62c2:b0:3ba:cd5b:3dcd with SMTP id
 adf61e73a8af0-3bfdc69589emr1376925637.36.1782847249974; Tue, 30 Jun 2026
 12:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jun 2026 15:20:36 -0400
X-Gm-Features: AVVi8CeUWBZtqtU3wWufhJ35rf7KN-O35V57TZRDwEyvAO9h530GFJE7-OayBpg
Message-ID: <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Tue, Jun 30, 2026 at 2:40=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using lsm_get_xattr_slot(). The
> hook now passes its xattr state as a single struct lsm_xattrs object,
> which the kfunc takes directly.
>
> The kfunc is only usable from lsm/inode_init_security programs: no other
> hook exposes a struct lsm_xattrs argument, so the verifier rejects calls
> from elsewhere. Restrict the xattr names that may be set via this kfunc
> to the bpf.* namespace.
>
> BPF reserves BPF_LSM_INODE_INIT_XATTRS slots via lbs_xattr_count, and the
> kfunc enforces that BPF never consumes more slots than it reserved,
> returning -ENOSPC once the budget is exhausted.
>
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant.
>
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-Oc=
tober/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6bcdfd2cac55 [2]
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c      | 79 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/bpf_lsm.h |  3 ++
>  kernel/bpf/bpf_lsm.c    |  1 +
>  security/bpf/hooks.c    |  1 +
>  4 files changed, 84 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..c4023c82f21e 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -10,6 +10,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
> +#include <linux/lsm_hooks.h>
>  #include <linux/mm.h>
>  #include <linux/xattr.h>
>
> @@ -374,6 +375,83 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dent=
ry *dentry)
>         return d_real_inode(dentry);
>  }
>
> +static int bpf_xattrs_used(const struct lsm_xattrs *ctx)
> +{
> +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> +       unsigned int i, n =3D 0;
> +
> +       for (i =3D 0; i < ctx->xattr_count; i++) {
> +               const char *name =3D ctx->xattrs[i].name;
> +
> +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_l=
en))
> +                       n++;
> +       }
> +       return n;
> +}
> +
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_se=
curity
> + * @xattrs: inode_init_security xattr state from the hook context
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs.
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> +                                    const char *name__str,
> +                                    const struct bpf_dynptr *value_p)
> +{
> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> +       size_t name_len;
> +       void *xattr_value;
> +       struct xattr *xattr;
> +       const void *value;
> +       u32 value_len;
> +
> +       if (!xattrs || !xattrs->xattrs || !name__str)
> +               return -EINVAL;
> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
> +               return -ENOSPC;
> +
> +       name_len =3D strlen(name__str);
> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> +               return -EINVAL;
> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +               return -EPERM;
> +
> +       value_len =3D __bpf_dynptr_size(value_ptr);
> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> +               return -EINVAL;
> +
> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> +       if (!value)
> +               return -EINVAL;
> +
> +       /* Combine xattr value + name into one allocation. */
> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
> +       if (!xattr_value)
> +               return -ENOMEM;
> +
> +       memcpy(xattr_value, value, value_len);
> +       memcpy(xattr_value + value_len, name__str, name_len);
> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> +
> +       xattr =3D lsm_get_xattr_slot(xattrs);
> +       if (!xattr) {
> +               kfree(xattr_value);
> +               return -ENOSPC;
> +       }
> +
> +       xattr->value =3D xattr_value;
> +       xattr->name =3D (const char *)xattr_value + value_len;
> +       xattr->value_len =3D value_len;
> +
> +       return 0;
> +}

This is not a generic VFS function, it is a LSM specific function, it
belongs under security/, please move the code as discussed previously.

--
paul-moore.com
