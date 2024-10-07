Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE381D4164
	for <linux-security-module@vger.kernel.org>; Mon,  7 Oct 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318959; cv=none; b=UPrVs0OjLMcYi0slbB9W8Bf5EpzLCV8IOpYEVtdDCkHN6wMY8TQfsGzsdT2qmzvDefvgdCpD4inv/JQD2sfzUjDG3FpCAxQ0K3ZDRIuFSpEv6TpZ/xfOyqadzWRYUDFKiv2AwKyMUFM5B1gy8WZKLXN09YF/u32lAfhS8VsvnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318959; c=relaxed/simple;
	bh=XWRRmYhbIsGnPQa0UxnUE2+vH7hB5dKVgAhDvK4tq/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hl3XO3/0/2953bQBVkThpEZOosO07jaBu0acNgPRpTwyCJ+lwTeNEooawhV+3bQKzkjtStd2WnQOHROe28UwtW9LL3JvfpoquqU8cqmZDQ82t46xhQTbv5tQzMOYS0hXYuZkRojKBlXj9VTwdFK2tm3RkoQYhf8ukyG2/R/KBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J1sbWIIY; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J1sbWIIY"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25cc9c93a9so4225917276.2
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2024 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728318957; x=1728923757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGLVVCKHdNtO/ioaopKZCdho+ecoPCau6mCNU2xBYcs=;
        b=J1sbWIIYrj5CKMu/nTkPtGa+lM72NkEqOe6oMtpLZqp9tXATmacb2Cqr7jsRLj1faw
         hyb8hpRwKjgylgCLDi3VH1wjJz4+lyOToEoeMsbyjgxro5St0r5JhduR1asM27bHGxPU
         NAImOQh23TkQnlooaP2LjqzbHRIuc1JUoGVhr0s5diDikCU6IPBX42mJc1NrDmN6qq/h
         lfH2yRHastJpLSf6mWpUvqHCrzYYKps0KMv3j1QlKnYyMD8Lt65oADbGQkSXOiZmqEVY
         sUExpsAPb0xytj2NPo8gXlkm79PobnJDSMsug2ph7YP4MzpYRRTHMonqrJKyvB3haJ2P
         gnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318957; x=1728923757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGLVVCKHdNtO/ioaopKZCdho+ecoPCau6mCNU2xBYcs=;
        b=VkxKqVouY2yqFPygxgOpex7wO+/KYHtr7qUIezCZRRzgYvhyMF3TMGvLkBuWz1JcKU
         Cwn3payaIzTVJzdiFPCEZJwzJrB97s4h3/r37o6mMYNdmva3CHh4dUX8P1dg0Ux9qg/f
         64gMT8YWfVQNOkrgCmsb2dTX4ScFkFmCGfhWmsipSqht/8JQEjiPuhuxCIuRsKakUJ0C
         IEABO+0dUeWegl3VS4L8ONgjAi6NZrZBq/yV3XbdMfLmEOsS460EJKB70BPzHZluiED6
         45mjI4areXklrbKABPLIWWHXq8hkb8TeG0lyTRq6VKU436A5n/Vwu80COFk53dzQJhXz
         exjg==
X-Forwarded-Encrypted: i=1; AJvYcCXuj0+fXfKV2Ixwk2SrYxcZeJXlIB1Vaz8Mw4Rv8QDayZlFpTlBnmep637sMB26DoEQIK8Sm+W/nGlB3dE2En8YNsQHThc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWRY7vv14cL7OKXgn9elsE/YCCR1avzzbPoOP77dPg9CmPRWfS
	YntiTLnz4kPtWRrYZAugyXKDT661RtMGNompFvlDcMxitB3LgpwnSrMUrdO6Yb6c9IFUFKHOT3w
	ZTERoVGqdWcrcR0ZXAiDDvi++4qY5iVO8c4Wr
X-Google-Smtp-Source: AGHT+IHMnCKj/L8qumQO35MXRgmOOBpLRXITDLkE2JHuYnlF1uX8MtmRoQF/PE4lBXFoP3VKXpQqHk5de4DKSnvSRQU=
X-Received: by 2002:a05:6902:2301:b0:e1a:9379:5aac with SMTP id
 3f1490d57ef6-e28937e4569mr9008649276.30.1728318957146; Mon, 07 Oct 2024
 09:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com> <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
 <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com> <05e893036fa8753e0177db99dd48eb9d2e33476a.camel@huaweicloud.com>
In-Reply-To: <05e893036fa8753e0177db99dd48eb9d2e33476a.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Oct 2024 12:35:46 -0400
Message-ID: <CAHC9VhSEMSwzxjXUHLCWXoGj3ds8pQJ-nH6WQuRDzBkx6Svotw@mail.gmail.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Shu Han <ebpqwerty472123@gmail.com>, 
	syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hughd@google.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	roberto.sassu@huawei.com, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:31=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2024-10-02 at 23:09 -0400, Paul Moore wrote:
> > On Sat, Sep 28, 2024 at 2:08=E2=80=AFPM Shu Han <ebpqwerty472123@gmail.=
com> wrote:
> > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > WARNING: possible circular locking dependency detected
> > > > 6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
> > > > ------------------------------------------------------
> > > > syz-executor369/5231 is trying to acquire lock:
> > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: ino=
de_lock include/linux/fs.h:815 [inline]
> > > > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: pro=
cess_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
> > > >
> > > > but task is already holding lock:
> > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_=
killable include/linux/mmap_lock.h:122 [inline]
> > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_remap_f=
ile_pages mm/mmap.c:1649 [inline]
> > > > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_remap_f=
ile_pages+0x22d/0xa50 mm/mmap.c:1624
> > > >
> > > > which lock already depends on the new lock.
> > >
> > > This issue (if not a false positive?) is due to the possible `prot`
> > > change caused by the processing logic for READ_IMPLIES_EXEC in do_mma=
p(),
> > > so the remap_file_pages() must perform LSM check before calling do_mm=
ap(),
> > > this is what the previous commit want to do.
> >
> > My apologies for the delay on this, I was traveling for a bit and
> > missed this issue while away.
> >
> > Looking quickly at the report, I don't believe this is a false positive=
.
> >
> > > The LSM check is required to know what the `prot` is, but `prot` must=
 be
> > > obtained after holding the `mmap_write_lock`.
> > >
> > > If the `mmap_write_lock` is released after getting the `prot` and bef=
ore
> > > the LSM call in remap_file_pages(), it may cause TOCTOU.
> >
> > Looking at the IMA code, specifically the process_measurement()
> > function which is called from the security_mmap_file() LSM hook, I'm
> > not sure why there is the inode_lock() protected region.  Mimi?
> > Roberto?  My best guess is that locking the inode may have been
> > necessary before we moved the IMA inode state into the inode's LSM
> > security blob, but I'm not certain.
> >
> > Mimi and Roberto, can we safely remove the inode locking in
> > process_measurement()?
>
> I discussed a bit with Mimi. Her concern was the duplicate iint
> structure creation during concurrent file accesses. Now that inode
> integrity metadata have been moved to the inode security blob, we can
> take the iint->mutex out of the ima_iint_cache structure, and store it
> directly in the security blob. In this way, we can remove the inode
> lock.
>
> Will write a patch and see if it passes our tests.

That's great, thanks Roberto.  Assuming all goes well we'll want to
backport this everywhere we merged the remap_file_pages() patch.

--=20
paul-moore.com
