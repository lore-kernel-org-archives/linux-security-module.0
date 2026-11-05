Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907478;
	b=U+2t4v6jVDApbne0T0UaMLu2t/xsvp3GK3Df2JazPNXpfF3cPHnMNidpzCvSVjf2lEw8
	 sdXt+hejfjH275SWRRXTbIStwPEdAiW1mInQnJG0qaLfxisRfnb8kVBMdCjq9unPKIEaV
	 +ggcDP9nwFo6tvfg5bhI3pECjUqWjLx5eEpY8qQO5OdfYNciNLmf2E9y3BH0A/yy84pYD
	 4+NBcB9ScoJkAjDXCUn98jb9Bjdgr4OODuog6mIyyvFDy76S6N/47N9R+R6ctXt/bBVV7
	 Z32V087jHrw+Cio8pKBCNt59YiAx6qwKi76G+OoFIZfzhzPpe8sVdwkI8TycQWubZjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3AyWWDFVbKJ/DkrPhpXcM2lwKymyXBABHoZtsa2/+w4=;
	b=XkZvFZ1RqvTmi1RFUJRHha/z5gKmknTjfmTad4gdyvPNQA+Fb2lw1vaZl9g22P+cVc9i
	 EZ4qoJ53jTTZVKvy/GuMBZOoa3epiy5/KjvAllYEz6sQwUwXOXrumWG8/KFGH8aLsPls8
	 TXlRXiNFzWUrpwN23vq7Ba1YVDxWFM4ox7CvalNKqIwFzT48+ToyrH5DyXUcsoKkyi6+n
	 ftjx0u6ekZXylqKoHm2YItnK5HRsTugJkDJB3isHrWlZ9yAgHOcooBhtJ5tsf6ze3mNcs
	 KjiAbDlAiZuBx4NW2IQaBhko7SiW+qZ8o3TgALham4DRJ0R/Bud0XdNstIlATkkCZfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=cPl6L7vv;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029E607B972
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 19:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3029E607B972
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=cPl6L7vv
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3706111eec.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 11:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793907477; x=1794512277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3AyWWDFVbKJ/DkrPhpXcM2lwKymyXBABHoZtsa2/+w4=;
        b=cPl6L7vv4IdiTxomRsfBZyJX59O6aKePsnYBsOL+Il0TM2e7QZLMYUoor5RewSvnv7
         vLLbLRMSyMW/YKWH7JVRt+VA8awqGEfSTnb3NSI212h84khTjynO2iw5mzK2nVh11z5d
         EZ6tC6WQcQkAThRjYpVZDYHpM0IHCup/ssjDItaCiUmXD6fNSzFXuqyMXfcjXo9Y3C18
         AjZA2LqCbQEPJQKpzTHX/9JMW5k+59UhN0TUOXzSYbdIuRgq6YZLqhp3MfDyp1FFBB4n
         21C0wHgHpp9aOnGvecq21MbiLJ846BIuczpuDUnGu78BBlZgT6V+04NGwiDJ3uZbl2e6
         YlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907477; x=1794512277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3AyWWDFVbKJ/DkrPhpXcM2lwKymyXBABHoZtsa2/+w4=;
        b=jArlP18TEzU3T2rgPPRjaTE0uD5CBTwzu6eujN9dikmociqRHoaZhOl6OjfqbiOdHU
         gz7We7beaEtHUBDmvyoXIteF/yuOkctoTCR0SPw9hHBrfIZ4i7/UfJ+VQdrCUQOTiQP0
         6EsVEKn4Y5TRtL+ucQCr9bj7WwRagEovgDBx5/PAgZzEy1AhRPe/SVLHt4DY5JFgg2xB
         cVmbDdJqynGZgI6VoJpaOJ1skIsrYYOzbKEVpbkPIl7Oz+PZW6TTEmOe8Ym21KiEjduY
         jyE8uXubw18+W6XeJOuOSj7kSjVvSjtZmMNQfSENQTWewF2KBgoJ9ES9MPgHlc24eC1Z
         HrBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNSP3kzKUFzSNOoS2kUohhkPR3heAVVuFLo7IS3R154VMDcp1wLluETOTlTAH75s2N6+hkfgE4fCI4WoguqJEPm1DKHbU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9O0eRZ87pmKN7/z7PAEwn/f8cWITa+1cEP4IHh21m7bTehneAM
	s7wroLTZfWAPwMicMIdYBMgDNzE5w3flW8eypDtQFi5FqcVzYRQpnEyb1HvbMqqmrQ==
