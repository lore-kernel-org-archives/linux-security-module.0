Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795854555;
	b=oo2cAvWqAks1c6fCdNxXNVGzoQylTNgl2iNNHN/F4FzVqG5Zj8rZw0YMkOL96uB6Jqen
	 BGSCYYmxr6S2yCKOPsig0DTNiZQOE9BCKhYXZWoV1SoTZyAI7nEEyx1nSfIwkhSpDpWaL
	 /czMGxUUlI+V4BMrsxOb172ONUrvvhk1jftnE6ijKoolWUZxqcIGuB9z+M80s1nPoTCHw
	 ICWEUf+P6fPzvpsBJXIGvDfnnMsW4yYcJgWZqAHuhwDlu9rbNoo0qaVvNSuFt2DZYveNp
	 purMsyyx2pytGZjX0uC2t63N6ObtkjTq6V+ZkinEo4ZfqBingmf78LFQp2f111vgX9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795854555;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=04XWHo51I/iilyFUIsQQzqp7PbV+QbY/1nUKexvohFc=;
	b=bOdkdk556OTDkQyoFz8zMO4o+Is/aEKgL9Mpx5aXYyhMT5W7KcfLIgGFG0yron00eNOh
	 2byEk0FkL1RdFgHnuhQC/SIcrVEYVFdXxBp9YWRTAMjlwWabym70vRlnjBu6AECf1o8h6
	 jgui/8lI79fmvKjre1U25dhrbjyh9RjZ5AOCx6I4ysQSBNlxLCgTDrnX2BQ2ARiK39+dx
	 ZNhbblyKKg2ZcT6HMA9nDCQMHe3sc55rDSvPLMrWpRu3K6XvzytiD7NXHc4QmIZ8F+3Mi
	 aKu/FNvDvkKPtG3w8mnvcb0zYOPYnRWFsgc2Jk3LuZBWhdK5HoIFbzR3EM3Q3Ra5oQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TFacgqbf;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16667606A31C;
	Sat, 28 Nov 2026 08:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16667606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TFacgqbf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=04
	XWHo51I/iilyFUIsQQzqp7PbV+QbY/1nUKexvohFc=; b=TFacgqbfCdMuAnGz8f
	T6/KpAcLGoZ13vVIgeEhdReGFTrXhcmVdCBc56zBPvHS5DCjGrp211RbLLpVE6Z0
	v3hWieDLCOAGGxug5/7/FFIQW4vZfXO5lnYDfzN62IAV4EPWbwx3FH4Gcpz8xJ2i
	F2X1LqqPjiUtgf0e2R9ple3iM=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3n7qokAprhidDKg--.24836S2;
	Sat, 28 Nov 2026 16:28:25 +0800 (CST)
From: shaos <shawnq1@163.com>
To: casey@schaufler-ca.com
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smack: mediate file attribute syscalls
Date: Sat, 28 Nov 2026 08:28:23 +0000
Message-Id: <20261128082823.3074924-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n7qokAprhidDKg--.24836S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur4fKryUGFyDWFWrtry3CFg_yoW7JFyUpF
	Z0qa43Kws5JFW7Gr93KF1UZ3Z09F4xGr4UXwnF9F4xZ3ZxGw1xKFyjvw1jyF15Grykurs0
	qF4jvF1UWa15A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz_M3UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8QmruWsKkKlgdgAA3k

Hello,

Smack does not implement the inode_file_getattr and inode_file_setattr
hooks.  As a result, the file_getattr() and file_setattr() system calls
bypass Smack's existing read and write checks.

The reproducer runs as uid 1000 without capabilities and changes its
Smack label to Subject.  A stat() on /mnt/secret is denied, but
file_getattr() on the same file succeeds.  The Subject label has only
read access to the Control label, yet file_setattr() clears the file
flags on /mnt/control.  Ordinary open() checks continue to be enforced.

This bypass exposes file attribute metadata and permits changes to file
attributes that the Smack policy denies.  It does not expose file contents
or demonstrate privilege escalation.

