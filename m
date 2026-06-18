Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CE341057
	for <linux-security-module@vger.kernel.org>; Thu, 18 Jun 2026 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823065; cv=pass; b=fUIKOdJ5wuR2+UpZRQRzLlfwblsuJ1v7k0MYXD4a40ZeU5aUU9qcQV7bNXJ+lOeb4LGyU09/OCtkjDtDFEpopj0vzzgpM5GB1IO7I+WKFiyzVaLfOZ4Ju1qOVXbdferg6ppJv3Pryg8NWMGP6V0JryP6JcWjhCE8bSMNsgimki8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823065; c=relaxed/simple;
	bh=EMYr1F+PpGtSmTpfHsTm52f8sshX1D1zHOemelGKRHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUXJJgsPih11ph87fySmrAUT1E8V6ySWjpLLSQKdh7MjP+U/kkb9z5BPu3jSKK2176BNY7ZgGls9AkmIEH51QbYpg0zvhM+xFolH9rNwYrEfnpduRlYa2/KDOr3/0/f4qjCp0rsiJOI+B8n1+D7tF+xnjzcTfFdWqq9b1SWR7S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ2E6C7p; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ2E6C7p"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-91563abd6a9so83666185a.3
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jun 2026 15:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781823063; cv=none;
        d=google.com; s=arc-20240605;
        b=VzmV/SddwfBWKQMppeC91T3JcrUn/K1BP8rV4qjtzyXwZ/TjhLmzmXWCg4NFFISmAa
         66oGwwfM/r9+HzH9V++so4nXFOJsKFMFOt+4zx786wM8hgOAsOybpCTbHcm+xvG28uJ/
         jsAm1+uJ/zQctyQAB+sO2Oc0ZfxNgCxXxHhYj1W6a+7qx2MruCLaetaTe7hlXKWz4/H2
         Gg1491QgdOk2Pu8NouujpAOGoaalp8rT7i3aZrinu+irE/iFqJ7375v/ECGTgPkjaC8Q
         w3Cwthz41ssHsoZ0SIXmxO0njjQBtgBjAzmtGqNo0JN314fc0z6OsY7iUSoGxc0g4J74
         K5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        fh=CfEhq0gLikmiMecun3VYZXS/oxndm5PvCRsxnBsxWCY=;
        b=XgYHXOCMl+VGkQNBYcAIw5K6g94MtnULtBFXb5KkXALgkj9T5a/Xw/9q32tJqb6fuF
         HUfMgvzTkLbcseS87F1wGuN4LRNlZZgBLK/Zwi/QU9RwVcQITYwvrQjRx2cXR+Svhsmw
         TvlcVLbdsNgZZK3Khw4PgCU72PAkv1a4ag0P84/uEyWaOLshg66HmwWpJLfV5ERVJVHW
         +eKFKKqph4qLXlboGHnqVBXIP6OR4+LPWX0inIV4CXCogDgdt7cBQNK6w6lBWVuWkoQ2
         BFoRoZAsdHtn/geb7/o5qhK3MS6VkUWCCv+OHePaTvf2IPMGzG5/KqvxMKuyogBPsuA2
         ltGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781823063; x=1782427863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        b=CZ2E6C7prhTojmgoHGdNe7OileXPbl3IdhXRahO17zU0p7sydgNazhp1YHE4kV/6eg
         /iLvrxYKEmWLRXuKoolRzvba4DUUKfRHLyiBgYpuqOcdWtg82BbySEy4qLx6HhHXP7dS
         PthIZYz4hSquO4gFZ3URQSYFja1vdkH+gSP3b9b2UHQAe+pCO5lsOGswbMvzZJQaVr3J
         LMfxXi93vOcsvLFfsN8zLILywVKhEiv9aH7ub2Wr26pPk6HXp1A+vN3Q1qU+OaSnl3td
         B+79jtylayY9plF1MJRE+jSxSw56SZl4UEYadYOtdVYwiErhIjX8wLS2AjK/RQ+xbQeP
         KzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781823063; x=1782427863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        b=R15O81nvb0W3LzacbMqsXNVcIUjY5bYn8HgjEDfeLQG3i75I7R7dVSVEYlzxfjVITN
         3kSvZnQmgFvI7pF9rT49n1nIf8YevKdEF3w4fUBxzsQWsrrFMbvKwqK8i2TX+utmyBAe
         d7q9PTsUSYo+ct58Fe9L0a0W5C+EQfjPBC/X3uB1BTdVLf6MGS2P9SQmCmIsTtgP/vxN
         RSypwGf0ytpZ2EVj6Kv7ZENgPg3V1jNbOuB/YH7fLxOQ9O+j9C54GZgNSuYrRSatg0Tj
         ryDM2uKgdrARJxMQSrUXE9mJ7IXsgrtxBZIyhipsH5dHfON8KWTUy+ask65qetRF/b9Y
         l4LQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wBR2kc1R7W+hM5L/3uuxyz7o5UYMKZ1jSLkGOyMDzAy8HPZHRsNbdYCSp5I7KJOem54ipomz5U+HvqDeYer3v5E3z28Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0alcHM/7+wWWWFlKkL9jY4vh1w7PJKWAkAbcind0pq1Xb0V8
	FW2vg2DPG7RjjyiUczvdJBgLQ3f6dH+UcpCJq1s7+TNf2WugL7CYM6kRBfkpXJgNyTi50+W31sV
	h6xVBTFdRGemFVzJ5P41ML13uKdck6o4=
