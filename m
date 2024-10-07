Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB41DE8BC
	for <linux-security-module@vger.kernel.org>; Mon,  7 Oct 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333467; cv=none; b=jt0/oZSUyPqGa0Xz4Cg/+PmXlcXyYIY+8SeCrdetm/PCoZiq0tdB+2PGKf9kmJIqZU2DRao56wHsHdClMpHMzaWoWolUnro2EsA8KL0KozdvjGhx/0Sprvvf/Gk47mll55c5f+zcX0NUuKt9iyDHQna7fUKqXJR/MtHkO/5j5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333467; c=relaxed/simple;
	bh=Y3xYC+wz5DB+ioeLv98h6nPB0DXqGCfot1aJrQPSDA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fk6B6LWuesRweo7a1lfKgfZGd2rOij0dLHExF3A7FuEcrp7tjIP26vE9/dTgiXf6xIZHBd+t/D+DufTkVh76/3q5Q155i4AAcd0BYm22jUX8nCmOkKeJdNdsLKzXUMx+3WjJdi6TwG6Y8JCWLn5npGbixCn4GUgCn2+nUPRUNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ccel2H8S; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ccel2H8S"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9941a48ac8so305494766b.3
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2024 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728333462; x=1728938262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gxfIEmnywXXr2F4fJYOrFGHGu5IS2gv2EOSHZH1isPU=;
        b=Ccel2H8S0Dy219pzvzwEotNeUYjQu93V6qRRkpNpk6ypR9spW66hUuVBd9V7m3GtHz
         JuALBejMrR8Ot0eYI4C95/eleDubDU7LhtEwHwgWZ+4xD030USnBntxBnwwijHEEVoC7
         zX7Qf/xVzi4evgZ0Xk4rO88J1qAswn7Ds8nBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333462; x=1728938262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxfIEmnywXXr2F4fJYOrFGHGu5IS2gv2EOSHZH1isPU=;
        b=QNKVQ42UTJFhB/vsiwQ3UiAEEIvgJgmgf18UBMUwElhGYO6lNZQN2gmvfB3QDNM5sV
         flQ/g0N4XKA1OhygWGqL/t6JP6j14cRlZH9hXHbK0lEHivSyH0weQyTBkgM/ah03SpZl
         FMqyc9fyBebbhyhv6WZBM/PQRjHG+QCB+tq7R4nq8xSdgL1DHfx1ZRcPbmW3wAwEiqbX
         rHJfHoqUm3AuwnvxakQhEZVCY5v69PVnxc6WmsUIeHubgBcZHWFALELLbJYdLuwhT0Jw
         Oh6/ENeojV2Uw51YEt1ylm1GFimQKBmawJ6/c9+qNLyrflwkcQP3M254feIXIgX+mnQW
         63jg==
X-Forwarded-Encrypted: i=1; AJvYcCV21es6ni5rQ9Sq1HAFwo1JYif3WVOAGAeaZDoh6/sZehvE6+cLOryrn7EwGoRwu+ou6YEjgmNgc0MYu+C9fCo7coUgBKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEV0dtkrEZl2Z4GYyuW9VdJyQPIu2Upxa3YQqAp3TG/pH/GFS
	QdrKcTTUesJZzl/HoyYaW2vAKXc2C+YN8vkzUkQmRPpGVJnCK2wLeyZ3emwyjSZqUoPJQ5aaxLC
	yzTsgEA==
X-Google-Smtp-Source: AGHT+IEBo39VRMEbNfI0ejP4CLTwsFgEEFJ/FAvUIahDnzuodPlURv5fqcPeGBmGaw4yaaSQoBI6qw==
X-Received: by 2002:a17:906:eec2:b0:a99:4789:6ad3 with SMTP id a640c23a62f3a-a9947896b17mr599236966b.59.1728333456960;
        Mon, 07 Oct 2024 13:37:36 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995a54ddf3sm130522566b.216.2024.10.07.13.37.36
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 13:37:36 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a994cd82a3bso253409866b.2
        for <linux-security-module@vger.kernel.org>; Mon, 07 Oct 2024 13:37:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOi0L1XSfNZVpOP0lWkANhd/KF7/CbOBAYbnNcVLiIiwvuS4dXem+KGE6V4FTtyLG6U6+Jk4MZ7vVbq67fSnmHM8MIKEA=@vger.kernel.org
