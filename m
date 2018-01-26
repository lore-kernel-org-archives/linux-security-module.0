From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Jan 2018 10:04:43 +0100
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-2-git-send-email-takondra@cisco.com>
	<CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
	<0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
Message-ID: <CAK8P3a0B0XK8g4H+4grEru2GKRG91_qKxZ=y8AxaQi9pcPwKRQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jan 26, 2018 at 3:39 AM, Rob Landley <rob@landley.net> wrote:

> The problem with 1 second timestamps was you honestly could confuse
> "make" about which file was newer once an exec() could complete in the
> same second having done real work. That was the motivating issue causing
> the change, going to nanoseconds was just the big hammer of "this is
> large enough it won't matter again in our lifetimes". But nanosecond
> time stamps are recording more jitter than useful information, and that
> seems unlikely to change this century?

Sure, the only thing we really need the nanosecond timestamp for is
to keep them identical. E.g. if you use cpio to make an exact copy
of a file system, using microseconds timestamps will round all mtime
values. If you then use 'rsync' to compare/update the two copies
without passing a --modify-window= or --size-only, it will have
to read all files in rather then skipping those with identical size and
mtime.

Side note: the default behavior for file systems is actually to only use
the coarse timestamps of the last timer tick, so you actually do get
identical timestamps in practice, plus six digits of nonsense:

(on tmpfs)
 $ for i in {000..999} ; do > $i ; done; stat --format="%y" *  | uniq -c
     86 2018-01-26 10:01:48.811135084 +0100
    469 2018-01-26 10:01:48.815135143 +0100
    445 2018-01-26 10:01:48.819135201 +0100

         Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
