Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A975374A16
	for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544339; cv=none; b=sKbmfr44As1XA3J+kXML+7vZAsaDwjSRQffg6nK3c+Z860hW0XfxK+xelQxHGC4IpESSHEHIDydlP9I86hVttBLsYCGhL3N/Y39X3fgvr2cLM+gqxYKnD26i0K9jCbN78gQ2pL21/XXuUf9Uicv4R6VbwZyP/TubAodrT1iqJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544339; c=relaxed/simple;
	bh=cO4Pj9HJvXCrtKDWlg8BCMRgxRtBdS4Ni/h9SSOUwWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHJQ657P1z5gmU8ltYp6A0nG2X730PZVNdQ8PHfrGSjcf6U5YY6WsIcDSUmD7HAJ18Dt7RtwcbqvG36XLOGMYrM4N2K5f0N4r4/74cKfcC4l/VSZPOqcIaKc3KuN+LAUJkV5/fF6y/PxZ8/QzgT021YyZ2wngcWNZWRt/uWITWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CSkouF3c; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="CSkouF3c"
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E21CF3FB57
	for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 14:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786544334;
	bh=ziTqEENmhcZwJoI7CW+xasRu/XWt1NvwONmfzBdAPeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=CSkouF3cwL8xsterUNLCTdLVv69S3SY6bCVZ40y/hbDr8GTsqMinjtXkf5rrSxENs
	 kKnEbFxgq4LCUaam2s5qvPO9Dx63n39wDHFB0LqBYk6xMTLBfgnx3hZV/ahDnXZc+b
	 WY5jXtnsSKd//pJJpnqDeQGMFHDtQx4rMoT48pL3dmkXA16u7RJxBbdahhfwoeeeH9
	 SEk5Yggq/7wtpW4t9gYJJaVr0vAAVg1ZRBWLUUyJh1YnqIoS9ijUfNG4xlgdWhvxPz
	 CA//8n0ORpSL2C3k+ivuXruVKQ9yVCOKSCdQNQjU0HgRAqkoJVS0eAmvoBUKUSEAf/
	 tZd7/wFX6afpo2mY4FpITDEHZI4+05BW9Z6l19r/Q6FiKHov7XYbwQpqWCahR8kRoA
	 BFbwLDmlEcG5SzPpQjMddQaDV54l0v7jtuX6o/QxcXnVvrWRHFRhy+QVizyqpdNSbe
	 hxvCfUElJlTk3UkzF4/ZyIg+E8739kp6BXUovyfEsrc4ey5QaYhRE/KmiLkQbdzS12
	 R74Dx+6ke7hZhfaixIYqEVOwZJxWNljS7kRenknM+z5dybqf5exkINJSaUjzZTnyun
	 hmdyHA0cJlpd8iIW5zBdmNvdjwTn99hBPSnLjhPPQ6FVuFMnmHW4V+YKXNGaDd3r+d
	 lHcAf1lwZFnlh9qiF75mbFmA=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso9533015e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 07:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544334; x=1787149134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziTqEENmhcZwJoI7CW+xasRu/XWt1NvwONmfzBdAPeA=;
        b=CDTSbpvGNGgS8kKuDSDNhA5RiT6bq2tfuXg/2lD6i90lNZsM0rvAIpff4NcBKYZd6O
         Rml/WlC2uhxM4fyN1fIOiAlDGkaRUTS341IEeBD1nII3CaAUi2IOoFfHmL214mX3E9z5
         eRuQKRnlB2SKaygHDnQyQvo5scwupQoUmSYBYzktHN2ZRHvAqL9sswm4j5mc21SHsAkk
         cPa0xFMBgOhccUkuplAFiK9bfNY9TXkcwjqol1YnZLU8QJBfdE1yuZXoenkjBTgkoxjt
         5rP/F9arbWNkg6YrkvAAFnuUSZHV1JFHgEvKoh/vloiL30IWfiU+a1BywXM1albxot52
         vOdw==
X-Forwarded-Encrypted: i=1; AHgh+RqQ8oOHw9Ec62q89FiE+A3W3v4Ta19uLR+T++OxYcv7azYcE7NbVAfv5Cm5h3PyhBOXfpyoIiSkpCUTguADArcIVmx86xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQeHPQnK/c2mV8cE++4zMW5LWToi80l1n8FPhuL83BJVRc5+r
	6biRoGbg3OkjYT6/OC7Jx/cxbKYvJAv/zNZBo8CpNKDJsaDQrtEvQv64rMNC4BT55rJ63VYnZ+6
	3oyhgIX5Jxv0SlW8/59CbZLvbVOucDpLZ60vGnhwQ6HSgEiGDNXr/xTnA0Jf9GozRtmqkWBPrI7
	tF6wAehK9cudcWp8T9ug==