X-Gm-Gg: AYBFou2dZncJSD2P8FMg//6NHyiveJ43geDSHNSiV1ZcI4ZbO4FnQs8PDRLkkEP/zzC
	fvRnCEY++382E0hNcbsMBZXQiRIemFKnClgxJdIgIGv8H5WjtoLaYsvXeNrJzNSlxyVDJSQRWS/
	uNkRjgtM0Wle2jiap9e2a46mknU3r4to/iISyisbhFR6ia0nDwEAT/jwEGqbuXdWiAeqK8od2YN
	cdI8edoWKqiR8ilSd6Zw/r8GOK1B7NIADtQ+WY5q2vcTjDz+J1sK4MCV9l7G4x1u+POHS95rq46
	Y3aHtkd9mgIpBro8tC34rYWNaj9wmN+ADbb+gkbJqPpADocO7vTQl7lzxXaic/CqnelFrmLrB14
	U2ug88qTPbT8aixfSWQaNzZy37ZoRc6z9/kYML86bhkoGgrh0Ltu9h5/M/1mIHt9ia60GqFPp3K
	gFlH33tMOw+2nAT8kKrMyeObcoM6qcW3DSkL3BoLh1YSHvDGP4VlEKVlF0y6mv2UmBKso36De+W
	WDPwlAxq4FTQUpnCFe7mXLb/ziPMbl3lOv6jBGqUadZjMAjlqZaygIIpssOEz348/8JYvsNOopq
	DDa+nRn45ElwCbAd/eqm8FYKXuvn9s1w7cRE/ADOYrB80YV97CrljjW54jaiQrH5GDGxOERwYgC
	K0IHVkcyFh3Amgj7X35cZnWA=
X-Received: by 2002:a05:7301:6285:b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-36f76f0e752mr142560eec.38.1793907476899;
        Thu, 05 Nov 2026 11:37:56 -0800 (PST)
