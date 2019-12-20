Return-Path: <SRS0=iN1c=2K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A7FC2D0D2
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Dec 2019 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE32B2465E
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Dec 2019 15:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UnFHOJ8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfLTPmc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:42:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43238 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfLTPmX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so9812841wre.10
        for <linux-security-module@vger.kernel.org>; Fri, 20 Dec 2019 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E3KRI0OMvvIk1Vp8KAUHmCXVK/1yf6rawh5IXDd9ces=;
        b=UnFHOJ8+GMLl+jOi6cH3hewYYZpM8CrAZz0SocrwHbHAJi5kJCGxdWoGBYNd56FKms
         4iXoCWR0Y+JGIzj7lVun/7TKSmQCrI86eAVnrLNHcZl2fSFj/iOG2XC4x+bnuIvXMVkx
         pA9LhZZrfM+iekDJ2f8ZjDb6LS4rmGE8qv4Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3KRI0OMvvIk1Vp8KAUHmCXVK/1yf6rawh5IXDd9ces=;
        b=V8EMqIRkBb6Qk6/SW+fQArqqF1it8OGxQUIAEa70H3YPApTl7fjI1eAI227u1ASK5a
         T3pm8OgNnvNeAOPnlNrP7IbZ4Iv2N5ODzypc/uGpo2N1P1zvkM18/S0f0JQPxAJjZvNF
         pn3IgKwZyTX/yuZzOE4raVs+ABDxyd4mgGKa5rAY1Dty+9eg7RgnLDU1v5OzaXMK1y4n
         BVAGHRwkiOUbcipwHj4Ge1lp5mMeFEWi33mYCFLLGu/8vJVFPxfuOJY7nxaOb4+PvdMK
         EVZSkQW/EMdW9GGS0bxJ9EySU0ceEK46gjrYBMxYIPAmhXh3xyLm4v4AOBRHiOY229RX
         lRHg==
X-Gm-Message-State: APjAAAWOi8+MBAMJg1huzkUVb3903E1/bJQ5Vm3Ahk7tPa/4B+O7EPAy
        I6LrQP1/wXxHGmftzuDdZjRt7A==
X-Google-Smtp-Source: APXvYqy+NoYaSlhnrfxz+YqWELrNDqgsG8cS58xKXuhUA6jx2tHjZj6TMGrFdnsggisjjCwLLCdlkQ==
X-Received: by 2002:adf:d184:: with SMTP id v4mr15936626wrc.76.1576856540672;
        Fri, 20 Dec 2019 07:42:20 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:20 -0800 (PST)
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
Subject: [PATCH bpf-next v1 13/13] bpf: lsm: Add Documentation
Date:   Fri, 20 Dec 2019 16:42:08 +0100
Message-Id: <20191220154208.15895-14-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Document how eBPF programs (BPF_PROG_TYPE_LSM) can be loaded and
attached (BPF_LSM_MAC) to the LSM hooks.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 Documentation/security/bpf.rst   | 164 +++++++++++++++++++++++++++++++
 Documentation/security/index.rst |   1 +
 MAINTAINERS                      |   1 +
 3 files changed, 166 insertions(+)
 create mode 100644 Documentation/security/bpf.rst

