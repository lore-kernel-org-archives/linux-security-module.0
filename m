Return-Path: <SRS0=yYm2=2M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CDFC2D0C8
	for <linux-security-module@archiver.kernel.org>; Sun, 22 Dec 2019 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3846C206B7
	for <linux-security-module@archiver.kernel.org>; Sun, 22 Dec 2019 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577037620;
	bh=hKwd6TwIZAJcn9hk4J2b5pJYC2ZvdgLbkpfCDqpPRAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gGjy58qAFDqwML4sSLUN9vcO6/0jv/Wu4EctPyfUvAG1hiIN/GwqaKcQyMhm406Wg
	 bwHes7dp8vFfG6tWL3tVDzXRN7RWyAIp/hwlfsfbi75gauwJdDDGB22R54wNaFVG1Q
	 EBHD28PjlY7tLCAOF5a0ZSV+fL9NQqce0qz5A264=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfLVSAT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 22 Dec 2019 13:00:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44411 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLVSAT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 22 Dec 2019 13:00:19 -0500
Received: by mail-qt1-f196.google.com with SMTP id t3so13445657qtr.11
        for <linux-security-module@vger.kernel.org>; Sun, 22 Dec 2019 10:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiNKBABcBmFtCB+cpUfK62X+UyUbv0jv4b9JqQniJ3U=;
        b=UxhaTUKcQuAoxAQSwmAjutMr3ohegaePPiMqsW+Sp3CpXPktBM6c6IvTn2h9wwbR25
         k0kJUWOXP49tmSYad5/hXoGiHLSbQtAQjIe0CmFR4IKTqxlPGd2OpCR5CpCfzbWbGKXT
         vtkiGFWBzYlcM1P9tA5Gh7JE39uodnu0NnAfuTEDHsDSa17IDXk/9XpDL177QGcX+ZfH
         ++v4jH1YPS8qI2PeEv/pk/wH74riy7m2yXAO9aH1pmYUm+4ErtFH1BKZkkIY1ixouiju
         Nd3+r0hkl+lcGP/qAUCwyZT5XnzhlJC0Xw7ux6LNjuWfMxzethxn0cb//ScsP1Uv0kPt
         FTyg==
X-Gm-Message-State: APjAAAXl1HDUVSJ8MoAQN6wfpGQyacL7YRyQKvcydx7gLUhmyxUPHd2j
        st1NUQT15uiO+sj4R7b8nR3qAXAjOxfhMpiUi67JjQ==
X-Google-Smtp-Source: APXvYqxGeDBEL+s1wiVfn75WTl/lYgep0BKQYOJwPmfGZDImC6R2/N+t5ZFN2Z6guqNTvJkh4qaHOgJ2phndMnbDEsw=
X-Received: by 2002:aed:2ee1:: with SMTP id k88mr13951651qtd.25.1577037617924;
 Sun, 22 Dec 2019 10:00:17 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkiyAkZy=oLrpJvHYU9Tq1dunNJLOJdtr508_w3vrdPWcQ@mail.gmail.com>
 <CALQRfL7i5r1d1K3fOuwyJ0BtmrsVMC8zzdd0Z7=14n3X8QNw5g@mail.gmail.com>
 <CAKgNAkjuFOumKV6Z+GDDEjLrVup7fJB_H86xguJ7asdUdfEBxQ@mail.gmail.com>
 <CALQRfL57VP_VHuHSzM9A65wxR6LjsH9+3wgeQ3qQEU0G9PuWHw@mail.gmail.com>
 <CAKgNAki++fQ3UtvA15g87YDPggbcinpJge-wf5nV76yrEqDgCA@mail.gmail.com>
 <CALQRfL4_kVKX=qJ0nDnEGgVeUHtQG5BDTCX72KfZr0toc-Mpuw@mail.gmail.com>
 <20191221030845.GA3626@mail.hallyn.com> <CALQRfL4O2CgkAdOxhsqN87MBDDaVhRaHBRVMu+hecQq-Fu8q-A@mail.gmail.com>
 <20191221043622.GA4580@mail.hallyn.com>
In-Reply-To: <20191221043622.GA4580@mail.hallyn.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Sun, 22 Dec 2019 10:00:06 -0800
Message-ID: <CALQRfL50+JUGcWk_NyyKvviCeNUPQdjjP=OGoewvH-mU6Pn2hQ@mail.gmail.com>
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

I can take a look, but I'm not really convinced this isn't going to
cause me grief at some point in the future when the kernel adds
support for another capability and all' does not equal all. I've done
some digging and I thought it was worth writing up.

Today, the kernel treats 'all' (as it is defined by libcap today)
differently for file and process capabilities. I suspect this is
contributing to expectations about what all means, because all as
defined today is effectively useless, and somewhere in the kernel
we've worked around it for filecaps when we shouldn't have.

Explanation of kernel bug (no use of 'all' here):

1) placing, say, bit-63 (undef today) and bit-0 (cap_chown) on the
permitted (fP) vector of a file, yields a file that can execute - it
gets pP=cap_chown.

