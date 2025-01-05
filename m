Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797244A3E
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736048969; cv=none; b=tGJxR9exgwRxx6cJ6dXzmDQrUHpJOPJyBTo0aOOtXbAmS6nSV5p+MrXg62UV41N0GgE0Gtd1hQSGegP1F45S/7oxjb3pcAdpikOkqT8sFXNfrA8pw1t4SmzN7dAuSiK1D18KnM5j6DO9VPmaqQTJH3Z0JFz6Z1iWP9NEDZNKoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736048969; c=relaxed/simple;
	bh=b6zVtB5LinMc1RpSrZ1qJBHiexLQ02Dvz3MvDOYq9Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcKddsifl5QIUvEo8gnUx9Ctj7tgTCq7+P6RpKQPlPXWd4bl2FHjBtlHwdAOU7NvgxnMhlagwA2cikYQalJCvh0bkzfn5A+cp7B6K7fQ9rF9qV6pPwNlbJ8DEgGgXjRkf+8GMYKXKawkUz/AHL1lRgalz2+CnUm6/r5dlMKn+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=df9O9wnM; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="df9O9wnM"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e460717039fso17221802276.0
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 19:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736048966; x=1736653766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4cgSgneQbSlBJD0+kgcCz+RS+iow4L0Shm1nbUOb04=;
        b=df9O9wnMzHAStMzplZre85Lf9v1XFkVJKoxPhnALZK2LmfxwLbEfFPkU27dTEtIKhq
         Ldx8d4PspKJB5M2S9d/vhQV0O/LpR2TBuX0EOPAfRrZBDlpxjuYqJnz3+UanD4ZG9jHV
         1V5zif7ksry+U7Lv48iakMSP+ZIIpD/EdlAHgTWnLhd/jOKiWnMpCqEqBcSaDOCqSph7
         2em0O3ptrP2TyVShrVww1O7it6g7ZnyZ33QF0lsQhZYagkUZ/CPlJcXVIZ76GK37PWvs
         uzpcQtO/zl+Abhklk3ZYpGQzvKak2U7NWzkYJ7bGP6mj5yfDD1uEix/VfVA+mIjJKAc5
         UIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736048966; x=1736653766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4cgSgneQbSlBJD0+kgcCz+RS+iow4L0Shm1nbUOb04=;
        b=akwi3XmpBRRdoHv8VJj6W9gLASFrDZa2Xk9zB+1C7mG4sAxua1DygmGKTBFoA6QTHh
         UTys/bYTH9YmZ7Btjd8lITLxXvyPhPm7ArHkA+2r+k8GV84zyTS0/1vn0dbe679vBq1L
         9EpkfA/JwuuYdwHT2tZCg8p1VgnOOQRM8LG+ZU3G8h7ccycfTuuYdlTbUTV9QtCKwWgv
         +YLLDeS94qsqmWV52ZgHlL1QbB6X048/koJ+UEyaSruW13/AymLUsGl8WasQNzzQTi+S
         D7wWd/+SPcHbd7ip108fqXTrPpC7UjWH9l50ZZJGnPF0Cfn5N0FFgnYCQrhmtDTOTt76
         Frzg==
X-Forwarded-Encrypted: i=1; AJvYcCXApkKCfbyV+4FRaAN/0IpV5r48v4cnjewsEkIiT8bk2v8JyzFqUYrp4rFN9/E5CNk57T59G7M6IerMH/UrBghDKXcsnvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8y+tg2nu8w05OXVZlOejRC0fANflA0MhtilinKn9vezuPy88
	dtP9Epa/pMsU/3PtSCjG25RBW9favj+UyTFr4mgTaE4hnyKGuIQaaDQMjDPC2shNRjzCG0aBz1y
	KzsubVG4ITq0xpcchLEeE6WUh+sKZ7Zi1HxCv
X-Gm-Gg: ASbGncsArZs/m9mdTg3Y7mP4KQxpfC4GJg1/zAKx+AH7cPGvnC5zGEmAqqkf2XgAl0F
	4SA9IHnkXEVR+85UtCsIJkfYbZ3C9htNghULW
X-Google-Smtp-Source: AGHT+IGbfwPxv2tLIgSY8NUO26W2crcCV3cOQls9iEOYgayZOjq0o5a4AnTktqu5sDGnfzTUrXlT8ft4L2Z11DHXov0=
X-Received: by 2002:a05:690c:6005:b0:6e2:ada7:ab3e with SMTP id
 00721157ae682-6f3f821a3femr361116767b3.30.1736048966316; Sat, 04 Jan 2025
 19:49:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
In-Reply-To: <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 4 Jan 2025 22:49:15 -0500
Message-ID: <CAHC9VhRektpFHeUirRP8MH3NkmHWyy4BLcrDpy9zJH=ZJD4gRw@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: check size of writes
To: Leo Stone <leocstone@gmail.com>, mortonm@chromium.org
Cc: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Dec 17, 2024 at 1:27=E2=80=AFPM Leo Stone <leocstone@gmail.com> w=
rote:
> >
> > syzbot attempts to write a buffer with a large size to a sysfs entry
> > with writes handled by handle_policy_update(), triggering a warning
> > in kmalloc.
> >
> > Check the size specified for write buffers before allocating.
> >
> > Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D4eb7a741b3216020043a
> > Signed-off-by: Leo Stone <leocstone@gmail.com>
> > ---
> > v2: Make the check in handle_policy_update() to also cover
> > safesetid_uid_file_write(). Thanks for your feedback.
> > v1: https://lore.kernel.org/all/20241216030213.246804-2-leocstone@gmail=
.com/
> > ---
> >  security/safesetid/securityfs.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Looks okay to me.  Micah, are you planning to merge this patch, or
> would you like me to take it via the LSM tree?
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> I'm going to tag this to come back to it in a week or so in case we
> don't hear from Micah, but if you don't see any further replies Leo,
> feel free to send a gentle nudge ;)

I'm going to go ahead and merge this into lsm/dev, if Micah has a
problem with that I can always remove/revert if needed.

We may need to revisit safesetid's documented support status, but
that's a topic for another day.

Thanks everyone.

--=20
paul-moore.com
