Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6A30E828
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672114; cv=none; b=j0JkP1qzGJfzIYCUeGCT2ZcvpESPUAtlLwumDq2ZZKOVuedx19Vv5UKUiX502nO9r+ZjR7oYu0n83K1Ccd30lUSuhTD3ruesicceDreuvs1QK48NwsmL+mLW3vcNY8BOWWJROtGVQTJnXIrzJS8HAFfO7QN8jfFHVeCTbm5cnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672114; c=relaxed/simple;
	bh=qM+AUMPPSOsO/xFhj9Od+YUAH9S8lYo+uEY1V7e0Ehs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jRZVnwtbgKwkzvcEdG00Zoe0bqgHDR3pWIGdePxMVOU1MqleKnPNNtvakp2l254zyI+njR0SvQTY0KpW7nO6mreoReGF11XU0V20e8iyJvh3XKr6njEh8uTiEiPNe7L/QoxKHznATWlVZovkFgfI8F+Duazp7/XQHhIrM5plUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=M0rQgl3H; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="M0rQgl3H"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d1959ba05cso2337002a34.2
        for <linux-security-module@vger.kernel.org>; Mon, 09 Feb 2026 13:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770672112; x=1771276912; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bf/ok2KALFW8VblL1bFh6P+HrccoXJ2oopKC4NTt0RY=;
        b=M0rQgl3HhyvQ4gLR55NLX75GsoHZe3qrRWK1uke2iR9s2NNpG2YUndH1vbNEVfCk6b
         9ZGSBgxpbCiuW2VaeJ1vxVN0W44PyFwB/j+UHzME3NvPn1iRIEAuQ7lXpnST1iw5M+rL
         NK9U67RQbiI+PEuahnwZRcTdBMzUDp/ua68z6H2Ji8ozigNWPULP1kC2M/vnoKgPHt0Z
         MuZRGLr+GVyQ9dDh0pf0y7AS5R49txhQtx7fVR1Daqa2cQABEG8UcsiodWI95aqs9UWy
         gxg3aqShWjgm5g3h0F++93qgb2la4ZcwF8ph98Y38VGhCAdnKzpOGGhKIfdeM8sHqs3C
         m7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672112; x=1771276912;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf/ok2KALFW8VblL1bFh6P+HrccoXJ2oopKC4NTt0RY=;
        b=qHJshDESl5k/6xPTF2DAPxEt1wknHXcuNR8vzgoeOH3kxrG9UvylmzZBVHR5AZy3mM
         TzfQKeSFhUJbQ7OkA5kzcOXtEkqW+LKiTtjGjjAbb80Sx82rsaCo9ooCcD2PxYKISyxR
         78rZHaubBrzvltGs+haF79ZzaVS0YC4A+SUOf9CTGhRUry3w9E3TB+H9P0dW9kKewY8M
         47Q94O819kgkhR/XLDwfmzJ7bKBgD/YpnQ8w88AQpCnzkR2NvXn8RKLjjWFlx+Dh1BIa
         8SdPnfHE65Bfne2dP5hdgZmVs1RtirVFR2C+i+eVCPeD0OEFbCXMvnPkcdoJVtq/wYf6
         3CWg==
X-Forwarded-Encrypted: i=1; AJvYcCU19okMOurDg0UVyu3z1C7Xy0cKK/snPZcCNOqvJ7UBfjDRV994VuE8VZkp/itMrJ31r06DRoId5B/Te8egrYGb7S+D7N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXqELPEcENwex6zL4iRymZVSROcEtlthcwf0kFJEr2HHw8tfO
	kummkhqvI7HTi4RAMuF7sNuO3XOZ/or3E8fKWZkNMKWEDZtzfkMXv4nMc3qMK8fOm30=
X-Gm-Gg: AZuq6aJ+veshxNKSwE7S/ksPyBKlnT+6V88OgjGfnZER159AcBNVlOZdg2RAuWq2dBh
	gHnsoMLlhirg0Z++D+dPt5OK61MHhgt/dn568gVsKWLfXApf6UgB+QESa2R91us63JL+FrJqo7i
	VfabKrapE2EjPb+jhSvNbnS/VgaPCTfbMtvz42d7m0uH7QnpMt0dCFAHRG88MbWquq4ZDVexr2P
	asM3LXeTb/Y+yGmrxkjCU7/TplQr3MtZSxHJgL9dc9moYea7jYS0u6j8Gp/PxF3D/ntlwxElLpa
	u8xRdJdU9FpZHZygoaxngU++ZbPYJk/QMUHPDZUEeKk5CuDgAoO0ccunNWqfFsabZ/OP9rEcgQ/
	0nbheMgPcpXOa0swhvFQ+u9QJ7Qr2LlV5Q9vhnZ7qQmcq6GYQ6wGRSe/Hhq4PX5qEq0iL4GS0Iw
	==
