From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Apr 2017 16:26:05 -0700
Subject: [PATCH net-next v6 00/11] Landlock LSM: Toward unprivileged
	sandboxing
In-Reply-To: <20170328234650.19695-1-mic@digikod.net>
References: <20170328234650.19695-1-mic@digikod.net>
Message-ID: <CAGXu5jLpM13xmFf2_bcWH=db7LEavfpZswvPbAM3+66dBPtMTg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 28, 2017 at 4:46 PM, Micka?l Sala?n <mic@digikod.net> wrote:
> This sixth series add some changes to the previous one [1], including a simpler
> rule inheritance hierarchy (similar to seccomp-bpf), a ptrace scope protection,
> some file renaming (better feature identification per file), a future-proof
> eBPF subtype and miscellaneous cosmetic fixes.

Sorry for the delay in review! I finally had a chunk of time I could
devote to this. I really like how it's heading. I still wonder about
its overlap with seccomp (it's really only using the syscall now...),
but that's just a detail. Getting the abstraction away from direct LSM
hooks looks good.

> There is as yet no way to allow a process to access only a subset of the
> filesystem where the subset is specified via a path or a file descriptor.  This
> feature is intentionally left out so as to minimize the amount of code of this
> patch series but will come in a following series.  However, it is possible to
> check the file type, as done in the following example.

I understand why you've taken a progressive approach here, but I think
there are two fundamental areas where people will use Landlock: path
evaluation and network address evaluation. I think it's worth
expanding this series to include those two confinement examples, since
that can help people understand what the "general" case will look
like.

As I mentioned in one of the patch review emails, I think there needs
to be a clearer explanation of how usage counting works vs the
"events" (which I think of as "rule tables" not events -- maybe it
needs a new name?) and "rule" lists. I think I understand it, but I
spent a lot of time trying to get there. More comments would help.

Finally, another thing I'm curious about is how to deal with the
thread-sync issue. Seccomp uses its TSYNC thing, and I'd expect we'd
want something similar for landlock... but that looks really hairy as
far as locking goes. Perhaps it's already solved by using the same
locking seccomp uses, in which case I'm less inclined to kick landlock
out of seccomp.c. :)

Looks like it's coming along nicely! Thanks for continuing to work on this!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
