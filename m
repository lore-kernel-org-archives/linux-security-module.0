Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA813B5A1;
	Thu, 22 Aug 2024 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724362315; cv=none; b=DH5TFk48jhLZ3kq2Rk+9DPNPpZ3CxmUDfSbAgG92661p1+N7f6584XEkB8ERxtl0OExo7b2faHKxeS6VN/tA2wBWFdO5xQuIlK42fjkck7rPWpsWQyLh5T4EZOpEqUS1rgbqZ0uHQAtfSQENjr+Tytw4iwGBbPZCMvyo1fcHxAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724362315; c=relaxed/simple;
	bh=o8Qj+w+x9UMJXl3RzSGXawpnsiM0owFaCBJxVCdA9IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeCsvbSUe8bpep8ATTyI8YWCflWLuRBWZ7/ItnFp0Ir8YDSd/Cm0EbmwG+RJsFiLIFM+WULVVEb4bqbJm4sIYkA64q0hpwN4FFIWJOKgheNwCpIorPfB1DJpGgJVLSbB3MWcA92mfpPhc4uLtDvMMyG3vmW411OqVP9p2bTsJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0dR7fqf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0dR7fqf"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so1784559a12.2;
        Thu, 22 Aug 2024 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724362312; x=1724967112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmOMLAP/sV89r0M1To4cfWqKrxz5e4Moq2BBvNUXlKg=;
        b=L0dR7fqfaF/LmeBym2rEyagHkzOAsZJyV1/LCDADO0fh3fsFlsYWGscMDGcNKdHHD3
         3pMXthPGu+wtIRQhazAdAIDuRKwm2MZmCbv2c+mw1x13hEjFRSh3lo/pieHq/ZaC/x6r
         op8KRXtX8PEeh08MxK54F8sue6E+kKo8mP8c+/EYnoMj+0nFa9/Xf1x6eqM9y03COQIC
         aFcfLSs8V1wT2Y/1CEuY6/7zCNNqFiGyQUY2c5+ZZ5653By0/+bXVxsWJBjvqkvCgjQQ
         l6X7YCh29b7xOLUqKmxzG7KIiMqxIzwGcmdRmFxWcNIJgI723JyblA6+s+Z27m6F7oPC
         o50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724362312; x=1724967112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmOMLAP/sV89r0M1To4cfWqKrxz5e4Moq2BBvNUXlKg=;
        b=m993Ea0FwJErj6gyUZJ4mk3D21RXiqh6ICM44TMX7kCSfc1aYsFM8rYofT8JJv966y
         8cBp/71voBndoiMLl1DrNCmaR+E7J+mYPBv2Ki+5W0ue+4a6/0uYbPEbkZbHpWCywQ+L
         qMkWLYRZQJAmqF51fLzrmZZYFxXdXO55BllQUtYCkCBYWlWAV0oA/N40zXb0C3vvGzRc
         VpPx1yALIV8UM2L60uauEPLKq54fGFp6kra840hPAzckWUZer9LDqJ9OT1nba+YL8nce
         NsnB/q5rHTHa0JPGQIiPyL+AJvYwo1LpZHoYwYxOziD0AOBxI54oYiu5T5Z7W7NV9lQi
         Fn2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIBDFXOMlNbLNmk/5iWnNF5Ap6l3FozVlIFyuwj33vWB4B41tUMeOpP0An8bLQvzi0i6yufDPDmXPNH+075QlaqzMFaCAa@vger.kernel.org, AJvYcCWx/02ZopN/cffcKsCWNycTfk/e2uq9hFg0HIUs/y3yTv7mGJE/yvr3eFLR6e9ttCTtliZ5i2mEvcrqq08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyACIB3BtUdtP895WXEu5BuKCT0LTkQCsfs5AdGnr62woUOz8FS
	E21x6PgyOwsf2E26Rwolev1KxxlDCreWh52ftGdGEFmS2zKSsWSUFsvnqacuw0SR1mxVfun/KC/
	0l5Ann04k75BV/yZraVNCRCy5ZLrMe2Sk
X-Google-Smtp-Source: AGHT+IEOYNTXCdnQItNSdCJflQBUw9Kb33nbjN+cNoB0BQpwT9rRPkJBHs4hkTlkQMrpV53uMKgNMEPiXIlIY5ff4ik=
X-Received: by 2002:a17:907:2d07:b0:a77:dde0:d669 with SMTP id
 a640c23a62f3a-a86a54d137dmr842366b.45.1724362312017; Thu, 22 Aug 2024
 14:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822131542.785546-1-mjguzik@gmail.com> <CAHC9VhRNMMtZ-_-sON_jz5_pkyFTyH5VOOVmPem=AbLpA5Y6dg@mail.gmail.com>
In-Reply-To: <CAHC9VhRNMMtZ-_-sON_jz5_pkyFTyH5VOOVmPem=AbLpA5Y6dg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 22 Aug 2024 23:31:39 +0200
Message-ID: <CAGudoHGJKUkYkrG514YzghV4mBMKGW6N4njdQViBnKiLwoN4SQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: separate the refcount from frequently read fields
To: Paul Moore <paul@paul-moore.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:58=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Aug 22, 2024 at 9:15=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> >
> > The refcount shares the cacheline with uid, gid and other frequently
> > read fields.
> >
> > Said counter gest modified a lot (for example every time a file is
> > closed or opened) in turn causing avoidable bounces when another thread
> > tries to do permission checks. Said bouncing can be avoided without
> > growing the struct by reordering the fields -- keyring (enabled by
> > default) is comparatively rarely used and can suffer bouncing instead.
> >
> > An additional store is performed to clear the non_rcu flag. Since the
> > flag is rarely set (a special case in the access(2) system call) and
> > transitions at most once, it can get placed in a read-mostly area and i=
s
> > only conditionally written to.
> >
> > With this in place regular permission checks no longer bounce cacheline=
s
> > in face of refcount changes.
> >
> > Validated with a simple test where one thread opens and closes a file
> > (dirtying creds twice), while another keeps re-reading *another* file i=
n
> > a loop (ops/s):
> > before: 4353763
> > after:  4742792 (+9%)
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > This is a resend with a reworded commit message and added Linus since h=
e
> > wrote the non_rcu thing.
> >
> > Note each process has its on creds, so this is not causing bounces
> > globally.
> >
> > Even so, there is stuff I plan to do in the area and this patch can be
> > considered prep (only one store to non_rcu).
> >
> > I'll also note I don't see a way to *whack* non_rcu either. :)
> >
> > 0 rush
> >
> >  fs/open.c            |  2 +-
> >  include/linux/cred.h | 31 +++++++++++++++----------------
> >  kernel/cred.c        |  6 +++---
> >  3 files changed, 19 insertions(+), 20 deletions(-)
>
> [NOTE: no comment on the patch context yet, just process comments below]
>
> FWIW, I really haven't commented on these last couple of cred patches
> mostly because I've been assuming someone else would emerge from the
> shadows as the cred maintainer, or at least someone who felt strongly
> enough about these changes would merge them.  Unfortunately, I worry
> that isn't really going to happen and I'd hate for some of the cred
> improvements to die on the lists.
>
> If no one starts grabbing your cred patches I can start taking cred
> patches as part of the LSM tree, I've done it a couple of times in the
> past and Linus didn't seem to mind.
>

ye I remember trouble getting any response in the past.

fwiw I expect to write one more patch (maybe split into two) to
distribute the refcount into task_struct, then modulo a bugfix should
someone find a problem hopefully I wont be submitting any more cred
stuff :)

--=20
Mateusz Guzik <mjguzik gmail.com>
