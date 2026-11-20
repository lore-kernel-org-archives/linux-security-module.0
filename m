Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186599;
	b=llu//2MrWyNylHwn1ReecS8aJAMl0PdvDxGcwTnOvgP1dZ22eSF8O6zofSvUvXmuJe61
	 m36n3w4LllJsbaPI0McDemyvc1OyKzlkfE40D4h2mxJqm4BRW1uks4+tJbHxXaHbFjk2c
	 H1YVegG5q3Do7pjWRQ7Q4AFOAmglpX5OMeJYgO7xIJLhzlhO9M87YRDgRMLXByyZNobQa
	 aiIUYb2l/7UgfBXgDxcSq38vwf0sVbfXUt3q1MNb/n281GSIVVOBrJrx6zTrSZd+XYR3z
	 YtRYSJFGESg32w7DGsIjZ+r+Udv+0JjCsKYIHKxTv9Fh2lQUHwm1fqXN2kndkiYb52g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186599;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
	b=bgXpsNexn3X/lzQaWFnA+pocQJqYaDY6mYrhtoXuy6gjACs/FukMLr2bIapAWH/6S69b
	 eR8ZBpzPtuNtJu2gLAQG4wJciOIYNPDWXo5X4onXebmDWe5kP2L+aXPD2d2lvBXCJOg4B
	 QgTwiJPFqfPg8UUuH3iXBtbXACKIPd/ou23meX67gvC8Ci3WaYFzw89u3pKAyT4yxWI89
	 JqH8ExKV7a93JvXJ3+1bQOdkxoO2ibd53/uWAz45fDtaAm6eGLgmTbzTRRcn5A44oRD9j
	 PLIwqVFdvTMALg5id7BEi0zJwlYGiJqKST0ScoIyn0MaYIgwy9vFjwcNuZl4ySEpXtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDjOLAM1;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B8606A32A
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 14:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC9B8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDjOLAM1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795186597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
	b=SDjOLAM1l0pNx+Ot+8jdCcJ+s1mBhvKEKDRktA8EgMIjXbkT+gnvsppKPAEr5w+rCpUF+U
	b4KdhkBfofX2oKMVh8CaQHGSxo/Kw3+/I8ForQHRpb0GJbWsucD0bRykI9cQeYSUXnU1QB
	Agd2F4IPY/DmIkLvXpGFJLv/+Y2Rj6A=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-T5uEjbINMgqk-J0sxi22qw-1; Fri, 20 Nov 2026 14:56:36 +0000
X-MC-Unique: T5uEjbINMgqk-J0sxi22qw-1
X-Mimecast-MFC-AGG-ID: T5uEjbINMgqk-J0sxi22qw_1795186595
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b0d978e4faso15182567b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 06:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186595; x=1795791395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
        b=Q4LHhmmK8TnV98Ty5Uis0bnGfc8PWK93iMqvsq8lEnR+6LMuHiDGt/NNezkLy0nEDn
         donmV8b86j7IMCssABBmp2qIKWh9IuWGY4P3Zo94RJcvBbjz1czyJ9fABkB/7AqdBow9
         YOOJK8JOPV7A2Xt59EuwlQ/xgaFo5XGX7t7lrKiLrJbuK2jIMlNW6JUkIQa/5jMv4mdy
         kly103e/aGnsRT9DjNhq3zCHYk9KfU3dwoa7fCCuZdghwvy64UFlfwhPI8/zFjgEBZeR
         Mj0k89yZQb0goqFKRjpCPWcGIfHp9zUgG6OPPOuIMGMNAW+fzifiCaM1orgjCUYoDMTt
         CUtg==
X-Forwarded-Encrypted: i=1; AL+hErHM1wv2UVUdBmZzlK5XgbIbhzlGVsVzvTjb1ewnARb5yFt9fQkLdDygFYBI1U/UEcVSjgz/ipAWoGvWorjj7nsPToHrj7k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BZJYFrghePFq97e7ZTy169QKMrI9M+k8mr7oBUicemr1XGlOR
	74pyN+ww2nlKkYK/twQuJJep9J2taUHQ+xAOPUYseYhAB1LNAdREwaBM/PesswxcUyQAidWxq4M
	LL1bsAzPaZmvXbA4QH77mVULwIQ8O2kQihnJswYSGgRWblCh1qqaWIntFszXkbTF1Ys7FpwrDVG
	RFxKphQ/eoDP3scoqNeK9/Qy2KPTzc5NZ63Z/n0mwIdJ9zNxWQB3DcpuezazSPPvAo1g==
