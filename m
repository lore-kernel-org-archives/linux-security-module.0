Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F82F25F8
	for <linux-security-module@vger.kernel.org>; Tue,  6 Jan 2026 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737598; cv=none; b=Yo6z8+OVlUw1sUuQRErEEzWVXBkzc9B5Oc6FhO4Igvw78+wU7TNGpYSWz7c9FhRf1893L+0BBSI9+1ldxF6WXOvswRoHD0F/JIfTDaBjgjYsGhkNDN4zMbFo4Cy/2ZavsqQwH0ViNG15/sVDd5knvt+cBZypd/rx4LBUAN61Tp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737598; c=relaxed/simple;
	bh=GluBh8m2y3PcEGE3+V9nl0D2yS7kGa0EPK26bG84vaA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=J7L74nmN2RBQP2YRCV0HgvRJtr/1kL3uKGBtAmHIwKg6Wj9DAmJ5kSTKodFEbS9vrdlUpH45zoUr5SdcADhETFsNMSKvVOr8XFiKJ+Vo+8W7FBOBJxMm0f5OustoD+6qWbROdZwYFrs7zPYjyZTOZOp631YMfrpRUdaMmsTLbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XQPsTu7C; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XQPsTu7C"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88a2d21427dso14420126d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jan 2026 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767737595; x=1768342395; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ndqp7w6INqSmDj45WR661sezFnhIaCas/O5ymSiHjQ=;
        b=XQPsTu7CGWrwhmDA1fIvenjHRnkIhsaeMXmGkj1NClTQtpGehA3W1yPzyQt/uQEqHq
         1NuPjhVh5s7OKK6+UmgUS45uqoKs1pJowLtUqO+yPsYDMjF2EaAQAEMOnNubOrpgEUlp
         AYAndsEGX4GCshBEHaDqRh0TIn7V3owdjZszR9sriC1xGb1Cseh7Vh9+OtwCVXQYDqy8
         B4cQ/hhAR4YowWtqMx+hzuHrDOLGvjBhMQh1l4zsGYOSv5Cski6EGr8OkhjAHMwN1b6B
         pPbAiHAYCAcBNjkklqbF1kYr38By80Zk9HNwHlIC/h5/nCKtyyrfXbS6O+Y49ilddWbx
         pYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767737595; x=1768342395;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ndqp7w6INqSmDj45WR661sezFnhIaCas/O5ymSiHjQ=;
        b=IqJRZ1YQXjVZoER3rChUKTMSMGbqEtKVjkieUyLVmOh/bHfNbU+3TzVtRTziVPySZg
         AfxF2XLXvkQgPCWWddku8Jxf6I7WcorALimht8N8nm9CG73PcF7MrfO/7ZkDVBZFIRst
         q5BmVigekrOwhgSmGWc01ukSSj/zmKh8PnWoJ8jSSazTal77yd3Zs4NkzQ7eaD0rEtLh
         PiQedOcEI6MK1/kLOvqbsDRQQ756bIMz4AcSDJnFOS7vigiM1gQYGCtt94Nwpy79mDwt
         s7yY9g2LvpXMhUobKFVKmMsEQ7hYyBlF+NHymi8Mx3dUerVQdwypbPsyXiZRUY5ZEe8A
         PiZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGJw5TtF7X9x/NkDlSoopUp19FolE2FKUbvzHi1EqtGCuvu0IS38ljyCBdeW7MFGRp0Au8Gxc3P1ieg+er+Zew+bqGrhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLyFexGfnlgXpbW7W+JDwktlTHGE3MVKhGoPH5FTAmUrGgqLPc
	HvnZpZZ6PsmfvARUkofCVr3fjnnO/qFPR2i4lP0fr7JImC2ONGaMjTyqqIRDHzuu63ql4q8C98S
	N5II=
X-Gm-Gg: AY/fxX49DEexeSTgHMIrdJDJxa/2TeP2A58CMKVi/qVxnyU2rW/B5fX9lbRxXUKhNtk
	O730KOgn49DAaFb/ST8BFvhBrBsmVPAaA8a3PPhVJIfBiH3UXs6hJlLIVcbUoU62L/9l5Nss72a
	Hfrc1pizsriD4JctvcwfIsrLWc1az/Uh+Yt04PSeKEyJNR3TTW1LrN4GQUBVza744D5t2TguSGH
	TQ2ZRbICpxHAc6MNncsHRKzHQuFOKV4fBMx2/+kbQCXL0oy/tTf8dmcYLqkcmeuYDy3xQT8T6JN
	89kxqwG3dPUPFZY2jhzJhJo/Osq/cgfi+gl2PlEI9EbNyQ4nbWjRRQahAubXjPB7minTE1DougH
	FQtqe56CpoHyFT7oVgg/vTG/lQ1oWcbeuY7UwP5KdByc+6IXHORe/KPd4/270T+cMEp8/24+JYX
	hiNbB9g+4qel1PAvLUiu9ePHm9QbqVV1Ti+5QyqGhRioW4HQtKeL0PVVz5
X-Google-Smtp-Source: AGHT+IHcmlCgI7WlFr18qOoSGtSo4kPbBkhNEeig2CIGNrNBUesdSzmx2NVuMD6+7V/OhPmQRFjH0A==
X-Received: by 2002:a05:6214:5509:b0:88a:525a:8db8 with SMTP id 6a1803df08f44-8908424fc75mr7312106d6.35.1767737595588;
        Tue, 06 Jan 2026 14:13:15 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm21004626d6.18.2026.01.06.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 14:13:14 -0800 (PST)
Date: Tue, 06 Jan 2026 17:13:13 -0500
Message-ID: <95dbf9af0e01953e2e6dca14eead406c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260106_1639/pstg-lib:20260106_1639/pstg-pwork:20260106_1639
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, trondmy@kernel.org, anna@kernel.org
Cc: okorniev@redhat.com, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] nfs: unify security_inode_listsecurity() calls
References: <20251203195728.8592-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20251203195728.8592-1-stephen.smalley.work@gmail.com>

On Dec  3, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> security label") introduced a direct call to
> security_inode_listsecurity() in nfs4_listxattr(). However,
> nfs4_listxattr() already indirectly called
> security_inode_listsecurity() via nfs4_listxattr_nfs4_label() if
> CONFIG_NFS_V4_SECURITY_LABEL is enabled and the server has the
> NFS_CAP_SECURITY_LABEL capability enabled. This duplication was fixed
> by commit 9acb237deff7 ("NFSv4.2: another fix for listxattr") by
> making the second call conditional on NFS_CAP_SECURITY_LABEL not being
> set by the server. However, the combination of the two changes
> effectively makes one call to security_inode_listsecurity() in every
> case - which is the desired behavior since getxattr() always returns a
> security xattr even if it has to synthesize one. Further, the two
> different calls produce different xattr name ordering between
> security.* and user.* xattr names. Unify the two separate calls into a
> single call and get rid of nfs4_listxattr_nfs4_label() altogether.
> 
> Link: https://lore.kernel.org/selinux/CAEjxPJ6e8z__=MP5NfdUxkOMQ=EnUFSjWFofP4YPwHqK=Ki5nw@mail.gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/nfs/nfs4proc.c | 38 +++-----------------------------------
>  1 file changed, 3 insertions(+), 35 deletions(-)

It's been over a month without any comments, positive or negative, so
I'm going to go ahead and merge this into lsm/dev; if anyone has any
objections, ACKS, etc. please speak up soon.

Thanks Stephen.

--
paul-moore.com
