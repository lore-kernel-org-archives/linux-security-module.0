Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792874379;
	b=Xdk1T5LRciDivk2p1eB3J8Oqi/p7CsmfmtEVXPi4r/dFMSRkzGp/QhQABN9yzrOkyenV
	 kg4fZ4Cx4wu2SeF+h+810FhC2rFQT3JALBQZEKpR17ort1oMeEWjgJm+y5Hg2yAFvHbby
	 hV44HPxUvwVjC9vJGewUixKTz32iD8opODsFRP7omi9AvimWT9kfAVtYAS+B/t2XKPeh7
	 ZQi89BLeVt9/MmLuy0B9VhSNsM9UDjMjhPdDE+k/XHNtnWeHTrTg/xP7yCzUCfffFdLXv
	 PxNy4PuvrrcWUeJNkjAO3DTtM52mmP2ybUuChuOOwBtgE53wKWScDar+VGmHqQUCFqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792874379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=IjSiHGQjMHBvlnVEepWUCcgABELupa+mQr5lHVGi+/M=;
	b=ahwt6LNyJ5rrI5qSBWCCzxc/dPpWj2lrT3ZrnIWGV8U3mVdwKc2+QDOFzV+zbwPfEQTg
	 lrjRsNmCLwB+zGl6eO3JGhfs90C1JgNZJtmKUc4wGghPiSvCPkCP8rsub1p0fbbMJiGJb
	 5nFL1DIpkciBBG3V4ofKDg8EgapoChKnJj2KOmde/FaP5RulljnG+dFDWI50vS9mOcCzD
	 bn7MsiutLwbJA7njvKWpXVL8rW+rTG1TTL7LMWGAISy5m7cVod6dvf2ervNNvcn2yuJqj
	 OVb7tAOFDiQJAQGQVDWapaYMIZONKSn8UFOOROA6lba3ngXm0jAzEDA3DNXCJj5xo4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ghOihAI/";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED42606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 20:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ED42606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ghOihAI/
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-354ba08cfd1so3357793eec.1
        for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792874377; x=1793479177; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IjSiHGQjMHBvlnVEepWUCcgABELupa+mQr5lHVGi+/M=;
        b=ghOihAI/niEfFdudfKnMpvmID9ulFb6KCy4bYzxqTPKhOY6+TDy1gKg4KftkTONQMx
         Y1254Et39lk13UtL+3kitY1qFdspTFyxgLZVtK2d3uRChUEw5ulzFu0ZFuDHpxH/mPe+
         BWHKiPH/WFDBYCjzlfjcnocAOPagWdFGx9g8BXcbuP61yXMKRND2Is1JJ2vfEdREuUQ6
         Ocbtrf6+W/Ia+RiFMoti45zjKWuEMXMyQXiAHgUodpZ8Waa2KDdULug6HP3ZHOqvXMg+
         iyYqcBAvlZfIWE7u/4oZeSnmG3Ebgrb1zJVB7zhnebeVx9+97RoV/0t2uICfuI1ilUu3
         2+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792874377; x=1793479177;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IjSiHGQjMHBvlnVEepWUCcgABELupa+mQr5lHVGi+/M=;
        b=wAEvnqOC+Eg81t8gdfQwD3DeboN08pUKnZms3OZiK/X8dCwElsXBhlmOwmS8/ZHJ7o
         29lx4RwsEmULGty3ffH6jc5O0a7KIOyE+Bza9tUagopLvS6IZsJMNcrHKWShQzPy4J8/
         1veEtDzoO3rLrxdUirqvBRyUsbFgmN65ybMGDdt1ZF0mRLZaBgzR4Om76LpDmPXjdNul
         OPnQ2OSDGnjegz3MBHBindHBXHVlNR3VTXFyZLol+wLrCiWPEcCNVSekgmBcxO4mc6Fl
         0BMbMWNenV3fxPrUnLCWJht+IfSnf4jbRbc7me/14iLTH3oUKJPTM5gfXxD7YacAJEjQ
         OMlw==
X-Forwarded-Encrypted: i=1; AKwUvBzB0zatQAAJMFHxUvv4Mr939zWarCD8cDPBWU1Siui4lbomc4BIO9XWTAcOGUT79djQK+cmzilofIvgFd+q/3HUOqJ3ii8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRcMseoXl7pTVt6jZujCQWyUMe1DJBMnOYHjoQXbxsTm4G+hkf
	j+Bj4VLWpmS6405Fs+vx19DDsyWlMCcV8HCG1/pt9QBz9apeONTCLo/g
X-Gm-Gg: AYBFou02C1wjN7db8t/01qHlMelE96EwB1pwJGE63mXUlsVDs7nqF3H349asVwH3Cs/
	VgIzgOHn05aPLhQbU+2eHK+n82W5qPN4WIONFpfUU9YRSOH5eZhcfs7JVGdeMq710fEVJKBBqbj
	4E+RmjS5uIlSEOKHuJW2ueNc8TX9eFDvBik+SmOW5SrrggypiUbEqwwh/QXGzO/eYTg8VJp9dlo
	ufcGx5bhWltbJJ9XA3p51utsWgGGhG4otfZfnHD7A9+LriXx34Vx7Wn+BIdLXJ5f5ha5x3EywZT
	DBg/Puwwm+PIT5oSOQpkaphcAEnjAaXpwqrgPXFZl8QNf2LozHocFeeP/ERxz5/El3sejRAmAm7
	c5XXb/KdrCjjPFCO9Pmkj/NYq0qrsEyUkBb0QJONieasInoNX5crnnhpYwqm4sLKRvKpxBHkHhb
	nRz5SGii/ZOPMtqD/oElZNvfuT6bRMy4NIrUFbnUFj5a038ChxCeLxs5W2G8/RjHJjrENV08EBf
	9LBk2gjGKkG7E+Uclmi55QeOLeTJ3peOfMNFJrJwhY8rsvlyKafBZOKvteTVw==
