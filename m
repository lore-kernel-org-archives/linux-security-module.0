Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0821376
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289362; cv=none; b=mzQhZHTncs0Lh4B58+XLnyDMXcMOYjm76NE8FJTDeIErYT1OCkoQyQVO34MKTUFkYPQ5t7CKO94tG9+Dwf5IgEa0hwtOSZVeuXjwMCaqR3fYLXHF+f1nj5xpshl8CX4qctYMMHwsg3ou46o5OpPn6J4REa82RAD3z7OczwCbu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289362; c=relaxed/simple;
	bh=VWYPT8g6Jd85tJW5Xy4JfiFcSB9nSNuj8foib8RsdEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjAMzNTkS2rZ8gSBAlApThWGIGPYhwTPx1zd3/xdPswPqI2Iv2Mah14f9JXqfHpBsbTgBgN/8avbClk3z88gu4eIavg8v9MDlN4Bz8lEFC7QE9PBQ7vU2sDtedfovzzVMJYvdm2SsY77X3WmDMNVK43cRz7pzOHEMliMyn0KDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CP7ssFwt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP7ssFwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706289359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgot8gnXgaT/PXNWyINqw6zO/OV0dslkn5Z+0ObOBdo=;
	b=CP7ssFwtfgHVzq1A1+hLNDJTyqV7Xv5uvIkJl76rUJtybksvZYmI0srEdKnmztjK73jn9E
	/Pk0iIWuRgfLV0tr90GVVBGZ2xCft0jm8WgjzAJdoL0H5qz88Eg6DV5+mYvuzTziXGc606
	+rOG2XkzBSdKFZyGFtMQkh+7PWkoprc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-x6JMVyx3PmerU_F8YHdo2Q-1; Fri, 26 Jan 2024 12:15:58 -0500
X-MC-Unique: x6JMVyx3PmerU_F8YHdo2Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-290f607c1dfso508828a91.3
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 09:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289357; x=1706894157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgot8gnXgaT/PXNWyINqw6zO/OV0dslkn5Z+0ObOBdo=;
        b=pvBCHgJ3b8V4FVIvinTiZuKwRHtbMihc1U0o4e6ggsIV5eJeUfZUsQMMShN9Z+FE5E
         DucvzIBeWz9XXNAYH1k7SVyl/Y5XLyP5fms2W5cM9y+6ledN/JOSf9Glb8j4sGzyUQH3
         vugb4x1bjL30g7qo9OBpMqJyVedgqfB9+gua2JF3wiQLbw73nOs9dB1XTFrOzFMHGKgK
         zy2KfU9fI/oAE4RlyHZH4dNweaKTdxCMn7/VJVjpk3EI+RAXOUg+8VDnzLEQlPv41tOv
         4PsjxJpqbjsb9AHCbM7sijlw2luUH53oHLfNHRCAFr73bs7TpkIS9UuS3o0Z+f8HvG4k
         GDng==
X-Gm-Message-State: AOJu0YzIKW9vmOb0UyM2HE5yFSEuzM+4f9QS6BY6B1hrI6KNPtC6HclZ
	m/FL//cETNN/HoDEfZLEa9cKIHa8w+GRD8MG5Ql6FgY9L6naaB9DL0jAgqNuLib7+gqQxU5Jrxd
	g9atS77riBUJMnOH/BlJkwQbDercNP+G/YG3B+U3LeFR3M9651IikCn+uE/HzAo+5S/Qtp4txdo
	hdsValRLhG3nhY/BZFvENFRBRKfO4Vy//oGJ+LZ8y6A7lbd+fTpEOwtzXY
X-Received: by 2002:a17:90a:4089:b0:28b:9749:c5a4 with SMTP id l9-20020a17090a408900b0028b9749c5a4mr165972pjg.80.1706289356822;
        Fri, 26 Jan 2024 09:15:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHewnI20Y5l1grIbvylQlE/FM5X1udcmBREJcp3l0x2EQqa4JWvew4t1fEOb0ARNHWpUO2FXI+0lWH2O5j/HGo=
X-Received: by 2002:a17:90a:4089:b0:28b:9749:c5a4 with SMTP id
 l9-20020a17090a408900b0028b9749c5a4mr165963pjg.80.1706289356585; Fri, 26 Jan
 2024 09:15:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com> <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
 <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 26 Jan 2024 18:15:45 +0100
Message-ID: <CAFqZXNvbm9OHvaY5rmO8fxxHCT5T+ne1kj1XiT3yTRMiff5d2A@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 5:04=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jan 26, 2024 at 10:03=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jan 26, 2024 at 5:44=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > The inode_getsecctx LSM hook has previously been corrected to have
> > > -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> > > behavior. However, the call_int_hook()-generated loop in
> > > security_inode_getsecctx() was left treating 0 as the neutral value, =
so
> > > after an LSM returns 0, the loop continues to try other LSMs, and if =
one
> > > of them returns a non-zero value, the function immediately returns wi=
th
> > > said value. So in a situation where SELinux and the BPF LSMs register=
ed
> > > this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
> > > returned 0.
> > >
> > > Fix this by open-coding the call_int_hook() loop and making it use th=
e
> > > correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> > > other hooks do.
> > >
> > > Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_W=
h90jYPwRQRAqXxmOKD4Q@mail.gmail.com/
> > > Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecc=
tx")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> > > serious issue that Stephen reported, some of the tests are still
> > > failing under NFS (but I will presume that these are pre-existing iss=
ues
> > > not caused by the patch).
> >
> > Do you have a list of the failing tests? For me, it was hanging on
> > unix_socket and thus not getting to many of the tests. I would like to
> > triage the still-failing ones to confirm that they are in fact
> > known/expected failures for NFS.
>
> Applying your patch and removing unix_socket from the tests to be run
> (since it hangs), I get the following failures:
> mac_admin/test            (Wstat: 0 Tests: 8 Failed: 2)
>   Failed tests:  5-6
> filesystem/ext4/test      (Wstat: 512 (exited 2) Tests: 76 Failed: 2)
>   Failed tests:  1, 64
>   Non-zero exit status: 2
> filesystem/xfs/test       (Wstat: 512 (exited 2) Tests: 76 Failed: 2)
>   Failed tests:  1, 64
>   Non-zero exit status: 2
> filesystem/jfs/test       (Wstat: 512 (exited 2) Tests: 83 Failed: 2)
>   Failed tests:  1, 71
>   Non-zero exit status: 2
> filesystem/vfat/test      (Wstat: 512 (exited 2) Tests: 52 Failed: 2)
>   Failed tests:  1, 46
>   Non-zero exit status: 2
> fs_filesystem/ext4/test   (Wstat: 512 (exited 2) Tests: 75 Failed: 2)
>   Failed tests:  1, 63
>   Non-zero exit status: 2
> fs_filesystem/xfs/test    (Wstat: 512 (exited 2) Tests: 75 Failed: 2)
>   Failed tests:  1, 63
>   Non-zero exit status: 2
> fs_filesystem/jfs/test    (Wstat: 512 (exited 2) Tests: 82 Failed: 2)
>   Failed tests:  1, 70
>   Non-zero exit status: 2
> fs_filesystem/vfat/test   (Wstat: 512 (exited 2) Tests: 51 Failed: 2)
>   Failed tests:  1, 45
>   Non-zero exit status: 2
> Files=3D77, Tests=3D1256, 308 wallclock secs ( 0.30 usr  0.10 sys +  6.84
> cusr 21.78 csys =3D 29.02 CPU)

I got the same ones (I, too, removed unix_socket to allow the rest to run).

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

