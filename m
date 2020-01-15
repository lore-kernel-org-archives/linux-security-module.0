Return-Path: <SRS0=2BO2=3E=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A74C32771
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C827924679
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bKrzOieP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAORNX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:13:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53567 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgAORNW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so754789wmc.3
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2020 09:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgruBRVWMITWgLk+xz9+UOcRsixuUiF7IKyFn83Fu2s=;
        b=bKrzOieP3Js7dZmklXn1FbwVZxZpRYxxjQBNgiaa8KMMtvJuxRX/Y8KWvXU0uxKVpT
         Ix79NlhaWOaac5XVbKg43JWviDN6nO0rtsiGpnTXlU/Q/3hqHQ8ynIzsAyxPM2vJl4OG
         XzplrdtyAslivP1PoYRpgBe1kqHEsXFVXkJnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgruBRVWMITWgLk+xz9+UOcRsixuUiF7IKyFn83Fu2s=;
        b=hgb+zQR6NY7UP+/LmrwUyr1Rteq4WU/9pOFVm/HC9vtLvYqbpTr6TWTyJeFae6UwpJ
         99H2rKjhKnzinjA1q3Q2Rl6qtjq7Xd6X5tALepXQ1nc4u0TMNlsJocZyb+F4VnGHDIOC
         mN8CZfl8zgJfIE7t/D4fnHOSo+FA48uqdU5cwLw2pjvk63AcJgFCQguv225IV7qBct7/
         JeYMvlV0Ew42G+vWU0oc1lo5W4j7guTnLhIqyRQdmbgq2EHBR9qYknfJ+6XkyCScX6Ys
         sifK6X0FauTpPk6nxBXGxSOFzOaSbebauEr0OfJ1bSVUuEE01M0IvhyNxhISwwByi1jU
         +5nQ==
X-Gm-Message-State: APjAAAVLLS4Y0jCFRpWyOyw89dvQ1+mrf5SLEhzDw1Pb9XtStLBv7atn
        Cicm+qGzA7uRq87rMYeQRtVIig==
X-Google-Smtp-Source: APXvYqzCProobzuSHyUYJtZM7z91ce8rWH/7n92IE/1vI+aJVzH6grz2BHMMEwTreU2e5lqFrOyOCg==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr940952wma.5.1579108400241;
        Wed, 15 Jan 2020 09:13:20 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:19 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v2 00/10] MAC and Audit policy using eBPF (KRSI)
Date:   Wed, 15 Jan 2020 18:13:23 +0100
Message-Id: <20200115171333.28811-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

# Changes since v1 (https://lore.kernel.org/bpf/20191220154208.15895-1-kpsingh@chromium.org/):

* Eliminate the requirement to maintain LSM hooks separately in
  security/bpf/hooks.h Use BPF trampolines to dynamically allocate
  security hooks
* Drop the use of securityfs as bpftool provides the required
  introspection capabilities.  Update the tests to use the bpf_skeleton
  and global variables
* Use O_CLOEXEC anonymous fds to represent BPF attachment in line with
  the other BPF programs with the possibility to use bpf program pinning
  in the future to provide "permanent attachment".
* Drop the logic based on prog names for handling re-attachment.
* Drop bpf_lsm_event_output from this series and send it as a separate
  patch.

# Motivation

Google does analysis of rich runtime security data to detect and thwart
threats in real-time. Currently, this is done in custom kernel modules
but we would like to replace this with something that's upstream and
useful to others.

The current kernel infrastructure for providing telemetry (Audit, Perf
etc.) is disjoint from access enforcement (i.e. LSMs).  Augmenting the
information provided by audit requires kernel changes to audit, its
policy language and user-space components. Furthermore, building a MAC
policy based on the newly added telemetry data requires changes to
various LSMs and their respective policy languages.

This patchset proposes a new stackable and privileged LSM which allows
the LSM hooks to be implemented using eBPF. This facilitates a unified
and dynamic (not requiring re-compilation of the kernel) audit and MAC
policy.

# Why an LSM?

Linux Security Modules target security behaviours rather than the
kernel's API. For example, it's easy to miss out a newly added system
call for executing processes (eg. execve, execveat etc.) but the LSM
framework ensures that all process executions trigger the relevant hooks
irrespective of how the process was executed.

Allowing users to implement LSM hooks at runtime also benefits the LSM
eco-system by enabling a quick feedback loop from the security community
about the kind of behaviours that the LSM Framework should be targeting.

# How does it work?

The LSM introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
program type BPF_PROG_TYPE_LSM which can only be attached to LSM hooks.
Attachment requires CAP_SYS_ADMIN for loading eBPF programs and
CAP_MAC_ADMIN for modifying MAC policies.

The eBPF programs are attached to a separate security_hook_heads
maintained by the BPF LSM for mutable hooks and executed after all the
statically defined hooks (i.e. the ones declared by SELinux, AppArmor,
Smack etc). This also ensures that statically defined LSM hooks retain
the behaviour of "being read-only after init", i.e. __lsm_ro_after_init.