diff --git a/Documentation/security/bpf.rst b/Documentation/security/bpf.rst
new file mode 100644
index 000000000000..898b7de148a0
--- /dev/null
+++ b/Documentation/security/bpf.rst
@@ -0,0 +1,164 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright 2019 Google LLC.
+
+==========================
+eBPF Linux Security Module
+==========================
+
+This LSM allows runtime instrumentation of the LSM hooks by privileged users to
+implement system-wide MAC (Mandatory Access Control) and Audit policies using
+eBPF. The LSM is priveleged and stackable and requires both ``CAP_SYS_ADMIN``
+and ``CAP_MAC_ADMIN`` for the loading of BPF programs and modification of MAC
+policies respectively.
+
+eBPF Programs
+==============
+
+`eBPF (extended BPF) <https://cilium.readthedocs.io/en/latest/bpf>`_ is a
+virtual machine-like construct in the Linux Kernel allowing the execution of
+verifiable, just-in-time compiled byte code at various points in the Kernel.
+
+The eBPF LSM adds a new type, ``BPF_PROG_TYPE_LSM``, of eBPF programs which
+have the following characteristics:
+
+	* Multiple eBPF programs can be attached to the same LSM hook.
+	* LSM hooks can return an ``-EPERM`` to indicate the decision of the
+	  MAC policy being enforced or simply be used for auditing.
+	* Allowing the eBPF programs to be attached to all the LSM hooks by
+	  making :doc:`/bpf/btf` type information available for all LSM hooks
+	  and allowing the BPF verifier to perform runtime relocations and
+	  validation on the programs.
+
+Structure
+---------
+
+The example shows an eBPF program that can be attached to the ``file_mprotect``
+LSM hook:
+
+.. c:function:: int file_mprotect(struct vm_area_struct *vma, unsigned long reqprot, unsigned long prot);
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
+	};
+
+	struct vm_area_struct {
+		unsigned long start_brk, brk, start_stack;
+		unsigned long vm_start, vm_end;
+		struct mm_struct *vm_mm;
+	};
+
+
+.. note:: Only the size and the names of the fields must match the type in the
+	  kernel and the order of the fields is irrelevant.
+
+The eBPF programs can be declared using macros similar to the ``BPF_TRACE_<N>``
+macros defined in `tools/testing/selftests/bpf/bpf_trace_helpers.h`_. In this
+example:
+
+	* The LSM hook takes 3 args so we use ``BPF_TRACE_3``.
+	* ``"lsm/file_mprotect"`` indicates the LSM hook that the program must
+	  be attached to.
+	* ``mprotect_audit`` is the name of the eBPF program.
+
+.. code-block:: c
+
+	BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
+		    struct vm_area_struct *, vma,
+		    unsigned long, reqprot, unsigned long, prot)
+	{
+		int is_heap = 0;
+
+		__builtin_preserve_access_index(({
+			is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
+				   vma->vm_end <= vma->vm_mm->brk);
+		}));
+
+		/*
+		 * Return an -EPERM or Write information to the perf events buffer
+	 	 * for auditing
+	 	 */
+	}
+
+The ``__builtin_preserve_access_index`` is a clang primitive that allows the
+BPF verifier to update the offsets for the access at runtime using the
+:doc:`/bpf/btf` information. Since the BPF verifier is aware of the types, it
+also validates all the accesses made to the various types in the eBPF program.
+
+Loading
+-------
+
+eBPP programs can be loaded with the :manpage:`bpf(2)` syscall's
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
+The LSM creates a file in securityfs for each LSM hook to which eBPF programs
+can be attached using :manpage:`bpf(2)` syscall's ``BPF_PROG_ATTACH`` operation
+or more simply by using the libbpf helper ``bpf_program__attach_lsm``. In the
+code shown below ``prog`` is the eBPF program loaded using ``BPF_PROG_LOAD``:
+
+
+.. code-block:: c
+
+	struct bpf_link *link;
+
+	link = bpf_program__attach_lsm(prog);
+
+The attachment can be verified by:
+
+.. code-block:: console
+
+	# cat /sys/kernel/security/bpf/file_mprotect
+	mprotect_audit
+
+If, when a program is attached, another program by the same name is already attached to the hook, that program is replaced.
+
+
+.. note:: This requires that the ``BPF_F_ALLOW_OVERRIDE`` flag be passed to
+	  the :manpage:`bpf(2)` syscall. If not, an ``-EEXIST`` error is returned instead.
+
+For conveniently versioning updating programs, program names are only compared up to the first ``"__"``. Thus if a program ``mprotect_audit__v1`` is attached and then ``mprotect_audit__v2`` is attached to the same hook, the latter will *replace* the former.
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
+An example eBPF program can be found in
+`tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c`_ and the corresponding
+userspace code in
+`tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c`_
+
+.. Links
+.. _tools/testing/selftests/bpf/bpf_trace_helpers.h:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/selftests/bpf/bpf_trace_helpers.h
+.. _tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
+.. _tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index fc503dd689a7..844463df4547 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -5,6 +5,7 @@ Security Documentation
 .. toctree::
    :maxdepth: 1
 
+   bpf
    credentials
    IMA-templates
    keys/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 652c93292ae9..6f34c24519ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3184,6 +3184,7 @@ F:	security/bpf/
 F:	include/linux/bpf_lsm.h
 F:	tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
 F:	tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
+F:	Documentation/security/bpf.rst
 
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
-- 
2.20.1

