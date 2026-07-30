Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76F3D8119
	for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455637; cv=pass; b=C559PIvaSYMmPoqzdqqBVhPJeXY75XzqjT90QBHTsNUuQSVXI014XHFqYmmiSEXL/PV4JSYhm4jiDeK6IySL5dexEVwXIcf76TRM11+eo62zQ55oX0Cqr1SaqClELaw2xaaT8KIBCwqKJ7KmVi5XNl6WjhMxHdQQAXeDeda3zqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455637; c=relaxed/simple;
	bh=JfxZFvpHBWcmAnd/aQ2atvfsHg1U5BfAHOmlK3lJJhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAPKc+EgV8Sd0Bvkvrzw1OhJD3o20nI5HU9D3NuNF6fPdY0uPtT+YI43/IctByYLU8EzwoaMVk6FBQ6o7BNfSc9K3pA5uAd6KxhhbVcBubLNXSAA+quMkIxcNabQ+ZLwxof0CIEnOsIzM+GOimb3BBO8jZ6HnbhiT9WRJ1ffaho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L0RYGTTM; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L0RYGTTM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d02b4c3601so3969235ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 16:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785455635; cv=none;
        d=google.com; s=arc-20260327;
        b=K4WNv9ZZPopwV3GEzxhguDG5k/Alu3PUnYjPzd7GHNV4f1j5Mcxs94iUc/2T87ebu6
         c5AuhtKNo3Z7fw+F0/Gz69kdgHG+NYcHg1zfR64KtGPloi/XtJfvMxIQObnq6w/oPigt
         m8xXiZTAk17sTBSI6Hkxnnn0uOvbaUrcSn7odAkMdaaKfv6eJsSIDPhdds0+EE3bCqlK
         8iFszaYXCy/MOy8SF2B3AyJt4gXJ6goLMBMiOFMNbeucs0OPgNcp/uho2ftTsDcnZEph
         jKN6fkKCJj55dG3nLcvDz+ATa3k0k4WS4cbYURIZIVDsaOOUlazDgv5k6fQuYOIPbFhd
         vIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4mBDHVCLcXdZXMibJjG6y+p4xVVz9yyfGfRo2UBJAHM=;
        fh=/08rncxke59yRRA6qVxY3UyjaTMhuqAJ/oePoe6RC2M=;
        b=YWZuQOS2melfuth+0y0K/6VgH8Kt0CXuU2vyEPEjQz6VxU7G4RsScc1bOTKBXWiIoZ
         41YLef2lDIfOQlnXoDkDbx8QlbblZz4fzNc9UE2jBG9m2aq/VGLceaBOxBKC6BCCZRxE
         unRY3QWMusjlUHQBEUA9lq3yLMQ4HveqTDPavlzihxPvCXNwAFtPVar8pehsCjKp6Klu
         teH4mLGLPYgrzxAjEA4CcnIVvmVn1CmFwcpvEI8vTUD/YSgGd7pwIDYWjL07yAEkaygD
         Owi95AyyFxdETNLwG3O4T1X/JyaaEU7uAXzbG9QtgnH9mI0WIZ+Y5U8d1rnOD0x8DWOe
         erQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785455635; x=1786060435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4mBDHVCLcXdZXMibJjG6y+p4xVVz9yyfGfRo2UBJAHM=;
        b=L0RYGTTMahPOIGy+R5OFo6oKFlyVg1FAvtglKC22q4Kvysdo8X1dJXYVhXwTCi9RcM
         xZC+qnTT0mCGlq/LX0qaP/ubg3OtP+9RcJIed2OnK8Rg39xuD3NvBOQy98O2cKv4UI7b
         kSA89Cs6NzqixFDjccF34QSMCWlcAdAb7TUVgw6dlGejsrZTaSTgeWoYFn9pOcCjPbHP
         WbzgQC8Y64NS7a27COodNZr/wTTf9pfSl1xsuKqoGKRyMeHNkj/kmOAPazLaaGuOI0HC
         DvbnLF5QBY0xDbyiDjotFuV54Ig0/imPU2bJIqOSZOSvobObLTvsYTGBjFMYBQQNJGB5
         nJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455635; x=1786060435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4mBDHVCLcXdZXMibJjG6y+p4xVVz9yyfGfRo2UBJAHM=;
        b=cEces6VeUTNe72lM9MT4XaOkDBRMBTQi8WJ3DPEZwO/91NKKukIv9UfZDKvz53EI2u
         tTuubcMWoR2gWrx+chGIc+FSqCeDBgK2aFp6la1bdxxh2v+X1Gyahu3U7/ZvzoLwvGDd
         qxCR8WjLe2A1e3wltb9Wg1rIgLQ9PofDK1pSk/22M3PV8oF5bhhycDsqpVEHSKWzOPib
         zd/8ZQr1uqv0iLl6x+jVNW4e72opH9lMT6VPBDAfhTkmHZRQC1toZJNw49XwXxDM3KgK
         CYiNgISX7tklvuirnrnEW/C+2KNbhzkEnqGW1VIRCrm400KqI47hl73JgRObE4IObrtG
         56gg==