X-Received: by 2002:a17:906:eec2:b0:a99:4789:6ad3 with SMTP id
 a640c23a62f3a-a9947896b17mr599234166b.59.1728333455897; Mon, 07 Oct 2024
 13:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002014017.3801899-1-david@fromorbit.com> <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org> <Zv5J3VTGqdjUAu1J@infradead.org> <20241003115721.kg2caqgj2xxinnth@quack3>
In-Reply-To: <20241003115721.kg2caqgj2xxinnth@quack3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Oct 2024 13:37:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
Message-ID: <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 04:57, Jan Kara <jack@suse.cz> wrote:
>
> Fair enough. If we go with the iterator variant I've suggested to Dave in
> [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> Landlocks hook_sb_delete() into a single iteration relatively easily. But
> I'd wait with that convertion until this series lands.

Honza, I looked at this a bit more, particularly with an eye of "what
happens if we just end up making the inode lifetimes subject to the
dentry lifetimes" as suggested by Dave elsewhere.

And honestly, the whole inode list use by the fsnotify layer seems to
kind of suck. But I may be entirely missing something, so maybe I'm
very wrong for some reason.

The reason I say it "seems to kind of suck" is that the whole final

                /* for each watch, send FS_UNMOUNT and then remove it */
                fsnotify_inode(inode, FS_UNMOUNT);

                fsnotify_inode_delete(inode);

sequence seems to be entirely timing-dependent, and largely pointless and wrong.

Why?

Because inodes with no users will get removed at completely arbitrary
times under memory pressure in evict() -> destroy_inode(), and
obviously with I_DONTCACHE that ends up happening even earlier when
the dentry is removed.

So the whole "send FS_UNMOUNT and then remove it " thing seems to be
entirely bogus, and depending on memory pressure, lots of inodes will
only see the fsnotify_inode_delete() at eviction time and never get
the FS_UNMOUNT notification anyway.

So I get the feeling that we'd be better off entirely removing the
sb->s_inodes use from fsnotify, and replace this "get rid of them at
umount" with something like this instead:

  diff --git a/fs/dcache.c b/fs/dcache.c
  index 0f6b16ba30d0..aa2558de8d1f 100644
  --- a/fs/dcache.c
  +++ b/fs/dcache.c
  @@ -406,6 +406,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
        spin_unlock(&inode->i_lock);
        if (!inode->i_nlink)
                fsnotify_inoderemove(inode);
  +     fsnotify_inode_delete(inode);
        if (dentry->d_op && dentry->d_op->d_iput)
                dentry->d_op->d_iput(dentry, inode);
        else
  diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
  index 278620e063ab..ea91cc216028 100644
  --- a/include/linux/fsnotify.h
  +++ b/include/linux/fsnotify.h
  @@ -261,7 +261,6 @@ static inline void
fsnotify_vfsmount_delete(struct vfsmount *mnt)
   static inline void fsnotify_inoderemove(struct inode *inode)
   {
        fsnotify_inode(inode, FS_DELETE_SELF);
  -     __fsnotify_inode_delete(inode);
   }

   /*

which makes the fsnotify_inode_delete() happen when the inode is
removed from the dentry.

Then at umount time, the dentry shrinking will deal with all live
dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
just the root dentry inodes?

Wouldn't that make things much cleaner, and remove at least *one* odd
use of the nasty s_inodes list?

I have this feeling that maybe we can just remove the other users too
using similar models. I think the LSM layer use (in landlock) is bogus
for exactly the same reason - there's really no reason to keep things
around for a random cached inode without a dentry.

And I wonder if the quota code (which uses the s_inodes list to enable
quotas on already mounted filesystems) could for all the same reasons
just walk the dentry tree instead (and remove_dquot_ref similarly
could just remove it at dentry_unlink_inode() time)?

It really feels like most (all?) of the s_inode list users are
basically historical, and shouldn't use that list at all. And there
aren't _that_ many of them. I think Dave was right in just saying that
this list should go away entirely (or was it somebody else who made
that comment?)

                   Linus