Upon attachment, a security hook is dynamically allocated with
arch_bpf_prepare_trampoline which generates code to handle the
conversion from the signature of the hook to the BPF context and allows
the JIT'ed BPF program to be called as a C function with the same
arguments as the LSM hooks. If any of the attached eBPF programs returns
an error (like ENOPERM), the behaviour represented by the hook is
denied.

Audit logs can be written using a format chosen by the eBPF program to
the perf events buffer or to global eBPF variables or maps and can be
further processed in user-space.

# BTF Based Design

The current design uses BTF
(https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html,
https://lwn.net/Articles/803258/) which allows verifiable read-only
structure accesses by field names rather than fixed offsets. This allows
accessing the hook parameters using a dynamically created context which
provides a certain degree of ABI stability:


// Only declare the structure and fields intended to be used
// in the program
struct vm_area_struct {
	unsigned long vm_start;
} __attribute__((preserve_access_index));

// Declare the eBPF program mprotect_audit which attaches to
// to the file_mprotect LSM hook and accepts three arguments.
SEC("lsm/file_mprotect")
int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
	     unsigned long reqprot, unsigned long prot)
{
	unsigned long vm_start = vma->vm_start;

	return 0;
}

By relocating field offsets, BTF makes a large portion of kernel data
structures readily accessible across kernel versions without requiring a
large corpus of BPF helper functions and requiring recompilation with
every kernel version. The BTF type information is also used by the BPF
verifier to validate memory accesses within the BPF program and also
prevents arbitrary writes to the kernel memory.

The limitations of BTF compatibility are described in BPF Co-Re
(http://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf, i.e. field
renames, #defines and changes to the signature of LSM hooks).

This design imposes that the MAC policy (eBPF programs) be updated when
the inspected kernel structures change outside of BTF compatibility
guarantees. In practice, this is only required when a structure field
used by a current policy is removed (or renamed) or when the used LSM
hooks change. We expect the maintenance cost of these changes to be
acceptable as compared to the previous design
(https://lore.kernel.org/bpf/20190910115527.5235-1-kpsingh@chromium.org/).

# Why not tracepoints or kprobes?

In order to do MAC with tracepoints or kprobes, we would need to
override the return value of the security hook. This is not possible
with tracepoints or call-site kprobes.

Attaching to the return boundary (kretprobe) implies that BPF programs
would always get called after all the other LSM hooks are called and
clobber the pre-existing LSM semantics.

Enforcing MAC policy with an actual LSM helps leverage the verified
semantics of the framework.

# Usage Examples

A simple example and some documentation is included in the patchset.

In order to better illustrate the capabilities of the framework some
more advanced prototype (not-ready for review) code has also been
published separately:

* Logging execution events (including environment variables and
  arguments)
https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
* Detecting deletion of running executables:
https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c
* Detection of writes to /proc/<pid>/mem:

https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c

We have updated Google's internal telemetry infrastructure and have
started deploying this LSM on our Linux Workstations. This gives us more
confidence in the real-world applications of such a system.

KP Singh (10):
  bpf: btf: Make some of the API visible outside BTF
  bpf: lsm: Add a skeleton and config options
  bpf: lsm: Introduce types for eBPF based LSM
  bpf: lsm: Add mutable hooks list for the BPF LSM
  bpf: lsm: BTF API for LSM hooks
  bpf: lsm: Implement attach, detach and execution
  bpf: lsm: Make the allocated callback RO+X
  tools/libbpf: Add support for BPF_PROG_TYPE_LSM
  bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
  bpf: lsm: Add Documentation

 Documentation/security/bpf.rst                | 150 ++++++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |  11 +
 include/linux/bpf.h                           |   4 +
 include/linux/bpf_lsm.h                       |  98 +++++
 include/linux/bpf_types.h                     |   4 +
 include/linux/btf.h                           |   8 +
 include/uapi/linux/bpf.h                      |   6 +
 kernel/bpf/btf.c                              |  17 +
 kernel/bpf/syscall.c                          |  51 ++-
 kernel/bpf/verifier.c                         |  74 +++-
 security/Kconfig                              |  11 +-
 security/Makefile                             |   2 +
 security/bpf/Kconfig                          |  25 ++
 security/bpf/Makefile                         |   7 +
 security/bpf/hooks.c                          | 337 ++++++++++++++++++
 security/bpf/include/bpf_lsm.h                |  75 ++++
 security/bpf/lsm.c                            |  92 +++++
 security/bpf/ops.c                            |  30 ++
 security/security.c                           |  24 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 tools/lib/bpf/bpf.c                           |   6 +-
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/libbpf.c                        | 143 +++++++-
 tools/lib/bpf/libbpf.h                        |   4 +
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/bpf/lsm_helpers.h     |  19 +
 .../bpf/prog_tests/lsm_mprotect_audit.c       |  58 +++
 .../selftests/bpf/progs/lsm_mprotect_audit.c  |  48 +++
 30 files changed, 1271 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/security/bpf.rst
 create mode 100644 include/linux/bpf_lsm.h
 create mode 100644 security/bpf/Kconfig
 create mode 100644 security/bpf/Makefile
 create mode 100644 security/bpf/hooks.c
 create mode 100644 security/bpf/include/bpf_lsm.h
 create mode 100644 security/bpf/lsm.c
 create mode 100644 security/bpf/ops.c
 create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c

-- 
2.20.1

