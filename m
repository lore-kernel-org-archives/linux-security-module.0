Return-Path: <SRS0=OCSC=24=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08677C32771
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jan 2020 03:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABC12051A
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jan 2020 03:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RZW4mc90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgAGDax (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:30:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36053 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgAGDax (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jan 2020 22:30:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so41848345qkc.3
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jan 2020 19:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Yq1g0yhtfB9XR3phLfiyQIzKxPRsM0n4AITUjRmTQB4=;
        b=RZW4mc908kSYrRf890x07TPS1gBTYDeSH5pP1/4meVM3fTmqOcMztPKc1Uis64jcqK
         7DRmxH0GbsoBcZt8Ub+GNjAy+xVqF4nGNK+Slp7eZIw9o4i8EKVlitkdrKA4Of/bL/M8
         eMw03iKIM+3cmt+q+8e/8kkQd/J3W7z4RdORmw6qyp2ApAsOCPpEedrvyGOH/OfoPK9S
         aInz/zm12etxj59+Rrb7e5Eiu+AnYl9tp/dd2g2YzJY8mgZSE9HGLyVgt9zqHH698gOl
         DcaeHo3eBgvC4d4EUM2hzOMA+YWy6SHGARDHucb8k/GHgVekxlVLbFe4nXYWlnX4NUGy
         JzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=Yq1g0yhtfB9XR3phLfiyQIzKxPRsM0n4AITUjRmTQB4=;
        b=O9IvGYWcvv3/70dhIkQ7+1d9EDFBWI8UTpJIsIUM1sTdqWEQu8o7NSFXKTyE/W0gdv
         WdrUtCFC0VQR29YVbYsrd/m0nJ2ZD6afdCmELoypl60+RqUqktMRhtzhB2laxEXkJSTP
         FD8/8I7LbpaHwUfLfr39HWhvqdCBM/QpdNJSEJGVrkQW75Y/o719unxLoP31OziPJRG+
         aBbax/IykKRaJnmeg9xMNJxQlt3jxWD9HUYMPK8hE+1zKQwQSsVwUqcaIw/Khx4P46FF
         9/ylNOhau9YwHdNULyTtVunp93eMZayYgqgb47A8NFonKSpW15ZrXzg+diBjiRUwpykk
         9aow==
X-Gm-Message-State: APjAAAX9tKCEjEJ5G24cAES/mXi3qYhhOTwOQxEASk/Z38dRkTtlbYm2
        uSojICng5YGGRxqPfQMBGrM364XnIg==
X-Google-Smtp-Source: APXvYqzKs2XmqaiFv0lJHkJlcNWztxhIXc2jqweWzXd8BDNsIEQOtst8hv5+hpEsoDrjqSLi1hhXcg==
X-Received: by 2002:a05:620a:1327:: with SMTP id p7mr84718554qkj.148.1578367851354;
        Mon, 06 Jan 2020 19:30:51 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id f5sm21686226qke.109.2020.01.06.19.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 19:30:50 -0800 (PST)
Subject: [PATCH v2] selinux: deprecate disabling SELinux and runtime
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org
Date:   Mon, 06 Jan 2020 22:30:49 -0500
Message-ID: <157836784986.560897.13893922675143903084.stgit@chester>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
code was originally developed to make it easier for Linux
distributions to support architectures where adding parameters to the
kernel command line was difficult.  Unfortunately, supporting runtime
disable meant we had to make some security trade-offs when it came to
the LSM hooks, as documented in the Kconfig help text:

  NOTE: selecting this option will disable the '__ro_after_init'
  kernel hardening feature for security hooks.   Please consider
  using the selinux=0 boot parameter instead of enabling this
  option.

Fortunately it looks as if that the original motivation for the
runtime disable functionality is gone, and Fedora/RHEL appears to be
the only major distribution enabling this capability at build time
so we are now taking steps to remove it entirely from the kernel.
The first step is to mark the functionality as deprecated and print
an error when it is used (what this patch is doing).  As Fedora/RHEL
makes progress in transitioning the distribution away from runtime
disable, we will introduce follow-up patches over several kernel
releases which will block for increasing periods of time when the
runtime disable is used.  Finally we will remove the option entirely
once we believe all users have moved to the kernel cmdline approach.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 Documentation/ABI/obsolete/sysfs-selinux-disable |   26 ++++++++++++++++++++++
 security/selinux/Kconfig                         |    3 +++
 security/selinux/selinuxfs.c                     |    6 +++++
 3 files changed, 35 insertions(+)
 create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-disable

diff --git a/Documentation/ABI/obsolete/sysfs-selinux-disable b/Documentation/ABI/obsolete/sysfs-selinux-disable
new file mode 100644
index 000000000000..c340278e3cf8
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-selinux-disable
@@ -0,0 +1,26 @@
+What:		/sys/fs/selinux/disable
+Date:		April 2005 (predates git)
+KernelVersion:	2.6.12-rc2 (predates git)
+Contact:	selinux@vger.kernel.org
+Description:
+
+	The selinuxfs "disable" node allows SELinux to be disabled at runtime
+	prior to a policy being loaded into the kernel.  If disabled via this
+	mechanism, SELinux will remain disabled until the system is rebooted.
+
+	The preferred method of disabling SELinux is via the "selinux=0" boot
+	parameter, but the selinuxfs "disable" node was created to make it
+	easier for systems with primitive bootloaders that did not allow for
+	easy modification of the kernel command line.  Unfortunately, allowing
+	for SELinux to be disabled at runtime makes it difficult to secure the
+	kernel's LSM hooks using the "__ro_after_init" feature.
+
+	Thankfully, the need for the SELinux runtime disable appears to be
+	gone, the default Kconfig configuration disables this selinuxfs node,
+	and only one of the major distributions, Fedora, supports disabling
+	SELinux at runtime.  Fedora is in the process of removing the
+	selinuxfs "disable" node and once that is complete we will start the
+	slow process of removing this code from the kernel.
+
+	More information on /sys/fs/selinux/disable can be found under the
+	CONFIG_SECURITY_SELINUX_DISABLE Kconfig option.
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 996d35d950f7..580ac24c7aa1 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -42,6 +42,9 @@ config SECURITY_SELINUX_DISABLE
 	  using the selinux=0 boot parameter instead of enabling this
 	  option.
 
+	  WARNING: this option is deprecated and will be removed in a future
+	  kernel release.
+
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_SELINUX_DEVELOP
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 278417e67b4c..adbe2dd35202 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -281,6 +281,12 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	int new_value;
 	int enforcing;
 
+	/* NOTE: we are now officially considering runtime disable as
+	 *       deprecated, and using it will become increasingly painful
+	 *       (e.g. sleeping/blocking) as we progress through future
+	 *       kernel releases until eventually it is removed */
+	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 

