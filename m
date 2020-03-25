Return-Path: <SRS0=gnGb=5K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EABC54FD0
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 15:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6069A2070A
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 15:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UHPsytR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgCYP06 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:26:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33158 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgCYP0z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 11:26:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so3707338wrd.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2020 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Gyxp2a9zGP5hZ4HP4Fi/8eZQmOLnr2Z8mMtXGHkhuU=;
        b=UHPsytR5w/jCg5MAHnUVTTsWgxse5E4WIwTLE3qFcFmv73tU9y0/HD8qPVWODPHv6d
         vegQD/OiKN9Os/0B1hig2WgcQV1wnCjPS1o1CTuIOgQZfVfQ2ex5RvLDMbeknpwTLWx4
         E7q5fJoO1BZZc+xfYU88K6zdtVv8tNGz6JGlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Gyxp2a9zGP5hZ4HP4Fi/8eZQmOLnr2Z8mMtXGHkhuU=;
        b=qnjdIVw2IE3GCLWjRuZKiyh+MwxEzMBO16FqluFABX9sQs4nLfyakSZ77Pe2GkwAs9
         YDx+kNB4A9poxsTMPGuB0QK+tHX9+GVfN3E3khcl22v7jLRzHKDscqYk99KpXvwlnEQc
         yMyB9DNOVbmri2HS6vjfeqNjbr99gMqPF3spKNOf9uH0BfUhu9Fu96Es3gMI7Vazccsb
         nbi4n+BA2hoUtbUcgoOIcR/f2qvQunEdk52L/W01AJgDa/rwvD71Nkuv2BO7qeFs6A5V
         YBDS1CyzrT7IEjuHr3nb4HHLZDDm89yB99RmlSfdNIkE6w52ywO0C3QhtscvPocIREno
         snUw==
X-Gm-Message-State: ANhLgQ3Myz+aI+tEVilklzjspt3c8LOFGtsg/+4u3D/gKw1WM3jyq93J
        SlRiP6HeoMTWT4EG6BhKs9CFgw==
X-Google-Smtp-Source: ADFU+vuCFYAQx8wKjzFjm8yswfCPHsfxDJ967YK931GekZSj8QKSDOtlqCPKU2ihNiJEHFVQi4Hxhw==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr3965059wrn.253.1585150012222;
        Wed, 25 Mar 2020 08:26:52 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a2sm4033701wrp.13.2020.03.25.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:26:51 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v6 8/8] bpf: lsm: Add Documentation
Date:   Wed, 25 Mar 2020 16:26:29 +0100
Message-Id: <20200325152629.6904-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325152629.6904-1-kpsingh@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Document how eBPF programs (BPF_PROG_TYPE_LSM) can be loaded and
attached (BPF_LSM_MAC) to the LSM hooks.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
---
 Documentation/bpf/bpf_lsm.rst | 150 ++++++++++++++++++++++++++++++++++
 Documentation/bpf/index.rst   |   1 +
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/bpf/bpf_lsm.rst