Received: from dannyhu-upstreamLinux.sjc.aristanetworks.com ([74.123.28.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f72ec8a02sm326134eec.11.2026.11.05.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:37:56 -0800 (PST)
From: Danny Hu <dannyhu@arista.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Jan Kara <jack@suse.cz>,
	Victor Kamensky <kamensky@cisco.com>,
	Taras Kondratiuk <takondra@cisco.com>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	zhangguangzhi <zhangguangzhi3@huawei.com>,
	Danny Hu <dannyhu@arista.com>,
	Jason Yan <yanaijie@huawei.com>,
	silviu.vlasceanu@huawei.com,
	hpa@zytor.com,
	arnd@arndb.de,
	james.w.mcmechan@gmail.com,
	niveditas98@gmail.com,
	pierre@arista.com,
	julien@arista.com,
	kbharathi@arista.com,
	alexandr.lobakin@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bug-cpio@gnu.org
Subject: [PATCH v6 2/4] initramfs: add file metadata
Date: Thu,  5 Nov 2026 11:37:41 -0800
Message-ID: <20261105193743.2654656-3-dannyhu@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261105193743.2654656-1-dannyhu@arista.com>
References: <20261105193743.2654656-1-dannyhu@arista.com>
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

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

This patch adds metadata to a file from a supplied buffer. The buffer might
contains multiple metadata records. The format of each record is:

<metadata len (ASCII, 8 chars)><version><type><metadata>

For now, only the TYPE_XATTR metadata type is supported. The specific
format of this metadata type is:

<xattr #N name>\0<xattr #N value>

[kamensky: fixed restoring of xattrs for symbolic links by using
           sys_lsetxattr() instead of sys_setxattr()]

[sassu: removed state management, kept only do_setxattrs(), added support
        for generic file metadata, replaced sys_lsetxattr() with
        vfs_setxattr(), added check for entry_size, added check for
        hdr->c_size, replaced strlen() with strnlen(); moved do_setxattrs()
        before do_name()]

[zhangguangzhi: fix checkpatch warning EMBEDDED_FILENAME in
                include/linux/initramfs.h]

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Tianxing Zhang <zhangtianxing3@huawei.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
Signed-off-by: zhoushuiqing <zhoushuiqing2@huawei.com>
Signed-off-by: zhangguangzhi <zhangguangzhi3@huawei.com>
Signed-off-by: Danny Hu <dannyhu@arista.com>
---
Changes in v6:
 - Document lack of support for POSIX ACL restoration. The main use case is to
   restore security.ima xattr for IMA use. POSIX ACL support is out of scope
   for this patchset
 - Check xattr name and value lengths to ensure they are valid and do not
   exceed the limit
 - Compare metadata header and record sizes against the remaining buffer
   length to avoid pointer arithmetic overflow in bounds checks
 - Use the kernel u32 type instead of uint32_t

Changes in v5:
 - For debug print in do_setxattrs(), use print_hex_dump_debug() rather
   than printing the xattr value as a string
 - Use u32 metadata record lengths and reject records smaller than their
   header

 include/linux/initramfs.h |  19 +++++++
 init/initramfs.c          | 103 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/initramfs.h

diff --git a/include/linux/initramfs.h b/include/linux/initramfs.h
new file mode 100644
index 000000000000..9b3839dc88a1
--- /dev/null
+++ b/include/linux/initramfs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Include file for file metadata in the initial ram disk.
+ */
+#ifndef _LINUX_INITRAMFS_H
+#define _LINUX_INITRAMFS_H
+
+#define METADATA_FILENAME "METADATA!!!"
+
+enum metadata_types { TYPE_NONE, TYPE_XATTR, TYPE__LAST };
+
+struct metadata_hdr {
+	char c_size[8];     /* total size including c_size field */
+	char c_version;     /* header version */
+	char c_type;        /* metadata type */
+	char c_metadata[];  /* metadata */
+} __packed;
+
+#endif /*LINUX_INITRAMFS_H*/
diff --git a/init/initramfs.c b/init/initramfs.c
index ebddde9c8f0d..d206624d1160 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -10,7 +10,9 @@
 #include <linux/hex.h>
 #include <linux/init.h>
 #include <linux/init_syscalls.h>
+#include <linux/initramfs.h>
 #include <linux/kstrtox.h>
+#include <linux/limits.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/namei.h>
@@ -22,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/umh.h>
 #include <linux/utime.h>
+#include <linux/xattr.h>
 
 #include <asm/byteorder.h>
 
@@ -189,7 +192,7 @@ static __initdata time64_t mtime;
 
 static __initdata unsigned long ino, major, minor, nlink;
 static __initdata umode_t mode;
-static __initdata unsigned long body_len, name_len;
+static __initdata unsigned long body_len, name_len, metadata_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata unsigned rdev;
@@ -264,6 +267,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 }
 
 static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *metadata_buf;
 
 static int __init do_start(void)
 {
@@ -365,6 +369,103 @@ static int __init maybe_link(void)
 	return 0;
 }
 
+static int __init do_setxattrs(char *pathname, char *buf, size_t size)
+{
+	struct path path;
+	char *xattr_name, *xattr_value;
+	u32 xattr_name_size, xattr_value_size;
+	int ret;
+
+	xattr_name = buf;
+	xattr_name_size = strnlen(xattr_name, size);
+	if (xattr_name_size == size) {
+		error("malformed xattrs");
+		return -EINVAL;
+	}
+
+	if (!xattr_name_size || xattr_name_size > XATTR_NAME_MAX) {
+		error("invalid xattr name length");
+		return -EINVAL;
+	}
+
+	xattr_value = xattr_name + xattr_name_size + 1;
+	xattr_value_size = buf + size - xattr_value;
+	if (xattr_value_size > XATTR_SIZE_MAX) {
+		error("xattr value exceeds size limit");
+		return -EINVAL;
+	}
+
+	ret = kern_path(pathname, 0, &path);
+	if (!ret) {
+		/*
+		 * POSIX ACL restoration is currently unsupported.
+		 * vfs_setxattr() rejects POSIX ACL xattrs with -EOPNOTSUPP.
+		 */
+		ret = vfs_setxattr(&nop_mnt_idmap, path.dentry, xattr_name, xattr_value,
+				   xattr_value_size, 0);
+
+		path_put(&path);
+	}
+
+	pr_debug("%s: %s size: %u (ret: %d)\n", pathname, xattr_name,
+		 xattr_value_size, ret);
+	print_hex_dump_debug("xattr value: ", DUMP_PREFIX_OFFSET,
+			     16, 1, xattr_value, xattr_value_size, false);
+
+	return ret;
+}
+
+static int __init __maybe_unused do_parse_metadata(char *pathname)
+{
+	char *buf = metadata_buf;
+	char *bufend = metadata_buf + metadata_len;
+	struct metadata_hdr *hdr;
+	char str[sizeof(hdr->c_size) + 1];
+	u32 entry_size;
+
+	if (!metadata_len)
+		return 0;
+
+	str[sizeof(hdr->c_size)] = 0;
+
+	while (buf < bufend) {
+		int ret;
+
+		if (bufend - buf < sizeof(*hdr)) {
+			error("malformed metadata");
+			break;
+		}
+
+		hdr = (struct metadata_hdr *)buf;
+		if (hdr->c_version != 1) {
+			pr_debug("Unsupported header version\n");
+			break;
+		}
+
+		memcpy(str, hdr->c_size, sizeof(hdr->c_size));
+		ret = kstrtou32(str, 16, &entry_size);
+		if (ret || entry_size < sizeof(*hdr) ||
+		    entry_size > bufend - buf) {
+			error("malformed xattrs");
+			break;
+		}
+
+		switch (hdr->c_type) {
+		case TYPE_XATTR:
+			do_setxattrs(pathname, buf + sizeof(*hdr),
+				     entry_size - sizeof(*hdr));
+			break;
+		default:
+			pr_debug("Unsupported metadata type\n");
+			break;
+		}
+
+		buf += entry_size;
+	}
+
+	return 0;
+}
+
 static __initdata struct file *wfile;
 static __initdata loff_t wfile_pos;
 
-- 
2.51.0

