Return-Path: <SRS0=yYm2=2M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7166C2D0C8
	for <linux-security-module@archiver.kernel.org>; Sun, 22 Dec 2019 23:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897AA205C9
	for <linux-security-module@archiver.kernel.org>; Sun, 22 Dec 2019 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577057796;
	bh=YNkE0sQl0kffpR27z1hrWeqBh55hYjjJyqci7ZkKlY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o7E3nfpgoM9IRjKhtTTXSEv5zPROZ1dXb9msykZROixmDnai8LDdIkJGwWaNxcx1y
	 bJu6bvFqVSIFctWPZC+9pYLvioh8myyG0YI/QG/Cy0GX81Aho9s8eUjZ+JjeFlJ3WN
	 bqDY9Vz7PiLo2sqFsEv70LgYvuSYF3jzx90iarCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLVXgg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 22 Dec 2019 18:36:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43468 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLVXgf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 22 Dec 2019 18:36:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so12258338qke.10
        for <linux-security-module@vger.kernel.org>; Sun, 22 Dec 2019 15:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtCrV5fPQcR9OtEg/icWQB3SsLAI0wqFth7uQkTc9Jw=;
        b=TwZ65YN2rjdDKJcVZ85WdxjPQ41xgHxBPT2TgCvJMYjMJ8uPgsINQbiXbaBph1m6eY
         cqRKVvak0sDBQVoEXa1qu7is2jlj592GYWUtNS8SR4NadlxFjh+bjtR5i0zOxgMplBC9
         FpKo00sFdVU/UGNdZEi+tz9I1cSphmP2fJnNJJ4kHUAAQRGFJdMlKeG/+R+yP0dkVZpW
         +3oGtpNX37huGKO/wxq/wqnO75i/ygbpNNH+a4l8GIxUr9bFN4a2q6XRTRsp+CwsYu5l
         V4qVo5S/imxL92r/1QtJLR5TeXyhs/wY5qlkMaCEg7PHbHxM8I0zBGI2NqFf5gEPB+cK
         WAsA==
X-Gm-Message-State: APjAAAUHQr8Tzw7YswXokNaXtLYr6tYwu/hiyg+/GW4mKjCdPQgWQwH+
        JY5Ss434OepUVh2o3EMyaEvF7vXtWUAyjeFsedMGug==
X-Google-Smtp-Source: APXvYqxf2NWl6onWv+R3LjwOWqQerZnriYOeYmV/yimibUjjwZUVogXRp93vDlUSDMDHKSuShAgw0u9B237uD8aYB1c=
X-Received: by 2002:a37:9ac5:: with SMTP id c188mr23448204qke.374.1577057794240;
 Sun, 22 Dec 2019 15:36:34 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkiyAkZy=oLrpJvHYU9Tq1dunNJLOJdtr508_w3vrdPWcQ@mail.gmail.com>
 <CALQRfL7i5r1d1K3fOuwyJ0BtmrsVMC8zzdd0Z7=14n3X8QNw5g@mail.gmail.com>
 <CAKgNAkjuFOumKV6Z+GDDEjLrVup7fJB_H86xguJ7asdUdfEBxQ@mail.gmail.com>
 <CALQRfL57VP_VHuHSzM9A65wxR6LjsH9+3wgeQ3qQEU0G9PuWHw@mail.gmail.com>
 <CAKgNAki++fQ3UtvA15g87YDPggbcinpJge-wf5nV76yrEqDgCA@mail.gmail.com>
 <CALQRfL4_kVKX=qJ0nDnEGgVeUHtQG5BDTCX72KfZr0toc-Mpuw@mail.gmail.com>
 <20191221030845.GA3626@mail.hallyn.com> <CALQRfL4O2CgkAdOxhsqN87MBDDaVhRaHBRVMu+hecQq-Fu8q-A@mail.gmail.com>
 <20191221043622.GA4580@mail.hallyn.com> <CALQRfL50+JUGcWk_NyyKvviCeNUPQdjjP=OGoewvH-mU6Pn2hQ@mail.gmail.com>