diff --git a/Documentation/bpf/bpf_lsm.rst b/Documentation/bpf/bpf_lsm.rst
new file mode 100644
index 000000000000..2a2c3b4a74d4
--- /dev/null
+++ b/Documentation/bpf/bpf_lsm.rst
@@ -0,0 +1,150 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2020 Google LLC.
+
+================
+LSM BPF Programs
+================
+
+These BPF programs allow runtime instrumentation of the LSM hooks by privileged
+users to implement system-wide MAC (Mandatory Access Control) and Audit
+policies using eBPF. Since these program end up modifying the MAC policies of
+the system, they require both ``CAP_MAC_ADMIN`` and also require
+``CAP_SYS_ADMIN`` for the loading of BPF programs.
+
+Structure
+---------
+
+The example shows an eBPF program that can be attached to the ``file_mprotect``
+LSM hook:
+
+.. c:function:: int file_mprotect(struct vm_area_struct *vma, unsigned long reqprot, unsigned long prot);
+
+Other LSM hooks which can be instrumented can be found in
+``include/linux/lsm_hooks.h``.
+
+eBPF programs that use :doc:`/bpf/btf` do not need to include kernel headers
+for accessing information from the attached eBPF program's context. They can
+simply declare the structures in the eBPF program and only specify the fields
+that need to be accessed.
+
+.. code-block:: c
+
+	struct mm_struct {
+		unsigned long start_brk, brk, start_stack;
+	} __attribute__((preserve_access_index));
+
+	struct vm_area_struct {
+		unsigned long start_brk, brk, start_stack;
+		unsigned long vm_start, vm_end;
+		struct mm_struct *vm_mm;
+	} __attribute__((preserve_access_index));
+
+
+.. note:: Only the size and the names of the fields must match the type in the
+	  kernel and the order of the fields is irrelevant.
+
+This can be further simplified (if one has access to the BTF information at
+build time) by generating the ``vmlinux.h`` with:
+
+.. code-block:: console
+
+        # bpftool dump file <path-to-btf-vmlinux> format c > vmlinux.h
+
+.. note:: ``path-to-btf-vmlinux`` can be ``/sys/kernel/btf/vmlinux`` if the
+	  build environment matches the environment the BPF programs are
+	  deployed in.
+
+The ``vmlinux.h`` can then simply be included in the BPF programs without
+requiring the definition of the types.
+
+The eBPF programs can be declared using the``BPF_PROG``
+macros defined in `tools/lib/bpf/bpf_tracing.h`_. In this
+example:
+
+	* ``"lsm/file_mprotect"`` indicates the LSM hook that the program must
+	  be attached to
+	* ``mprotect_audit`` is the name of the eBPF program
+
+.. code-block:: c
+
+        SEC("lsm/file_mprotect")
+        int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
+                     unsigned long reqprot, unsigned long prot, int ret)
+	{
+                /* Ret is the return value from the previous BPF program
+                 * or 0 if it's the first hook.
+                 */
+                if (ret != 0)
+                        return ret;
+
+		int is_heap;
+
+		is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+			   vma->vm_end <= vma->vm_mm->brk);
+
+		/* Return an -EPERM or write information to the perf events buffer
+		 * for auditing
+		 */
+	}
+
+The ``__attribute__((preserve_access_index))`` is a clang feature that allows
+the BPF verifier to update the offsets for the access at runtime using the
+:doc:`/bpf/btf` information. Since the BPF verifier is aware of the types, it
+also validates all the accesses made to the various types in the eBPF program.
+
+Loading
+-------
+
+eBPF programs can be loaded with the :manpage:`bpf(2)` syscall's
+``BPF_PROG_LOAD`` operation or more simply by using the the libbpf helper
+``bpf_prog_load_xattr``:
+
+
+.. code-block:: c
+
+	struct bpf_prog_load_attr attr = {
+		.file = "./prog.o",
+	};
+	struct bpf_object *prog_obj;
+	struct bpf_program *prog;
+	int prog_fd;
+
+	bpf_prog_load_xattr(&attr, &prog_obj, &prog_fd);
+
+Attachment to LSM Hooks
+-----------------------
+
+The LSM allows attachment of eBPF programs as LSM hooks using :manpage:`bpf(2)`
+syscall's ``BPF_PROG_ATTACH`` operation or more simply by
+using the libbpf helper ``bpf_program__attach_lsm``. In the code shown below
+``prog`` is the eBPF program loaded using ``BPF_PROG_LOAD``:
+
+.. code-block:: c
+
+	struct bpf_link *link;
+
+	link = bpf_program__attach_lsm(prog);
+
+The program can be detached from the LSM hook by *destroying* the ``link``
+link returned by ``bpf_program__attach_lsm``:
+
+.. code-block:: c
+
+	link->destroy();
+
+Examples
+--------
+
+An example eBPF programs can be found in
+`tools/testing/selftests/bpf/progs/lsm.c`_ and the corresponding
+userspace code in `tools/testing/selftests/bpf/prog_tests/test_lsm.c`_
+
+.. Links
+.. _tools/lib/bpf/bpf_tracing.h:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/lib/bpf/bpf_tracing.h
+.. _tools/testing/selftests/bpf/progs/lsm.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm.c
+.. _tools/testing/selftests/bpf/progs/lsm_void_hook.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm_void_hook.c
+.. _tools/testing/selftests/bpf/prog_tests/test_lsm.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/test_lsm.c
diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 4f5410b61441..2c3d3c0cb7bb 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -45,6 +45,7 @@ Program types
    prog_cgroup_sockopt
    prog_cgroup_sysctl
    prog_flow_dissector
+   bpf_lsm
 
 
 Testing BPF
-- 
2.20.1

