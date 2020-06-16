Return-Path: <SRS0=f9XP=75=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6123CC433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 07:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C08320663
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 07:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ezoce9rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFPHuI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgFPHtt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 03:49:49 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036CDC03E96A
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 00:49:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so1812955pgk.4
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SckuiE/B7lu+6jQS16TWP9mI8faQuosMWgoWexlj1hQ=;
        b=Ezoce9rOyDbyfb2m0aOrEEf25Ar+VgtfGVGX7Wb43LprRiiKs8JpB/E1A8WjnNBYVM
         4B/2J1SbeOl4KRTIVJGuoIJrcfaelSeF1ydg45cZRS2zNkqfDndwR9ABRkm6uBr1dsE/
         zx03AhgjZ//VcaKbc8oBMMuTMxxXHOHe46e3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SckuiE/B7lu+6jQS16TWP9mI8faQuosMWgoWexlj1hQ=;
        b=jF1+tOlm9isBCSxxuhOkRDCESpA+vxV4MSC8inyHq9+vKKekwvM2ge7YCGWVOdnEXK
         wqSa+gB4IBOzRev70RHyDEwpRzaYlHppLURyVuGwB+1yoTn8fiwBb04Fre/0qwq2bHHI
         UjQp8C3FO/pKlzvg5U74KJ33SmF/zAn5hDDS/LtGYUghH1/5pqu/yuva2zTXrL2phQet
         kXxowTGw1LhYCU6YUxa/v4P6CkqkNIIhP6yDUFAvi8A0IV5B4/GsjtU6KbOsLRf4FyY/
         sgB5a4RKbBze7KjfFk2oIINM/LurDR2EGvfq/sPB2+llsi4LHTuwzynHA3JtgKiwp5ea
         Wkpg==
X-Gm-Message-State: AOAM533WXSh4/IRudhcmuGGK0RBU+hOtcg8FZs5adQhJut5ml3nDo2/e
        LpCqaJjUlNQQAeoUQ8EyXap9QA==
X-Google-Smtp-Source: ABdhPJxlBlHeeNWH2iV7QDmG8pcWwANr2ZY0ns37yCawd/LXFvUhug3zZethxpMjrE7ictMsq4oubQ==
X-Received: by 2002:aa7:8490:: with SMTP id u16mr943050pfn.259.1592293784291;
        Tue, 16 Jun 2020 00:49:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s36sm13764762pgl.35.2020.06.16.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:49:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: [RFC][PATCH 0/8] seccomp: Implement constant action bitmaps
Date:   Tue, 16 Jun 2020 00:49:26 -0700
Message-Id: <20200616074934.1600036-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

This is my initial stab at making constant-time seccomp bitmaps that
are automatically generated from filters as they are added. This version
is x86 only (and not x86_x32), but it should be easy to expand this to
other architectures. I'd like to get arm64 working, but it has some
NR_syscalls shenanigans I haven't sorted out yet.

The first two patches are small clean-ups that I intend to land in
for-next/seccomp unless there are objections. Patch 3 is another
experimental feature to perform architecture-pinning. Patch 4 is the
bulk of the bitmap code. Patch 5 is benchmark updates. Patches 6 and
7 perform the x86 enablement. Patch 8 is just a debugging example,
in case anyone wants to play with this and would find it helpful.

Repeating the commit log from patch 4:


One of the most common pain points with seccomp filters has been dealing
with the overhead of processing the filters, especially for "always allow"
or "always reject" cases. While BPF is extremely fast[1], it will always
have overhead associated with it. Additionally, due to seccomp's design,
filters are layered, which means processing time goes up as the number
of filters attached goes up.

In the past, efforts have been focused on making filter execution complete
in a shorter amount of time. For example, filters were rewritten from
using linear if/then/else syscall search to using balanced binary trees,
or moving tests for syscalls common to the process's workload to the
front of the filter. However, there are limits to this, especially when
some processes are dealing with tens of filters[2], or when some
architectures have a less efficient BPF engine[3].

