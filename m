Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1F41CB31
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330010; cv=none; b=jMYZIqp0KO42MYfW473JfTJGA1Q1F9Bb68kqT/2knYksotya8bqmY8U9KdeCP+O1wWwQjLX/BeB7eLwCPftp+bshO3NC9DHEemWu4CFY+cL99L3ghj97Jq0JqMDxZ5y/vmoyInirVZFi6LDZ0X4Kit/ORT3VJ5t1ipmIrxkgGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330010; c=relaxed/simple;
	bh=6GRmHPLR3TCBKfBWB4SA0tOdNi5yoK35GggbLziGW1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgcqvbDmXcsWWoYteW5HT1NB8CLbqPZa1LEjkF11r2m+8/PnQrdxp/JAef1MK6BeTam7QEoWMrJU/LVROpHCCLDssGRlLGQBPinxOy6NughVkY/OqlSqPhtxoZbIJ7AbgIi0QUC6hJGPXx3UqQ488RevEp131amGPUAm/5PVDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg//vogO; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg//vogO"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87fd84c0bfeso131692b3a.3
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790330008; x=1790934808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGO9gkMm/hjzd0yK8CgZnet7IwsFNqJtn1zmuKbVxic=;
        b=gg//vogOWU/RAeqYZxulKUi27gcuiAoTzhF165r+EXvbak6awTs0cPaKfBbSVd4MI3
         5TszjsJSQjGbQX/ksNczbyXILIlOFc/qnpzUUfFGkb41Bw6xm/YY2DA3Fsna40JCyiMs
         +KdPvHeND0GdEcEIiibjwEMA90xuHrnIghe2pN35Gg9WoNJ948MK7sL3lHHJVyfwXSka
         V36P9KHbNfd+Ch8sZMgop2BtTHSXFXCYcPjv9FaGgKz/GxiYDFqSZMCJ2V8Zp5vi1Toe
         Tr1SvKf7Q6OxN+mgLhlLNg+q1noF9b8cVk2Qo4CHvdEO3vrZAysRPRQwTj/2pFHKVDJZ
         OygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790330008; x=1790934808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGO9gkMm/hjzd0yK8CgZnet7IwsFNqJtn1zmuKbVxic=;
        b=IyGf4PhQrlaPdQFnEs/uNPgqdC3KxDyttFQdRl0GwtSvcGzRXsLFC5rUAQbrAG21PB
         kRt8Yxv81TRH6eK3w3zx6LIBrex439+UbwB8ifycnTJ08Ndoftq/NBm+yDEjoNW1fUWq
         w81T8Fto2Es6GSOcJceke2idmZGsY5GRxeQlCrnuMSDBDJmcpmPye/0+uFqemry7SYgO
         8hZeO7v/X/v/xoZWyi/YDcKA+i5mRqVVvS3tdMVWyw8Cq3ZixvdXQHaZ1Zted79d/mn7
         B+/d+VoGHO+atZLueYPSCpvw7lpkmYmZhdZsGWpiwJMx3pqsYXJGHpgwM98X1EZEhRrj
         3jEw==
X-Forwarded-Encrypted: i=1; AKwUvBwRIscQDtAgs++OWaClUa9byIPcM7I1+07rlamjuqQuLPtMn63xikmQsCcYrrROTXAtrVzLzv5Nb/0J81iZtjiG8fDbp6M=@vger.kernel.org
X-Gm-Message-State: AFuF++kOpng4aJx1kAxsC53p3wHaKdGHkpkKbpdAECXrPEIT0RfQTOa+
	cMS2mexR/GoMRK+2NuW/VS5GJRMA/P3Sh8zRZDpOaFS+Icm0mNV6iQBK
X-Gm-Gg: AYBFou1yPRc7oS89o8ty4cCz59iZT+3xMD5nculSR5i3jF3zqSb/CdzRbPfCkjpf/e4
	SYxNgGSW11k0eGqRgiXhkn+WA0X88S880Oh+cyIJnuxryRPkaKi6M20ju70i6fH89ihraeFvnAB
	ZMAA4MOW0b2ybWzpJjtIIVBHqWtO6fqekNPiUh08AuLtut83OJUZzK6fkft5QT9KvOlJfk5TJv7
	EA/rv2xXKFmNOcviebGZaDIhDddxbcTwC0uY0fXJw3LAN5Eo1cu4WBG9xZTE9FL+caKg2axt+lW
	2PKXyTZmZADrQi0BRSpAZUngX4+AX5Rn9vo4FZBi23zVRYKne886vru5w4dNp28PZLEAf250ZJg
	tDxxK2aefW3SWVvtlYR5z8EcRoHmdh24fn7NtATv/MTbwB3HMmILxIKtZaoyUF7s0oJMK5K+Mkn
	i4wKsJ1dTuFqs+SEkwfu+mk6oINBo1v2k9mrijisWP9KwRMcA9adQ6Oks7lJbp7E9YfUioUoY5w
	iTq2V4JIqZI
X-Received: by 2002:a05:6a20:3d20:b0:3db:3d0b:31fd with SMTP id adf61e73a8af0-3de0e703d8dmr5190620637.1.1790330003117;
        Fri, 25 Sep 2026 02:53:23 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78796cf39sm924154a12.32.2026.09.25.02.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:53:22 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: trusted: Reject short TPM2 public areas
Date: Fri, 25 Sep 2026 18:53:08 +0900
Message-ID: <20260925095308.3248297-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_load_cmd() reads TPMA_OBJECT with get_unaligned_be32(pub + 4), but
does not require public_len to cover that field.

A new-format blob with public_len zero makes the read begin at the end of
the B + 4-byte decoded allocation, causing a four-byte heap out-of-bounds
read before the TPM command is transmitted. This is reachable from an
unprivileged add_key() call when TPM trusted keys and a TPM2 device are
available.

This affects v5.13-rc1 and later kernels built with CONFIG_TRUSTED_KEYS=y
and CONFIG_TRUSTED_KEYS_TPM=y when a TPM2 device is present. A KASAN run
as UID 1000 with no effective capabilities reported:

BUG: KASAN: slab-out-of-bounds in tpm2_unseal_trusted
Read of size 4 at addr ffff888106273b48 by task exploit/160
CPU: 1 UID: 1000 PID: 160 Comm: exploit
The buggy address belongs to the object at ffff888106273b40
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff888106273b40, ffff888106273b48)

TPMT_PUBLIC starts with the two-byte type, two-byte nameAlg and four-byte
objectAttributes fields. Require public_len to cover all eight bytes before
reading the attributes.

The exact input produced the KASAN read in 3/3 fresh boots. The fixed build
rejected it with -E2BIG and no KASAN report in 3/3 boots; valid new- and
old-format trusted-key loads continued to succeed.

Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly interoperable")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Tested with QEMU tpm-tis and swtpm: vulnerable 3/3 KASAN reports,
fixed 3/3 clean -E2BIG rejections, with public_len 7/8 and new/old-format
controls passing. Stable 5.15+ requires 114f00d738f1 first; both patches
apply cleanly in that order.

The source reproducer and full logs are available privately on request.

 security/keys/trusted-keys/trusted_tpm2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c2a69bcf381d7..b3109e0a924f5 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -418,6 +418,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	public_len = get_unaligned_be16(blob + 2 + private_len);
 	if (private_len + 2 + public_len + 2 > blob_len)
 		return -E2BIG;
+	if (public_len < 8)
+		return -E2BIG;
 
 	pub = blob + 2 + private_len + 2;
 	/* key attributes are always at offset 4 */

base-commit: 27d14d3b15d5691bcbf0683883a2ea12469edbea