X-Gm-Gg: AR+sD13q+YAuGGx32mVlq3sYXex+a5hOmeIYYSBJeyl8w+pphb6rlx887qlgZ9Jp+6+
	rlwiXx+1Ahc5+Szxl1AycI+Y0VluzQ9mKUSE2cKICR/3Q7WuQsyXWOXpmS2gB1GZeFnhy/vF+Lv
	N5QZUYdZuD2NgaCIReMObKzn7uPr2XvMcq6PeNrnxWj2sNmHXMU7WLjOmT4R8BMbGcgCliFSmwq
	iDuuCP09E5FP3mivjxOMogNJH1WNj/dJl5vBvAFROUVQNhWlorHP3YETmLozfzpS5aNOiannazj
	3rb3XvOTM2pkNotKH6udwar0zLuXfsQVZEZKyHwE9AUGw1C57SqGZNLOHmQiGJVfdN0wyDjNuIy
	CfrvaZF1BcnasphVIZiqcBEWx4iWNjauu7axPGVfSC44F81Hz3sZWDJl05C0TRbkciHiRDgoEQX
	ZjoSkaEZ1Y5kOQTng1foQKT9p9
X-Received: by 2002:a05:600c:35c1:b0:499:811b:dfed with SMTP id 5b1f17b1804b1-499811be003mr10736385e9.5.1786544334101;
        Wed, 12 Aug 2026 07:18:54 -0700 (PDT)
X-Received: by 2002:a05:600c:35c1:b0:499:811b:dfed with SMTP id 5b1f17b1804b1-499811be003mr10735465e9.5.1786544333585;
        Wed, 12 Aug 2026 07:18:53 -0700 (PDT)
Received: from t-14 (2a01cb00088323003ba1cc9bdc9c322c.ipv6.abo.wanadoo.fr. [2a01:cb00:883:2300:3ba1:cc9b:dc9c:322c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c8fa1c7sm71800405e9.0.2026.08.12.07.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:18:53 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: reject a kexec buffer whose declared size exceeds the buffer
Date: Wed, 12 Aug 2026 16:18:40 +0200
Message-ID: <20260812141842.2319635-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ima_restore_measurement_list() parses the measurement list persisted across
kexec.  It computes the parse end directly from the blob:

	bufendp = buf + khdr->buffer_size;

khdr->buffer_size is a u64 read straight from the persisted buffer.  The
only length checks in the function are size >= sizeof(*khdr), version == 1
and count -- none relates buffer_size to size, the actual buffer size the
caller (ima_load_kexec_buffer()) obtained from the ima-kexec-buffer region.
ima_parse_buf() bounds every field read to bufendp, so a blob whose
internal buffer_size exceeds the real size makes the parse loop read past
the end of the buffer (CWE-125).

The buffer's memory range is validated against addressable RAM by
commit cbf9c4b9617b ("of: check previous kernel's ima-kexec-buffer
against memory bounds") and commit c5489d04337b ("x86/kexec: add a
sanity check on previous kernel's ima kexec buffer"), but the blob's
own declared size is never clamped to it.  Reject a buffer_size larger
than size before the loop.

This is on the boot-time kexec-restore path (__init) and the buffer comes
from the previous kernel, so triggering it requires control of the
persisted buffer; it is an out-of-bounds read only.

Fixes: 94c3aac567a9 ("ima: on soft reboot, restore the measurement list")
Assisted-by: copilot-cli:claude-opus-4-6 frama-c
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
Tested under KASAN (CONFIG_KASAN_GENERIC, x86-64) with a KUnit case that calls
ima_restore_measurement_list() on a 24-byte buffer whose header declares
buffer_size = 0x1000.  On an unpatched kernel this takes a slab-out-of-bounds
read of size 4 in ima_parse_buf() from ima_restore_measurement_list(); with
this patch the buffer is rejected and the case passes with no KASAN report.
The test is not included here (there is no upstream IMA KUnit suite yet); I'm
happy to submit it separately if useful.

 security/integrity/ima/ima_template.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7034573..2467cae 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -450,6 +450,11 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		return -EINVAL;
 	}
 
+	if (khdr->buffer_size > size) {
+		pr_err("attempting to restore a corrupted measurement list");
+		return -EINVAL;
+	}
+
 	bitmap_zero(hdr_mask, HDR__LAST);
 	bitmap_set(hdr_mask, HDR_PCR, 1);
 	bitmap_set(hdr_mask, HDR_DIGEST, 1);
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.53.0

