Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7131E868
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099380; cv=none; b=Fd1EvIJzyS90KyuUeViPsLDDahP5u8t+B2aLcFX9Poq6wxif9xCvb1jeTvl+59mWcdsJHK8vFg6QWCLzeWtuNGqubZ5HylU0KEZU1aGbNs1G16CitVe2C1Brn93AzcTvFp/eclaWLs5m6B0aqDijU9Qqmc7E5+9KP0nTcXQ5o38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099380; c=relaxed/simple;
	bh=qMj55OgEXjwHputJ8S8fmURGCDSurMmVFEx6sQGoflw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hB6bDU6oKmdUFO+hbo+NL2x2WE1t1AuLfEd5MVAWL7rhXafz7oyRQzkRCV1Q+rOnvtzYbZgEnVUWnWkUSUuFlWIUAr2yaS8zhboNAHVPGQdtcwmXl0kTHgFF4OQfp+5ekG/PEnHLKWvn+Szy5r/Nw6L5Plqfu8bf2o17wp7hoJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YRO9j7Oz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YRO9j7Oz"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3b12e8518so248334366b.0
        for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743099376; x=1743704176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YAD3FrghPaJkpW039wt/AHmDgQi7dvtgBZolcDWTamY=;
        b=YRO9j7Oz+afw1fSVBxxH/BR3AIeHfIgzx1bB/IeK1RW4C+Nfk1WQ7EGyQ3Xp6eNYx4
         YuXhgL9vVu4iuYn3XCwaxv3ixb2KCbNdjY+qU5/k14lAPbDIZENIQJYxrGLFNDdbeya3
         Ude0OSQhGFit5Lvil6eVNpIRR2AHDEL63p7G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743099376; x=1743704176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAD3FrghPaJkpW039wt/AHmDgQi7dvtgBZolcDWTamY=;
        b=dAQLVq8eYqh07qO90Jqf8OdPUfNjRvpwNB3+3rBQ8q8go6uDGd1JovZxTHdNaUydtt
         V8L4hbVqTgedDPdyo1uBdr3DzDjZhwQ7qVWJGRoEoHhWQ8BwN0iUZAps+x9NCbsq42tX
         Ic5tUBQVN4Xoz62MMmdAJdO7Mxuy3Eb0lkD2akMrQny6wsXof5SwD+UfhahKuGgclr4j
         fdOdzMBGYD13JV7YIX3GB1CMW20KoQH7/2cKFctDT49b06URXTADA8SfTWo//47hOBdm
         lIY5rxdxce1yp/kF0xAnkN6vt1LKFqq6JO69yjPe9OtNXwYSbLG4USZAfTXw48jxD7vU
         YsRg==
X-Forwarded-Encrypted: i=1; AJvYcCWO3UJv2+xHiHZ7nUq6u+puNyPGvXVtil3sSccEZOtCoBQQwNtPaK5FWLO9S9/oVoPJpvA/PM5kwz7/5/1ZwU6Ut7kP86w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCmt0YBovpPkPn0aTOWNR0clkwOCblB607cwphzhoWSOI5TUj
	AzveorKwRRYDcjYkvWg7I3Daalp+5ZXuum+MWwhBMd5/8YcdiQHWAEidLQZr1BCsKy/2TC7dpVP
	WniY=
X-Gm-Gg: ASbGncv//tidOPY1CNa5h/TyIiI4aWwyis4+a+to0C0DRNiTBXYKCxHO5HtRkogBpzm
	VeA10JeceyBKaeHPHtzZscXP+22v8eEPvC88iQnhHDy/m0tSoWJxwGeP+jj5aE7ZxNIWlxDtOlh
	Gtz362P+TGSZrbsurXaVUJAGQIe7PZSUe/xWI/1RBz4B5BhpUravGXqg8WPW90iWCjuyPxgoKi3
	2q/8ZgqZ5TYplnh5Exx+s4dfoAwrTCuZAkuylzAoCZrmb0dQsVSIqgeDhGgrbfwF11y89YgqlKz
	OWTrrnR/huMG/HEsjQMc86sD3uiEarwLgIZ2y/zHTaXV5rbDzCtGlb+V9boRTTeeYKYRBtuxmoZ
	R4J3KnXmzdh8xze9HA/g=
