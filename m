Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744E33CA
	for <linux-security-module@vger.kernel.org>; Tue,  8 Oct 2024 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347359; cv=none; b=Hf9sxbIkWNQpCy/dd/4Km1uuYD11FDa/PkVt5H/RB2pGUueAlmjHh6vafL36EYJ+AHno5RxGR9JBPcu1KwFqmW/iBsX/I+bJ+Ts47Ycvaezq5X4mV4rgukA5SDO/OLVyuTqiSY2id5JjSx+t83XC6D8+dRXu9MCkOOIb/MtTz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347359; c=relaxed/simple;
	bh=Tke8szf/tF+Zw53GGM7FveqgBu9sg0bXcPAEsM0e6AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cih6xRbZQChl02L+sL6omN5gnuvx/hDuZtULJkJTvKagnMPDx80ubxS8TgARqiygh1wJUwNWKMQetcvPYa6L5EGwABStJ4TCYwNe+hOukVXh0qIFDhj+6/Z4rFw1OvW/FpGUfN+KotqQ3qS4+V71vZfV8CsfSDAEUtfh17dBKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SurQBpMW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SurQBpMW"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99388e3009so344307366b.3
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2024 17:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728347356; x=1728952156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nsQ1lX9RfNwwbE7U1ME2PBLb06zd6P+Kklt61iLJfEw=;
        b=SurQBpMW7G7bZrq3KaGn3kA+A8iOOqmVEuTSU8e+54O6jzmM69OUsbYB2WQ12eHK1x
         ZECw/2nGIhM+RJ6Cf0dLpwpRjAGwcMBXP1D/CmnQ17Q8o1jAIH/d9cj8KBXqMzQ313+q
         vGIxuq4lE4TAOpLuf1nbarN7u0wDwxIM8oMFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728347356; x=1728952156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsQ1lX9RfNwwbE7U1ME2PBLb06zd6P+Kklt61iLJfEw=;
        b=Qs/+0FugDzIVeD5eq2J+FfmAjlpEr9FxVK9GGqqh4W8SnJ5qSy5OU2015nchhqQJ7O
         M2N33nT0cRmitykOAgQoHt0zrGm4i750XyOx+yodjD7K+eO0n8ZKCLRW8p2S05m1rEWx
         ekRA4LdRQyKgyMGF2GzSHQ7tV1+VzNlXuYvwQ2A9/OLgZLdcP7DVg4Kqaz1MxSlezheE
         7owBIdHVhaKOg63ZSiltIzaeW9zegqFvwrIpOqYxFRGhI2N8h1UMmbIMsxBKFLKB6DsD
         JFPtFwEEnbYkGlxoHLYD4OifN7BXtiWXv1FbErzbVC8AaLmjHESWBXS5WMT9T5iLBflp
         ZG3w==
X-Forwarded-Encrypted: i=1; AJvYcCW2kZBBiYMXrY6k4+9W/J8uYzWQrtDNn2k389bBhfgGoQR32sCzSxkw1fSuV8pJyXot5YwcjGTE9xqMkuX8u5uMjpTsBIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOe2TmSsqEDrlEgYAFx3+QZVDip4SQzrWp+i8dpMfF4GslKKb
	S+BbA3yeC34tPevQtfWQjPLBXwULxOdOOHVQ2untis9GVvVTN/5kywnD/34bNw34vqw+epEer5u
	GLXxuhA==