X-Received: by 2002:a05:7023:881:b0:168:fe32:35a with SMTP id a92af1059eb24-19935be806fmr4264812c88.20.1792874377042;
        Sat, 24 Oct 2026 13:39:37 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm9764737c88.14.2026.10.24.13.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:39:36 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: [PATCH RFC 0/3] landlock: Add access rights on created files
Date: Sat, 24 Oct 2026 13:39:16 -0700
Message-Id: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L27MI2BlGvgg/wKh7SZG1XSyq7U
 YTSvxv1OAMzMxirsMG+mUH5JSZTrtCuGohDyD2jpMrgyG1ach7HkNM4xTtG5VA4oUo/FMPd2lN
 HFLbRJ6j1Q/kq79/5DKfjAS5/ac/uxrF8n7AsH5qqeoaAAAAA
X-Change-ID: 20261024-landlock-created-rights-9340b00a8c4d
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, John Ericson <mail@johnericson.me>, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

This is a proposal for an idea to add support for landlock to work
better with build systems such as Nix where they want to apply
restrictions but the paths may not yet exist.

TL;DR;
========

Landlock rules attach to inodes that exist when a ruleset is built.
That makes a directory shared between trusted and sandboxed tasks hard
to confine: the sandbox may create entries there with
LANDLOCK_ACCESS_FS_MAKE_*, but no rule can name those entries ahead of
time, and granting read access on the directory to cover them exposes
every other entry as well. This series adds a rule flag that grants
access rights on the entries a domain creates in a directory, instead
of on the directory.

Motivation
==========

The motivating user is the Nix build sandbox. Every Nix build runs in
its own sandbox, and a build may only read its declared inputs in
/nix/store and must be able to write and read back the outputs it
creates there. Nix enforces this with a private mount namespace: it
creates an empty store directory and bind-mounts each input path into
it, one mount per input. Nix has paid this per-input cost since the
sandbox was introduced [1].

The cost is paid per build and grows with the size of the input
closure. Nix is moving towards much finer-grained builds (many small
derivations instead of a few large ones), so the number of sandboxes
grows while each build's own work shrinks, and the sandbox setup is
becoming the bottleneck. A typical build has hundreds of inputs; large
ones have thousands.

A microbenchmark sets up and tears down a Nix-like sandbox (user,
mount, PID, IPC, UTS and network namespaces, pivot_root into a chroot,
removing the chroot afterwards). It compares one bind mount per input
with a single bind mount of the whole store plus one Landlock rule per
input. Median latency per sandbox, one sandbox at a time, Linux 7.1,
ext4, 16 cores:

  inputs   bind mount per input   one bind mount + Landlock   speedup
      10         3.2 ms                    2.3 ms               1.4x
     100        11.6 ms                    2.8 ms               4.1x
    1000        79.3 ms                    6.4 ms              12.4x
    5000       400.1 ms                   24.4 ms              16.4x

With Landlock, an input costs an O_PATH open and a landlock_add_rule()
call: there is a single mount, and no mountpoint directory to create
before the build and remove after it (removing the 1000 empty
mountpoints alone took 17 ms).

The single bind mount is only sound if the store listing and the
undeclared store paths stay unreadable while the build can still use
its outputs. Without this series, covering the outputs requires a rule
on /nix/store itself, which makes every store path readable again.

[1] https://github.com/NixOS/nix/issues/179

Series
======

Patch 1 lets an LSM observe inode creation through the
inode_init_security hook when no LSM provides an xattr. Patch 2 adds
the LANDLOCK_ADD_RULE_CREATED flag for path-beneath rules and bumps the
ABI to 13. Patch 3 adds selftests.

Testing
=======

The series applies to the Landlock next branch (3e271a27c46f) and was
tested on Linux 7.3 with that branch applied.

Without patch 2, the five new tests and the ABI version check fail.

Open questions
==============

- A created inode stays pinned until the layer's hierarchy is freed, so a
  sandbox that creates many entries in such a directory keeps them all in
  memory. Should this be bounded?

- Creation is detected in inode_init_security, so on filesystems that do
  not call security_inode_init_security() created entries get no rights.
  Is there a better hook?

- Through overlayfs, created entries get no rights either, because the
  upper inode is created with the mounter's credentials. Should overlayfs
  be handled, e.g. via security_dentry_create_files_as()?

- A file renamed or linked in keeps only the rights it had at its source.
  Should it get none instead?

---
Farid Zakaria (3):
      lsm: Call inode_init_security hooks without xattrs
      landlock: Add access rights on created files
      selftests/landlock: Test LANDLOCK_ADD_RULE_CREATED

 Documentation/userspace-api/landlock.rst     |  42 +++++
 include/uapi/linux/landlock.h                |  18 +++
 security/landlock/domain.c                   | 182 ++++++++++++++++++++-
 security/landlock/domain.h                   |  28 ++++
 security/landlock/fs.c                       | 176 +++++++++++++++++++--
 security/landlock/object.h                   |   6 +
 security/landlock/ruleset.c                  |   6 +
 security/landlock/ruleset.h                  |  14 ++
 security/landlock/syscalls.c                 |  20 ++-
 security/security.c                          |   9 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 227 +++++++++++++++++++++++++++
 12 files changed, 703 insertions(+), 27 deletions(-)
---
base-commit: 3e271a27c46fd591d1011c7de5a644a41e2010f1
change-id: 20261024-landlock-created-rights-9340b00a8c4d

Best regards,
--  
Farid Zakaria <farid.m.zakaria@gmail.com>

