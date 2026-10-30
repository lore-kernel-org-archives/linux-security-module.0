Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394620;
	b=DeV6p0THr2c4TVFZJfhRVn6T3F/ywZsZVPmSD5PAHTl6K0XORIIdZO+igv+CmzUA/192
	 QUesidgMbdRTQIiBpCWiOjWODYk+PYATb7aOsYbRZZezybjq40fVppTP3l6O6EGir7Yxa
	 aWktT7t7aFKI5XEllT1JDIPvl2XLUPyLDPyYvIwkYtEzpkNwt3b6GLlI1aCIFt495psT4
	 Lh7ypai6aRqk/MnEHmk7W+c40eTglEYQoq7C/rrEYw/IZ5/shEiadKybEexKrchQC3po0
	 odexr1r/l0eWR9cZxuXIxyBL1MESrXv0EeJiWcND0TrJ7YYPwZSFcHqNg0u4gxg6NDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NRj5hwEzENLjlsB+UAcfFJohIr0Hf4YgXfYZEvjse4o=;
	b=cEbNiuZhdC7pwpxKZpYWXScc8OQi37CzERrraExJNISA1tXBSE38hZZigeADuAt6xBPr
	 YbPkkbnV0si44Crxs3gGA7XOl0BwGlCFR+ybP2gPo7XohQRpmNuvAk0K7kV39x0UyfOob
	 YtJ/A8p6/ZiwXSg8SleabvBkc/9WnWabRh9epzQCiKANfjsyl9tsC3wCK0OeX3xIcYXaa
	 4REj4LO1DmktzfSzCKFij7NUF1CrAkmb/wat5IfdXiVIXU2oUsnAj7+FtTbDSw6ODGkms
	 2Tm5WMWXO6/WELh+9XcSQOC1js7cQ4+BOPEr7tuHdDk6/uSkaEpMrj53BmK8n0firGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=Q+l1mbbi;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5860A2607
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 21:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9A5860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=Q+l1mbbi
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1846bc43c28so1413027c88.0
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793394618; x=1793999418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRj5hwEzENLjlsB+UAcfFJohIr0Hf4YgXfYZEvjse4o=;
        b=Q+l1mbbiKUvjbillm6pdJDpPjF2pQbA9OXFE3js3iBgUUgRIvYtGZk1vlSB8K/HTYA
         JHLWZiJdKozGA+8AxwHbiJNr/oGfNBn1ferC3KPHky9ffn1z68fIGBbdcJkXju0iMcjW
         D7U+S4awiVjIJvkF7oc3ImP0tcsgng9AgW3ZnSKa67rHNurXCk1N9rZPBacfFZaYkbNf
         GLpXVaw0Vn7aHSe6c1RH7FMY2Y0M8a9KhDUI6N/CNshZuvHLimKPE9hD1zC08ZX9FBNm
         tiLFtax3PWuUY+9ZwdfpCHLjjYVGmkIWm3+1+49K8AAuIDQ6MaoqvIsBm3lhULlRz9Og
         7KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394618; x=1793999418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NRj5hwEzENLjlsB+UAcfFJohIr0Hf4YgXfYZEvjse4o=;
        b=pZgcrZkezCqMYpEaUSUaLCqMGGD4Z8Iyzg6djtWYYvC8p4xOT01sP2eDcP0/7Is4YZ
         G7CfhJV4VuBNNgAOD1K0/TZ8MX7dVyz4Q7luFrnGZl6DBrATfMjHaYTnludYfg5aPYXX
         VmXKrDibXs5s8MjRiMLC4tOomGnKor5qwpzlIk1aOhD0sERlaO/1sJaDiWrGcxYThkMF
         DSij+hAZ16x0sFqfvn9Yd/ApQLZPKN4IX7bQ8f0JUNnzDFZmv1JACpqeNFUFWAAqq14N
         LO9tiF8MasuPwgubjXDJPX/w4bKrvNr27282RIXpo0IWC6z0H9p/4JxqY73i9W0j8Y5T
         FE+g==
