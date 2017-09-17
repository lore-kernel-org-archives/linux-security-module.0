From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sun, 17 Sep 2017 09:34:01 -0700
Subject: [PATCH 3/3] ima: use fs method to read integrity data (updated
	patch description)
In-Reply-To: <1505664935.4200.191.camel@linux.vnet.ibm.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505451494-30228-4-git-send-email-zohar@linux.vnet.ibm.com>
	<1505507142.4200.103.camel@linux.vnet.ibm.com>
	<CA+55aFxmeff53zeioTiQY6m=F18ekgX1-HWZyQUor=NJYrxM9A@mail.gmail.com>
	<20170917151757.GA14262@infradead.org>
	<CA+55aFyrZ=YsfNc1vp=vArNgotLXGPr4F6uZiz22Uj2XHGUvaw@mail.gmail.com>
	<1505664935.4200.191.camel@linux.vnet.ibm.com>
Message-ID: <CA+55aFyBhb_hQ84heyWnAP+1vn48Wjpnas0YSUY-R6Ej6bv_Dw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 17, 2017 at 9:15 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>
> Unless I'm missing something, that would only be possible with an IMA
> policy rule that permits direct IO (eg. permit_directio).  Otherwise
> the direct IO is denied.

Note that the "XFS and directio" was only an example.

There is absolutely nothing that says that a  filesystem has to use
i_rwsem for IO serialization at all. Even for the regular write path.

Now, I suspect most (all?) do, but that's a historical artifact rather
than "design". In particular, the VFS layer used to do the locking for
the filesystems, to guarantee the POSIX requirements (POSIX requires
that writes be seen atomically).

But that lock was pushed down into the filesystems, since some
filesystems really wanted to have parallel writes (particularly for
direct IO, where that POSIX serialization requirement doesn't exist).

That's all many years ago, though. New filesystems are likely to have
copied the pattern from old ones, but even then..

Also, it's worth noting that "inode->i_rwlock" isn't even well-defined
as a lock. You can have the question of *which* inode gets talked
about when you have things like eoverlayfs etc. Normally it would be
obvious, but sometimes you'd use "file->f_mapping->host" (which is the
same thing in the simple cases), and sometimes it really wouldn't be
obvious at all..

So... I'm really not at all convinced that i_rwsem is sensible. It's
one of those things that are "mostly right for the simple cases",
but...

              Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
