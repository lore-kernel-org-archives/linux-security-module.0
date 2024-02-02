Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3CF148304
	for <linux-security-module@vger.kernel.org>; Fri,  2 Feb 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891481; cv=none; b=o++BvGcDbzvthKIQ3RhnQVcqZKeX0oFAOu37pCnLfQgRNeLjKr2RfaXokyL0KN1XHbjDrwxsfu4yX/zrSp2sD1W/V9RGnkS4fPKpWfFZR3M7EX0iYHG2o9dcc1K+I2CRSYn/nhalN4P7XGrznhLGdm7Hb4KU/86PPAEw2VA3q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891481; c=relaxed/simple;
	bh=L5XX9q9Bgwmes5VChQaRo0wPdr/Y43FELw3URgsUbfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE4zUmql6awEdLEXlvSDnjRf/kkhXRPHll3xhUicUrkX3IzaP+aTklZkoDSydnxah7vjMARFKqkoPrhCU0t4EATDGfWbl3L9yuy7i5f2c+g4C4sEiL2RIi/MHb9zKWFgLK1u1dUtyHV2VVBcVgmv4yqxu3tzoVUhBTxzVqlSq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhKbHfXm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhKbHfXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706891479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk0HlDLODgfQxPi8eQL+hYbTQD1mb0Iz4J6bjfS5DyY=;
	b=YhKbHfXmzGj7isFQvV3S5OhJiyXyAyAfWktIK0DFKo3Uo7h3XPNjgeSII9naWZd2tQHOhQ
	OunlJV2iaav+9ynLclsRHAPdnTLkk4ixPon+BxnRz5nIsTUpeuf4SjCaGC0+rtQWPTfAMK
	bOwlLs/KOXCtekVHi/KzXyGJxjFAK68=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-ymxwvo5TN7CcTqyXiq-FcQ-1; Fri, 02 Feb 2024 11:31:18 -0500
X-MC-Unique: ymxwvo5TN7CcTqyXiq-FcQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ddddbf239aso1905332b3a.3
        for <linux-security-module@vger.kernel.org>; Fri, 02 Feb 2024 08:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891477; x=1707496277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk0HlDLODgfQxPi8eQL+hYbTQD1mb0Iz4J6bjfS5DyY=;
        b=VOHruJjiy43jQz2r3ZqG1ZCGwxI54AYwbJcU5pSHFllnkmzST/QKrWHLXr4duyYc1U
         LROtHSbFpnIZ7DunctcK/Ncrpg6p1DpkFRIpH6YH5azT8ba8JEQi6OCXf3uqhyAWBwCz
         xDz6mCljAJ+JLdssqRFmg1J0ChAxtMv5Q2+NcoydQ+41TI0CrjtBYQvhFLfQemqT+sz8
         4psmj+15PieqVzP/XE3G9ICTYIF4EnE4b40dzWjJf+57Ef9avIqHQMG/Kmc0TAMsGojD
         YS9yraTGNtWVOhKhUJJq/cMpGxBf/9+DMvxlutwAkpOnsfA5NZgQXmP6bBLa0xsN6Ddx
         bbsQ==
X-Gm-Message-State: AOJu0YyoCxlxPfLc0HjrazNmSmoVvkwysqbzKvcgjwW9cRZLCMdZA/Lg
	TUS4G0vA7/rRMw7hda/MxCOHu1aPtEPTlt5JFuI44+5mNUhK4YVKp/Cg0m6aAoAUsaAAI1rYUoh
	PxiSVhCnWGekYHaVbIVc+veT8aAqgXWKFoHWAu/Lf5i718oUQ2ZnGM85uegRy7yuYN1IEnT2EXX
	jXc/nONJo1ONsjc3yupvin8h/C6Rfg9xp7k7ZgeoV/BWymdfBw
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id eb19-20020a056a004c9300b006dfe0355549mr9341742pfb.15.1706891476159;
        Fri, 02 Feb 2024 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgHoeBG2Xdr20yw3gJ0WYTkapLgzV5sN33Vdcc74VwBIGKGFLCt2pM0mIE0OOYW6PvCilVy3VKGPphO9s59cw=
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id
 eb19-20020a056a004c9300b006dfe0355549mr9341683pfb.15.1706891475565; Fri, 02
 Feb 2024 08:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNu2V-zV2UHk5006mw8mjURdFmD-74edBeo-7ZX5LJNXag@mail.gmail.com>
 <41edca542d56692f4097f54b49a5543a81dea8ae.camel@kernel.org>
In-Reply-To: <41edca542d56692f4097f54b49a5543a81dea8ae.camel@kernel.org>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 2 Feb 2024 17:31:04 +0100
Message-ID: <CAFqZXNv0e9JTd6EtB4F50WkZzNjY7--Rv6U1185dw0gS_UYf9A@mail.gmail.com>
Subject: Re: Calls to vfs_setlease() from NFSD code cause unnecessary
 CAP_LEASE security checks
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:08=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Fri, 2024-02-02 at 16:31 +0100, Ondrej Mosnacek wrote:
> > Hello,
> >
> > In [1] a user reports seeing SELinux denials from NFSD when it writes
> > into /proc/fs/nfsd/threads with the following kernel backtrace:
> >  =3D> trace_event_raw_event_selinux_audited
> >  =3D> avc_audit_post_callback
> >  =3D> common_lsm_audit
> >  =3D> slow_avc_audit
> >  =3D> cred_has_capability.isra.0
> >  =3D> security_capable
> >  =3D> capable
> >  =3D> generic_setlease
> >  =3D> destroy_unhashed_deleg
> >  =3D> __destroy_client
> >  =3D> nfs4_state_shutdown_net
> >  =3D> nfsd_shutdown_net
> >  =3D> nfsd_last_thread
> >  =3D> nfsd_svc
> >  =3D> write_threads
> >  =3D> nfsctl_transaction_write
> >  =3D> vfs_write
> >  =3D> ksys_write
> >  =3D> do_syscall_64
> >  =3D> entry_SYSCALL_64_after_hwframe
> >
> > It seems to me that the security checks in generic_setlease() should
> > be skipped (at least) when called through this codepath, since the
> > userspace process merely writes into /proc/fs/nfsd/threads and it's
> > just the kernel's internal code that releases the lease as a side
> > effect. For example, for vfs_write() there is kernel_write(), which
> > provides a no-security-check equivalent. Should there be something
> > similar for vfs_setlease() that could be utilized for this purpose?
> >
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2248830
> >
>
> Thanks for the bug report!
>
> Am I correct that we only want to do this check when someone from
> userland tries to set a lease via fcntl? The rest of the callers are all
> in-kernel callers and I don't think we need to check for any of them. It
> may be simpler to just push this check into the appropriate callers of
> generic_setlease instead.
>
> Hmm now that I look too...it looks like we aren't checking CAP_LEASE on
> filesystems that have their own ->setlease operation. I'll have a look
> at that soon too.

I did briefly check this while analyzing the issue and all of the
setlease fops implementations seemed to be either simple_nosetlease()
or some wrappers around generic_setlease(), which should both be OK.
But it can't hurt to double-check :)

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

