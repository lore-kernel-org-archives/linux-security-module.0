Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21CE555
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469403; cv=none; b=IOlIL8x8EP+zeeHqQLxEOR9UZblhBoha4m4SX/Y6pAwaTu6i8JTtVQfN4DYpjCqlstbXdXH5ESBNqaaK96v7nbhO/bTXwQn6gao25XRBj2BN3iPkOhwM8/Z1Ff2g3VIXd2f9Jzy1IBAlbiQv1MgNIpamrx+MEgzFhQJh5H1ztvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469403; c=relaxed/simple;
	bh=c58fnOiwEsN7lUj0DmXeQk2wWyvK7VT5Pt/ChD76cJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPJLHpq2BJ2M9szy+/iJca5gWCEGrfxB41BuBT/mGk82tKd2QASIquZvMyOSeTQlZ04TfcmI0WMbbxlD8HJYZk+M61sXFMTlIJsNv4RtfpsP5w6bgCKhDWFoWFmfkUGKRKVKvB/NL1Bx2ukf8EpAuiU7PvExPJiKu7fLF4ugsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUVlOCJr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUVlOCJr"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9204711e831so4900785a.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2026 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783469400; x=1784074200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5YW1Vp33W4R7ClL7Q/jKwGiZ/RqUWzBm7jRzsfKd+8=;
        b=PUVlOCJrUkLuEsI+OMjFuJKsGa+l4JaMsu7vrh3aCQKgwbb6G2N1kmia8DPz4HVdQW
         CgRC71bA4obYOXHAljFXW1RsJygheVmQXgOH8GfoeQiCjiYwPH++jG1H2rhl4xkmgVq/
         AeLgvgRCUMyjM1il7xFIyGlUUkZJjllO41FTEEb3q9IebTucD21lXmIUojFRckwKQoiA
         QWDWqRcdEh9x8qJb+Qe5JJf8RXJSPMqJSEhj1tPFT0DYuT/RbEAeTxiMfhzIhZ0Cqb9K
         6x2A6ikZZnJTYl8pqUs+JsE5QVVWuhRDYn4D6WoQay6FzWEiKoKJE/Xx8sI/9Xu/jRCN
         2FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783469400; x=1784074200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5YW1Vp33W4R7ClL7Q/jKwGiZ/RqUWzBm7jRzsfKd+8=;
        b=f42YzmlOUTuSo2DSKh6YvLVBbRKn1ych9aWZyiBv0WfQM0echAmCIXS3V1A/ZXEwbo
         X2ClISXVWzeKb5GF863sDjiUen7RK3axRGf9towB5nL1RGRtTorBxR5iaLaVQSyh2SH8
         UZ/F6GcBVUoFv1LMjOZCdya6zN97gj5A6W+IHOTNyJS5/HUF3sR+TvsiithqazSUTxtt
         3xMa4Qcx1F/KOB22G6l28ads1Fovhw53ixVRQPIoDYSFQM7I82o3p68+pY0L9LTe+KFZ
         DjmaqE2AkHMKkIj16NHXIyT8nAPQhs58yPspzzXG4+FceaGuOf6ed53qnmnPypcaWy85
         yarw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2BAKaN8iMHUgkomqJZR4slSeAU732CS3/Hyck56uwTOsQtlP+2zki0E+vSgEEfahkN0pl+cflSXDhbf1SQdHfC+o23TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrENphNUl0Iq4RczwPDnJGwFf6NRId7tqjsX023wZO/1xlFAGs
	5455fzzSNaSMFX5wGt9aPA3ZkY+pKwfrJLO+VQIye3AaKahIu2gxK1Pm
X-Gm-Gg: AfdE7cmMIFj57soNX3e7Oj6g5EH+Hv2kRUD1j2bUjxp49cWVwPVo3z9uzxci7R0hi+n
	mdOObuDM/2u5wi2W/NTjpi4oP+rqX3f7NKl4KonNAMf61HRoWcn/W+dlM10QX/iFJtY/1Xz6z2A
	FE91qfadYsI9LbI7aV/6asIuqx/GWOB7sM2quUX1fzdjNpleTDWumJML0pdP+hQdMhdL2P2oMqs
	rwBZ+ThmA/H2gpIffA2JsIO3rHg0D748lt0dycGPXIsL1k+TspBLvp5xjb7bgwwwdtKNJXmYGgd
	4f3WrlWfYgVuC5lSInfMFsz8F4skeRnzMhUtufjnPB2zeBxee/gBG8H4VpU8OJ4ZO5a/yP2ITfS
	sn5LE06MvcRJ3zuhuSaO6k8HPXnlMXm5m89qizcb2xEfnP9ITj8AXWdlysfjfra3FYYAU5mLvpK
	1w0p7NX20UH/GRQt2DkcHMve3KHbAi39+0h41d2EOvh5WS96I3F7uh4RortfbqEtCrXTUxKxc4M
	v1jjecE69F2Drk=
X-Received: by 2002:a05:620a:2b4d:b0:920:6061:816e with SMTP id af79cd13be357-92ecf629324mr5879185a.7.1783469400172;
        Tue, 07 Jul 2026 17:10:00 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e93ea5ed3sm1191281885a.29.2026.07.07.17.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:09:59 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v5 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Tue,  7 Jul 2026 20:09:53 -0400
Message-ID: <20260708000956.46138-1-dwindsor@gmail.com>
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
the combined inode_init_security xattr context argument and claims a
slot in it via the new security_lsmxattr_add() LSM helper.

v5:
  - make the kfunc non-sleepable to avoid an ext4 deadlock (sashiko)
  - move xattr creation logic to security_lsmxattr_add() (Paul)
  - use distinct xattr names in init_inode_xattr_slot_limit

v4:
  - introduce struct lsm_xattrs in separate patch (Alexei, Paul)
  - rename struct xattr_ctx to struct lsm_xattrs (Paul)
  - make lsm_xattrs.xattr_count unsigned int (Paul)
  - drop new_xattrs/xattr_count locals in
    security_inode_init_security() (Paul)
  - fold __bpf_init_inode_xattr() into bpf_init_inode_xattr() (Paul)
  - drop bpf_fs_kfuncs_filter() attach-point check; rely on verifier
    type enforcement (Alexei)
  - drop attach-time cap; enforce slot budget in the kfunc (Alexei)
  - allocate the combined xattr with GFP_NOFS (sashiko-bot)
  - replace init_inode_xattr_attach_cap selftest with runtime
    init_inode_xattr_slot_limit

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

David Windsor (3):
  security: rework inode_init_security xattr handling
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            |  36 +++++
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 +--
 include/linux/security.h                      |  15 +++
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           | 108 +++++++++++++--
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++--
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 124 ++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 14 files changed, 344 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: 602701718649936eb287bf6c7ecf870ec54c6f71
-- 
2.53.0