X-Forwarded-Encrypted: i=1; AKwUvBzaMx0aIGkJiCOkJs88AgsP/+eU8zdLLf22vOAX3eFyWHxXKZrNRuAE5pLUbmMFUdejTVZAvSbYlBoaxZ68X8IJm6pkh8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpYZ6xEK//CnXeq8CaHAhBkAUQnIRKHOGpsfJCgdpLBmL7A51h
	fqNuMd3BrNdUg+HHcpDvZSFkDR5P8ru2UI4AefrizOVnusZH6DEu1cosL+Z2oh9gRw==
X-Gm-Gg: AYBFou3GpYJjvglUBzsg1v5BOPMO2kJCke3DX5WkGIDD6uVEW48Q0Si4e+g7iUBCu+M
	k/CS2ksfWxwpBC/9EPHLOqnaZ82d4PFCElp0mJ02lEpO1cBEtdGm4CNjwdvU/vgEthyNV+UORyd
	JCCN7U2FMH/OPezwejfhJHjKx/6yTob/DP0DhkQOZ65dKGeuxVV4jqoSOnPQZuwP4+TWTZgo72w
	qeFHtgX0WGvhJ0njNgP0x179RQ6Ug3rQs8Na35diU9PbKdeLYcFKebUvrMldQDnCl0JsPo+ZxKZ
	wT6PUQtPoFozpkTIP8d8pAIe9RPdkpEtCBBouXzWPcv/fkcDM40wm0FtnS8GT7JLqrBUnnfX2Vu
	Z3SpNrio7Dl/gk7DySFCGjSBlg5QvUdKX4BszIWr+q5xvEkMJgMG2k/tx+CEznvyaf8/Sjsu65A
	uLClTreKh9Mge/wTT6zRIdgsgZSgVQ4vdkDfeNiXNjKy2LxxebxJerYzZ3I7tgnv+eA/qbNexG0
	aGmReAasVpslOBJv0aEmNExT+ZFXTPz53W2usRYO89ZT7NP2UCxwdmBZJHIY5nNn+3hlNrbigyv
	CSxmC20qkalfZNR+GOOflyy3N6URNsG8p4qUqvs21Rlg0fkdozrNUxVE0wvMsNoHLIcrrHJLFMt
	qr5i2TG7gi+qV5oh77weCiNc=
X-Received: by 2002:a05:7022:2581:b0:1a8:7b58:6f1b with SMTP id a92af1059eb24-1ac5cfe587cmr5911022c88.19.1793394617878;
        Fri, 30 Oct 2026 14:10:17 -0700 (PDT)