The most common use of seccomp, constructing syscall block/allow-lists,
where syscalls that are always allowed or always rejected (without regard
to any arguments), also tends to produce the most pathological runtime
problems, in that a large number of syscall checks in the filter need
to be performed to come to a determination.

In order to optimize these cases from O(n) to O(1), seccomp can
use bitmaps to immediately determine the desired action. A critical
observation in the prior paragraph bears repeating: the common case for
syscall tests do not check arguments. For any given filter, there is a
constant mapping from the combination of architecture and syscall to the
seccomp action result. (For kernels/architectures without CONFIG_COMPAT,
there is a single architecture.). As such, it is possible to construct
a mapping of arch/syscall to action, which can be updated as new filters
are attached to a process.

In order to build this mapping at filter attach time, each filter is
executed for every syscall (under each possible architecture), and
checked for any accesses of struct seccomp_data that are not the "arch"
nor "nr" (syscall) members. If only "arch" and "nr" are examined, then
there is a constant mapping for that syscall, and bitmaps can be updated
accordingly. If any accesses happen outside of those struct members,
seccomp must not bypass filter execution for that syscall, since program
state will be used to determine filter action result.

During syscall action probing, in order to determine whether other members
of struct seccomp_data are being accessed during a filter execution,
the struct is placed across a page boundary with the "arch" and "nr"
members in the first page, and everything else in the second page. The
"page accessed" flag is cleared in the second page's PTE, and the filter
is run. If the "page accessed" flag appears as set after running the
filter, we can determine that the filter looked beyond the "arch" and
"nr" members, and exclude that syscall from the constant action bitmaps.

For architectures to support this optimization, they must declare
their architectures for seccomp to see (via SECCOMP_ARCH and
SECCOMP_ARCH_COMPAT macros), and provide a way to perform efficient
CPU-local kernel TLB flushes (via local_flush_tlb_kernel_range()),
and then set HAVE_ARCH_SECCOMP_BITMAP in their Kconfig.

Areas needing more attention:

On x86, this currently adds 168 bytes (or 336 bytes under CONFIG_COMPAT)
to the size of task_struct. Allocating these on demand may be a better
use of memory, but may not result in good cache locality.

For architectures with "synthetic" architectures, like x86_x32,
additional work is needed. It should be possible to define a simple
mechanism based on the masking done in the x86 syscall entry path to
create another set of bitmaps for seccomp to key off of. I am, however,
considering just leaving HAVE_ARCH_SECCOMP_BITMAP depend on !X86_X32.

[1] https://lore.kernel.org/bpf/20200531171915.wsxvdjeetmhpsdv2@ast-mbp.dhcp.thefacebook.com/
[2] https://lore.kernel.org/bpf/20200601101137.GA121847@gardel-login/
[3] https://lore.kernel.org/bpf/717a06e7f35740ccb4c70470ec70fb2f@huawei.com/



Thanks!

-Kees

Kees Cook (8):
  selftests/seccomp: Improve calibration loop
  seccomp: Use pr_fmt
  seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
  seccomp: Implement constant action bitmaps
  selftests/seccomp: Compare bitmap vs filter overhead
  x86: Provide API for local kernel TLB flushing
  x86: Enable seccomp constant action bitmaps
  [DEBUG] seccomp: Report bitmap coverage ranges

 arch/Kconfig                                  |   7 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/syscall.h                |   5 +
 arch/x86/include/asm/tlbflush.h               |   2 +
 arch/x86/mm/tlb.c                             |  12 +-
 include/linux/seccomp.h                       |  18 +
 include/uapi/linux/seccomp.h                  |   1 +
 kernel/seccomp.c                              | 374 +++++++++++++++++-
 .../selftests/seccomp/seccomp_benchmark.c     | 197 +++++++--
 tools/testing/selftests/seccomp/settings      |   2 +-
 10 files changed, 571 insertions(+), 48 deletions(-)

-- 
2.25.1

