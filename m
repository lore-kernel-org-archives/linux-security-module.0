From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sat, 10 Feb 2018 12:44:50 -0800
Subject: [GIT PULL] Integrity: IMA FUSE fixes
In-Reply-To: <alpine.LRH.2.21.1802101718330.4382@namei.org>
References: <alpine.LRH.2.21.1802101718330.4382@namei.org>
Message-ID: <CA+55aFzX+=WRaVi51gaqCdnrxwXC3kqxk8LZyXQY=yn5XigE4Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Feb 9, 2018 at 10:26 PM, James Morris <jmorris@namei.org> wrote:
> These patches ensure that IMA works correctly on FUSE filesystems, so that
> cached integrity data is not used.  FUSE filesystems can change this data
> at any time without notifying the kernel and we now verify it for each
> use.
>
> This work is late in the kernel cycle, but they have had good review,
> testing, and acks.  They only impact FUSE and IMA.

This seems entirely insane.

You simply cannot use IMA on a fuse filesystem, because the data can
change dynamically any time.

But that doesn't mean that you can't cache the measurements - it means
that the measurements are pointless. Those are two completely
different things.

This patch seems to disable caching, but still _use_ the measurement.

Which seems *worse* than what we do now, in that it wastes time and
effort on re-creating those pointless measurements because it disables
the caching of them.

So honestly, the only sane thing seems to be to disable IMA on fuse,
not to force it to do even _more_ pointless work.

What am I missing?

                   Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
