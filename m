Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009540B0E8
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184917; cv=none; b=DZNxVQQQe015r060Tr6Mv24nejuQR19J0xbEMboyJNojDC4gNGb2y/mREuW0Rh41p5W/ZZMc/5pMuErbCg5bI4kheD7a3x2Kky9UFXJqSEdGKDd//QqYgsYDRBfAcRri3TYtTP7GYJozBQOFD1qAAMmeszcA56r0jTdr3NEiVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184917; c=relaxed/simple;
	bh=EMiwijCSi9gVRyUeRj2kGmZadFEy+BUHc+JcXjP3tuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=mT4xMaelm6X4/WDr5AmQ9LaXdezKlpdwKlRz9G/oZouJjVCVMjxaujzPNPXlly28EZom4A8RQPqEoEnZDdl1YhL2d5Pz1zzrxIQkcOGlOvp0715gFVN5UhcnBauaxt9Wh3SnbYUQlmSGqh4UhHZwMy7CbAyxQ9I+qu/YayAIgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3XzOKLw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3XzOKLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790184911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/r6AwuaWI+e4d7iGoKYDG/9yrPmbnqwvnnzXS2lDObo=;
	b=g3XzOKLwHoPWUuRQYrLqlNUll7m08iqygfIWZHLTevbWNokDCbsyIZwYXoJLqlY5/x76yl
	QA52SKKkPFu8WycrBgprLc9z7MayRe9xZKIb6cFkpFaD8k2ISufqCmjD7/5QSofju/GPmO
	VQBWyKF7NXIjrsSNfyXwnUOhVJvuAAA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-wklqTKx9PhyTL0jo2lNRCA-1; Wed, 23 Sep 2026 13:35:10 -0400
X-MC-Unique: wklqTKx9PhyTL0jo2lNRCA-1
X-Mimecast-MFC-AGG-ID: wklqTKx9PhyTL0jo2lNRCA_1790184909
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso8424515e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 10:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790184909; x=1790789709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/r6AwuaWI+e4d7iGoKYDG/9yrPmbnqwvnnzXS2lDObo=;
        b=Ixw/sxOSbkbUVAFznra+9L6mCneK/ubMSH60k6LS+NEDOY8wd7PFPLnyK0IpN4Oe0i
         ZZUUQhraTR8t13A02I0jBkBjVyvVQLUDI3whAyB0sePbJyJhK0pVtdnN+GSwJfoNBw9F
         UdAdjt3L6K+4wp1Mzw+TFnmoIjEqk2pks86MdIimyhsVoSEz7z5kbiZ8n151NGxqeIFO
         HJQrHX8rYTd0sY0kjpjfPkH6xCL91LHSbuJjY7LoDJr66qujMayvobnCXrdJiq8I6g3x
         MUtKrcr7XjVjFRXzSijAZM9CkRF/vqnj5/Lc3+QBhOa7Fow+Vsvjy3izoeKD52jxMlhq
         jPEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGLj71e/mkg2X/xLnqbzSlR38dWKwGmX5GfockWm1xxIyKnY0ghT9yBL9SuDJmdRcnFFmqsppKZSkQ8IbZe62+ijL49ew=@vger.kernel.org
X-Gm-Message-State: AFuF++lG6OoFcONoRmlLdDEYE+nzZJ6CaqkUlvuXnoXzxzIN80BrlfjX
	5use5srYNUC5HdTV2rXkSoOUGKRoXJdpCIQllW1GWBZVH/CMzRx5GUkkLFjYq4tLecrT7MnjubZ
	yB4WA/vXW61CHOiqbgEW1fPMRj5ArBtJ8LKpHLMJX0kldcXVXgj2nnWoZ814VCiMGMQABXNRCLd
	7VX16EU14tkg==
X-Gm-Gg: AYBFou3mUbcmZnZNo41u6WQUJXrstKmho613awAFdOKsOi8RKHktdP9+o2BQQBH+der
	TXmGViUQrxY2H0UXxqXkpV0JaXrbdULHqjrSpdN6GnMBW36yiHqtIQfIl8A8G95SW95kY/EpHMy
	1aa+pUNEWQjiT4+RK0v1VGzh4jQWTvzYQwWo9CtOJ2G3EjpHMD77WCi0XisFE4IDWjiKPiIpCHr
	NhgwTdAegU6gfn8gUQcZ9r3Nnmf9qTwbMZvU6RygFDlofAewOK+vuQpV3ndqou4aRsBHE3dktuc
	nQwMKqoYJLKJHGYJcKwcBU9j4yZYnxH/K6I+RuMT4iUMboyDtQb8kC/b9tSBithQWFLe1J91OBs
	jMag4YhB4J5HISWIpNjEuMxSr80zaDQei96ssFaIQ+bUn5/gU62PfzA==
X-Received: by 2002:a05:600c:468c:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49fdf15a3e6mr54023915e9.29.1790184909095;
        Wed, 23 Sep 2026 10:35:09 -0700 (PDT)
X-Received: by 2002:a05:600c:468c:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49fdf15a3e6mr54023415e9.29.1790184908631;
        Wed, 23 Sep 2026 10:35:08 -0700 (PDT)
Received: from stex1.redhat.corp (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfbc0csm1404045e9.13.2026.09.23.10.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:35:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Paul Moore <paul@paul-moore.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] KEYS: trusted: Fix blob allocation size in tpm2_key_decode()
Date: Wed, 23 Sep 2026 19:35:06 +0200
Message-ID: <20260923173506.41519-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aITZKTnNDqLFNZLUO0CfzHWUnNvKCDY-XD4fxrFIgGc_1790184909
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

tpm2_key_decode() allocates 4 bytes more than needed. The ASN.1
callbacks tpm2_key_priv() and tpm2_key_pub() provide the lengths
of TPM2B_PRIVATE and TPM2B_PUBLIC, so ctx.priv_len and ctx.pub_len
already account for the 2-byte `size` field each of those structures
starts with.

I noticed this while reviewing commit 114f00d738f1 ("KEYS: trusted:
Fix tpm2_load_cmd() boundary check"), which correctly reports
ctx.priv_len + ctx.pub_len as the decoded blob size [1].

Let's allocate exactly that amount, matching the data copied into
the blob.

[1] https://lore.kernel.org/linux-integrity/apfoKo-BdwaLXtkT@sgarzare-redhat/

Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 01f18bb37047..a9b8a31a637c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -115,7 +115,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
 		return -EINVAL;
 
-	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
+	blob = kmalloc(ctx.priv_len + ctx.pub_len, GFP_KERNEL);
 	if (!blob)
 		return -ENOMEM;
 
-- 
2.55.0