Received: from dannyhu-upstreamLinux.sjc.aristanetworks.com ([74.123.28.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm9471777c88.21.2026.10.30.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:10:17 -0700 (PDT)
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
	Tianxing Zhang <zhangtianxing3@huawei.com>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	zhoushuiqing <zhoushuiqing2@huawei.com>,
	zhangguangzhi <zhangguangzhi3@huawei.com>,
	Danny Hu <dannyhu@arista.com>,
	Jason Yan <yanaijie@huawei.com>,
	silviu.vlasceanu@huawei.com,
	hpa@zytor.com,
	arnd@arndb.de,
	rob@landley.net,
	james.w.mcmechan@gmail.com,
	niveditas98@gmail.com,
	pierre@arista.com,
	julien@arista.com,
	kbharathi@arista.com,
	erosca@de.adit-jv.com,
	alexandr.lobakin@intel.com,
	jim_baxter@mentor.com,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bug-cpio@gnu.org
Subject: [PATCH v5 3/4] initramfs: read metadata from special file METADATA!!!
Date: Fri, 30 Oct 2026 14:09:42 -0700
Message-ID: <20261030210944.2143778-4-dannyhu@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261030210944.2143778-1-dannyhu@arista.com>
References: <20261030210944.2143778-1-dannyhu@arista.com>
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

From: Roberto Sassu <roberto.sassu@huawei.com>

Instead of changing the CPIO format, metadata are parsed from regular files
with special name 'METADATA!!!'. This file immediately follows the file
metadata are added to.

This patch checks if the file being extracted has the special name and, if
yes, creates a buffer with the content of that file and calls
do_parse_metadata() to parse metadata from the buffer.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tianxing Zhang <zhangtianxing3@huawei.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
Signed-off-by: zhoushuiqing <zhoushuiqing2@huawei.com>
Signed-off-by: zhangguangzhi <zhangguangzhi3@huawei.com>
Signed-off-by: Danny Hu <dannyhu@arista.com>
---
v5 changes:
 - clean up metadata buffer when returning from unpack_to_rootfs()

 init/initramfs.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 36254dba7822..a1744cc9523c 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -265,8 +265,8 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
-static __initdata char *header_buf, *symlink_buf, *name_buf;
-static __initdata char *metadata_buf;
+static __initdata char *header_buf, *symlink_buf, *name_buf, *previous_name_buf;
+static __initdata char *metadata_buf, *metadata_buf_ptr;
 
 static int __init do_start(void)
 {
@@ -454,6 +454,7 @@ static int __init __maybe_unused do_parse_metadata(char *pathname)
 
 static __initdata struct file *wfile;
 static __initdata loff_t wfile_pos;
+static __initdata int metadata;
 
 static int __init do_name(void)
 {
@@ -471,6 +472,10 @@ static int __init do_name(void)
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
 		return 0;
+	} else if (strcmp(collected, METADATA_FILENAME) == 0) {
+		metadata = 1;
+	} else {
+		memcpy(previous_name_buf, collected, strlen(collected) + 1);
 	}
 	clean_path(collected, mode);
 	if (S_ISREG(mode)) {
@@ -508,11 +513,47 @@ static int __init do_name(void)
 	return 0;
 }
 
+static int __init do_process_metadata(char *buf, int len, bool last)
+{
+	int ret = 0;
+
+	if (!metadata_buf) {
+		metadata_buf_ptr = metadata_buf = kmalloc(body_len, GFP_KERNEL);
+		if (!metadata_buf_ptr) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		metadata_len = body_len;
+	}
+
+	if (metadata_buf_ptr + len > metadata_buf + metadata_len) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(metadata_buf_ptr, buf, len);
+	metadata_buf_ptr += len;
+
+	if (last)
+		do_parse_metadata(previous_name_buf);
+out:
+	if (ret < 0 || last) {
+		kfree(metadata_buf);
+		metadata_buf = NULL;
+		metadata = 0;
+	}
+
+	return ret;
+}
+
 static int __init do_copy(void)
 {
 	if (byte_count >= body_len) {
 		if (xwrite(wfile, victim, body_len, &wfile_pos) != body_len)
 			error("write error");
+		if (metadata)
+			do_process_metadata(victim, body_len, true);
 
 		do_utime_path(&wfile->f_path, mtime);
 		fput(wfile);
@@ -524,6 +565,8 @@ static int __init do_copy(void)
 	} else {
 		if (xwrite(wfile, victim, byte_count, &wfile_pos) != byte_count)
 			error("write error");
+		if (metadata)
+			do_process_metadata(victim, byte_count, false);
 		body_len -= byte_count;
 		eat(byte_count);
 		return 1;
@@ -539,6 +582,7 @@ static int __init do_symlink(void)
 		return 1;
 	}
 	collected[N_ALIGN(name_len) + body_len] = '\0';
+	memcpy(previous_name_buf, collected, strlen(collected) + 1);
 	clean_path(collected, 0);
 	init_symlink(collected + N_ALIGN(name_len), collected);
 	init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
@@ -614,6 +658,7 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		char header[CPIO_HDRLEN];
 		char symlink[PATH_MAX + N_ALIGN(PATH_MAX) + 1];
 		char name[N_ALIGN(PATH_MAX)];
+		char prev_name[PATH_MAX + N_ALIGN(PATH_MAX) + 1];
 	} *bufs = kmalloc_obj(*bufs);
 
 	if (!bufs)
@@ -622,6 +667,7 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	header_buf = bufs->header;
 	symlink_buf = bufs->symlink;
 	name_buf = bufs->name;
+	previous_name_buf = bufs->prev_name;
 
 	state = Start;
 	this_header = 0;
@@ -664,6 +710,9 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	dir_utime();
 	/* free any hardlink state collected without optional TRAILER!!! */
 	free_hash();
+	kfree(metadata_buf);
+	metadata_buf = NULL;
+	metadata = 0;
 	kfree(bufs);
 	return message;
 }
-- 
2.51.0

