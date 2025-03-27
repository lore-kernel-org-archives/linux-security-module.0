Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9321D3CA
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104432; cv=none; b=K5jvUAT9vGKYa4C3YtQO1NrV81D+2nf5mOcwR3MRHjPWYe8Z1j23y891D07IFLBm2Nfza2z2gvXagk8Wx9TERVL479L4P0wklpKL7YT5T3mzv2sTlDYAscYkBxK/HM0ZekD/fL3NhpLpHCSfqsebWBVSHzoVFOs8rcYD8gQBmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104432; c=relaxed/simple;
	bh=Am6MfhmhhKahON+wcT6CJkFPn4eNFrNyfxwl40UWhHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5G9xDYo9xbf5yhKZ5H9a6eHGcn1D14kwFRbnxw5DBbEp8yENOwzv+6Xm9v+nuaZRYiKLGhthN8XrJAGGgOdQajWgk7P38/NFXm3UUuJMvVe3qsSS9ant5AVocPub98+nvvqm7orgxRenpVflyg87bWHzh0aUOec1DRKuOURj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hXZg8QjC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hXZg8QjC"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so2204028a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743104429; x=1743709229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JEq/0HpybPrPkftoA0ZBHzqv4jivtz6CrXQUZogyrs=;
        b=hXZg8QjCeHuDb3aXuInhbE2QkwxNbqrMFL6uZnXeQOoqYRFIV1/HthN/a7brZfJGHu
         DHNB1TsBBmYTxEbDa2dKBfUlxW/gljwWacJbhVhzviq3hBfjzl4nANWsiUEzN4V9gKdk
         xMp48ZYjF38o1N9hecGcq0OJa7N94fZf4ibMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104429; x=1743709229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JEq/0HpybPrPkftoA0ZBHzqv4jivtz6CrXQUZogyrs=;
        b=CM9sUhE0xXgtHS4DJZpsfOWszkJ96aK1zEGYSoGWHxn3sAPWKz7aQsoifaQSGkfT/m
         U6XR70dLUkDnTZ3qZkKtg9i99Ekfxs5EeJCk57QH2Xc0dyXIYVA9IqP34h5NcdeinXks
         7fOZ6TQ5+5hyBGJ4FBJsy+ZLBp2wpYoZ25MLBgKPiZjfcyJ9Zj61eQg4ke1sFr2Vi9qF
         cogZyD5d8wQE6XmfFSurp47o6GdgRpjZNlqu53042fsU2ZRZvdLqn0bhDJzqZqzDzX4O
         jvWoUEayeHey2ZYMsahfAoX0SCetlYpBEnIiWvw3+hyfL/w0BJ364eo1bHPPx4v7zJSG
         2zew==
X-Forwarded-Encrypted: i=1; AJvYcCVlrSALsnwwUiVgGLW6TDqdOHCU1sjiaQCiyIeZRt9TN0YHnwTHAnvpT9y/Ld0oJ5n7I7N60EhpVYgbbySuzqnZJKbkkgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9TuB228bAt9s+QfMNo9kV+revYbjW98H1WrDimob4ZgCIk6S
	h+cis1UlBhn9RUhMd70iHkDlifkVq5N7x6A4p++bl2UN71nTm0zbJRmRw6cwNPIWLRef1CBt4an
	e438=
X-Gm-Gg: ASbGncunxTFaA5gbe/0ZmVxbOj5QVxlZVrvoK+KYrcnqvUG+i144Xb1ETaBHQWpyBYv
	PQkEXcfKw1YqqcD8Dc22aJKPyzfCAftj5mVNB9XYUPtnKS3ZRGkkLl/hPKSu0dm9mG1u+2cLE2X
	5BLzTRKb3jXMd4weW+Aw/GSpjy3L6w6pw98zNp4/UXtWTOsxQQCCLfJY5Nlg8qYCihpOk5lEdZh
	RalhLmaaa0zj7dLAoVhTtbWqjm9HYJhKMifP/NseuaZvzxnoUPpygHp7pjiIatEJt5WFWG6ichx
	Y8iRjW2sJBD9tBBMx3eXYjznuFYCNy/RuOk2b8kuEjZliRvP6eTsNU9Y1/8VdnLVHlP/bWTBTdh
	zQgg/ffc4pKtMagtPk1Q=