cd libcap/progs ; make ; cp capsh pcapsh ; sudo setcap
63,cap_setpcap,cap_chown=p pcapsh

./pcapsh --print

2) dropping cap_chown from the bounding set causes this same file to
not run (insufficient privilege) because the file has been setup to
require cap_chown, but can't have it so (by design) we deny execution
altogether -- this fails:

./pcapsh --drop=cap_chown --print == --print

To be consistent, (1) should fail because bit-63 is being dropped by
the bounding set at execution time. That is, a binary that requires
some future definition for capability #63 to run successfully should
fail on a kernel that does not support it today.  This but was
introduced with this kernel commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/security/commoncap.c?id=7d8b6c63751cfbbe5eef81a48c22978b3407a3ad

Ironically, the commit message declares the fact that (4) now passes
is the fix. The real fix is to think about what we mean by 'all'.

Cheers

Andrew

On Fri, Dec 20, 2019 at 8:36 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> I think the thing to do is use /proc/sys/kernel/cap_last_cap (if it
> exists) to compare *caps to ~(cap_last_cap-1) and for each bit where
> it's the same, show the full set.  Been looking at the fn for a bit,
> and I might be comfortable enough to try it at this point.  But, if
> you want to do it (to make sure it's done right :), please let me know.
>
> -serge
>
> On Fri, Dec 20, 2019 at 07:27:46PM -0800, Andrew G. Morgan wrote:
> > /proc/1/status changed at some point to drop the undefined bits. When
> > it did I changed libcap to try harder to not display unnamed
> > capabilities.
> >
> > Cheers
> >
> > Andrew
> >
> >
> > On Fri, Dec 20, 2019 at 7:08 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > >
> > > I believe this is coming from the kernel.  I booted an old 12.04
> > > ubuntu server livecd (3.13 kernel) and libcap 2.22, it shows
> > > Capabilities for `1': =ep
> > > This was running
> > > libcap 2.22.  Same version of libcap compiled on my laptop gives me the
> > > long output.  booting an old 14.04 livecd, running 4.4 kernel,
> > > getpcap also gives the long output.
> > >
> > > On Mon, Dec 16, 2019 at 07:47:44PM -0800, Andrew G. Morgan wrote:
> > > > Serge might want to comment. I seem to recall that the issue was relevant
> > > > for Serge's namespaces and checkpointing/restarting over a kernel upgrade.
> > > > But it has been more than a decade and I can't seem to find the email
> > > > exchange we had back then.
> > > >
> > > > Cheers
> > > >
> > > > Andrew
> > > >
> > > >
> > > > On Sun, Dec 15, 2019 at 8:52 PM Michael Kerrisk (man-pages) <
> > > > mtk.manpages@gmail.com> wrote:
> > > >
> > > > > Hello Andrew,
> > > > >
> > > > > On 12/16/19 12:26 AM, Andrew G. Morgan wrote:
> > > > > > [Resend with reply-all this time.]
> > > > > >
> > > > > > On Sun, Dec 15, 2019 at 11:17 AM Michael Kerrisk (man-pages)
> > > > > > <mtk.manpages@gmail.com> wrote:
> > > > > >>
> > > > > >> Hello Andrew,
> > > > > >>
> > > > > >> On Sun, 15 Dec 2019 at 19:30, Andrew G. Morgan <morgan@kernel.org>
> > > > > wrote:
> > > > > >>>
> > > > > >>> This changed with this commit I think:
> > > > > >>>
> > > > > >>>
> > > > > https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=3fa808f5886d08c45866217cfe6e6e9def7de04e
> > > > > >>>
> > > > > >>> Prior to that, we had "=ep" mean the cap set was ~0 for
> > > > > >>> all the bitmasks in e and p. When we started to clip the
> > > > > >>> bounding set to only defined capabilities, it meant that the
> > > > > >>> text output started to look like
> > > > > >>> "=ep 33,34,35,36,37,38,39,40,41,42.....63-ep" which
> > > > > >>> was quite terrible.
> > > > > >>
> > > > > >> Was that really the change that caused this? That's a 2008 commit.
> > > > > >> Certainly, I recall in 2014 or 2015 still being able to see =ep, and I
> > > > > >> presume (but do not recall for sure) that I was using a system with a
> > > > > >> libcap more recent than v2.11 (of which that commit was a part).
> > > > > >
> > > > > > The only other commit that seems relevant was this one:
> > > > > >
> > > > > >
> > > > > https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=afb17b8c007a49d93b0d30936b2d65af1bfdb039
> > > > > >
> > > > > > But I think this was all part of the same effort.
> > > > > >
> > > > > >>> So, this was seen as the least worst option.
> > > > > >>
> > > > > >> But surely this is fixable? Or, to put it another was, I presume
> > > > > >> there's something that makes this difficult to fix in getpcaps, but
> > > > > >> what is that something?
> > > > > >
> > > > > > I recall spending a day or more trying to avoid it, but I can't see
> > > > > > how it is really fixable because there are too many moving parts.
> > > > > >
> > > > > > If the kernel adds another capability, then =ep could reasonably mean
> > > > > > both the "old full set" or the "new full set". There are contexts
> > > > > > where the difference matters. For example, where folk are using text
> > > > > > representations for things like package manager shell-script setups.
> > > > > > What they get when they say "=ep
> > > > > > cap_setpcap,cap_sys_admin,cap_setfcap-ep" today, might suddenly be
> > > > > > inappropriate when the new kernel adds "cap_self_destruct". At least
> > > > > > the way it is at present, we are very explicit about what is in
> > > > > > effect
> > > > >
> > > > > I can sort of see how the idea you are expressing might
> > > > > apply when *setting* capabilities on *files*, but:
> > > > >
> > > > > a) I'm talking about the *display* of capabilities of a running
> > > > > *process* using getpcaps(8).
> > > > >
> > > > > b) In practice, the logic that actually applies when setting
> > > > > capabilities on files seems to run *counter* to the idea
> > > > > that you express above (if I understand you correctly),
> > > > > and your argument seems more relevant to files (especially
> > > > > when *setting* file capabilities) than to processes.
> > > > >
> > > > > Consider the following examples:
> > > > >
> > > > > 1. A binary that has all but one capability is described in a
> > > > > compact way by getcap(8):
> > > > >
> > > > >         $ sudo setcap "=p cap_kill-p" mypog
> > > > >         $ getcap mypog
> > > > >         mypog =p cap_kill-p
> > > > >
> > > > > When that same binary is run, the process's capabilities
> > > > > are described with a very different format by getpcaps(8)
> > > > >
> > > > >         $ getpcaps $(pidof i_syscall)
> > > > >         Capabilities for `152006': =
> > > > >         cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,
> > > > >         cap_fsetid,cap_setgid,cap_setuid,cap_setpcap,
> > > > >         cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,
> > > > >         cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,
> > > > >         cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,
> > > > >         cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,
> > > > >         cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,
> > > > >         cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,
> > > > >         cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,
> > > > >         cap_block_suspend,cap_audit_read+p
> > > > >
> > > > > That is quite inconsistent! And also, the second notation is
> > > > > simply very hard to read. How many capabilities are listed there?
> > > > > Is it all of them? (When a process does have all caps in permitted,
> > > > > the display differs only by one item.) A security-related notation
> > > > > that is difficult to read is a risk... [*]
> > > > >
> > > > > 2. I just now tried the following, and it really surprised me
> > > > > (although the reasons are quickly obvious when one considers
> > > > > the point I made earlier in this mail thread that 'setcap =p' is
> > > > > setting *64* bits in the file's permittted set):
> > > > >
> > > > >         # Set "all" permitted capabilities on a file:
> > > > >
> > > > >         $ sudo setcap =p myprog
> > > > >         $ getcap myprog
> > > > >         myprog =p
> > > > >
> > > > >         # Set "all" 38 permitted capabilities on a file, by specifying
> > > > >         # them individually:
> > > > >
> > > > >         $ sudo setcap 0$(for c in $(seq 1 37); do \
> > > > >         echo -n ",$c"; done)=p myprog
> > > > >         $ getcap myprog
> > > > >         cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,
> > > > >         cap_fsetid,cap_setgid,cap_setuid,cap_setpcap,
> > > > >         cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,
> > > > >         cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_kill,
> > > > >         cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,
> > > > >         cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,
> > > > >         cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,
> > > > >         cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,
> > > > >         cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,
> > > > >         cap_block_suspend,cap_audit_read+p
> > > > >
> > > > > I think there would be few users who would *not* be surprised
> > > > > about the fact that two steps that seem equivalent produce
> > > > > quite differnt output from getcap(8)!
> > > > >
> > > > > 3. Suppose I set all permitted capabilities on a binary:
> > > > >
> > > > >         $ sudo setcap =p myprog
> > > > >
> > > > > Then actually, I have set not just the 38 existing capabilities,
> > > > > but also 26 future capabilities, so that when "cap_self_destruct"
> > > > > is added to the kernel, 'myprog' already has it. This seems to
> > > > > run directly counter to your argument above (if I have understood
> > > > > it correctly).
> > > > >
> > > > > My summary from the above:
> > > > >
> > > > > * The output notation from getpcaps(8) is (1) inconsistent (with
> > > > > getcap(8)), and (2) difficult to read, two things that strike me
> > > > > as risk factors in a security-related notation.
> > > > >
> > > > > * The fact that "setcap =p ..." sets the top 26 (currently unused)
> > > > > bits in the permitted set is surprising, and perhaps also a
> > > > > security risk when new capabilities are actually added to the
> > > > > kernel, since existing binaries will automatically have those
> > > > > capabilities.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Michael
> > > > >
> > > > > [*] I often joke that the cap_to_text(3) notation is one that is
> > > > > "human-readable, but not necessarily human-comprehensible", but
> > > > > at the same time I also note that the notation has one virtue:
> > > > > it is compact. However, that one virtue seems to have gone out
> > > > > the window for getpcaps(8).
> > > > >
> > > > > --
> > > > > Michael Kerrisk
> > > > > Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> > > > > Linux/UNIX System Programming Training: http://man7.org/training/
> > > > >
