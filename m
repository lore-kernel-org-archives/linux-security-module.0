Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72EB1D9A46
	for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2024 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949007; cv=none; b=lm2YkOoA/HVKgiPfBBh+atUCvUkH0AmewLp1yarRaa4gsEbYy4rcG5LKrAB+smCTCNi5z1i4bH0A8fdRugJMrGPDYyV/t0OMKcyLcUWbSQ5FdU3iqaDyqwabdSJAKLoX9mR0AW1KluEwAdDTihuypRnaUXL2ovCHldlcom1T7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949007; c=relaxed/simple;
	bh=YYiSmCPN3TvqJgCL4LqcmX67TPAVLvdjqxfU7qETvaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErghVI66vhYNJKMcELsprp2k5z+cS6y0hyddV3irLrJkC9B7Rq0c18flDZZjNoxbktSpvIzsdjv6hz947uaE7o36Vb/sVGPjwRyMWqmJFKnSHnaYsPKMV1je2mcroD5gGMPs1nak4rUPLDxUAFzG2N/jajxkm7jgRyE7rnmgbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F2FY5YMt; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F2FY5YMt"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so2788813276.0
        for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2024 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728949003; x=1729553803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7EptkXWnpaL/k/9PWhawROS2K5xJQhwh/HCtCSp7fE=;
        b=F2FY5YMtfY8LTdR83BaogIdDfZw31DZW2IZuq3TkE4TYsBnDPWJP65FDDflBgD850P
         hgn9nMVY2Xu3rEPNYqeiP77QalKBXAsY880pdIILjDRKp9vJtErmvtWP6JKLPI6i+B0o
         tIm+VkQHbCK5Q1DREz60HKIsnVkbd4dlZzMqGxAvqU65dDeDsYgPfrUNfTNxSuLrIQpJ
         3KMIzxR9dZJnQkPK1JF2BKaR7DuTKTTiABr7+I8ywUBd+aaNEpogAQwn8uXBzDT5tWux
         XKhSFMWHuE/r+EBXvwKbD0h4JRl8G7HKCanIOOGveG74AyQJ5ShNjwYCg9G+NhFvfUQW
         QDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949003; x=1729553803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7EptkXWnpaL/k/9PWhawROS2K5xJQhwh/HCtCSp7fE=;
        b=VCOEdkCO+2TKgQiM4RXlXdQTEbmh+o4plJ9nJP8vnNc0kNe25kIW5vPV2KuYO5O0hF
         LjdxffWvDwHP7iZ8Xg0+VQwNniPuRBBfMAuvSOG23CSBT8LGlq5hVEFLaNcO6T87Wgl9
         sQJ+4ku4DCpkuOOuMu1OwZRDdYR/1sXt6xv2WRcuMlLSH5DNf8+pOmuVi54JagI5KxhC
         OukfDDoa9d0LfM3gGP3Z1yjAqxq+EDJyvFvkBmr/dcX0H9usdQbjpE2IN+BkuCYPDbEO
         K6o93/llsKerIr7WXUjO8+OZrkfYpp4+JoGudMHD1MW+FyzMom84dRw/6y60JQekPoYF
         HarA==
X-Forwarded-Encrypted: i=1; AJvYcCVeikBqD7WuPQ2pw5s/V2qC6XtOzJ2eKbMgIYCRj7ckevgccEeAqVuT324NNgWZF+fiUo2F5d69DnxBIMHciOcoo5DLE1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqyziFOjf8RfVVxo6fTNpqLEh8CZ11xJ8wLoR04+dIjkN+y9N/
	Rvv7D/6tH1jIJcz3e1oczzTI3DgXvx+JgPlKhLnxH9gKf9+lYOJRQB0yoO4ww+oPb1TUWmEME/8
	ewmKqiXaqBqf0qhm2iMgS/QJBRCx+wEnZNhUJ
X-Google-Smtp-Source: AGHT+IFt8evXayClmB6u6crNOqWAGK/LqQS6YoxjB76sqksYLFIC+tuagD9Z6iZG7/Bs3SVNOb5KLHTYwWn1DWcVZV4=
X-Received: by 2002:a05:6902:e07:b0:e29:23f7:ccf8 with SMTP id
 3f1490d57ef6-e2931b38df4mr6839532276.14.1728949003636; Mon, 14 Oct 2024
 16:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241010152649.849254-2-mic@digikod.net>
 <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com> <20241014.Ahhahz2ux0ga@digikod.net>
In-Reply-To: <20241014.Ahhahz2ux0ga@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Oct 2024 19:36:32 -0400
Message-ID: <CAHC9VhTn=hb7DmB7Py3okcow89OGR31abHrcniSPt+K7ecW_ow@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:30=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Fri, Oct 11, 2024 at 05:34:21PM -0400, Paul Moore wrote:
> > On Thu, Oct 10, 2024 at 11:26=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > >
> > > Use the new inode_get_ino() helper to log the user space's view of
> > > inode's numbers instead of the private kernel values.
> > >
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Eric Paris <eparis@redhat.com>
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  security/lsm_audit.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > While answering some off-list questions regarding audit, I realized
> > we've got similar issues with audit_name->ino and audit_watch->ino.
> > It would be nice if you could also fix that in this patchset.
>
> I can do that with the next version, but I'm wondering how it would fit
> with the UAPI's struct audit_rule_data which has only 32-bit
> fields/values.

Don't worry about audit_rule_data for the moment, that's obviously
going to require a userspace update as well to supply 64-bit inode
numbers.  My guess is we'll probably want to introduce a new field
type, e.g. AUDIT_INODE64 or similar, that either carries the high
32-bits and is used in conjunction with AUDIT_INODE, or we create the
new AUDIT_INODE64 field as a "special" filter field which takes up two
of the u32 value spots.  Regardless, let's not worry about that for
this patchset and focus on ensuring the underlying kernel filtering
and reporting mechanisms work as expected so that when we do sort out
the UAPI issues everything *should* work.

> Does 64-bit inode filtering currently work?

Likely not :/

--=20
paul-moore.com
