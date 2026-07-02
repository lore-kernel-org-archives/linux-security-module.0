Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347030B51A
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026962; cv=pass; b=fw8HAyIV5GTfO4XugLlGQaXmWJhih82Kt0nGt5pDWMfGs7mPUqSBDAJV2Xot62ChNyNSDmcjgfW93+9v4Qz9xh5irP8zKF/XbfSo8ES6Oh4ZntwEram+d7WzjP0Bi6ZZgmz41vHlJVlLfoYZ16qbyd9gYg/s7fg1QooWYJmJyMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026962; c=relaxed/simple;
	bh=CRRyF0ZmV6QAOvLNMyYIyuBjF+4nVnj3WsLLfWhXSYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViUnm/hkpbff+SoysFWtCfU2ATkDDvdOLu/KC8c3N/pAIXI6Oiy45OaGKWSx/GPwD5NQ3eTDz+cf9Djj+6X8/zuvkv5whnNOyB44bfxuQoL9ptyv1J6lC3yeNDPl71FTQKTC9iG3rlTlXE6JkWUTkQxCbQEHxteTPYky32eQjeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QX/foz9D; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QX/foz9D"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1183326a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 14:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783026960; cv=none;
        d=google.com; s=arc-20260327;
        b=ZxoD+vd/h49mrznNOF3WjIAJK9MM0Xy+x34dySYodYffCfaWMl/CFdSai5CfbC0nWp
         Oi9XtM701qQ3P7y2lWE2m/dhrUcCXGnGIM2fPEUNEtdZtn0qpQUpYl/wYZpaCpO2FiN+
         v6Ld9fFX03aa61zTOramJNDCmC1ITKnT6bMP7IW8Rwsba+tOKml6l4QauxtwZouKKCHz
         jYRkF2MfdZhd4XXNjC3qoQJ6v1g05aH41AuSauXe/HHqmVCDRYiBoecm9b2M2xj21M0u
         BvDIRqO0OHe2ZScaljOKQLfeG0swNQpc2hCu1Kht6FCOQDF4tMPqy60yltCTb8tazJQN
         oa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6GaLUVyJg238f5zVmM980M/4Qfp3qCHqnZLBBreogGc=;
        fh=wPCiefjkwYo6UBQUHB+BvdlhlavKyQQ9H0pw3bCsePc=;
        b=TcPvkII/AL5BH/oqMbNDixMpoQ7c2iwPKGK961IEe5O5tYz5LphQiw1kMc3MVw8l3m
         blfcuY5St/E+CWhMpNNDKjCVEHJeWZOOzjm86r5IDk6KrYrWvO2VpIbf6EnUHb26/cIq
         lHikBWjvgageXgQaZfQSRjJHAktFz6mdVSFlV3JJMsRHxxFflflFhIm7Dmd1hfd2/BEd
         sTPSW3+2nDvgPfzsksSp1b2BCHh5je4qmGPQWxUIHO2Nv2FJxhqtJP40Hs9xBLQOpImD
         x+DirHOIPcJhgxAswFspRWMboweSstCVCnhxMJES6a9JsQ5tLB5rxWcIc82TJ4shcrmA
         b79w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783026960; x=1783631760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GaLUVyJg238f5zVmM980M/4Qfp3qCHqnZLBBreogGc=;
        b=QX/foz9Dfwf8YJvhaPdwQdobvib4EZefg+eN8puFljhDxUZT6eHdAz+VN4Z/Y9FjwP
         aM9STMkj5nUm7DYi05/Z8cAz7obJ1XtuOTpC2teIm0Msg95UUpapVZbYBLgCJl12GKqs
         Xzfdsj/7gm96W/m+71sQghhp1/GeOuTWtlyR6hJmaR2I3/WsgkCdBM77ruLJzXgqhcTv
         dSvvZT/043bXMYbMeh4y75f8NQro2KYvbiopKTo5L+aVcBiDxXM3L4lEOjtZrs6aY2ED
         fvEpNKy4irGUBC7wbSDl5lywC/bizRhM7NhAt2QWdrS30+RLpKGyR6k1VRgw+cgQaSIe
         /HMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026960; x=1783631760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6GaLUVyJg238f5zVmM980M/4Qfp3qCHqnZLBBreogGc=;
        b=AoznvxLF/2NKm92r4+BfDPpXja+/CAwZ3MyXcHSKeceFbKbtQOPMCDalPqYE1ZotWd
         xnrk2r9VfHddZGpmpyiINCZTQ0MRhDQftAwjFGmCvq8MAk6Uj4euMBTHanvY8ltu1wyj
         PFa87ueUGyMVTuFovjcgPXqjT+BWfjl1j2lW19WJSCWoam7tdzR5jgE8mtaJRXbD92qS
         OjFYwghIa3LA/m1Q/Bu8V3+/1BAsHZejnceyuqSJXoupEsTkZzd1T5B6N4zf48r/Ug8r
         nnd7X2pRGgs0kZ+EWW+YeE7yPF49gSbjauXHbHCIMksRDwH0xR8DrRTUpLZOKpiMrt1r
         x74A==
