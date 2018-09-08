From: amir73il@gmail.com (Amir Goldstein)
Date: Sat, 8 Sep 2018 10:41:41 +0300
Subject: Containers and checkpoint/restart micro-conference at LPC2018
In-Reply-To: <20180908045935.GA9201@castiana>
References: <20180813161015.GD18492@castiana> <20180908045935.GA9201@castiana>
Message-ID: <CAOQ4uxiQEpofdS97kxnii8LtVW2QiKAGvjjaH0Px-Bj3eHVCFA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Sep 8, 2018 at 8:00 AM St?phane Graber <stgraber@ubuntu.com> wrote:
>
> On Mon, Aug 13, 2018 at 12:10:15PM -0400, St?phane Graber wrote:
> > Hello,
> >
> > This year's edition of the Linux Plumbers Conference will once again
> > have a containers micro-conference but this time around we'll have twice
> > the usual amount of time and will include the content that would
> > traditionally go into the checkpoint/restore micro-conference.
> >
> > LPC2018 will be held in Vancouver, Canada from the 13th to the 15th of
> > November, co-located with the Linux Kernel Summit.
> >
> >
> > We're looking for discussion topics around kernel work related to
> > containers and namespacing, resource control, access control,
> > checkpoint/restore of kernel structures, filesystem/mount handling for
> > containers and any related userspace work.
> >
> >
> > The format of the event will mostly be discussions where someone
> > introduces a given topic/problem and it then gets discussed for 20-30min
> > before moving on to something else. There will also be limited room for
> > short demos of recent work with shorter 15min slots.
> >
> >
> > Details can be found here:
> >
> >   https://discuss.linuxcontainers.org/t/containers-micro-conference-at-linux-plumbers-2018/2417
> >
> >
> > Looking forward to seeing you in Vancouver!
>
> Hello,
>
> We've added an extra week to the CFP, new deadline is Friday 14th of September.
>
> If you were thinking about sending something bug then forgot or just
> missed the deadline, now is your chance to send it!
>

[cc: overlayfs developers]

Hi St?phane!

I am not planing to travel to LPC this year, so this is more of an FYI than
a CFP, but maybe another overlayfs developer can pick up this glove??

For the past two years I have participated in the effort to fix overlayfs
"non-standard" behavior:
https://github.com/amir73il/overlayfs/wiki/Overlayfs-non-standard-behavior

Allegedly, this effort went underway to improve the experience of overlayfs
users, who are mostly applications running inside containers. For backward
compatibility reasons, container runtimes will need to opt-in for fixing some
of the legacy behavior.

In reality, I have seen very little cross list interaction between linux-unionfs
and containers mailing lists. The only interaction I recall in the
past two years
ended up in a fix in overlayfs to require opt-in for fixing yet another backward
compatible bad behavior, although docker did follow up shortly after to fix
bad practice in container runtime:
https://github.com/moby/moby/issues/34672

So the questions I would like to relay to the micro-conf participants w.r.t the
new opt-in overlayfs behavior:
1. Did you know?
2. Do you care?

Cheers,
Amir.
