Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5201B423E
	for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674902; cv=none; b=foro3NTg7fD3kKACgl2p9RXsQh/yHhSL4R2B+mzCE6BfS3OGDtXCA52gbNtfUHGLnbWY6Jg1mLjI8TWHTk5RWI0Y+oGqm/nD7ZQRX2DV5HpYoJGyXrBZYFTckIPQnXn8WC/2rYIHvUtzc2DLTPf+yWORLAtkowi0bp79a7Qo2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674902; c=relaxed/simple;
	bh=kjNwow5X4ZZ01USyEwmrs9aAMem57HqtvhZwTRgcBNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQ0soWc5IcGadVNxO+fUgXKhE1LxHkI44GKYj7YrcRC1wTkg5wIaaK/3rOY3x5cK9jzPid3XrOlBV7XJ6LdI608tLtg/8opYPzU4ISZf9ZQ0fcb2XG4zgO3CEuKDai0hgfaU/+1hFk9HfTCvzbwjSH0BvuM8qPhg7F7RomowmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aFGm/P6E; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aFGm/P6E"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f6ca9a3425so10725277b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 08:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740674900; x=1741279700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+CwlNOwz6cX/UtBgNuuvuqtR0CZarS1LGfkpgdEQ4w=;
        b=aFGm/P6EA+fOrqfeuLBh8ZkU2FSqNU5NoCwbJjTQDRL/RTELoynFTZxgrNc5IgVccC
         uiODXHU85IT/fsY9H1nVeXJ/9xVnZ5wlBFGSaZoKGLGcI02CqfIGLoF/3Slw0W/99xdG
         ma1IOm9fn6p0hxaAiaV0NLnhYTN+FxZXi4PdMva+leh6+bRooqh3/lME7jeane7CZK7E
         LJuqf/KaqKBoVuJz/HrVfyF1UT8UwZ6hYwaLD00wTbz8nGIb6BiFauqKJMF1cXShsShf
         J59OenIJ/umBY/K6bMURTRnu6AVZG8d+2+m2kTVks93Sf7Li51OF7rnoO3Eu0LmAo2yx
         SoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674900; x=1741279700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+CwlNOwz6cX/UtBgNuuvuqtR0CZarS1LGfkpgdEQ4w=;
        b=gbO/M/KUCdrIw50BrvlMEgCLFeqapprfcuslXB2uuqqTtukhyKiz1rGQwavHciUBaN
         m9VLZlJE9lhoLnFVhj99CiFRFWc6NkpjdyyKR1zFaU+La3624Ph7pA8toYzFI4Ow2+pR
         PXgwbDm8KXUgee8Ct8nbufnzEWbW92jWa8zcGL7b75KR8jty/WrMwhnoFEmCifOJm+hm
         e8VRhVDCF2M3T1xGg1L7LgtHQTe6AD0S67K9CxGTdiVSbVBfrZQQGXgi20L0TAediS3u
         v6ULBH7LW2zWH5hrW++jSsjsNGagJf2ghj0jC+GEVCIg+a31SB3ADEj/VgIVkVronC2A
         uN/g==
X-Forwarded-Encrypted: i=1; AJvYcCV2FueFOMHJTaHbCnhBklDnWCKhKR1tNBpC/7HsktRknxlIsWTVakplATxaTKo3DCDyy0+/D1l66FEHmYgwSAGprDzHMck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6OKCfVd5dwJrUK/QyiXfY8W8WrfZA/OadeimmhxckfmhLSrp
	48jyFSJ30JLbeASe/8l87pqkb/XOvZshIVQerdvghW5fRurdyjD9F4c2GPXLS9/1B5Y7MvKaztt
	o2B9l/2WRJfgf/w2k3jkV3eFb+PUuc3uVRO9O
X-Gm-Gg: ASbGncsX2C/OuAYl8sGSFE7mGO2OoJrwQw/I7P1EojwMJqzvp9XNRuSNCWalRrCCA8j
	HCKvtZKz3p1d+BLMP3YW+wMStWuX9gH+K7c1L8VZpDubbxqP+FWJ+qptuOPfpbOmv06hM9VT+O5
	BJU2MDn5s=
X-Google-Smtp-Source: AGHT+IFYI+8SraAdigQGx7lYdH5LUnt1/UBb+qYVnBDFc3+wD7MPjfWvDbf4Mkowsvjayh1/wuUuat9GLQUM9I01TCE=
X-Received: by 2002:a05:6902:2e0b:b0:e58:aa00:ffe0 with SMTP id
 3f1490d57ef6-e5e8359551emr21182111276.5.1740674900254; Thu, 27 Feb 2025
 08:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224154836.958915-1-mszeredi@redhat.com> <4a98d88878a18dd02b3df5822030617a@paul-moore.com>
 <CAEjxPJ5V9z87c6pHVRemKxENoNq9TvqpQ3tJpLEbP4QEViZTHQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5V9z87c6pHVRemKxENoNq9TvqpQ3tJpLEbP4QEViZTHQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Feb 2025 11:48:09 -0500
X-Gm-Features: AQ5f1JqX1rQ6m62bB5eNpWIdO0cQOPLAxtXa7BRO08xtGHgf2ADpYVSS1Bp8tTM
Message-ID: <CAHC9VhTVBY7qkNQ-_vUWm_Y5bQ7OREp2hOWmfLizAXJs0f6Rtg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add FILE__WATCH_MOUNTNS
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:22=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Feb 26, 2025 at 3:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Feb 24, 2025 Miklos Szeredi <mszeredi@redhat.com> wrote:
> > >
> > > Watching mount namespaces for changes (mount, umount, move mount) was=
 added
> > > by previous patches.
> > >
> > > This patch adds the file/watch_mountns permission that can be applied=
 to
> > > nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny wat=
ching
> > > a particular namespace for changes.
> > >
> > > Suggested-by: Paul Moore <paul@paul-moore.com>
> > > Link: https://lore.kernel.org/all/CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6j=
yovz92ZtpKtoVv6A@mail.gmail.com/
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > >  security/selinux/hooks.c            | 3 +++
> > >  security/selinux/include/classmap.h | 2 +-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > Thanks Miklos, this looks good to me.  VFS folks / Christian, can you
> > merge this into the associated FSNOTIFY_OBJ_TYPE_MNTNS branch you are
> > targeting for linux-next?
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> I'm not objecting to this patch, but just for awareness, this adds the
> permission for all file-related classes, including dir(ectory), and we
> are almost out of space in the access vector at which point we'll need
> to introduce a file2 class or similar (as with process2).

Yes, I've been paying closer attention to this over the past several
years as we start to nudge the permission count limits.  However, as
you mentioned, this isn't a new concern and we've successfully dealt
with it in the past.

--=20
paul-moore.com
