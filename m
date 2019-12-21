Return-Path: <SRS0=UJ12=2L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722B5C43603
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Dec 2019 03:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28091206DA
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Dec 2019 03:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576898880;
	bh=5ep+IWLto/7cM8t3TxziEHAFu/52ix71J0bKxx4ev7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iLkxo6FVUNT2xLh65fvzJjmwCZaqTnt3yDi87ktpZ04N1DpLD0yoLOVOqZN6/2rbf
	 tK/NRdxMUdnTKZFmFPIc2k/9rCOSZNKhMlYdxWR4jzLXAjX7X3Lxu69dReBgeldb5L
	 FZUuJxNTEXYETmDGd8pivloordexSzvr38nR/BmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLUD17 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Dec 2019 22:27:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45227 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfLUD17 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Dec 2019 22:27:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so9285640qkl.12
        for <linux-security-module@vger.kernel.org>; Fri, 20 Dec 2019 19:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gghB9hh1U655otBFDgmpAs/yaii3eMy+Q6d1bsOTtT0=;
        b=Q3J/xmF3qqHhKIzFVwx1bTPVe8C2Bg8m+KyMlihFzl2Q3Yl/vfFuC9BdiT2w9hhpXM
         yrLi3M4nEiBSoUacDrazWPydgolRFB+LGLoh6M8/IqmRLFIE/q8HikO207IAB7H0esrb
         5J/ZAbqaCRq9GfZA8WacIvPfBIqGtgk0daGflPgohV1qJNgtwGnFly4g6EGdUOaL5Tlb
         NSTIbJwBwWQZpeAf/Ysrvav0nJbBB9Wjkt7uRKfp1Z9BQ+7vtWq/mFIU2YEN1yrUg8+G
         zftL/TO/Oq8Joz3YS1De1ynSDO+BmPgBqOfItKbiGuJqPT+VUiEfNvZjJmIownT5nKU9
         uMIw==
X-Gm-Message-State: APjAAAXgassQTUMCwGxZJpxbfuD0iJkwlJBod1AHFeOhELvohsYNF79g
        mpepdB2Dd6mT5Q1SKRIj2nBWmqoNMa2fh8EJUWz0PA==
X-Google-Smtp-Source: APXvYqxe0GXIBHZQLS9PeSPmtVFvHK18YjHKNWJJgO0fLXOky8K/Odr28OfOKlPdlsh+2J1tWDNUqNZFjy9VMRsIxEA=
X-Received: by 2002:a05:620a:1401:: with SMTP id d1mr14760820qkj.79.1576898877835;
 Fri, 20 Dec 2019 19:27:57 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkiyAkZy=oLrpJvHYU9Tq1dunNJLOJdtr508_w3vrdPWcQ@mail.gmail.com>
 <CALQRfL7i5r1d1K3fOuwyJ0BtmrsVMC8zzdd0Z7=14n3X8QNw5g@mail.gmail.com>
 <CAKgNAkjuFOumKV6Z+GDDEjLrVup7fJB_H86xguJ7asdUdfEBxQ@mail.gmail.com>
 <CALQRfL57VP_VHuHSzM9A65wxR6LjsH9+3wgeQ3qQEU0G9PuWHw@mail.gmail.com>
 <CAKgNAki++fQ3UtvA15g87YDPggbcinpJge-wf5nV76yrEqDgCA@mail.gmail.com>
 <CALQRfL4_kVKX=qJ0nDnEGgVeUHtQG5BDTCX72KfZr0toc-Mpuw@mail.gmail.com> <20191221030845.GA3626@mail.hallyn.com>
In-Reply-To: <20191221030845.GA3626@mail.hallyn.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Fri, 20 Dec 2019 19:27:46 -0800
Message-ID: <CALQRfL4O2CgkAdOxhsqN87MBDDaVhRaHBRVMu+hecQq-Fu8q-A@mail.gmail.com>
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

