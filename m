Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DC47F52
	for <linux-security-module@vger.kernel.org>; Thu,  1 Feb 2024 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706831571; cv=none; b=or6U0zOA8gyv5UxDjzXmZVxtvq2zEdY09zL/6NBukBo/b20OiUe/O5GrfXcx3uOvKqdhFKCpZikjenp7Ags1nPfZApkhPYvYt+X01kMbhB1UwbiXUcAx73oYD4HaqKBMT5JqfP9DXAim1G+AxmiG/lR4ZG5W6uARcSihuw+/eTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706831571; c=relaxed/simple;
	bh=K26+ljmstsTXJaJziijgy2UvetOVAHHAEAHWgTsCUX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJIes0mE3sNrVppr2RacShYmBxQOk+V4dTmx6P2Cz6c+ZzvsS+KzW+KHiCMacv5Md9Q7sBhRX7hpkpX3w5dR7frg7gZcT8tdmH1S++b3m1O6Szp3vLahUNE4u3mOEMCekIhs8/byQR3RntyZsU2h/poUJaXXTYmGalKo8TEMOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JuWScAjO; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JuWScAjO"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6af9a988eso1370349276.0
        for <linux-security-module@vger.kernel.org>; Thu, 01 Feb 2024 15:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706831569; x=1707436369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZutApDQyHqWHXOheSHjZFiqHN5iJQZ+ZDThq7vbOdtU=;
        b=JuWScAjO7seZd0lYVhu8/VBS9ayfN0BgKHdvuJKSr4LHND4xlma3T+dTiFVQOhhxNt
         YjW8PZTq10g8I2sCm1yObR8nX6bXmrMFunG6+9+elUWyOZ70DU7V5Ocnd5HPIdotL2qA
         Slv18+Pq3bwcInPVAozJStixyDOm/cm1SUStJo7RoAEh8lgCkj9O+BtLx2z5lp7ymep6
         FQrAHKe0f09G9yzvYJXIsIkz1RiZwmMIIuvrKUFkLHK9RbQUgCvfvFVK9sFn1PXc3ck6
         eKSIccN722UuVd+EWW02zo4TnA6yY3U7PO0bjJLx6mcnXF4WiikHGEkgexAqUMGRZX/l
         Vbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706831569; x=1707436369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZutApDQyHqWHXOheSHjZFiqHN5iJQZ+ZDThq7vbOdtU=;
        b=ADVusflNX3H0LjZSwjjS+RiQE2KQCZmnlZiut22RYBqEEgREJ54zJKpSSePmgJAMk4
         UcnARe72AOsa8FOmFbNMK0p/nGplTo0g64GScQvlyAU43qccJnFA1LIYkU9bF9SxyCWI
         zUsr9eP0Toz1Cxnb1Ipylkso5y3KYKw0M/rYHczMHtRgRJ7BpQxD6zNAo6i+9E2aa2V4
         d+HChrpc5rh/1KSmBTSM6utIslNbYXihaDcwvPuW41f/07gRQF32APrRKrtA8pSTKkrn
         9B85Gat1/hRE7A1wpQcnH5rk7FDypNySTezebnlT5yg19dhHCAZTa6GuwpKHONcsq84q
         ru6Q==
X-Gm-Message-State: AOJu0YzA/9gWgfIO+p9CSRuqfRfdgBxyxOT4IsacPpZszL2rMqv52U6f
	2AtIhpdvCCOguMB9OsBuksGNwhmRuOUggE16AVgIPVMGcJaV4N58N/bbmRMiMwH/BYeDmnOtgXm
	tJ5rHX0ZkICMq/tqsmtRdXfHxUOBYxGDri7AqbLqQsZ7oxyk=
X-Google-Smtp-Source: AGHT+IFwyMjMA6Kd/s870YFazzZNwFzIhi3jMlai3uZhLkWNcs0/1NiL7U0BcuJQVYXiGxoUBz/PMlE1yRX55NsEmyU=
X-Received: by 2002:a25:41d0:0:b0:dc2:5573:42df with SMTP id
 o199-20020a2541d0000000b00dc2557342dfmr6590927yba.25.1706831569046; Thu, 01
 Feb 2024 15:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129133058.1627971-1-omosnace@redhat.com> <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
 <CAHC9VhQRSWMRAg=y5cUx9+XLG4A2_+WSqJN1RgQQ8bF=VDwnWw@mail.gmail.com> <CAHC9VhRa5q3fvWUD-Dh-d5Udq18XqFwR4AGUzSow6Ur+_TmFrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRa5q3fvWUD-Dh-d5Udq18XqFwR4AGUzSow6Ur+_TmFrQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Feb 2024 18:52:38 -0500
Message-ID: <CAHC9VhSyNPd4rK+oZE6cDwZTCb3Km_eu-+K8s+X73BJwt8ynuA@mail.gmail.com>
Subject: Re: [PATCH] security: fix no-op hook logic in security_inode_{set,remove}xattr()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 9:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I'll come back to this tomorrow with some fresh eyes.

My apologies, "tomorrow" turned into "the day after tomorrow" (as it
often does) ...

I've been struggling with the idea that there are individual LSMs
still calling into the capability hooks instead of leveraging the LSM
stacking infrastructure, and the "magic" involved to make it all work.
While your patch looks like it should restore proper behavior - that's
good! - I keep thinking that we can, and should, do better.

The only thing that I coming up with is to create two new LSM hooks,
in addition to the existing 'inode_setxattr' hook.  The new LSM hooks
would be 'inode_setxattr_owned' and 'inode_setxattr_cap'.  The _owned
hook would simply check the xattr name and return a positive value if
the LSM "owned" the xattr, e.g. XATTR_NAME_SELINUX for SELinux, and
zero otherwise.  The _cap hook would only be used by the capabilities
code (or something similar), and would match up with
cap_inode_setxattr().  With these two new hooks I think we could do
something like this:

int security_inode_setxattr(...)
{
  owned =3D false
  hook_loop(inode_setxattr_owned) {
    trc =3D hook->inode_setxattr_owned(name);
    if (trc > 0) {
      owned =3D true;
      break;
    }
  }
  if (owned) {
    hook_loop(inode_setxattr) {
      /* run the existing inode_setxattr hooks, e.g. SELinux and Smack */
    }
  } else {
    hook_loop(inode_setxattr_cap) {
      /* run the capability setxattr hooks, e.g. commoncap.c */
    }
  }
}

... with security_inode_removexattr() following a similar pattern.

I will admit that there is some duplication in having to check the
xattr twice (once in _owned, again in inode_setxattr), and the
multiple hook approach is less than ideal, but this seems much less
fragile to me.

Thoughts?

--=20
paul-moore.com