X-Google-Smtp-Source: AGHT+IGw99f73sh+PboeQXz761+U20q4mvCMl0nLutx+UVR1vSLTvSJsVBMEjC+72gO78iV/hsobSw==
X-Received: by 2002:a17:907:a43:b0:a7a:9fe9:99e7 with SMTP id a640c23a62f3a-a991bff0620mr1503965666b.41.1728347355566;
        Mon, 07 Oct 2024 17:29:15 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e8145b8sm434228266b.225.2024.10.07.17.29.14
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 17:29:14 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso6552932a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2024 17:29:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwdHQtvlV0lhSi04CLbRBq4Pz7Mg0Eev32zNg+v3TlFAPlaqqb2J7blKtJJXBumKDbyVFkEglgASQ/O+Xrk8BJxHCyd+8=@vger.kernel.org
X-Received: by 2002:a17:906:6a19:b0:a99:762f:b296 with SMTP id
 a640c23a62f3a-a99762fbb7fmr20741966b.59.1728347354279; Mon, 07 Oct 2024
 17:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002014017.3801899-1-david@fromorbit.com> <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org> <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3> <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
In-Reply-To: <ZwRvshM65rxXTwxd@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Oct 2024 17:28:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
Message-ID: <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 16:33, Dave Chinner <david@fromorbit.com> wrote:
>
> There may be other inode references being held that make
> the inode live longer than the dentry cache. When should the
> fsnotify marks be removed from the inode in that case? Do they need
> to remain until, e.g, writeback completes?

Note that my idea is to just remove the fsnotify marks when the dentry
discards the inode.

That means that yes, the inode may still have a lifetime after the
dentry (because of other references, _or_ just because I_DONTCACHE
isn't set and we keep caching the inode).

BUT - fsnotify won't care. There won't be any fsnotify marks on that
inode any more, and without a dentry that points to it, there's no way
to add such marks.

(A new dentry may be re-attached to such an inode, and then fsnotify
could re-add new marks, but that doesn't change anything - the next
time the dentry is detached, the marks would go away again).

And yes, this changes the timing on when fsnotify events happen, but
what I'm actually hoping for is that Jan will agree that it doesn't
actually matter semantically.

> > Then at umount time, the dentry shrinking will deal with all live
> > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > just the root dentry inodes?
>
> I don't think even that is necessary, because
> shrink_dcache_for_umount() drops the sb->s_root dentry after
> trimming the dentry tree. Hence the dcache drop would cleanup all
> inode references, roots included.

Ahh - even better.

I didn't actually look very closely at the actual umount path, I was
looking just at the fsnotify_inoderemove() place in
dentry_unlink_inode() and went "couldn't we do _this_ instead?"

> > Wouldn't that make things much cleaner, and remove at least *one* odd
> > use of the nasty s_inodes list?
>
> Yes, it would, but someone who knows exactly when the fsnotify
> marks can be removed needs to chime in here...

Yup. Honza?

(Aside: I don't actually know if you prefer Jan or Honza, so I use
both randomly and interchangeably?)

> > I have this feeling that maybe we can just remove the other users too
> > using similar models. I think the LSM layer use (in landlock) is bogus
> > for exactly the same reason - there's really no reason to keep things
> > around for a random cached inode without a dentry.
>
> Perhaps, but I'm not sure what the landlock code is actually trying
> to do.

Yeah, I wouldn't be surprised if it's just confused - it's very odd.

But I'd be perfectly happy just removing one use at a time - even if
we keep the s_inodes list around because of other users, it would
still be "one less thing".

> Hence, to me, the lifecycle and reference counting of inode related
> objects in landlock doesn't seem quite right, and the use of the
> security_sb_delete() callout appears to be papering over an internal
> lifecycle issue.
>
> I'd love to get rid of it altogether.

Yeah, I think the inode lifetime is just so random these days that
anything that depends on it is questionable.

The quota case is probably the only thing where the inode lifetime
*really* makes sense, and that's the one where I looked at the code
and went "I *hope* this can be converted to traversing the dentry
tree", but at the same time it did look sensible to make it be about
inodes.

If we can convert the quota side to be based on dentry lifetimes, it
will almost certainly then have to react to the places that do
"d_add()" when re-connecting an inode to a dentry at lookup time.

So yeah, the quota code looks worse, but even if we could just remove
fsnotify and landlock, I'd still be much happier.

             Linus