X-Gm-Message-State: AOJu0YwGvwQgNduIT/OikzzTKufNwCozewwmfE0gCFl4cMyAMD40sbWR
	656aONMzbExLVUpoprwZPJ/pP2eP9p6071sH9kvzM/Lnxs3whVRNS+VhXYYtGDNfRoo3cDFTmKU
	g09qMvKWrYg7xErZHcTBYKq26TqftoTIso2eHnLmr
X-Gm-Gg: AfdE7cl3g+xmqgfm2zaqt65rPenV4qoPbJH1jH8ZrujRXhdJW/+wvPrEvtSrT6vh+DO
	L2fPVEWdgy34heN+DvMM7ebTcoH5szXM39TeI3+SUzGKcJP6YyfN0z57cMCczPaUbrcfz9hEqTl
	jyZSPt2SdlOTcMJmG5IDg20mbiTmL0u2qgDZ87uEjX9A5ldmb7486aXWJCfez66hks5Il5CIwv8
	t1DMYlmjHe9hUtHwj1qY0bm4+78qw2Wss7VN63zLZ68M2CM9mAUEdzwIwQoNOIBJi+NNaoh
X-Received: by 2002:a05:6a21:6086:b0:398:837a:7af0 with SMTP id
 adf61e73a8af0-3bfed362205mr8895796637.30.1783026959543; Thu, 02 Jul 2026
 14:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629210150.832576-1-mattbobrowski@google.com>
 <dde355196558210f6ca87c1a0745a3a8@paul-moore.com> <akbHgKxaNmRQEfqs@google.com>