X-Received: by 2002:a05:6820:2293:b0:662:fc95:1f8b with SMTP id 006d021491bc7-66d0a47957dmr4593250eaf.29.1770672111997;
        Mon, 09 Feb 2026 13:21:51 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:1b37::2b6:46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d390b935asm6591730eaf.5.2026.02.09.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:21:51 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v6 0/3] ima: Detect changes to files via kstat changes
 rather than i_version
Date: Mon, 09 Feb 2026 15:21:47 -0600
Message-Id: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtPimkC/22QvW7DMAyEXyXQXBUiaesnU4suHTt0KzrQstQIS
 OLAbowUgd+9sosChu2RJO67491FF9oUOrHf3UUb+tSl5pwH/bAT/sDnryBTnWeBCktAQHmLnUw
 nljHdrhfpCIxVrNGjF1lzaUM+TLwP8fb8/vIqPvP6kLrvpv2ZXHqYjn9AdAtgDxKkZgPGO3LR+
 Cd/bK51PHIbHn1zGk2yVCtYZZmktgaqtFJAgEvpmKTHf/eMQLVEYEZEIgxc20oVtImgOWKVgjI
 CFVHJltmS3kQUc8Sqg2LsoKqsq6OpNG+nKGcIWj1SSiVLE2wR2IHZ6GIYhl/lU1q7/QEAAA==
X-Change-ID: 20251212-xfs-ima-fixup-931780a62c2c
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4605; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=qM+AUMPPSOsO/xFhj9Od+YUAH9S8lYo+uEY1V7e0Ehs=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpik/tEhamzz+u1nbpst2YvQ+dPU1OGY1iJmMYg
 jNblVKV/t2JAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaYpP7QAKCRCrJbR2A5LT
 beDyD/4r+Xpu/c71CZ+P8NnaoZ0SlBXsD7XohtI+RtA078plY8dE8W4WeoNFdvFb1wxg6/iC8iJ
 0hCm8f2h7PJrSEHB37OC5qtCmyJqwlUCDiCVnl4qYj4Qlt/vn2DP8exzr8pnJ2dEcI/rH7qRGIa
 fil52RbDaQpytIZ5pHcYuSIbitg7tX4Cvwb8IB6zV5tlse/JR3lz0unlQlKFjXW6QpR0Bk0D24/
 shpK4PNQYn+/EU2330we7bV9CNoGoSZvt7DiPxL04vv//iGWyOw261dT9yZhf3va8E4Tgq2GQc6
 RZR1BRqE9kq8VwsaNjv27IntU/7fxG+sqM0vWmC9TZzBnR4UFi0meuO9AggUKT1BqPy9KNgEjWf
 FvW61sy/xaOmU0aCCxjF9xNsLKYVQr6tshVpoT2/jWTDFNLJJ3cZdO04lwX4Dh64ChrpRc3aO1V
 R2Ki322wfm8YmSR2qd21gy5vN/GXcnBMLcZhUVeromxuZswLun6qfEqjbo1olBfRluKgsiyb3Ll
 f1VqoAU0wXw1MnbKDx6vbtfaI/MnBjbcF7hCavCy7ona4cjIUMX6I4nwxZlaA6Px9pJvfQsMtDO
 2L507pjOvrYi4yqd6TkPburqrVQxK8dIw/dh0gI9XHz5bRejZhFw3wmF5JFrqDeK6yE5Ss4k3s1
 Y9qd0ZOrkNFGPZw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