X-Gm-Gg: AfdE7clWiLoQli6OxBTknfDICxrIm4zof5kFrwREGaALtSXLQGi6N4MJ4XGPr9JEPtP
	dH5zgdRkbjjXy3gr9ejnCBWJlejWadOFjkPnIU5WjHQMKMT28zfreuTo6RG90vj+yeCrGc7uKcy
	vDN7aqvYkAfiI5VBov9RNV/auAFilfx+/UnRp/AZRFiKry37YRtb/RiNG6ihSDaMC9Hh34Os7kW
	9yt6OjQzKfJbqxBltvGCxBRj11EBMw2ENt3/YjdW05tl+m+Gm6Z/SHQfHZD2c+V/D+81cyMEQIg
	KMZX3Vc5v29c29STWAd86sYocI0=
X-Received: by 2002:a05:620a:19a7:b0:915:6504:2a11 with SMTP id
 af79cd13be357-9208d2f42f5mr171322285a.44.1781823063019; Thu, 18 Jun 2026
 15:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <e9ec622a8a49be299cbbfd459e2fc10693bcd65c6dbf00c9e2645281564e5579@mail.kernel.org>
In-Reply-To: <e9ec622a8a49be299cbbfd459e2fc10693bcd65c6dbf00c9e2645281564e5579@mail.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 18 Jun 2026 18:50:50 -0400
X-Gm-Features: AVVi8Ceqq7GMU3vGf90S537LLM-Tkad05xeAgBh-3i_pTCiFmecE5-lsBfct2HY
Message-ID: <CAEXv5_hDJyZ=nY6JaSL=17Mtw+e_m1doj=KReWSNmgo6ULFKpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: bot+bpf-ci@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:22=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> [ ... ]
> >
> > +struct xattr_ctx {
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +};
> > +
>
> Paul Moore suggested in v2 renaming this to 'struct lsm_xattrs' to avoid
> overloading the term 'ctx' in the LSM space. The struct was renamed from
> 'lsm_xattr_ctx' to 'xattr_ctx' in v3, but 'ctx' is still in the name. Was
> there a reason to keep 'ctx' in the name, or would renaming to 'lsm_xattr=
s'
> as Paul suggested be preferable?
>

Indeed he did; I mistakenly inverted his original request.

Will send a fix for this, as well as converting GFP_KERNEL to GFP_NOFS
in the allocation in __bpf_init_inode_xattr.


> >  /* Default (no) options for the capable function */
> >  #define CAP_OPT_NONE 0x0
> >  /* If capable should audit the security request */
>
> [ ... ]
>
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 564071a92d7d..86a8e188b900 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -113,6 +113,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog=
 *prog,
> >  }
> >  #endif
> >
> > +BTF_ID_LIST_SINGLE(bpf_lsm_inode_init_security_btf_ids, func,
> > +                bpf_lsm_inode_init_security)
> > +
> >  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >                       const struct bpf_prog *prog)
> >  {
> > @@ -137,6 +140,12 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *v=
log,
> >               return -EINVAL;
> >       }
> >
> > +     /* bpf reserves a fixed number of xattr slots for itself.
> > +      * Set the attach limit so the trampoline rejects excess attaches=
.
> > +      */
>
> This isn't a bug, but a subsystem pattern flags this as potentially
> concerning: the BPF subsystem comment-style rule for files under kernel/b=
pf/
> requires multi-line comments to have the opening /* on its own line, with
> comment text starting on the next line. The preferred form would be:
>
>         /*
>          * bpf reserves a fixed number of xattr slots for itself.
>          * Set the attach limit so the trampoline rejects excess attaches=
.
>          */
>
> > +     if (btf_id =3D=3D bpf_lsm_inode_init_security_btf_ids[0])
> > +             prog->aux->attach_limit =3D BPF_LSM_INODE_INIT_XATTRS;
> > +
> >       return 0;
> >  }
> >
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/277886=
16397