X-Google-Smtp-Source: AGHT+IEtikeyjBGOtKqlOg3ZeBeWSouwpPTNGlc0LMomEqSdkhAN4e7EwhRref/0JK+FibdZEFM1rg==
X-Received: by 2002:a05:6402:518d:b0:5ec:f769:db07 with SMTP id 4fb4d7f45d1cf-5ed8f113a85mr4859359a12.29.1743104428430;
        Thu, 27 Mar 2025 12:40:28 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16f12ffsm254665a12.45.2025.03.27.12.40.26
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 12:40:26 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac29af3382dso217847966b.2
        for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 12:40:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNID+KQTfu0gE8PMjoeKr2B8ylrjGjEhQfz9wqf+e20pWhQcplOtYogMzmpYzCRjLgd+COlD+qXdgtvQGyxqFEyE6Efp8=@vger.kernel.org
X-Received: by 2002:a17:906:794a:b0:ac2:dfcf:3e09 with SMTP id
 a640c23a62f3a-ac6fb100848mr518877966b.43.1743104426218; Thu, 27 Mar 2025
 12:40:26 -0700 (PDT)
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
 <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
 <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com>
 <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
 <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com> <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Mar 2025 12:40:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com>
X-Gm-Features: AQ5f1JpsgpsoU5qvy0FXDgptv2LfsiQnXe2KM7mTv3DMgNv1TpFR9zIlmzjZ8ug
Message-ID: <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 12:16, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Where could/would we cache that information so that it was accessible
> directly by the VFS layer?

So the VFS layer already does this for various other things. For this
case, the natural thing to do would be to add another IOP_xyzzy flag
in inode->i_opflags.

That's how we already say things like "this inode has no
filesystem-specific i_op->permission function" (IOP_FASTPERM), so that
we don't even have to follow the "inode->i_op->permission" pointer
chain to see a NULL pointer.

Yes, the VFS layer is *heavily* optimized like that. It literally does
that IOP_FASTPERM to avoid chasing two pointers - not even the call,
just the "don't even bother to follow pointers to see if it's NULL".
See do_inode_permission().

And we have 16 bits in that inode->i_opflags, and currently only use 7
of those bits. Adding one bit for a IOP_NO_SECURITY_LOOKUP kind of
logic (feel free to rename that - just throwing a random name out as a
suggestion) would be a complete no-brainer.

NOTE! The rule for the i_opflags accesses is that *reading* them is
done with no locking at all, but changing them takes the inode
spinlock (and we should technically probably use WRITE_ONCE() and
READ_ONCE(), but we don't).

And notice that the "no locking at all for reading" means that if you
*change* the bit - even though that involves locking - there may be
concurrent lookups in process that won't see the change, and would go
on as if the lookup still does not need any security layer call. No
serialization to readers at all (although you could wait for an RCU
period after changing if you really need to, and only use the bit in
the RCU lookup).

That should be perfectly fine - I really don't think serialization is
even needed. If somebody is changing the policy rules, any file
lookups *concurrent* to that change might not see the new rules, but
that's the same as if it happened before the change.

I just wanted to point out that the serialization is unbalanced: the
spinlock for changing the flag is literally just to make sure that two
bits being changed at the same time don't stomp on each other (because
it's a 16-bit non-atomic field, and we didn't want to use a "unsigned
long" and atomic bitops because the cache layout of the inode is also
a big issue).

And you can take the IOP_FASTPERM thing as an example of how to do
this: it is left clear initially, and what happens is that during the
permission lookup, if it *isn't* set, we'll follow those
inode->i_io->permission pointers, and notice that we should set it:

        if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
                if (likely(inode->i_op->permission))
                        return inode->i_op->permission(idmap, inode, mask);

                /* This gets set once for the inode lifetime */
                spin_lock(&inode->i_lock);
                inode->i_opflags |= IOP_FASTPERM;
                spin_unlock(&inode->i_lock);
        }

and I think the security layer could take a very similar approach: not
setting that IOP_NO_SECURITY_LOOKUP initially, but *when* a
security_inode_permission() call is made with just MAY_NOT_BLOCK |
MAY_LOOKUP, and the security layer notices that "this inode has no
reason to care", it could set the bit so that *next* time around the
VFS layer won't bother to call into security_inode_permission()
unnecessarily.

Does that clarify?

             Linus
