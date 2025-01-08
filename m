Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C11DF746
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736371081; cv=none; b=cWCK4lvToKxyTO46+LNhsMwlKY/cyWxywIJUnzaBBwSg3ZPsynDg5C9+usPRQ3G4k//SnL/sA/Adxp3MlurF1+apVMsnQGQEBuG4KdKAg0ZcZzlj5mXjokudJvOCtLD571icHKXGvclOQi54Q6pQM0P5TWL6zoHPs/2n3F/7oO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736371081; c=relaxed/simple;
	bh=NkFCanEVnLS83Ar+4ZbtH7xZLEehznfQmh9+Zbi1ntY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wb9Xn2y7aRBruyFNSo2MFWRIJeiRPraUa/W3+53NpYmMOjaXlQLYQdwIJTZsSbZQ4WH9n6U8sFI7lub3UC8s7ClX03PlVIUO49Onavo9VYz/z/yy9ePP9hD1OcL6NDwSvKsFHeuGKJCNxTwi4/xXy6rn9XaoYeauxe9tBNxu5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KLJxiWMk; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KLJxiWMk"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e479e529ebcso260891276.3
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jan 2025 13:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736371078; x=1736975878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hotY+t9DQBcAeb7yhgUdMiRAbJrlaqfeC4dygHkJIvQ=;
        b=KLJxiWMkoH9C4z/QhbrFiHuDtsbSEyMOwb05Fu8pcr3OkpWfanoGN7TBya19JqFknJ
         eU6YFUPzmqj48mTgBKrvql/bm+j7KmOO5xbaGZwtPaecFAdKsiX4ErZFIMeshPEQkS1W
         EluS2jNJR0YuhS3hY6jk1C5YQAL+ZjcQ/MG+vj/BNudhiD0dPPB16ubmLb72xba/B3Ve
         AVGkqT0BWzO/USmQsp1yMe5iLVYRZMOzwgYC/gwG3Gjtf7SC8A6+82RoW/OpUoJV8kpk
         3vXdV6W881DtQlEK46YriJcAFfsuNpM0sciS7AZpfkY3hG1bmAtUCXfzGN7D62aUl101
         A+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736371078; x=1736975878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hotY+t9DQBcAeb7yhgUdMiRAbJrlaqfeC4dygHkJIvQ=;
        b=M2MUtYWpCZJTwDd3cFrG9xVzYnRbx9lqbJ1TbCGBm6JnoFJd3Xoe0LcpkTJnQTGQ/P
         3JdS2kKRbaXejewQKTvMA2f3mJTlnfSU0GErnrPtu4Ktpfc35njlqn16YqqZ+H2EyYFB
         gWHyWYUGhqTBTu21MDyQPLqYQAMxb6PktMYKQxpvRXoGr3ZZLht7J6ECrxGqdwHWzOtg
         MmXZKn02cWTtIzdlpyC7wQKpfJeooCFDIywShFR8sNxFe9O2/kSpTSbPKnHd6WibkR7E
         Ut/4ivM/tcrpbMDUGfkBVNJER0MTAo76/wJuPa7vHvkJHby9Se1QsUJbtehjoDnFgGAE
         e4mg==
X-Forwarded-Encrypted: i=1; AJvYcCW10UZxYddrhpk8+TlsIKhaVielR39qWgfpz7qR7SNb3IV2FAtS2grAF7VbnL5+8UArxPjK+rtLeNafhvPpg7jlLju7CvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXXyWM9iHkC6c8BZPNskYIIomlYvMVq6dYSBDGCSDjdxjPNwut
	NkgZmn2KfXbj1MFLNi6SaZIQO/mfP+vOdjvsveShdZFA9AdNSpDQBg4FfCweAXSLRYosZnk6927
	/C7BQhGxyg2EWh5gYmeGy36CD6cfuoZwhR2tI
X-Gm-Gg: ASbGnctq8nXvNDtYszaHKyf7NB9xRCEB7k3vur3l1bRA7IDJOTMQ/G3anSpgHfqTcTc
	ACx/Qs4Ol2FXFn6zgqldqHpcvU6x7zaBGVXNO
