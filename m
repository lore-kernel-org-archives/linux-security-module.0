Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4F2FA0DF
	for <linux-security-module@vger.kernel.org>; Thu, 18 Jun 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814859; cv=none; b=mJgxVDx1f9Ib7Z8s7aKw+Sxhkks6yajVZFNzK5vjeeSlb4yozMXdFWckgZCXwH1WOCsUrlPPkLTnJ1h+PeSGuKj9rUKJH4L2r3NCDsjnJrnbsmPn1XoKbAbMX2QKUl25dR8vol8CfoIDTg1g82Wohd903Dzt3PPt2oCh79IAZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814859; c=relaxed/simple;
	bh=58J+e+qzOqSL8rLq819iM9p8hX+gCfzoDVUQTirsvLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqxbBeRPL9iZhDD+ombA/ZX2gjLj9dyWC2l0Bi7twJ2QS180gPfWZbzEJdzqyJmIHHZuSEiWrHA9w+wffsgNTA6g0yMLkEO74F+TcOWhQU3N/Dwz/wuev0efHGNR3Nyu+dknyKcWjYwqKrTHkGBCbp6DA7MLhKomFsrOxZk5PfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpZDhoWP; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpZDhoWP"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8db35680d0cso25451816d6.1
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jun 2026 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814856; x=1782419656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DA8ujigZ7IZh+Xr0JA9p0ivPwgMz7UTZBS7avx55oOk=;
        b=ZpZDhoWPKMWpdhZAt8MJSKrpVWP33cTDKaLOR8NEm9junQifEuiYa61pJ5oKMbbDUp
         42KlQxUeHhddXxpPPL9P1duAU4scCVYsf9Fv7rU3/GthpI/WNmrIVWvBONGMBsDmatKx
         9pmj94Sw9dU5HEm0wqLwGiSYEfF/PvlCwC97ckbrUYXu7AtWeIuQdJtx42WNlmaLrw7d
         zgOG/03uEJsvIoAfkBVVZG1S6pcC6/hKSd5wun/hlHCOOqb885aiX/JzgcJxPOMCXMc3
         SBBF0xL/wmhsbV9oTsLOSFhom3l53/qIZn056E6zi+qFXQVjmzHM55+LIqbAFSK1CsxM
         Ckyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814856; x=1782419656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA8ujigZ7IZh+Xr0JA9p0ivPwgMz7UTZBS7avx55oOk=;
        b=FqYb6oCe0BPVoCCOEpArfWXjSrRNEj1qZnpfOen65CCFnjxvyNvFSHyqK4QhBZQbq3
         07MgLexLhkFnF5pd/QEhJpYcCCTFalVR9LddIj3DPYryTHDzr42HananBbr7+vZEb9nU
         baF7amCxp/c+mUDUtjNLV7PAH9OCku5VdkRnW73iuCms0a285eNpcM2s8Z6+BDE7Re4l
         yupQ1kdI8aGfgboXJm6/hZYP2UGNvdpYS0uNv+G4c6MDx2xBVGxnSddDrnqrs0Tzj21C
         teT/S4xZUfT2+GyXsjEnzDm3GIEW1cE4rclxvMGTk87GlolND0gXODTMNW/Zwz2RdaDO
         tmEw==
X-Forwarded-Encrypted: i=1; AFNElJ/na68IqKh1NFibsh9Wf0VxCf6v1oan6XlqZpqHUdRC2rTGteaoqCJQbgFRnlt6pAZU3KLUXq1+e/+5VmwPzlMqltmRpBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIR9rbe1OfzqVGsDxNtIn0YtxihXPBpP/xBpdSsx9VTphgtfR
	khkkb11MrJalZS/V57m3wS3G9n3oFfccd9PcYxtB9sc+KNW/0bvUELUi
X-Gm-Gg: AfdE7cntPoCNtI8Ag1D/M4X9Qn+TvikMqPSHGUmmWSqNFs/Kn2KZTt1hmnsgGd36kK6
	tvVC2JJyNl7IJE0wYxOCHxBUUIaYDdBF5xkyY4H2JeS5Bdz9yomcsn6WxMcxrj+VsM3lCYkrrb3
	8YsOdpg0gWVKpmktneO8Og0vIAAyuvs9RmeSPWLxHKNr3DGybWGSBB1ULLfN/ItrapJsgGvP+2N
	MYQz8DUzAbsBjHn8WToA34dkUefXvuN1ylEwZprtDTFhjbry1SVz335R4RRfFbdCRaAufbjJdT7
	1nP3Diszm8LUjM1u4kSRSyEWF58AMrWYALjWZU+pplPMEulBt2YZyOwHZSGTqp3BAc4exy1TrDt
	B7GhzYgxoKk61N8nFDaskELDWPtYsBnsUVTOFhMk7YBLbsuFNX83gP9mwIAtymoHUlz1iojHRbS
	s4re8J7/YQsB7HjobquIJ4JUbZqxuFqSdmrRRec1IiiS02SNazYYxvslbOlGLsVJhfzt80O5266
	dZtH7+afruE+T99UmvEutfBmw==
X-Received: by 2002:a05:6214:dc1:b0:8dc:939d:b03d with SMTP id 6a1803df08f44-8de4c76b7c5mr8335506d6.16.1781814855698;
        Thu, 18 Jun 2026 13:34:15 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12d1c3sm2176166d6.10.2026.06.18.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:34:14 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Thu, 18 Jun 2026 16:34:09 -0400
Message-ID: <20260618203411.73917-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
extended attributes. For these LSMs, atomic labeling during inode
creation is critical: if the inode becomes accessible before its xattr
is set, it is briefly unlabeled, which can disrupt LSMs making policy
decisions based on file labels.

Existing LSMs solve this by setting xattrs directly in the
inode_init_security hook, which runs before the inode becomes
accessible. BPF LSM programs currently lack this capability because
the hook uses an output parameter (xattr_count) that BPF programs
cannot write to, and existing kfuncs like bpf_set_dentry_xattr
require a dentry that isn't available until after the inode is
accessible.

This series introduces the bpf_init_inode_xattr() kfunc, which takes
the combined inode_init_security xattr context argument to access
xattrs and xattr_count, and internally writes to xattr_count via
lsm_get_xattr_slot().

v3:
  - rename struct lsm_xattr_ctx to struct xattr_ctx (Paul)
  - increase BPF_LSM_INODE_INIT_XATTRS to 4 (Song)
  - enforce per-hook attachment cap at attach time to prevent
    runtime rejection (Paul)
  - add init_inode_xattr_attach_cap selftest

v2:
  - pass the xattr state as a combined context object and drop the
    verifier fixup path (Kumar)
  - restrict bpf_init_inode_xattr labels to bpf.* namespace (Matt)
  - cap bpf_init_inode_xattr() at BPF_LSM_INODE_INIT_XATTRS slots per
    invocation (AI)

Link: https://lore.kernel.org/all/20260503211835.16103-1-dwindsor@gmail.com/ [v2]

David Windsor (2):
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            | 106 +++++++++++++++++-
 include/linux/bpf.h                           |   1 +
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 ++-
 include/linux/security.h                      |   5 +
 kernel/bpf/bpf_lsm.c                          |  10 ++
 kernel/bpf/trampoline.c                       |   3 +
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           |   7 +-
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 105 ++++++++++++++++-
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 17 files changed, 306 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
-- 
2.53.0