X-Gm-Gg: AZFdTZd01lP//1db9jIAS6/Xmf0UdEJY9mggUKBZkQdEnoBerXitstMFc0lnlMV07Ba
	8FRRL8/cSFiHmBkN5Sjq1zs4dw0v+d8+g5EeH3KwBsloXGU7wgURiap/CUCq32JI3sonWzmqCLB
	HtY+EYUxJOe14YxrDWvbdvGw4wONVwXjJTLWM+G4zEOIbc/wG1oOh2cMShN0fl5CALVQwA3YbgY
	rT11Kx5rAb+xG8gIbNcH7xr2wF27/8eP64WLM9LNY3K3A==
X-Received: by 2002:a05:690c:296:b0:8ae:a9c6:2740 with SMTP id 00721157ae682-8b5204dbbf4mr17277257b3.48.1795186595361;
        Fri, 20 Nov 2026 06:56:35 -0800 (PST)
X-Received: by 2002:a05:690c:296:b0:8ae:a9c6:2740 with SMTP id
 00721157ae682-8b5204dbbf4mr17276957b3.48.1795186594739; Fri, 20 Nov 2026
 06:56:34 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn> <20261120031305.3561045-2-huangsj@hygon.cn>
In-Reply-To: <20261120031305.3561045-2-huangsj@hygon.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 20 Nov 2026 15:56:23 +0100
X-Gm-Features: AclHuK-KPlGaYd21yj03z7EB2mPfkwiCHXM0MaDKxGgj2dWKdsX7kpdNXfvoeLg
Message-ID: <CAHc6FU7VUBLg=gX-xspFfp4jPffdH7Pc4oVx5nRDo7A3aiVWug@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] vfs: add super_iter_inodes()
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OcmrucQfH0bkTfkMMezhE3AwimNLUUjHMhvwzAvtNkQ_1795186595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:19=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> Iterating the cached inodes of a superblock is open coded in the
> kernel. Add super_iter_inodes() for the callers which can work without
> holding the sb->s_inode_list_lock.
>
> For super_iter_inodes():
> -- By default, it runs @iter_fn with a referenced inode and with
>   sb->s_inode_list_lock dropped, so the callback is free to block and to
>   do whatever it wants with the inode except drop the reference the
>   iterator holds.
>
> -- Three flags change the default behaviour.
>
>   INO_ITER_F_REFERENCED restricts the walk to inodes which still have a
>   reference.
>
>   INO_ITER_F_NOREF does the opposite: only inodes whose reference count
>   has already reached zero are handed out.
>
>   INO_ITER_F_NOIGET tells the iterator do not call __iget for the inode.
>   Used with INO_ITER_F_NOREF in evict_inodes().
>
>   The flags are not orthogonal, so super_iter_inodes() warns if an unknow=
n
>   bit is set or if INO_ITER_F_REFERENCED is combined with either of the
>   no-reference flags.
>
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>
> ---
>  fs/super.c                     | 87 ++++++++++++++++++++++++++++++++++
>  include/linux/fs/super_types.h | 29 ++++++++++++
>  2 files changed, 116 insertions(+)
>
> diff --git a/fs/super.c b/fs/super.c
> index c5a0658f7aaf..204c70c7f179 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -171,6 +171,93 @@ static void super_wake(struct super_block *sb, unsig=
ned int flag)
>         wake_up_var(&sb->s_flags);
>  }
>
> +static bool super_iter_check(struct inode *inode, int flags,
> +                            ino_iter_eligible_fn eligible, void *priv)
> +{
> +       bool ret =3D false;
> +
> +       if ((flags & INO_ITER_F_REFERENCED) && !icount_read_once(inode))
> +               return false;
> +       if ((flags & INO_ITER_F_NOREF) && icount_read_once(inode))
> +               return false;
> +
> +       spin_lock(&inode->i_lock);
> +
> +       if ((flags & INO_ITER_F_NOREF) && icount_read(inode))
> +               goto out_unlock;
> +
> +       if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))
> +               goto out_unlock;
> +
> +       if (eligible && !eligible(inode, priv))
> +               goto out_unlock;
> +
> +       if (!(flags & INO_ITER_F_NOIGET))
> +               __iget(inode);
> +
> +       ret =3D true;
> +out_unlock:
> +       spin_unlock(&inode->i_lock);
> +       return ret;
> +}
> +
> +/**
> + * super_iter_inodes - iterate all the cached inodes on a superblock
> + * @sb: superblock to iterate
> + * @iter_fn: called for each inode, with a reference held
> + * @eligible: optional filter, called before the reference is taken
> + * @priv: caller data, passed to @iter_fn and @eligible
> + * @flags: INO_ITER_F_* control flags
> + *
> + * This function iterates all cached inodes on a superblock that are not=
 in
> + * the process of being initialised or torn down. By default it runs @it=
er_fn
> + * with a valid, referenced inode, so it is safe for the caller to do an=
ything
> + * it wants with the inode except drop the reference the iterator holds.
> + *
> + * The flag INO_ITER_F_NOIGET changes that contract. It runs @iter_fn wi=
thout
> + * grabbing the inode with __iget().
> + *
> + * Return INO_ITER_RET_DONE if the iteration runs to the end.
> + * Return other value if the iteration breaks.
> + */
> +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> +                     ino_iter_eligible_fn eligible, void *priv, int flag=
s)
> +{
> +       struct inode *inode, *old_inode =3D NULL;
> +       int ret;
> +
> +       WARN_ON_ONCE(flags & ~INO_ITER_F_ALL);
> +       WARN_ON_ONCE((flags & INO_ITER_F_REFERENCED) &&
> +                    (flags & (INO_ITER_F_NOREF | INO_ITER_F_NOIGET)));
> +
> +       spin_lock(&sb->s_inode_list_lock);
> +       list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +               if (!super_iter_check(inode, flags, eligible, priv))
> +                       continue;
> +
> +               spin_unlock(&sb->s_inode_list_lock);
> +
> +               if (!(flags & INO_ITER_F_NOIGET))
> +                       iput(old_inode);
> +
> +               ret =3D iter_fn(inode, priv);
> +
> +               old_inode =3D inode;
> +               if (ret !=3D INO_ITER_RET_NEXT)
> +                       goto out_loop;
> +
> +               cond_resched();
> +               spin_lock(&sb->s_inode_list_lock);
> +       }
> +       spin_unlock(&sb->s_inode_list_lock);
> +       ret =3D INO_ITER_RET_DONE;
> +out_loop:
> +       if (!(flags & INO_ITER_F_NOIGET))
> +               iput(old_inode);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(super_iter_inodes);
> +
>  /*
>   * One thing we have to be careful of with a per-sb shrinker is that we =
don't
>   * drop the last active reference to the superblock from within the shri=
nker.
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_type=
s.h
> index 72f4288e16c5..974d3c087952 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -80,6 +80,35 @@ enum freeze_holder {
>         FREEZE_EXCL             =3D (1U << 3),
>  };
>
> +/* Inode iteration callback return values */
> +#define INO_ITER_RET_DONE      0
> +#define INO_ITER_RET_ABORT     1
> +#define INO_ITER_RET_NEXT      2
> +
> +/* Inode iteration control flags */
> +/* Only iterate inodes that still have a reference. */
> +#define INO_ITER_F_REFERENCED  BIT(0)
> +/* Only iterate inodes whose reference count has reached zero. */
> +#define INO_ITER_F_NOREF       BIT(1)
> +/* Do not take a reference on the inodes handed to the callback. */
> +#define INO_ITER_F_NOIGET      BIT(2)
> +
> +/* REFERENCED and NOREF ask for opposite things, so only one may be set.=
 */
> +#define INO_ITER_F_ALL         (INO_ITER_F_REFERENCED | INO_ITER_F_NOREF=
 | \
> +                                INO_ITER_F_NOIGET)
> +
> +typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
> +
> +/*
> + * Optional filter, called from inside the inode's i_lock and before
> + * __iget(), so that an inode can be rejected without paying for a
> + * reference.
> + */
> +typedef bool (*ino_iter_eligible_fn)(struct inode *inode, void *priv);
> +
> +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> +                     ino_iter_eligible_fn eligible, void *priv, int flag=
s);
> +
>  struct super_operations {
>         struct inode *(*alloc_inode)(struct super_block *sb);
>         void (*destroy_inode)(struct inode *inode);
> --
> 2.53.0

Sorry to say, but this has gone quite a bit off course. Can you try a
construct like iomap_iter() instead?

Thanks,
Andreas

