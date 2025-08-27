Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016229B8F8
	for <linux-security-module@vger.kernel.org>; Wed, 27 Aug 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309103; cv=none; b=YzwPfwu3xgWbBmB2DbP4E1RHI1EFQ8PSpw3wTp6ErrpLuh394ss4eejxut5J6lkI29oqIX1dilJr8svTP5+mMF0w5lUbXakvI3m0oFpyd5+R5njKpCV3xWW7PRZdmigE+SGU6SJs4LzBLAb/Iyn6ylN+HFSpOobsOPuYE9AMo1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309103; c=relaxed/simple;
	bh=5V5gmHT4ib9khjTGQ2iAE/pbDIJrEyHXN89uDM9KYh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HINA0sbo/LFhBMe/6rd0MmSD0CqNDQoKEdmS/aihEeKMWdqTnpEeZ1flPby++CmzSoIXkOLkh6DiMG52/W65NkXeyP1Rs9iM6DVvL1+MxU1CNwaVGbr/HX1xmZnD/s5drJlo5tVVnaf1ReMBIybvC4pTXc/uDwOLrGv5fwk8yv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HP8FNLFN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HP8FNLFN"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3256986ca60so4694049a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 27 Aug 2025 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756309100; x=1756913900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCaj9qU1uTlK3Io/0yLAp0BC9tLpIJ8rHughNbkImAs=;
        b=HP8FNLFN/oeTa/q2z0v9DvphaeVF51yppEkoHCzBEfBnnOyRhZAvVaas7TIL/8uSOM
         MOorrs1uRuCA2tTYm2OhjjuTVSR529ohETkWSXSLv7Fpj+ZKy18d/sx9KOsB6FiYiHpb
         i2FrRaXRF89KcsIhTB18q19jmZ+LdcAqAoDZieHG2eWaZrpuMzR61PCXClVBK6VaR5Hr
         AMvtbmT04DmdGBVOW8nZBIKrj0zZyzEFJw0EjwfBfbEFxv82w/RQlplRNVQBNJDwf24N
         aqEmjRgm68lGTG4fWsbdPRrggl7TpuRK7gAgauROmg+eFSiHzgEK+FoFqBxMi08FBgaH
         h7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756309100; x=1756913900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCaj9qU1uTlK3Io/0yLAp0BC9tLpIJ8rHughNbkImAs=;
        b=batrdYhXwXUQPBLJZiz9qix6VQIFFNqjZWvyI5MjQxhFP2rKLXtXTsPLxCL3XJlR1b
         ISPjshhfKIH2YEVWiKmPuIRssWSiDbO2PPzepO90pPs7am23iSFUIp+5P0pvmMfNcEG8
         kgOHb/xBUBUzM3BmC5yLI2tciLyyri94pILTYQBRN0yBP/1gZJrqX+UEOkhmvDvqVyOP
         cWXxKrZpDco5X477tgLok5YF+984zi7n2Yal4xC6KL8o2KrPSWcen7UeaOTZNIh+T7kI
         2qqPrSjs5PENQyzSmfhZMaz1FP3g28WZQQPB0z1WJNs41Pyr4WgibKoa4KVIlfrazNxY
         oVkw==
X-Forwarded-Encrypted: i=1; AJvYcCVjB1K9B77zY9T5qgF+NCHCZQKSajFvbX+Hqa+5xY/8Dk3oQnqE6/NcBUksuOfW/uUJvwk/t0rE/BXbXyXnE7fnaS/+apA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpKbOSAQsaSprrDXwqzVLd1gciYZp9r5H7X9G1AXvvZxv/5ML
	V6l47cL/6eBsQ/CEgqcz6EJs9RFfRuwVSDxs1fqSara+RYZfRnNHsvx5EOINdOn1mpkjJLoie3s
	VQVBj9Mu+Pv5+M/XJ+XECGTykr75YjQSQqrUK/BvX
X-Gm-Gg: ASbGncvDNLJCv1io8yK6FzmQP5xNZSyb+YOtb8BO35L3s9BSngACPEq16J65UBV4IlS
	fWqbtl16seydfbHCazpCepS5UQVo/NVgTTZYswHlOCBrz3UruoVPNr+AqFCg95qW52fciHGrP06
	N7LLHJcbcUnDO6kIbKBgcsIN6ZN/VslTSpOwuLxXgDKrTSYVd7VZbu0tC07CvQRt49SRSRP1z40
	7ZFwXgVbHKlZp3oBg==
X-Google-Smtp-Source: AGHT+IHtW2dnjAZbisWoax5mDslCTJ0tibAgoeGxJEVde+ImUinBOPTyITNYGZAcvnmQsIs+XXzFMCwatNRnWjAZUS0=
X-Received: by 2002:a17:90b:3f90:b0:324:ff5a:38c7 with SMTP id
 98e67ed59e1d1-32515e4f4e3mr28437601a91.16.1756309100066; Wed, 27 Aug 2025
 08:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-25-viro@zeniv.linux.org.uk> <20250825-zugute-verkohlen-945073b3851f@brauner>
 <20250825160939.GL39973@ZenIV> <20250826-kronleuchter-vortag-af3c087ae46a@brauner>
 <20250826170044.GT39973@ZenIV> <20250826175501.GU39973@ZenIV> <20250826182124.GV39973@ZenIV>
In-Reply-To: <20250826182124.GV39973@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Aug 2025 11:38:07 -0400
X-Gm-Features: Ac12FXwI_c9yQVliIi4jpN4iAYA38ukwD9hnjwkrY0xsL1nLzMdiDBBGXi7UHag
Message-ID: <CAHC9VhQ9p3W79N5nFJFgoiogNH-zANi+65ydYXhZikMPEvqKkQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] switch do_new_mount_fc() to using fc_mount()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:21=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> [
> This is on top of -rc3; if nobody objects, I'll insert that early in seri=
es
> in viro/vfs.git#work.mount.  It has an impact for LSM folks - ->sb_kern_m=
ount()
> would be called without ->s_umount; nothing in-tree cares, but if you hav=
e
> objections, yell now.
> ]

Thanks for the heads-up, I'm not aware of anyone currently
posting/working-on patches that would be dependent on this.

> Prior to the call of do_new_mount_fc() the caller has just done successfu=
l
> vfs_get_tree().  Then do_new_mount_fc() does several checks on resulting
> superblock, and either does fc_drop_locked() and returns an error or
> proceeds to unlock the superblock and call vfs_create_mount().
>
> The thing is, there's no reason to delay that unlock + vfs_create_mount()=
 -
> the tests do not rely upon the state of ->s_umount and
>         fc_drop_locked()
>         put_fs_context()
> is equivalent to
>         unlock ->s_umount
>         put_fs_context()
>
> Doing vfs_create_mount() before the checks allows us to move vfs_get_tree=
()
> from caller to do_new_mount_fc() and collapse it with vfs_create_mount()
> into an fc_mount() call.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

--=20
paul-moore.com
