Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8C1EB31
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727924976; cv=none; b=CD9d76wsSezMEXcD4u8RyS6t827vUR4I1/PmHTEcW3L0HOACySgEcxe449M6tLJlzW0zExKldi7wEcX8E+CMMAQIczzNRBFjSmycPC4Wz/m2OK2J09XvRtHrpG7yp8cGS6ERFEaVrH5KNIz0knyMFEWwSes6FtoX+XYrnxHJkmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727924976; c=relaxed/simple;
	bh=gqxa1YnqSpyoO8jYHhaneN1Xbjde9NeCMupNvy17rVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMov4MCV/0aOMWdPfyv+X2yz+6g5RtFcKM5TNj/CUsymWUZXEKMcmEjMA9abJDNwuBUXNWAQ+Eyx8nWOwIPfv6/z3J9wmxpO5c83kgQwfqs01JS34Xtq0Lpm+DbqPJ8422Rp61ZdH2N3ckr8W0O2YU7q1+lZWJgTrG/KtqJCnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dcT++lDK; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dcT++lDK"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e24a2bc0827so454393276.2
        for <linux-security-module@vger.kernel.org>; Wed, 02 Oct 2024 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727924973; x=1728529773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TKlAqmWS7yAuGxt2U11/NinoSGw3zEex51U/NMll6k=;
        b=dcT++lDKZGo+I167ijS7wJafX8qH34ogEGytZ+LqXFMa+/I6+gJWFaLd9OIy8+rNqQ
         hytoO83DZqTVs0rcShRiCzQomzXm/m0oywfe6Ha7D7Rg+6iBTQNx27QpXnsSGyQFSPKW
         ngqyxBSepdTtk62nC5prlCPZDpjC0FTIe6Ng2ByDzdJ1E8J+khx/7Eed44nnyIJut1/x
         iWDwkoEgggTrgZmxlMFbAI2aace//qm+gYPsQIyiV/jH4MZMB9BXBx6HOwTZ7iQeMZ8p
         cblaOkdadofbtyUhBcZtc/9OcHEar2tWIfbuuI3AW8XEus8CcVKThImFtjXYVsinQ9fj
         3xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727924973; x=1728529773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TKlAqmWS7yAuGxt2U11/NinoSGw3zEex51U/NMll6k=;
        b=qOcLogdI/XSvTGvS6FOqSNbi9tU0aUmlE6qcEPy841f2bl3wgMxAaku47InpqhV9OW
         7JZhoTFOMZZnvY5vyle/p2n3g22xhZZpDg2Boxvmd4TQZywJaVUqmeexWLR5AHDSTfbu
         ycd4fJ8499paEbD0GgOP9kds6mYQdYEPShlB821LAOjydHeh3UO/1rGBlmBWTnXwCsv/
         S0ixBxS+OlcLSHJeVPq9rXca5tAEPnSTjrW7z4iNIdljOWV5EBdNZJk2HjEnI6wtLOq2
         RhbH8DRY/azK2hgfga0CfR30rADtYB9/+imLo/2eGMhjBIsIMQSZNdno48WEJpldiXrs
         N0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGmErO62Zjwrien2czuRxSZbBiZIO8chQ3wLSAjo272qqBs9+dLDJxXF3OnOuTzt7ebkmhWpNRhSNY4hdAmeT1UOS0YxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOyWESTpAbGfYgu8lfNK3wWK8IJpe9K9MiDP5jg2iL3tIybJ2
	ye0KuzEWHCnKgPw27Oc4zB4fSYEzaW2/bKpIvHa2lG+omb3tlnyABR1e4c0FyHf9JF2IEVQ4Zv4
	Q4mlaa1bPa/SH/0gJZBdXKMhHgauauGORcgRS
X-Google-Smtp-Source: AGHT+IEXOkpzxjalt/s6BumTiyIkpgNz6DTSsxcgK3vVgqu+PX9GLKOWjEc84soRoaZm+DQi7TTIHvhFljCKfSz0Z54=
X-Received: by 2002:a05:690c:ed0:b0:6dd:c679:f108 with SMTP id
 00721157ae682-6e2a2b3f03cmr55041267b3.5.1727924973274; Wed, 02 Oct 2024
 20:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com> <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
In-Reply-To: <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 23:09:22 -0400
Message-ID: <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hughd@google.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	roberto.sassu@huawei.com, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 2:08=E2=80=AFPM Shu Han <ebpqwerty472123@gmail.com>=
 wrote:
>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
> > ------------------------------------------------------
> > syz-executor369/5231 is trying to acquire lock:
> > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_l=
ock include/linux/fs.h:815 [inline]
> > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: process=
_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
> >
> > but task is already holding lock:
> > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_kill=
able include/linux/mmap_lock.h:122 [inline]
> > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_remap_file_=
pages mm/mmap.c:1649 [inline]
> > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_remap_file_=
pages+0x22d/0xa50 mm/mmap.c:1624
> >
> > which lock already depends on the new lock.
>
> This issue (if not a false positive?) is due to the possible `prot`
> change caused by the processing logic for READ_IMPLIES_EXEC in do_mmap(),
> so the remap_file_pages() must perform LSM check before calling do_mmap()=
,
> this is what the previous commit want to do.

My apologies for the delay on this, I was traveling for a bit and
missed this issue while away.

Looking quickly at the report, I don't believe this is a false positive.

> The LSM check is required to know what the `prot` is, but `prot` must be
> obtained after holding the `mmap_write_lock`.
>
> If the `mmap_write_lock` is released after getting the `prot` and before
> the LSM call in remap_file_pages(), it may cause TOCTOU.

Looking at the IMA code, specifically the process_measurement()
function which is called from the security_mmap_file() LSM hook, I'm
not sure why there is the inode_lock() protected region.  Mimi?
Roberto?  My best guess is that locking the inode may have been
necessary before we moved the IMA inode state into the inode's LSM
security blob, but I'm not certain.

Mimi and Roberto, can we safely remove the inode locking in
process_measurement()?

--=20
paul-moore.com