Tested source revision:
HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: Linux 7.4.0-rc4
compiler:       gcc (Ubuntu 11.4.0-1ubuntu1~22.04.3) 11.4.0,
                GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/fbf8b7f663ee82593d7d41623aa2e2c4/raw/2ad22ab46d2cf376b59ef361d9c7ca2b691c6eda/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/fbf8b7f663ee82593d7d41623aa2e2c4/raw/f9e1ceca2f52ead87738af313610fc49834654dc/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/fbf8b7f663ee82593d7d41623aa2e2c4/raw/d9b447aad65076391390d150d752b6b9cb116abc/poc.c

Build the kernel at the tested revision with the attached configuration.
The reproducer is a static init program and expects an ext4 image on
/dev/vda containing empty files named secret, control, and public:

    truncate -s 32M smack.img
    mkfs.ext4 -F smack.img
    mkdir mnt
    mount -o loop smack.img mnt
    touch mnt/secret mnt/control mnt/public
    umount mnt
    gcc -O2 -Wall -Wextra -static -o poc poc.c
    mkdir -p rootfs
    cp poc rootfs/init
    chmod 0755 rootfs/init
    (cd rootfs && find . -print0 | cpio --null -o -H newc) |
        gzip -9 > initramfs.cpio.gz

Boot the initramfs and ext4 image with:

    qemu-system-x86_64 -m 2G -smp 2 \
        -kernel <linux-tree>/arch/x86/boot/bzImage \
        -initrd initramfs.cpio.gz \
        -drive file=smack.img,format=raw,if=virtio \
        -append 'console=ttyS0 rdinit=/init lsm=smack loglevel=7' \
        -nographic -monitor none -no-reboot

On two vulnerable boots, file_getattr() on /mnt/secret returned success
while stat() returned -EACCES.  file_setattr() on /mnt/control also
returned success and cleared its flags.  With this patch, both denied
operations return -EACCES; permitted operations on /mnt/public still
succeed.

Implement both hooks with the same Smack access checks used by the
existing getattr and setattr hooks:

Fixes: defdd02d783c ("lsm: introduce new hooks for setting/getting inode fsxattr")
Signed-off-by: shaos <shawnq1@163.com>
---
 security/smack/smack_lsm.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3a4a33568297b..6da2492f9bb61 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1311,6 +1311,34 @@ static int smack_inode_getattr(const struct path *path)
 	return rc;
 }
 
+static int smack_inode_file_getattr(struct dentry *dentry,
+				    struct file_kattr *fa)
+{
+	struct smk_audit_info ad;
+	struct inode *inode = d_backing_inode(dentry);
+	int rc;
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+	rc = smk_curacc(smk_of_inode(inode), MAY_READ, &ad);
+	rc = smk_bu_inode(inode, MAY_READ, rc);
+	return rc;
+}
+
+static int smack_inode_file_setattr(struct dentry *dentry,
+				    struct file_kattr *fa)
+{
+	struct smk_audit_info ad;
+	struct inode *inode = d_backing_inode(dentry);
+	int rc;
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+	rc = smk_curacc(smk_of_inode(inode), MAY_WRITE, &ad);
+	rc = smk_bu_inode(inode, MAY_WRITE, rc);
+	return rc;
+}
+
 /**
  * smack_inode_xattr_skipcap - Skip the xattr capability checks?
  * @name: name of the xattr
@@ -5185,6 +5213,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_permission, smack_inode_permission),
 	LSM_HOOK_INIT(inode_setattr, smack_inode_setattr),
 	LSM_HOOK_INIT(inode_getattr, smack_inode_getattr),
+	LSM_HOOK_INIT(inode_file_getattr, smack_inode_file_getattr),
+	LSM_HOOK_INIT(inode_file_setattr, smack_inode_file_setattr),
 	LSM_HOOK_INIT(inode_xattr_skipcap, smack_inode_xattr_skipcap),
 	LSM_HOOK_INIT(inode_setxattr, smack_inode_setxattr),
 	LSM_HOOK_INIT(inode_post_setxattr, smack_inode_post_setxattr),
-- 
2.34.1

Thanks,

shaos

