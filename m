Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E3C64EC4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBQD1P (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBQD05 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:57 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728BC5972D
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:53 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id q13so4306780qtx.2
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bc7zwUTAdB7OsU4/MJPO3KTv9ylTakbgk8wB6QrWFg4=;
        b=LEtjQcT/g9jMZb/Ohms9DjEx9WcUEEdM3KWUeNuTQ2DpQ/n1IM3kn3i6AbfPxJG13j
         WCeQB2AP+Cbt6k0k/hh3SYP3pU+2TgPMrBRRBDMYmVD7beY29C90vaPsLhVrjFRv0JY7
         MtZJU+ShZrCo7X55YUpziHh9LJvhDDeZ8K+xCBdrV6iCc4AvxC/975eBjTy9K7Z0Rdd/
         2yJF7xNgx3ll9OmCTOP65HtWMNOQoJCuXz91lxuDN8zL5UQOBy3uRcpC/yldsyTCWzdu
         3Baqu/jlbscNdQfUkpq32R3PywYnVqxBFcDia6aVXzqC2vrsulbd9F980TSL3Rpmo0GR
         C6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc7zwUTAdB7OsU4/MJPO3KTv9ylTakbgk8wB6QrWFg4=;
        b=17+Aebm0+ySPhsHrmIxAGZdOcWbUzMK/tVix4aX+z60kWUE1V2XEq3tLl1Q7Q6MCVw
         qOJdpxUPxs5LlfNW1JxDLQsCEdy3u3P8muI0HPleGzGSWNQG54wfSx2w8piuAy8tlNt7
         2O+ceSzRAAl6mngGwMoh47t40xX9/9oP71by3M4c0BNFwQY9FYMXJ0FZrr09Bd7XV6IC
         0LHv94O1QRhBl8oSW6mN89oAU9ALn6JwZuWa5S3Jemj3ao5IayPcReqxwjcY71MAE1my
         ier2JBb9LKuHQdSHz1KHMDvvH+sXdATsYG5epVD92hEuWfhW2fRIw2YMNsWEsQqm5mg8
         vRcw==
X-Gm-Message-State: AO0yUKVfHCrOhFagesrrEDbxUs52TfYZQx5BwVywdazU8JieoloLZfsE
        aIoceRdzNoVXl8hwEhVeUONosJh0WaULLA8=
X-Google-Smtp-Source: AK7set/r38Y+rSZp1BGknEotow7zteWMcZlDiz4mKHOcyXi7KqKRwfvsJ31C48PErcW0mUT5bYohxw==
X-Received: by 2002:ac8:5990:0:b0:3bd:1647:9333 with SMTP id e16-20020ac85990000000b003bd16479333mr4154652qte.28.1676604412594;
        Thu, 16 Feb 2023 19:26:52 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id b1-20020a378001000000b0073b597ce5f8sm2456045qkd.120.2023.02.16.19.26.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:52 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 18/22] lsm: move the bpf hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:21 -0500
Message-Id: <20230217032625.678457-19-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch relocates the LSM hook function comments to the function
definitions, in keeping with the current kernel conventions.  This
should make the hook descriptions more easily discoverable and easier
to maintain.

While formatting changes have been done to better fit the kernel-doc
style, content changes have been kept to a minimum and limited to
text which was obviously incorrect and/or outdated.  It is expected
the future patches will improve the quality of the function header
comments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 36 ----------------------
 security/security.c       | 65 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e36387f88083..601d1ecdae0f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -190,42 +190,6 @@
  *	@key: The key to watch.
  *	Return 0 if permission is granted.
  *
- * Security hooks for using the eBPF maps and programs functionalities through
- * eBPF syscalls.
- *
- * @bpf:
- *	Do a initial check for all bpf syscalls after the attribute is copied
- *	into the kernel. The actual security module can implement their own
- *	rules to check the specific cmd they need.
- *	Return 0 if permission is granted.
- *
- * @bpf_map:
- *	Do a check when the kernel generate and return a file descriptor for
- *	eBPF maps.
- *	@map: bpf map that we want to access.
- *	@mask: the access flags.
- *	Return 0 if permission is granted.
- *
- * @bpf_prog:
- *	Do a check when the kernel generate and return a file descriptor for
- *	eBPF programs.
- *	@prog: bpf prog that userspace want to use.
- *	Return 0 if permission is granted.
- *
- * @bpf_map_alloc_security:
- *	Initialize the security field inside bpf map.
- *	Return 0 on success, error on failure.
- *
- * @bpf_map_free_security:
- *	Clean up the security information stored inside bpf map.
- *
- * @bpf_prog_alloc_security:
- *	Initialize the security field inside bpf program.
- *	Return 0 on success, error on failure.
- *
- * @bpf_prog_free_security:
- *	Clean up the security information stored inside bpf prog.
- *
  * @locked_down:
  *	Determine whether a kernel feature that potentially enables arbitrary
  *	code execution in kernel space should be permitted.
diff --git a/security/security.c b/security/security.c
index 4a2eff06f418..8eb0cef761dd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4824,30 +4824,95 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
+/**
+ * security_bpf() - Check if the bpf syscall operation is allowed
+ * @cmd: command
+ * @attr: bpf attribute
+ * @size: size
+ *
+ * Do a initial check for all bpf syscalls after the attribute is copied into
+ * the kernel. The actual security module can implement their own rules to
+ * check the specific cmd they need.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 {
 	return call_int_hook(bpf, 0, cmd, attr, size);
 }
+
+/**
+ * security_bpf_map() - Check if access to a bpf map is allowed
+ * @map: bpf map
+ * @fmode: mode
+ *
+ * Do a check when the kernel generates and returns a file descriptor for eBPF
+ * maps.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_bpf_map(struct bpf_map *map, fmode_t fmode)
 {
 	return call_int_hook(bpf_map, 0, map, fmode);
 }
+
+/**
+ * security_bpf_prog() - Check if access to a bpf program is allowed
+ * @prog: bpf program
+ *
+ * Do a check when the kernel generates and returns a file descriptor for eBPF
+ * programs.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_bpf_prog(struct bpf_prog *prog)
 {
 	return call_int_hook(bpf_prog, 0, prog);
 }
+
+/**
+ * security_bpf_map_alloc() - Allocate a bpf map LSM blob
+ * @map: bpf map
+ *
+ * Initialize the security field inside bpf map.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_bpf_map_alloc(struct bpf_map *map)
 {
 	return call_int_hook(bpf_map_alloc_security, 0, map);
 }
+
+/**
+ * security_bpf_prog_alloc() - Allocate a bpf program LSM blob
+ * @aux: bpf program aux info struct
+ *
+ * Initialize the security field inside bpf program.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
 {
 	return call_int_hook(bpf_prog_alloc_security, 0, aux);
 }
+
+/**
+ * security_bpf_map_free() - Free a bpf map's LSM blob
+ * @map: bpf map
+ *
+ * Clean up the security information stored inside bpf map.
+ */
 void security_bpf_map_free(struct bpf_map *map)
 {
 	call_void_hook(bpf_map_free_security, map);
 }
+
+/**
+ * security_bpf_prog_free() - Free a bpf program's LSM blob
+ * @aux: bpf program aux info struct
+ *
+ * Clean up the security information stored inside bpf prog.
+ */
 void security_bpf_prog_free(struct bpf_prog_aux *aux)
 {
 	call_void_hook(bpf_prog_free_security, aux);
-- 
2.39.2