In-Reply-To: <CALQRfL50+JUGcWk_NyyKvviCeNUPQdjjP=OGoewvH-mU6Pn2hQ@mail.gmail.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Sun, 22 Dec 2019 15:36:22 -0800
Message-ID: <CALQRfL530ySipAtBrWi=i19VKZ+VGdRtJzTymHaEYk5XHK4E0A@mail.gmail.com>
Subject: Re: Anomalous output from getpcaps(1) for process with all capabilities
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        ksrot@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

New libcap behavior implemented:

  https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=afef3ef1c62613e1cac12a2bbec6017f7d5e033e

Cheers

Andrew

On Sun, Dec 22, 2019 at 10:00 AM Andrew G. Morgan <morgan@kernel.org> wrote:
>
> I can take a look, but I'm not really convinced this isn't going to
> cause me grief at some point in the future when the kernel adds
> support for another capability and all' does not equal all. I've done
> some digging and I thought it was worth writing up.
>
> Today, the kernel treats 'all' (as it is defined by libcap today)
> differently for file and process capabilities. I suspect this is
> contributing to expectations about what all means, because all as
> defined today is effectively useless, and somewhere in the kernel
> we've worked around it for filecaps when we shouldn't have.
>
> Explanation of kernel bug (no use of 'all' here):
>
> 1) placing, say, bit-63 (undef today) and bit-0 (cap_chown) on the
> permitted (fP) vector of a file, yields a file that can execute - it
> gets pP=cap_chown.
>
> cd libcap/progs ; make ; cp capsh pcapsh ; sudo setcap
> 63,cap_setpcap,cap_chown=p pcapsh
>
> ./pcapsh --print
>
> 2) dropping cap_chown from the bounding set causes this same file to
> not run (insufficient privilege) because the file has been setup to
> require cap_chown, but can't have it so (by design) we deny execution
> altogether -- this fails:
>
> ./pcapsh --drop=cap_chown --print == --print
>
> To be consistent, (1) should fail because bit-63 is being dropped by
> the bounding set at execution time. That is, a binary that requires
> some future definition for capability #63 to run successfully should
> fail on a kernel that does not support it today.  This but was
> introduced with this kernel commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/security/commoncap.c?id=7d8b6c63751cfbbe5eef81a48c22978b3407a3ad
>
> Ironically, the commit message declares the fact that (4) now passes
> is the fix. The real fix is to think about what we mean by 'all'.
>
> Cheers
>
> Andrew
>
> On Fri, Dec 20, 2019 at 8:36 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > I think the thing to do is use /proc/sys/kernel/cap_last_cap (if it
> > exists) to compare *caps to ~(cap_last_cap-1) and for each bit where
> > it's the same, show the full set.  Been looking at the fn for a bit,
> > and I might be comfortable enough to try it at this point.  But, if
> > you want to do it (to make sure it's done right :), please let me know.
> >
> > -serge
> >
> > On Fri, Dec 20, 2019 at 07:27:46PM -0800, Andrew G. Morgan wrote:
> > > /proc/1/status changed at some point to drop the undefined bits. When
> > > it did I changed libcap to try harder to not display unnamed
> > > capabilities.
> > >
> > > Cheers
> > >
> > > Andrew
> > >
> > >
> > > On Fri, Dec 20, 2019 at 7:08 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > >
> > > > I believe this is coming from the kernel.  I booted an old 12.04
> > > > ubuntu server livecd (3.13 kernel) and libcap 2.22, it shows
> > > > Capabilities for `1': =ep
> > > > This was running
> > > > libcap 2.22.  Same version of libcap compiled on my laptop gives me the
> > > > long output.  booting an old 14.04 livecd, running 4.4 kernel,
> > > > getpcap also gives the long output.
> > > >
> > > > On Mon, Dec 16, 2019 at 07:47:44PM -0800, Andrew G. Morgan wrote:
> > > > > Serge might want to comment. I seem to recall that the issue was relevant
> > > > > for Serge's namespaces and checkpointing/restarting over a kernel upgrade.
> > > > > But it has been more than a decade and I can't seem to find the email
> > > > > exchange we had back then.
> > > > >
> > > > > Cheers
> > > > >
> > > > > Andrew
> > > > >
> > > > >
> > > > > On Sun, Dec 15, 2019 at 8:52 PM Michael Kerrisk (man-pages) <
> > > > > mtk.manpages@gmail.com> wrote:
> > > > >
> > > > > > Hello Andrew,
> > > > > >
> > > > > > On 12/16/19 12:26 AM, Andrew G. Morgan wrote:
> > > > > > > [Resend with reply-all this time.]
> > > > > > >
> > > > > > > On Sun, Dec 15, 2019 at 11:17 AM Michael Kerrisk (man-pages)
> > > > > > > <mtk.manpages@gmail.com> wrote:
> > > > > > >>
> > > > > > >> Hello Andrew,
> > > > > > >>
> > > > > > >> On Sun, 15 Dec 2019 at 19:30, Andrew G. Morgan <morgan@kernel.org>
> > > > > > wrote:
> > > > > > >>>
> > > > > > >>> This changed with this commit I think:
> > > > > > >>>
> > > > > > >>>
> > > > > > https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=3fa808f5886d08c45866217cfe6e6e9def7de04e
> > > > > > >>>
> > > > > > >>> Prior to that, we had "=ep" mean the cap set was ~0 for
> > > > > > >>> all the bitmasks in e and p. When we started to clip the
> > > > > > >>> bounding set to only defined capabilities, it meant that the
> > > > > > >>> text output started to look like
> > > > > > >>> "=ep 33,34,35,36,37,38,39,40,41,42.....63-ep" which
> > > > > > >>> was quite terrible.
> > > > > > >>
> > > > > > >> Was that really the change that caused this? That's a 2008 commit.
> > > > > > >> Certainly, I recall in 2014 or 2015 still being able to see =ep, and I
> > > > > > >> presume (but do not recall for sure) that I was using a system with a
> > > > > > >> libcap more recent than v2.11 (of which that commit was a part).
> > > > > > >
> > > > > > > The only other commit that seems relevant was this one:
> > > > > > >
> > > > > > >
> > > > > > https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=afb17b8c007a49d93b0d30936b2d65af1bfdb039
> > > > > > >
> > > > > > > But I think this was all part of the same effort.
> > > > > > >
> > > > > > >>> So, this was seen as the least worst option.
> > > > > > >>
> > > > > > >> But surely this is fixable? Or, to put it another was, I presume
> > > > > > >> there's something that makes this difficult to fix in getpcaps, but
> > > > > > >> what is that something?
> > > > > > >
> > > > > > > I recall spending a day or more trying to avoid it, but I can't see
> > > > > > > how it is really fixable because there are too many moving parts.
> > > > > > >
> > > > > > > If the kernel adds another capability, then =ep could reasonably mean
> > > > > > > both the "old full set" or the "new full set". There are contexts
> > > > > > > where the difference matters. For example, where folk are using text
> > > > > > > representations for things like package manager shell-script setups.
> > > > > > > What they get when they say "=ep
> > > > > > > cap_setpcap,cap_sys_admin,cap_setfcap-ep" today, might suddenly be
> > > > > > > inappropriate when the new kernel adds "cap_self_destruct". At least
> > > > > > > the way it is at present, we are very explicit about what is in
> > > > > > > effect
> > > > > >
> > > > > > I can sort of see how the idea you are expressing might
> > > > > > apply when *setting* capabilities on *files*, but:
> > > > > >
> > > > > > a) I'm talking about the *display* of capabilities of a running
> > > > > > *process* using getpcaps(8).
> > > > > >
> > > > > > b) In practice, the logic that actually applies when setting
> > > > > > capabilities on files seems to run *counter* to the idea
> > > > > > that you express above (if I understand you correctly),
> > > > > > and your argument seems more relevant to files (especially
> > > > > > when *setting* file capabilities) than to processes.
> > > > > >
> > > > > > Consider the following examples:
> > > > > >
> > > > > > 1. A binary that has all but one capability is described in a
> > > > > > compact way by getcap(8):
> > > > > >
> > > > > >         $ sudo setcap "=p cap_kill-p" mypog
> > > > > >         $ getcap mypog
> > > > > >         mypog =p cap_kill-p
> > > > > >
> > > > > > When that same binary is run, the process's capabilities
> > > > > > are described with a very different format by getpcaps(8)
> > > > > >
> > > > > >         $ getpcaps $(pidof i_syscall)
> > > > > >         Capabilities for `152006': =
> > > > > >         cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,
> > > > > >         cap_fsetid,cap_setgid,cap_setuid,cap_setpcap,
> > > > > >         cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,
> > > > > >         cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,
> > > > > >         cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,
> > > > > >         cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,
> > > > > >         cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,
> > > > > >         cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,
> > > > > >         cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,
> > > > > >         cap_block_suspend,cap_audit_read+p
> > > > > >
> > > > > > That is quite inconsistent! And also, the second notation is
> > > > > > simply very hard to read. How many capabilities are listed there?
> > > > > > Is it all of them? (When a process does have all caps in permitted,
> > > > > > the display differs only by one item.) A security-related notation
> > > > > > that is difficult to read is a risk... [*]
> > > > > >
> > > > > > 2. I just now tried the following, and it really surprised me
> > > > > > (although the reasons are quickly obvious when one considers
> > > > > > the point I made earlier in this mail thread that 'setcap =p' is
> > > > > > setting *64* bits in the file's permittted set):
> > > > > >
> > > > > >         # Set "all" permitted capabilities on a file:
> > > > > >
> > > > > >         $ sudo setcap =p myprog
> > > > > >         $ getcap myprog
> > > > > >         myprog =p
> > > > > >
> > > > > >         # Set "all" 38 permitted capabilities on a file, by specifying
> > > > > >         # them individually:
> > > > > >
> > > > > >         $ sudo setcap 0$(for c in $(seq 1 37); do \
> > > > > >         echo -n ",$c"; done)=p myprog
> > > > > >         $ getcap myprog
> > > > > >         cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,
> > > > > >         cap_fsetid,cap_setgid,cap_setuid,cap_setpcap,
> > > > > >         cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,
> > > > > >         cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_kill,
> > > > > >         cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,
> > > > > >         cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,
> > > > > >         cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,
> > > > > >         cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,
> > > > > >         cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,
> > > > > >         cap_block_suspend,cap_audit_read+p
> > > > > >
> > > > > > I think there would be few users who would *not* be surprised
> > > > > > about the fact that two steps that seem equivalent produce
> > > > > > quite differnt output from getcap(8)!
> > > > > >
> > > > > > 3. Suppose I set all permitted capabilities on a binary:
> > > > > >
> > > > > >         $ sudo setcap =p myprog
> > > > > >
> > > > > > Then actually, I have set not just the 38 existing capabilities,
> > > > > > but also 26 future capabilities, so that when "cap_self_destruct"
> > > > > > is added to the kernel, 'myprog' already has it. This seems to
> > > > > > run directly counter to your argument above (if I have understood
> > > > > > it correctly).
> > > > > >
> > > > > > My summary from the above:
> > > > > >
> > > > > > * The output notation from getpcaps(8) is (1) inconsistent (with
> > > > > > getcap(8)), and (2) difficult to read, two things that strike me
> > > > > > as risk factors in a security-related notation.
> > > > > >
> > > > > > * The fact that "setcap =p ..." sets the top 26 (currently unused)
> > > > > > bits in the permitted set is surprising, and perhaps also a
> > > > > > security risk when new capabilities are actually added to the
> > > > > > kernel, since existing binaries will automatically have those
> > > > > > capabilities.
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > Michael
> > > > > >
> > > > > > [*] I often joke that the cap_to_text(3) notation is one that is
> > > > > > "human-readable, but not necessarily human-comprehensible", but
> > > > > > at the same time I also note that the notation has one virtue:
> > > > > > it is compact. However, that one virtue seems to have gone out
> > > > > > the window for getpcaps(8).
> > > > > >
> > > > > > --
> > > > > > Michael Kerrisk
> > > > > > Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> > > > > > Linux/UNIX System Programming Training: http://man7.org/training/
> > > > > >
