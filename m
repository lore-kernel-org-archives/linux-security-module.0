Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322FDE56C
	for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610737; cv=none; b=VMzQ0Pgd3p5JHE8ptjIsdetRHMIfL8s0OofhZLophQHqdVzktlvuU9MNwKzjT+8FivMZNzG0jtxd9QPD57x0wNk0cF25n33h3Q4g/zseNe/xJ1FS/Z9mhx5BE5M/E60UOnPo1Tz+Im0jQUMXqsycOTIYF0vZoQIka4qB0W++EBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610737; c=relaxed/simple;
	bh=9tJXSsQ9fSvcpkQGEvBg2L68OGr0KwcdVp0VeMEtExA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl0gyUKt8bcLpSOk5lye/S3WxQWjUx4LeI0r6ThQH/zzTBQiqwMHL39bziFlsMtyVbVVKX2XR+fwUrxrmZ4d/mP5wU+rujd/NkdcJGlfDk5XXCfWaoDdiIpIAYJY9X0tq9w69s4L5EtL01MgV1Yrd+uan9gRJFq327EhQrSJIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JSCg7dbs; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JSCg7dbs"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso1344954276.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 18:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728610735; x=1729215535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRcd9cwIZFh48Jk9iJ5FWFlPG9snV80qLzRLo6hXxJo=;
        b=JSCg7dbsLrzz2Z4F7/4WhtnEh8Ni8l0mm6RCMLDgsI2tctqgNbvd5Gl4acrgKk7mtw
         82HqGBD8uC8gf+svvHOMvucERy7YIRytPO1b14sAaDoCjXK4kgUqOi28GftMSHmvQEVx
         HeflE8bxjuuADOiB8wnDYcwZy3JAC0fwyPj819EBeZBpnFFg3Jmc27yIeaikX7o5o4nD
         3bQLiR7XNRBJSMQXJCaqlt0qCkf/B2R1DcErvCqPFedM2i2JoJf+AWSMNcceyPovU3uZ
         kRLskDTU2vvEdO/MVMdQewQNhlpBXqy7PxkUey+1M9gf1as0jxayQ0CeUPG0U1ypTbA/
         VTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728610735; x=1729215535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRcd9cwIZFh48Jk9iJ5FWFlPG9snV80qLzRLo6hXxJo=;
        b=j8/1qjashS1qeVyXUGBGdi9Yw1xjKeYXnRWOLuu++Osv8vD8I5Kdct0ngicF+0436K
         4YdkV8dcvAot0NDitI2D3RVKTnYI/7WZqNw/iwOzCQzmO6Ngmg3nM0GYrfRxcu1RK4LL
         BjmJ4QesSLYrhGJx2zKlmoNXvrWssONxnwDQa9qiSaFgQAo1efg8ojSbBpcZfG1744Vo
         0NezRDBS+qOSxp94QvGz842rK1qyt+tqBFpRGgc6+fptyT2rCRAY7Tc7nPMVOb15JPa5
         /bVr7BdT1mr3TZVjtOgnxPBrjBxkbl5ho0nJiubNOH8VztuVihjzY4nHbE+9TV2CtBX2
         V58Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRUNY7Rxqc57s2qXngIMWe0dhE2Nny632e4BZJgXgjycFZKgKkeuA495bYj4GY/1KB3BGseBTHVBK2+bIYrlvXAYWftEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKKeWLlIxO50SVeVA0707e2y/ZgrAOfFh/2D76k1gmTNXxjPhm
	L/85lwcqR2WNvswvijhye0ty4IIitRZhOOlR9oVfdwfJPpaJ5VbY+HKM3uI8C30hWBCX0W4AVYs
	Ckc++4e+OXr57tfp5affHMzXu42Oc0on5exo8
X-Google-Smtp-Source: AGHT+IFvoAiqQTsFIOJfK+l/01uP1b8r2mlIlEpP49rC76iACwSSk+CMcgg9Ira3XeXkyuN2zyckIivG5f2h/gWZomE=
X-Received: by 2002:a05:6902:124f:b0:e29:6b8:af3 with SMTP id
 3f1490d57ef6-e2919df898fmr992944276.44.1728610735214; Thu, 10 Oct 2024
 18:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-2-mic@digikod.net> <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
In-Reply-To: <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Oct 2024 21:38:44 -0400
Message-ID: <CAHC9VhSJOWD93H0nPTCdKpbM2dDnq65+JVF1khPmEbX_KhHxsQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 9:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Oct 10, 2024 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <mic=
@digikod.net> wrote:
> >
> > Use the new inode_get_ino() helper to log the user space's view of
> > inode's numbers instead of the private kernel values.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Eric Paris <eparis@redhat.com>
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > ---
> >  security/lsm_audit.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Acked-by: Paul Moore <paul@paul-moore.com>

It looks like patch 1/7 still needs some revisions, and an ACK from
the NFS/VFS folks, but once that's sorted I can send the patchset up
to Linus marked for stable.

--=20
paul-moore.com