X-Forwarded-Encrypted: i=1; AHgh+RrVhF4fSsBLbWOgyiBDXnbo5EWbwIqndSWlPrvv6LuWL2OoSNIzTSgwe0tLziBueaNR5iNgV6woAOwtCGS3ewb/Mn2hv7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMujmx/m/Ny8oHT1I8nzmpqJVw4cgMkmM8OpJUqDP5p9aRaWS
	pI+oY50AME/2OiNHu8uO/WefsjDxhwb+9rnb2jKcwrXso5gl4tSaMdVCvFRl7in41gRI/TFakNY
	qw27dTiWFdQNkwL5ObfYZvRU0VQ7S4sJHqNdYWtfe
X-Gm-Gg: AR+sD125jG5P9zwSRHlfU4IhY0emSGlrQ7r37zIJPFK+Pt/J4476qHePfyNKUydgaJm
	pRNr/ZrI31ny9V9W1PGxKmM9BqW+BGTTotGP/9VdZnSV4ne3xh4eQn0K+p162FVXBnKxgN7M1if
	t3Zpr4pBtX01QfukawtKFdunB1zPaYrW9LpZvbAgwE75STL/Tyk+To9niwUJo7MWKuOSZtE8BrH
	E3HKt+ZS6Pr0VUncdSgn5CEoOaPJOEPUOd54DJJfih7k6OvzNbigaJUKLJQZq6PIo87tWOl242Y
	upoPOPdfYpaLbNfML+Yr6VVVofNMDgg0oja929YIRiNa
X-Received: by 2002:a17:902:d541:b0:2cc:eec6:558 with SMTP id
 d9443c01a7336-2d035d02a76mr42105125ad.39.1785455635347; Thu, 30 Jul 2026
 16:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
In-Reply-To: <20260730234533.1912709-4-dwindsor@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Jul 2026 19:53:43 -0400
X-Gm-Features: AUfX_myIwEPkdTB9y2A5EVFOJTxu57iscp_A0mJDOnaf1-ooecLYPMIU4zjErAM
Message-ID: <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
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

On Thu, Jul 30, 2026 at 7:45=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using security_lsmxattr_add().
> The hook now passes its xattr state as a single struct lsm_xattrs
> object, which the kfunc takes directly.
>
> This kfunc is only callable from inode_init_security; the verifier
> rejects attempts to call it elsewhere.
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
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index f1863a891db6..7b55073934e0 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -11,7 +11,9 @@
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
>  #include <linux/mm.h>
> +#include <linux/security.h>
>  #include <linux/xattr.h>
> +#include <uapi/linux/lsm.h>
>
>  __bpf_kfunc_start_defs();
>
> @@ -379,6 +381,44 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct=
 file *file)
>         return d_real_inode(file_dentry(file));
>  }
>
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_se=
curity
> + * @xattrs: inode_init_security xattr state from the hook context
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the filesystem does not accept
> + *         xattrs at inode creation, negative error on other failures.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> +                                    const char *name__str,
> +                                    const struct bpf_dynptr *value_p)
> +{
> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> +       const void *value;
> +       u32 value_len;
> +
> +       if (!name__str)
> +               return -EINVAL;
> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +               return -EPERM;
> +
> +       if (!xattrs->xattrs)
> +               return -EOPNOTSUPP;
> +
> +       value_len =3D __bpf_dynptr_size(value_ptr);
> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> +       if (!value)
> +               return -EINVAL;
> +
> +       return security_lsmxattr_add(xattrs, LSM_ID_BPF,
> +                                    name__str + sizeof(XATTR_BPF_LSM_SUF=
FIX) - 1,
> +                                    value, value_len);
> +}
> +

Based on our discussion in the v5 patchset, I was expecting to see
this under security/; did something happen, or was there some
confusion?

--=20
paul-moore.com
