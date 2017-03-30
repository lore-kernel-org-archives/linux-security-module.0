From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 30 Mar 2017 12:12:31 -0700
Subject: [PATCH RFC 0/4] proc: support multiple separate proc instances
	per pidnamespace
In-Reply-To: <1490887379-25880-1-git-send-email-tixxdz@gmail.com>
References: <1490887379-25880-1-git-send-email-tixxdz@gmail.com>
Message-ID: <CALCETrWooKTtViVh4ik9e-3nLs3NET9wptgxhjS9V499sfUJQA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 30, 2017 at 8:22 AM, Djalal Harouni <tixxdz@gmail.com> wrote:
> Hi,
>
> This RFC can be applied on top of Linus' tree 89970a04d7
>
> This RFC implements support for multiple separate proc instances inside
> the same pid namespace. This allows to solve lot of problems that
> today's use case face.
>
> Historically procfs was tied to pid namespaces, and mount options were
> propagated to all other procfs instances in the same pid namespace. This
> solved several use cases in that time. However today we face new
> problems, there are mutliple container implementations there, some of
> them want to hide pid entries, others want to hide non-pid entries,
> others want to have sysctlfs, others want to share pid namespace with
> private procfs mounts. All these with current implementation won't work
> since all options will be propagated to all procfs mounts.
>
> This series allow to have new instances of procfs per pid namespace where
> each instance can have its own mount option inside the same pid namespace.
> This was also suggested by Andy Lutomirski.
>
>
> Now:
> $ sudo mount -t proc -o unshare,hidepid=2 none /test
>
> The option 'unshare' will allow to mount a new instance of procfs inside
> the same pid namespace.
>
> Before:
> $ stat /proc/slabinfo
>
>   File: ?/proc/slabinfo?
>   Size: 0               Blocks: 0          IO Block: 1024   regular empty file
> Device: 4h/4d   Inode: 4026532046  Links: 1
>
> $ stat /test3/slabinfo
>
>   File: ?/test3/slabinfo?
>   Size: 0               Blocks: 0          IO Block: 1024   regular empty file
> Device: 4h/4d   Inode: 4026532046  Links: 1
>
>
> After:
> $ stat /proc/slabinfo
>
>   File: ?/proc/slabinfo?
>   Size: 0               Blocks: 0          IO Block: 1024   regular empty file
> Device: 4h/4d   Inode: 4026532046  Links: 1
>
> $ stat /test3/slabinfo
>
>   File: ?/test3/slabinfo?
>   Size: 0               Blocks: 0          IO Block: 1024   regular empty file
> Device: 31h/49d Inode: 4026532046  Links: 1
>
>
> Any better name for the option 'unshare' ? suggestions ?
>
> I was going to use 'version=2' but then this may sound more like a
> proc2 fs which currently impossible to implement since it will share
> locks with the old proc.
>
>
> Al, Eric any comments please ?

I like the concept, except that I think it would be nice to avoid
needing 'unshare', perhaps by making unsharing the default and making
hidepid work backwards compatibly if needed.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