In-Reply-To: <akbHgKxaNmRQEfqs@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jul 2026 17:15:45 -0400
X-Gm-Features: AVVi8CdMy1cNGEFmQHB4WTGe_AOdq4edMBCkxyD8qbAPpSrz8H3ndpzGD767XUM
Message-ID: <CAHC9VhQ719M3TQz8LCDSxR1vECx-WmwcPFR+OuuEJ-rcEW+y3g@mail.gmail.com>
Subject: Re: [PATCH] lsm: cleanup repeated lsm_blob_size_update() calls in lsm_prepare()
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 4:18=E2=80=AFPM Matt Bobrowski <mattbobrowski@google=
.com> wrote:
> On Thu, Jul 02, 2026 at 03:15:02PM -0400, Paul Moore wrote:
> > On Jun 29, 2026 Matt Bobrowski <mattbobrowski@google.com> wrote:
> > >
> > > Centralize the definition of LSM security blob fields using an X-macr=
o
> > > (LSM_BLOBS_LIST). This reduces repetitive boilerplate code across
> > > struct lsm_blob_sizes, blob size registration in lsm_prepare(), and
> > > debug log printing in security_init().
> > >
> > > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> > > ---
> > >  include/linux/lsm_hooks.h | 42 ++++++++++++++++------------
> > >  security/lsm_init.c       | 59 ++++++++++---------------------------=
--
> > >  2 files changed, 38 insertions(+), 63 deletions(-)
> > >
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index b4f8cad53ddb..0e73b22bdeea 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -98,28 +98,34 @@ struct security_hook_list {
> > >     const struct lsm_id *lsmid;
> > >  } __randomize_layout;
> > >
> > > +#define LSM_BLOBS_LIST(X) \
> > > +   X(cred)          \
> > > +   X(file)          \
> > > +   X(backing_file)  \
> > > +   X(ib)            \
> > > +   X(inode)         \
> > > +   X(sock)          \
> > > +   X(superblock)    \
> > > +   X(ipc)           \
> > > +   X(key)           \
> > > +   X(msg_msg)       \
> > > +   X(perf_event)    \
> > > +   X(task)          \
> > > +   X(tun_dev)       \
> > > +   X(xattr_count)   \
> > > +   X(bdev)          \
> > > +   X(bpf_map)       \
> > > +   X(bpf_prog)      \
> > > +   X(bpf_token)
> > > +
> > >  /*
> > >   * Security blob size or offset data.
> > > + * Note: lbs_xattr_count is the number of xattr slots in new_xattrs =
array.
> > >   */
> > >  struct lsm_blob_sizes {
> > > -   unsigned int lbs_cred;
> > > -   unsigned int lbs_file;
> > > -   unsigned int lbs_backing_file;
> > > -   unsigned int lbs_ib;
> > > -   unsigned int lbs_inode;
> > > -   unsigned int lbs_sock;
> > > -   unsigned int lbs_superblock;
> > > -   unsigned int lbs_ipc;
> > > -   unsigned int lbs_key;
> > > -   unsigned int lbs_msg_msg;
> > > -   unsigned int lbs_perf_event;
> > > -   unsigned int lbs_task;
> > > -   unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs ar=
ray */
> > > -   unsigned int lbs_tun_dev;
> > > -   unsigned int lbs_bdev;
> > > -   unsigned int lbs_bpf_map;
> > > -   unsigned int lbs_bpf_prog;
> > > -   unsigned int lbs_bpf_token;
> > > +#define LSM_BLOB_SIZE(name) unsigned int lbs_##name;
> > > +   LSM_BLOBS_LIST(LSM_BLOB_SIZE);
> > > +#undef LSM_BLOB_SIZE
> > >  };
> >
> > Generally speaking I greatly prefer to see the structure fields typed o=
ut
> > as it makes it easier to find them using grep, code indexers, etc.  The=
re
> > is a similar argument for the security_init() changes (below).
> >
> > > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > > index 7c0fd17f1601..c256f1c33efa 100644
> > > --- a/security/lsm_init.c
> > > +++ b/security/lsm_init.c
> > > @@ -282,40 +282,24 @@ static void __init lsm_blob_size_update(unsigne=
d int *sz_req,
> > >   * lsm_prepare - Prepare the LSM framework for a new LSM
> > >   * @lsm: LSM definition
> > >   */
> > > -static void __init lsm_prepare(struct lsm_info *lsm)
> > > +static void __init lsm_prepare(const struct lsm_info *lsm)
> > >  {
> > >     struct lsm_blob_sizes *blobs =3D lsm->blobs;
> > >
> > >     if (!blobs)
> > >             return;
> > >
> > > -   /* Register the LSM blob sizes. */
> > > -   blobs =3D lsm->blobs;
> > > -   lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> > > -   lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> > > -   lsm_blob_size_update(&blobs->lbs_backing_file,
> > > -                        &blob_sizes.lbs_backing_file);
> > > -   lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> > > -   /* inode blob gets an rcu_head in addition to LSM blobs. */
> > > +   /* The inode blob (inode->i_security) gets an rcu_head in additio=
n to
> > > +    * LSM blobs.
> > > +    */
> > >     if (blobs->lbs_inode && blob_sizes.lbs_inode =3D=3D 0)
> > >             blob_sizes.lbs_inode =3D sizeof(struct rcu_head);
> > > -   lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> > > -   lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> > > -   lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
> > > -   lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg=
);
> > > -   lsm_blob_size_update(&blobs->lbs_perf_event,
> > > -                        &blob_sizes.lbs_perf_event);
> > > -   lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> > > -   lsm_blob_size_update(&blobs->lbs_superblock,
> > > -                        &blob_sizes.lbs_superblock);
> > > -   lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
> > > -   lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev=
);
> > > -   lsm_blob_size_update(&blobs->lbs_xattr_count,
> > > -                        &blob_sizes.lbs_xattr_count);
> > > -   lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
> > > -   lsm_blob_size_update(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map=
);
> > > -   lsm_blob_size_update(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_pr=
og);
> > > -   lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_t=
oken);
> > > +
> > > +   /* Register the LSM blob sizes. */
> > > +#define UPDATE_LSM_BLOB_SIZE(name) \
> > > +   lsm_blob_size_update(&blobs->lbs_##name, &blob_sizes.lbs_##name);
> > > +   LSM_BLOBS_LIST(UPDATE_LSM_BLOB_SIZE);
> > > +#undef UPDATE_LSM_BLOB_SIZE
> > >  }
> >
> > This is one case where the macro approach *might* have some value, but =
as
> > it is the one instance, and multiple sequential blob operations like th=
is
> > are going to be *very* limited, I'm not sure there is enough value to
> > be worth the change.
> >
> > I appreciate the initiative to search out areas that you think could us=
e
> > improvement, but for the reasons mentioned, I'm not going to merge this
> > patch.
>
> That's not a problem. Perhaps you may want to consider only taking the
> minor cleanup targets the redundant lsm->blobs access within
> lsm_prepare().

I did think about that, but I ever *so* slightly prefer it the way it
is now, although as I said this is the one case where there may be
some value.  If there had been other areas where it was a clear cut
win I likely would have just accepted this change too, but there
wasn't (at least not now, and with this revision) so I just decided to
leave it well enough alone.

However, as I said, thank you taking the initiative on this.

--=20
paul-moore.com
