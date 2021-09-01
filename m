Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE53C432BE
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Sep 2021 16:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1F161057
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Sep 2021 16:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbhIAQ36 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245215AbhIAQ35 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Sep 2021 12:29:57 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA8C061575
        for <linux-security-module@vger.kernel.org>; Wed,  1 Sep 2021 09:29:00 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4H08dP5cbkzMqtqB;
        Wed,  1 Sep 2021 18:28:57 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4H08dP2QBMzlhH3V;
        Wed,  1 Sep 2021 18:28:57 +0200 (CEST)
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Landlock news #1
To:     landlock@lists.linux.dev
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
Message-ID: <2df4887a-1710-bba2-f49c-cd5b785bb565@digikod.net>
Date:   Wed, 1 Sep 2021 18:30:09 +0200
User-Agent: 
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

Landlock landed in Linux 5.13 and here is an overview of the ongoing
developments.

User space
----------

### Rust library

This Rust library enables to manage Landlock in a best-effort way. It is
still a work-in-progress, but we plan to release a new major version in
the coming weeks, including documentation. Feedback is welcome!
https://github.com/landlock-lsm/rust-landlock

### Go library

We are pleased to welcome Günther Noack and his Go library which enables
to create sandboxes with Landlock. This will be useful for any projects
developed in Go.
https://github.com/landlock-lsm/go-landlock

### Open Container Initiative Runtime Specification

This project is intended to be a shared specification amongst container
runtimes (e.g. Docker/runc). Thanks to H. Vetinari for bringing the
subject and to Kailun Qin, Günther Noack, Konstantin Meskhidze, Aleksa
Sarai, Akihiro Suda for working on this and giving feedback!
https://github.com/opencontainers/runtime-spec/pull/1111

### runc

Bringing Landlock support to runc has started.
https://github.com/opencontainers/runc/pull/3194

### strace

strace 5.13 (2021-07-19) now supports Landlock syscalls and especially
their argument decoding. We can now easily debug programs using
Landlock. Thanks to Eugene Syromyatnikov and Dmitry V. Levin!
https://github.com/strace/strace/commit/7592a0eeab2588162c1741077053f8a052c8418f

### glibc

glibc 2.34 (2021-08-01) now includes Landlock system call IDs, which are
required to properly use Landlock in C and C++ programs.
https://sourceware.org/git/?p=glibc.git;a=commit;h=b1b4f7209ecaad4bf9a5d0d2ef1338409d364bac

### musl libc

A patch series is under review for musl libc to include Landlock system
call IDs in this alternative libc.
https://www.openwall.com/lists/musl/2021/07/10/12

### Man Pages

Four manual pages dedicated to Landlock are being reviewed by Alejandro
Colomar and G. Branden Robinson. Thanks to them! This documentation is
splitted into a general overview landlock(7) and one page per syscall.
https://lore.kernel.org/linux-man/20210818155931.484070-1-mic@digikod.net/

Conferences
-----------

I'm glad that two (complementary) Landlock talks have been accepted to
the Open Source Summit and to the Linux Security Summit. I have given a
few talks in the last years but Landlock has changed drastically since
then (i.e. no more eBPF). These talks will unfortunately be virtual, but
I'll still be available for questions. See you at the end of the month!

### Open Source Summit 2021 - Sandboxing Applications with Landlock

This talk focuses on the use of Landlock by user space, explaining the
rationale behind the design, how backward and forward compatibility is
handled, what features are currently available and what could come next.
https://sched.co/lAVl

### Linux Security Summit 2021 - Deep Dive into Landlock Internals

This talk first explains the goal of Landlock and the related
consequences. This will enable to explain the kernel implementation
constraints, the choices that led to the current design, and the
potential and limits of the current and future features.
https://sched.co/ljRQ

Roadmap (kernel-side)
---------------------

Last but not least, here is an overview of the roadmap for Landlock.
We'll add a proper dedicated page to the website soon: https://landlock.io

Short term:
* improve kernel performance for the current features;
* add the ability to change the parent directory of files (see current
Landlock limitations).

Medium term:
* add audit features to ease debugging;
* extend filesystem access-control types to address the current limitations;
* add the ability to follow a deny listing approach, which is required
for some use cases.

Long term:
* add minimal network access-control types;
* add the ability to create (file descriptor) capabilities compatible
with Capsicum.

Regards,
 Mickaël