X-Google-Smtp-Source: AGHT+IGG2C67qQmC08w9NXrbJqwZe9M1vXisqckUBzUkNTmWQl7xbPMs1vDLrdGGuEjdNAxO9OmsFMH/+sLgYQasnFI=
X-Received: by 2002:a05:690c:6088:b0:6ef:4a57:fc7c with SMTP id
 00721157ae682-6f531248e7fmr39080647b3.16.1736371078550; Wed, 08 Jan 2025
 13:17:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
 <ed6e5639-c87e-49e8-8125-5b93cec69d43@I-love.SAKURA.ne.jp>
 <9fcd3f3d-33c1-4feb-8c98-472d44bc0a54@I-love.SAKURA.ne.jp>
 <202412222126.E70910E7A8@keescook> <CAHC9VhRkAbvj=9qe8iWPCtsgkF0zvgP+pbOsUG=VVFcPgO3-jQ@mail.gmail.com>
 <202501061501.26556F56@keescook>
In-Reply-To: <202501061501.26556F56@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jan 2025 16:17:47 -0500
X-Gm-Features: AbW1kvZKBPx02s7TORiggNdKqQ_Brtb_91zlzxJna2YiJfsofKRaNEhHAVO6jZA
Message-ID: <CAHC9VhQHpBjp-gYTqSg9kDj+ZTQES2EfyeQYgpfW7gaMZxj4eg@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: check size of writes
To: Kees Cook <kees@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	Leo Stone <leocstone@gmail.com>, mortonm@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 7:09=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Sat, Jan 04, 2025 at 11:04:09PM -0500, Paul Moore wrote:
> > On Mon, Dec 23, 2024 at 12:33=E2=80=AFAM Kees Cook <kees@kernel.org> wr=
ote:
> > >
> > > If the LSM core did a kmem_buckets_create() for each LSM, and the LSM=
s
> > > were adjusted to explicitly allocate from their own bucket set, that
> > > would be one way. Or just for the LSM as a whole (1 set of buckets
> > > instead of a set for each LSM). I'd be happy to review patches for
> > > either idea.
> >
> > If we're doing the work to shift over to kmem_buckets, it seems like
> > creating per-LSM buckets is the better option unless I'm missing
> > something.
> >
> > I'm also not sure why the LSM framework would need to call
> > kmem_buckets_create() on behalf of the individual LSMs, can someone
> > help me understand why the individual LSMs couldn't do it in their
> > init routines?
>
> When we moved stuff around for stacking, we moved other allocation
> duties into the "core" of the LSM, so it just seemed reasonable to me to
> do it again if this happened.

Moving the allocation of the LSM state blobs for core kernel entities,
e.g. inode->i_security, was a bit different as it was necessary to
support multiple LSMs.  How could we support multiple simultaneous
LSMs if each of them wanted to control the inode->i_security field?

Moving arbitrary LSM allocations out of the individual LSMs and into
the LSM framework itself is definitely *not* something we want to do.
We really want to keep the LSM framework as small as possible.

> > If it is necessary for the LSM framework to create the buckets and
> > hand them back to the individual LSMs, I would suggest adding a new
> > flag to the lsm_info->flags field that a LSM could set to request a
> > kmem_bucket, and then add a new field to lsm_info that the LSM
> > framework could use to return the bucket to the LSM.  LSMs could
> > opt-in to kmem_buckets when they found the time to convert.
>
> Yeah, agreed. Since allocations would need to swap kmalloc() for
> kmem_bucket_alloc(), we could also create something like lsm_alloc() and
> hide everything from the individual LSMs -- the core would handle
> allocating and using the buckets handle, etc.
>
> Does anyone want to make a series for this? I am not planning to -- I'm
> focused on the per-site implementation.

I personally have enough other things to work on, and review, right
now that I don't see having any time to work on this in the near or
mid term, especially as a more preferred solution is in the works.
Putting on my SELinux maintainer hat for a moment, as long as there is
some belief that we'll have a per-site implementation, I'm not sure I
would merge a per-LSM bucket patchset right now as it would be work
that we would need to unroll once we had the per-site work upstream
... I would need to think about that.  Of course other LSM maintainers
might feel differently about their respective LSMs.

> > > I think per-site buckets is going to be the most effective long-term:
> > > https://lore.kernel.org/lkml/20240809072532.work.266-kees@kernel.org/
> > >
> > > But that doesn't exclude new kmem_buckets_create() users.
> >
> > Is there an update on the per-site buckets?  I agree that would be the
> > preferable solution from a hardening perspective, and if it is on the
> > horizon it may not be worth the effort to convert the LSMs over to an
> > explicit kmem_buckets approach.
>
> I haven't had a chance to refresh the patch series, but the implementatio=
n
> still works well. Besides some smaller feedback, I had also wanted to
> make the individual buckets be allocated as needed. That way if something
> was only doing allocations in, say, the 16 to 128 byte range, we wouldn't
> lose memory to track the (unused) higher order bucket sizes.
>
> I expect to send out the next revision after the coming merge window.

Thanks for the update.

--=20
paul-moore.com