/proc/1/status changed at some point to drop the undefined bits. When
it did I changed libcap to try harder to not display unnamed
capabilities.

Cheers

Andrew


On Fri, Dec 20, 2019 at 7:08 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> I believe this is coming from the kernel.  I booted an old 12.04
> ubuntu server livecd (3.13 kernel) and libcap 2.22, it shows
> Capabilities for `1': =ep
> This was running
> libcap 2.22.  Same version of libcap compiled on my laptop gives me the
> long output.  booting an old 14.04 livecd, running 4.4 kernel,
> getpcap also gives the long output.
>
> On Mon, Dec 16, 2019 at 07:47:44PM -0800, Andrew G. Morgan wrote:
> > Serge might want to comment. I seem to recall that the issue was relevant
> > for Serge's namespaces and checkpointing/restarting over a kernel upgrade.
> > But it has been more than a decade and I can't seem to find the email
> > exchange we had back then.
> >
> > Cheers
> >
> > Andrew
> >
> >
> > On Sun, Dec 15, 2019 at 8:52 PM Michael Kerrisk (man-pages) <
> > mtk.manpages@gmail.com> wrote:
> >
> > > Hello Andrew,
> > >
> > > On 12/16/19 12:26 AM, Andrew G. Morgan wrote:
> > > > [Resend with reply-all this time.]
> > > >
> > > > On Sun, Dec 15, 2019 at 11:17 AM Michael Kerrisk (man-pages)
> > > > <mtk.manpages@gmail.com> wrote:
> > > >>
> > > >> Hello Andrew,
> > > >>
> > > >> On Sun, 15 Dec 2019 at 19:30, Andrew G. Morgan <morgan@kernel.org>
> > > wrote:
> > > >>>
> > > >>> This changed with this commit I think:
> > > >>>
> > > >>>
> > > https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=3fa808f5886d08c45866217cfe6e6e9def7de04e
> > > >>>
> > > >>> Prior to that, we had "=ep" mean the cap set was ~0 for
> > > >>> all the bitmasks in e and p. When we started to clip the
> > > >>> bounding set to only defined capabilities, it meant that the
> > > >>> text output started to look like
> > > >>> "=ep 33,34,35,36,37,38,39,40,41,42.....63-ep" which
> > > >>> was quite terrible.
> > > >>
> > > >> Was that really the change that caused this? That's a 2008 commit.
> > > >> Certainly, I recall in 2014 or 2015 still being able to see =ep, and I
> > > >> presume (but do not recall for sure) that I was using a system with a
> > > >> libcap more recent than v2.11 (of which that commit was a part).
> > > >
> > > > The only other commit that seems relevant was this one:
> > > >
> > > >
> > > https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=afb17b8c007a49d93b0d30936b2d65af1bfdb039
> > > >
> > > > But I think this was all part of the same effort.
> > > >
> > > >>> So, this was seen as the least worst option.
> > > >>
> > > >> But surely this is fixable? Or, to put it another was, I presume
> > > >> there's something that makes this difficult to fix in getpcaps, but
> > > >> what is that something?
> > > >
> > > > I recall spending a day or more trying to avoid it, but I can't see
> > > > how it is really fixable because there are too many moving parts.
> > > >
> > > > If the kernel adds another capability, then =ep could reasonably mean
> > > > both the "old full set" or the "new full set". There are contexts
> > > > where the difference matters. For example, where folk are using text
> > > > representations for things like package manager shell-script setups.
> > > > What they get when they say "=ep
> > > > cap_setpcap,cap_sys_admin,cap_setfcap-ep" today, might suddenly be
> > > > inappropriate when the new kernel adds "cap_self_destruct". At least
> > > > the way it is at present, we are very explicit about what is in
> > > > effect
> > >
> > > I can sort of see how the idea you are expressing might
> > > apply when *setting* capabilities on *files*, but:
> > >
> > > a) I'm talking about the *display* of capabilities of a running
> > > *process* using getpcaps(8).
> > >
> > > b) In practice, the logic that actually applies when setting
> > > capabilities on files seems to run *counter* to the idea
> > > that you express above (if I understand you correctly),
> > > and your argument seems more relevant to files (especially
> > > when *setting* file capabilities) than to processes.
> > >
> > > Consider the following examples:
> > >
> > > 1. A binary that has all but one capability is described in a
> > > compact way by getcap(8):
> > >
> > >         $ sudo setcap "=p cap_kill-p" mypog
> > >         $ getcap mypog
> > >         mypog =p cap_kill-p
> > >
> > > When that same binary is run, the process's capabilities
> > > are described with a very different format by getpcaps(8)
> > >
> > >         $ getpcaps $(pidof i_syscall)
> > >         Capabilities for `152006': =
> > >         cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,
> > >         cap_fsetid,cap_setgid,cap_setuid,cap_setpcap,
> > >         cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,
> > >         cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,
> > >         cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,
> > >         cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,
> > >         cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,
> > >         cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,
> > >         cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,
> > >         cap_block_suspend,cap_audit_read+p
> > >
> > > That is quite inconsistent! And also, the second notation is
> > > simply very hard to read. How many capabilities are listed there?
> > > Is it all of them? (When a process does have all caps in permitted,
> > > the display differs only by one item.) A security-related notation
> > > that is difficult to read is a risk... [*]
> > >
> > > 2. I just now tried the following, and it really surprised me
> > > (although the reasons are quickly obvious when one considers
> > > the point I made earlier in this mail thread that 'setcap =p' is
> > > setting *64* bits in the file's permittted set):
> > >
> > >         # Set "all" permitted capabilities on a file:
> > >
> > >         $ sudo setcap =p myprog
> > >         $ getcap myprog
> > >         myprog =p
> > >
> > >         # Set "all" 38 permitted capabilities on a file, by specifying
> > >         # them individually:
> > >
> > >         $ sudo setcap 0$(for c in $(seq 1 37); do \
> > >         echo -n ",$c"; done)=p myprog
> > >         $ getcap myprog
> > >         cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,
> > >         cap_fsetid,cap_setgid,cap_setuid,cap_setpcap,
> > >         cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,
> > >         cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_kill,
> > >         cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,
> > >         cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,
> > >         cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,
> > >         cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,
> > >         cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,
> > >         cap_block_suspend,cap_audit_read+p
> > >
> > > I think there would be few users who would *not* be surprised
> > > about the fact that two steps that seem equivalent produce
> > > quite differnt output from getcap(8)!
> > >
> > > 3. Suppose I set all permitted capabilities on a binary:
> > >
> > >         $ sudo setcap =p myprog
> > >
> > > Then actually, I have set not just the 38 existing capabilities,
> > > but also 26 future capabilities, so that when "cap_self_destruct"
> > > is added to the kernel, 'myprog' already has it. This seems to
> > > run directly counter to your argument above (if I have understood
> > > it correctly).
> > >
> > > My summary from the above:
> > >
> > > * The output notation from getpcaps(8) is (1) inconsistent (with
> > > getcap(8)), and (2) difficult to read, two things that strike me
> > > as risk factors in a security-related notation.
> > >
> > > * The fact that "setcap =p ..." sets the top 26 (currently unused)
> > > bits in the permitted set is surprising, and perhaps also a
> > > security risk when new capabilities are actually added to the
> > > kernel, since existing binaries will automatically have those
> > > capabilities.
> > >
> > > Thanks,
> > >
> > > Michael
> > >
> > > [*] I often joke that the cap_to_text(3) notation is one that is
> > > "human-readable, but not necessarily human-comprehensible", but
> > > at the same time I also note that the notation has one virtue:
> > > it is compact. However, that one virtue seems to have gone out
> > > the window for getpcaps(8).
> > >
> > > --
> > > Michael Kerrisk
> > > Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> > > Linux/UNIX System Programming Training: http://man7.org/training/
> > >