We uncovered a case in kernels >= 6.13 where XFS is no longer updating
struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS is
using multigrain ctime (as well as other file systems) for
change detection in commit 1cf7e834a6fb ("xfs: switch to
multigrain timestamps").

Because file systems may implement i_version as they see fit, IMA
unnecessarily measures files.

We're proposing to compare against the kstat.change_cookie
directly to the cached version, and fall back to a ctime comparison,
if STATX_CHANGE_COOKIE is not supplied by vfs_getattr_nosec()'s result
mask.

EVM is largely left alone since there's no trivial way to query a file
directly in the LSM call paths to obtain kstat.change_cookie &
kstat.ctime to cache. Thus retains accessing i_version directly.

Regression tests will be added to the Linux Test Project instead of
selftest to help catch future file system changes that may impact
future evaluation of IMA.

I'd like this to be backported to at least 6.18 if possible.

Patches 1 & 2 are preparation patches. Ideally patch 2 is squashed into
3, though not strictly necessary.

Below is a simplified test that demonstrates the issue such that
there are multiple unnecessary measurements occurring for actions on
a file in a stacked TMPFS on XFS, prior to the file moved over to TMPFS:

_fragment.config_
CONFIG_XFS_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_IMA=y
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y

_./test.sh_

IMA_POLICY="/sys/kernel/security/ima/policy"
TEST_BIN="/bin/date"
MNT_BASE="/tmp/ima_test_root"

mkdir -p "$MNT_BASE"
mount -t tmpfs tmpfs "$MNT_BASE"
mkdir -p "$MNT_BASE"/{xfs_disk,upper,work,ovl}

dd if=/dev/zero of="$MNT_BASE/xfs.img" bs=1M count=300
mkfs.xfs -q "$MNT_BASE/xfs.img"
mount "$MNT_BASE/xfs.img" "$MNT_BASE/xfs_disk"
cp "$TEST_BIN" "$MNT_BASE/xfs_disk/test_prog"

mount -t overlay overlay -o \
"lowerdir=$MNT_BASE/xfs_disk,upperdir=$MNT_BASE/upper,workdir=$MNT_BASE/work" \
"$MNT_BASE/ovl"

echo "audit func=BPRM_CHECK uid=$(id -u nobody)" > "$IMA_POLICY"

target_prog="$MNT_BASE/ovl/test_prog"
setpriv --reuid nobody "$target_prog"
setpriv --reuid nobody "$target_prog"
setpriv --reuid nobody "$target_prog"

audit_count=$(dmesg | grep -c "file=\"$target_prog\"")

if [[ "$audit_count" -eq 1 ]]; then
        echo "PASS: Found exactly 1 audit event."
else
        echo "FAIL: Expected 1 audit event, but found $audit_count."
        exit 1
fi

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Changes in v6:
- Patch 1: No changes
- All other patches including cover letter have descriptions updated.
- Link to v5: https://lore.kernel.org/r/20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com

Changes in v5:
- Split into patch series. [Mimi]
- Link to v4: https://lore.kernel.org/r/20260129-xfs-ima-fixup-v4-1-6bb89df7b6a3@cloudflare.com

Changes in v4:
- No functional changes.
- Add Reviewed-by & Fixes tags.
- Link to v3: https://lore.kernel.org/r/20260122-xfs-ima-fixup-v3-1-20335a8aa836@cloudflare.com

Changes in v3:
- Prefer timespec64_to_ns() to leverage attr.version. [Roberto]
- s/TPMFS/TMPFS/ in description.
- Link to v2: https://lore.kernel.org/r/20260120-xfs-ima-fixup-v2-1-f332ead8b043@cloudflare.com

Changes in v2:
- Updated commit description + message to clarify the problem.
- compare struct timespec64 to avoid collision possibility [Roberto].
- Don't check inode_attr_changed() in ima_check_last_writer()
- Link to v1: https://lore.kernel.org/r/20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com

Changes since RFC:
- Remove calls to I_IS_VERSION()
- Function documentation/comments
- Abide IMA/EVM change detection fallback invariants
- Combined ctime guard into version for attributes struct
- Link to RFC: https://lore.kernel.org/r/20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com

---
Frederick Lawler (3):
      ima: Unify vfs_getattr_nosec() stat comparisons under helper function
      ima: Make integrity_inode_attrs_changed() call into VFS
      ima: Use kstat.ctime as a fallback for change detection

 include/linux/integrity.h         | 43 +++++++++++++++++++++++++++++++++++----
 security/integrity/evm/evm_main.c |  5 ++---
 security/integrity/ima/ima_api.c  | 11 +++++++---
 security/integrity/ima/ima_main.c | 11 +++++-----
 4 files changed, 54 insertions(+), 16 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251212-xfs-ima-fixup-931780a62c2c

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>