X-Google-Smtp-Source: AGHT+IH4PHIPVz9vCKwJ+hWt4VqpdCBBsRgsNTMV/nBNkC+vMyAdED4psV8l5aI8HZyz55oaO+yUEA==
X-Received: by 2002:a17:907:1c0c:b0:ac6:b639:5a1b with SMTP id a640c23a62f3a-ac6fb14ec02mr418801766b.45.1743099375487;
        Thu, 27 Mar 2025 11:16:15 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196c8174sm31044966b.148.2025.03.27.11.16.14
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 11:16:14 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abbd96bef64so204198166b.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 11:16:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcvTw14vHtpZXxqoGlN0n6IiXzUUzfEBvtmrU/hGQBExDCrbo7M0dBpV7MqBvzQgDaKwXVaL6iJz5Bl/ZiUJQN6AP4U7M=@vger.kernel.org
X-Received: by 2002:a17:907:8711:b0:ac7:1d9a:4db5 with SMTP id
 a640c23a62f3a-ac71d9a6707mr3076666b.0.1743099373902; Thu, 27 Mar 2025
 11:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
 <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
 <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com> <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Mar 2025 11:15:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
X-Gm-Features: AQ5f1JomcXU8uedXsS_SUCgWLMCnhZ5GwaGBQB7qWRik00JwiQRThwSwSUer2Dw
Message-ID: <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 09:55, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> If you have constructive suggestions (or patches!) to improve
> performance of LSM and/or SELinux, we'd be glad to take them. Or even
> helpful hints on how to best measure and see the same overheads you
> are seeing and where.

So measuring it is fairly easy. I have various loads I care about, but
the simplest one that I feel is actually a real load - rather than the
more artificial bencmarks I then use for verification when I make any
changes - is literally "do an allmodconfig kernel rebuild with no
changes".

That empty kernel rebuild approximates what I actually do for most
small pull requests when only a couple of files really get re-built. I
don't want to actually try to profile user space and the actual
compiler overhead.

To see that load, first do this as root:

    echo -1 > /proc/sys/kernel/perf_event_paranoid

so that you as a regular user can then do a kernel build and get good
kernel-level profiles (there are other ways you can do this: you can
obviously also do a full profile as root). Obviously you should *not*
do this on a machine with other users, the above basically says "let
anybody do profiling on kernel".

Then I just do

   make allmodconfig
   make -j64

