Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A42EA17D
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021960; cv=none; b=Bxbjg2Ju4ZKSKV2LJg5qpdgMozdgphGWOV9Xs0fO5CspkQ+adRwBUJV4PxKEPGdUEMcik5HqLvlsJnWtt2A+0dZHnpeENy3FL113nt0NJVtaKE/STxhnnAvke23b83U2qfc3u3SPU961P2KMrbkxv077o0tmP29CbygfaT0dmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021960; c=relaxed/simple;
	bh=s4LtQsa5EVllx+birty57NnxElV7bKafGqgU2aZZh0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3QioSPXGXhl/h/5IpvHJoTf0uUe/A3DlOtb0k5mCu+sckhO4Cd0ozrzbcMdE9ThORnztt9PLlLKiTtqnfKFEGMdAkJ5Y/PbOArUAKf/UE/2NbGREpISOqSauiQS9jS1dKenK+bp3k9Jx05W8bLNBZuQhgP6VvYZKIb7669Kltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WRY3vYTQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WRY3vYTQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso1104136a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 Oct 2025 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760021958; x=1760626758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahjgOspVOdMfoAz+ojX32xnetLiqRNtvEWbGqK6jlpg=;
        b=WRY3vYTQIEl0w6vrzb0TkeHNaUJv5kMqlWWqHHmvKaGQfWYjI0NkzV1rrHVL7FNWbi
         zvgAhjMWPn0EoqHf6jfOUmAymYTgGCZzxfOS81KRpGZLgt5jKlnnGcdk7EzIGAQxaF16
         D0keH+n0tlcsdr3xFnO/GuZniqyGRgWLpy17zejdJyw5GnjjZvEEolI+BOIFSvPkQ4MT
         dH9ihR643KJV7UujWzJSnXiK5tIabYDxJkmXXa3p4Fz1hBq+wqbH9bbugBGflT6NIvip
         q6VKSzyvHc6oWM00Qu/HwqiwElMcsDn82z3E1cBBDF0dmf/qkHjHnni6qmOGRl3GDKWk
         eqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021958; x=1760626758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahjgOspVOdMfoAz+ojX32xnetLiqRNtvEWbGqK6jlpg=;
        b=QgwGsR49Bc7QyqQ358VfVDNTRcgD6n4oCJXGphEcXdxo1wJPeWPs51YBHGSrvWk5fF
         rp+wL0aiCCk2hDSHRMz8eC/zEUslSiCzG/xSLCmtElWndbg5rWNY5cPP6hbFH+pdteOW
         geCKhg7WtDVrMisCUeKYWk0kxC4NWt1wZJmfNIles/tXPFLpp1qVFlylyYZSsIpS6L7q
         ZnsXKrbc+Q1ok5KYWuLRodUUCBpDAcpG3T6UJQpzyhkV+vzvIVBMe5KBGbL8lJl88ayo
         yytDuWk9OCzBqIzQDNnTYdC1aCrKz+IraDBSfYLPQaGKt5pRj/JHb8facYQxIK6yGNs5
         LsDg==
X-Forwarded-Encrypted: i=1; AJvYcCX07gTRtGr7Ts57+dIeT0OTLTWaVF/9RgAVkKFEV/NxMQxa4YOyXkEV1d7x1kI6hf70SvmE3Y5JBGaP6xHTL51UQtaBYrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKiPXG2/G4X2vfEM7kUSLRYWjXIaTBj0XCZDmmVew7TLTmsFlR
	lJ0I/xPo/D0noo2y/Q34IG43/TMwHeip42b+UBe6PgswuGCpEl810A6B6LWou7+0PMzkL7OKj+L
	wmqf7VU4l8/+JMPGkJcJtCas0/31ibw6L6Sb07J4E
X-Gm-Gg: ASbGncsJMBm9pwsCWTeUzmXPNUQBe+uHng948j3cjTLnKwq0qnkFOtb4p/goSJwCn5c
	Od7/8eyQxudlq68ZYhxjrm9pkQ8wQ+zRrnZ/GmjDYHCTDuEgmMa/D83VlEUUCuZMn5Uosm22DKN
	SvHVVuni0b7pLEAXNCW6/0XV++bnzGUuIvdLYry9lL30hAGa5KxpO+WeF0KeRKBVqrIFAQtIgSl
	XEFMd9YVb6sv63QTJD826NM63/RrwU=
X-Google-Smtp-Source: AGHT+IFf2eEZ8Y3dwPHYfsVPR85J/bW2SFKaZNq78idaJg/NJwVTub7Z+ubYcdUX+OzcCgA2pvccKjX4/bJU8TSe2e4=
X-Received: by 2002:a17:90b:3810:b0:339:bf9e:62a6 with SMTP id
 98e67ed59e1d1-33b51129786mr11695081a91.11.1760021957340; Thu, 09 Oct 2025
 07:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009134542.1529148-1-omosnace@redhat.com> <CAEjxPJ5FVGt0KR=wNmU=e_R5cD6T4K1VRabaZmDAWMd0ZNnPNA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5FVGt0KR=wNmU=e_R5cD6T4K1VRabaZmDAWMd0ZNnPNA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Oct 2025 10:59:05 -0400
X-Gm-Features: AS18NWCQ7y7YKQUxDIqDE5v5atyeT9gE-uS-Jx9EA3wAYJDjv0gABnAz5t8dd9E
Message-ID: <CAHC9VhTCa_SgkOrJVtf1dz0bYt+cyWAUwDWx16MxL9mMRSogDw@mail.gmail.com>
Subject: Re: [PATCH] nbd: override creds to kernel when calling sock_{send,recv}msg()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 10:34=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Oct 9, 2025 at 9:45=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > sock_{send,recv}msg() internally calls security_socket_{send,recv}msg()=
,
> > which does security checks (e.g. SELinux) for socket access against the
> > current task. However, _sock_xmit() in drivers/block/nbd.c may be calle=
d
> > indirectly from a userspace syscall, where the NBD socket access would
> > be incorrectly checked against the calling userspace task (which simply
> > tries to read/write a file that happens to reside on an NBD device).
> >
> > To fix this, temporarily override creds to kernel ones before calling
> > the sock_*() functions. This allows the security modules to recognize
> > this as internal access by the kernel, which will normally be allowed.

...

> > @@ -2706,6 +2720,8 @@ static void __exit nbd_cleanup(void)
> >
> >         nbd_dbg_close();
> >
> > +       put_cred(nbd_cred);
> > +
>
> Should this be done at the end, after the workqueue is destroyed?

I didn't trace the send side, but it does look like the receive side
could end up calling into __sock_xmit() while the workqueue is still
alive.

> >         mutex_lock(&nbd_index_mutex);
> >         idr_for_each(&nbd_index_idr, &nbd_exit_cb, &del_list);
> >         mutex_unlock(&nbd_index_mutex);
> > --
> > 2.51.0

--=20
paul-moore.com
