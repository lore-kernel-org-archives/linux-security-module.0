Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284078;
	b=Ii6zsT9We3wrmYmOBiiespWwZZ6FflQolJfIoGbzr/JUQv7OmKH/qgId543sHjqSDYUS
	 2HwzHs0q9ggGbQZe227dlwNhuRjB7fPk/Bv7pYXumfHyRVp635hjZTmrFzabDqt/HXvw4
	 gBGEEx6aG9WrZbmSTxXrAWQ7Fgoa/b9QJ85T4huzwsWC0DmrcbLaVDg2d1bIIHc1cYIdq
	 HrPrm8XJnuSPWuVVXAhEQZ2ycUFiL3979Cee6B4S+2qqs8/F0nRAtNEHkiUzgtYi48r4x
	 nR0lWJYVgUtCef33h9n44vWAhwE7yLTCGxz+kgCtXSm/hX4WsMLPq6mYIjvP4lixhoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284078;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=/A0MxQglS0ZHNGIlbC4lGCMwN6cadxGitHtdMgDjhiI=;
	b=ABQPoYcMlbWPyEq9hwQY+sDgmbeGJ6F49YnAUha1TLYO16e5Y9yDnNlrHqDbzUi4vpQD
	 UI3yzjVmzN/up5hsxgooaZObb6QZQ40ROvYbKHZ38MqkOapIw0AER6SxuY2olOpTEnpPa
	 kit5/f+UGKvJdfe2NClkBUaU7psKgPV96X1u/xqpga9rFblWOM7HJUir8ZxRjWtgT8sVz
	 KfPACokFc9jJBAfQIeEf/tXywNJcTOo4Hw8QK+cV3ND5CYwuBmy6ERo1D7MycCziaZSQw
	 S6mNYqZxeh+SBrUSIz4MLj9VO+7ZaBLYdtCM+6C61/5jsKvfAmmYNg6bOWYbax7of2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.154
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95B606A31A;
	Thu, 29 Oct 2026 14:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF95B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jFmlv4x8lzsbTh;
	Thu, 29 Oct 2026 22:27:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id 0EF6840006;
	Thu, 29 Oct 2026 22:27:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0BGLGLcV+NqQagGAA--.23469S2;
	Thu, 29 Oct 2026 15:27:47 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	fabrice.derepas@canonical.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] evm: Bound writes in evm_read_protected_xattrs() to buffer_size
Date: Thu, 29 Oct 2026 15:27:07 +0100
Message-ID: <20261029142707.2602008-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD2AHCbuQyKwR27hNcYRhU7njCeigmQoL9x9i25zb0N5-8Kx+A@mail.gmail.com>
References: <CAD2AHCbuQyKwR27hNcYRhU7njCeigmQoL9x9i25zb0N5-8Kx+A@mail.gmail.com>
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
X-CM-TRANSID:nRC2B0BGLGLcV+NqQagGAA--.23469S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCry7GFW3KFWrtry5ZFW3Awb_yoWrKF4fpF
	ZxKayxGrs5JFyxGr9xCF1fJayrurZxXr1UKrWkG3WjywnIkws7ZrWxKryYgrW8urn7trn5
	trZ0qrn5Crn8A3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xU4NB_UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHDWriukpvEQAAsN

From: Roberto Sassu <roberto.sassu@huawei.com>

ima_eventinodexattrs_init_common() calls evm_read_protected_xattrs()
first with a NULL buffer to obtain the required size, allocates a buffer
of that size, and then calls it again to fill it. Nothing keeps the
result stable between the two calls: a protected xattr may be added to
evm_config_xattrnames through the evm_xattrs securityfs file (with
CONFIG_EVM_ADD_XATTRS=y), or a protected xattr may be set on, removed
from, or changed in the measured file in the meantime.

However, the 'n' (names) and 'l' (lengths) cases write into the buffer
without checking buffer_size, so if the data grew between the two calls,
they write past the end of the allocation.

The 'v' (values) case passes the remaining space to __vfs_getxattr(),
so the copy itself is bounded, but advances total_size by the length
returned by the earlier probing __vfs_getxattr() call, rather than by
the length actually copied. This causes two problems:

- If the probed size fits in the remaining space, but the value shrinks
  before the copy, total_size does not exceed buffer_size, but the
  returned size covers bytes of the buffer that were not written.

- If the probed size exceeds the remaining space, but the value shrinks
  enough to fit before the copy, total_size exceeds buffer_size after
  adding the probed size.

In addition, once the buffer is full, any further non-empty xattr (e.g.
one added to the list or set on the file after the buffer size was
determined) is read with a zero remaining size. Some filesystems, such
as XFS and btrfs, take a zero size as a request for the xattr length,
return it without copying, and total_size exceeds buffer_size as well.

When total_size exceeds buffer_size, either the next iteration passes a
negative remaining size to __vfs_getxattr(), converted to a huge size_t,
causing a write past the end of the buffer, or the caller reads past
the end of the buffer.

Return -ERANGE in the 'n' and 'l' cases when the data no longer fits in
the buffer. In the 'v' case, skip the copy if the probed length is zero,
return -ERANGE if no space is left, so that __vfs_getxattr() is never
called with a zero size, and advance total_size by the number of bytes
actually copied. Since __vfs_getxattr() then either copies at most the
remaining space or fails with -ERANGE, total_size never exceeds
buffer_size. Also document the -ERANGE return in the kernel-doc.

On -ERANGE, ima_eventinodexattrs_init_common() records an empty template
field, as it already does for the other errors.

Fixes: 8314b6732ae4 ("ima: Define new template fields xattrnames, xattrlengths and xattrvalues")
Reported-by: Fabrice Derepas <fabrice.derepas@canonical.com>
Closes: https://lore.kernel.org/linux-integrity/CAD2AHCbuQyKwR27hNcYRhU7njCeigmQoL9x9i25zb0N5-8Kx+A@mail.gmail.com/
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 5be9349afcd0..a29b7f80e55d 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -369,6 +369,10 @@ int evm_protected_xattr_if_enabled(const char *req_xattr_name)
  * given dentry and return the total size of copied data. If buffer is NULL,
  * just return the total size.
  *
+ * The set of protected xattrs and their values may change between a call with
+ * a NULL buffer and a subsequent call with a buffer of the returned size. If
+ * the data no longer fits in @buffer_size, -ERANGE is returned.
+ *
  * Returns the total size on success, a negative value on error.
  */
 int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
@@ -389,6 +393,9 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 		case 'n':
 			size = strlen(xattr->name) + 1;
 			if (buffer) {
+				if (size > buffer_size - total_size)
+					return -ERANGE;
+
 				if (total_size)
 					*(buffer + total_size - 1) = '|';
 
@@ -398,6 +405,9 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 		case 'l':
 			size = sizeof(u32);
 			if (buffer) {
+				if (size > buffer_size - total_size)
+					return -ERANGE;
+
 				if (canonical_fmt)
 					rc = (__force int)cpu_to_le32(rc);
 
@@ -407,12 +417,22 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 		case 'v':
 			size = rc;
 			if (buffer) {
+				/* Nothing to copy. */
+				if (!size)
+					break;
+
+				/* A zero size would query the length. */
+				if (buffer_size - total_size == 0)
+					return -ERANGE;
+
 				rc = __vfs_getxattr(dentry,
 					d_backing_inode(dentry), xattr->name,
 					buffer + total_size,
 					buffer_size - total_size);
 				if (rc < 0)
 					return rc;
+
+				size = rc;
 			}
 			break;
 		default:
-- 
2.43.0