to prep the tree and causing everything to be built (well - normally I
obviously don't do that, because my kernel tree is always built
anyway, but I'm just trying to make it obvious how to reproduce it).

And then I just do

   perf record -e cycles:pp make -j64 > ../makes
   perf report --sort=symbol,dso

and press 'k' to just get the kernel side (again - there's little I
can do, or care, about the user space profiles).

The "--sort=symbol,dso" is because I don't care _which_ process it is
that does what, so I just want the output binned by kernel function.

Just on a very high level, this is what I get with the v6.14 tree
(cut-off at 0.25%, this is "out of total cost" for the load including
user space, so these top functions account for just over 9% of the
*total* cost of the benchmark):

   1.26%  [k] clear_page_rep
   0.82%  [k] avc_has_perm_noaudit
   0.73%  [k] link_path_walk
   0.73%  [k] terminate_walk
   0.58%  [k] __d_lookup_rcu
   0.56%  [k] step_into
   0.52%  [k] selinux_inode_permission
   0.50%  [k] memset_orig
   0.49%  [k] vfs_statx_path
   0.47%  [k] strncpy_from_user
   0.47%  [k] rep_movs_alternative
   0.37%  [k] vfs_statx
   0.31%  [k] __rcu_read_unlock
   0.30%  [k] btrfs_getattr
   0.28%  [k] inode_permission
   0.26%  [k] kmem_cache_free
   0.26%  [k] generic_permission
   [...]

so the top thing is the page clearing (and you see other memcpy/memset
variations there too), but the #2 hit for the kernel profile is
selinux, which takes more time than the basic path walking.

And selinux_inode_permission() is rather high up there too, as you can
see. Together, those two functions are about 1.3% of the whole load.

Now, the above profile is just from *my* machine, and
microarchitecture will matter a *LOT*. So the details will depend
hugely on your hardware, but I've been doing kernel profiles for
decades, and the basics haven't really changed. memory movement and
clearing is universally the biggest thing, and that's fine. It's
fundamental.

Also, when I do profiles I turn off the CPU mitigations, because again
depending on microarchitecture those can just swamp everything else,
and while they are a real overhead, from a performance standpoint I'm
hoping they are something that long-term is going to be mostly fixed
in hardware (apart from the basic Spectre-v1 branch speculation, which
is *not* turned off in my kerrels, and which we've actually worked
fairly hard on making sure is handled efficiently).

Now, looking at instruction level profiles is kind of iffy, and you
have to know your microarchitecture to really make sense of them. The
"cycles:pp" helps make profiles more relevant (and requires PEBS/IBS
or equivalent CPU support to work), but it won't replace "you have to
understand hardware".

You do want to look at instruction profiles at least a bit, partly
because inlining makes _not_ looking at them often kind of misleading.
The real cost may be in a function that was inlined.

Typically, once you look at instruction-level profiles, and understand
them, you'll see one of three issues:

 - cache misses. This is typically the big obvious one.

   And you'll see them both for I$ and D$. People will tell you that
I$ cache misses are in the noise, but people are wrong. It's simply
not true for the kernel or many other real benchmarks, and you'll
often see it as big hits at the beginnings of functions - or at the
return points of calls - where the instructions otherwise look very
benign.

 - serialization. This shows up hugely on modern CPUs, so any memory
barriers etc (ie locked instructions on x86) will stand out.

 - branch misprediction. This will typically show up in the profiles
not on the branch, but on the mispredicted _target_ of the branch, so
it can end up being a bit confusing. The CPU speculation mitigations
typically turn this issue up to 11 and add misprediction noise
absolutely everywhere, which is why turning those off is such a big
deal.

but in an OoO CPU all of the above will basically result in various
instruction profile "patterns", so you in general cannot really look
at individual instructions, and should use the above patterns to try
to figure out *why* the profile looks like it does.

It's not obvious, and the patterns will be different for different
microarchitectures. You can use fancier perf things to try to figure
out exactly what is going on, but you should always _start_ from the
"where are the costs" on a pure basic cycle basis. Only after that
does it make sense to say something like "Oh, this is expensive and
seems to be taking excessive cache misses, let's drill down into why".

Also, typically, code that has already been tweaked to death tends to
show fewer obvious peaks in the profile.

Because the obvious peaks have often been getting some attention. So
the profile ends up not showing a big read flag any more, because the
big issue has been fixed and now it's mostly a "it's called too much"
issue.

For the security layer, at least historically the big cache miss (on
this load) has been the inode->i_security access (not loading the
pointer itself, but the accesses following it), and the hash tables
for that AVC lookup.

And both been improved upon, and I didn't do try to analyze the above
profiles any closer when it comes to exactly what is going on, so take
that with the grain of salt it deserves. The exact details may have
changed, but as you can see, avc_has_perm_noaudit() really is very
much a top offender today.

And yes, the reason is that we have to call it a *lot* for any
filename lookups. Some of those security hooks get called for every
path component, others get called only for the final one.

The best fix would be to be able to cache the "this doesn't have any
extra security rules outside of the regular POSIX ones" and avoid
calling the hook entirely. That's what we've done for the ACL path,
and that has turned ACL costs into almost a non-issue.

                  Linus
