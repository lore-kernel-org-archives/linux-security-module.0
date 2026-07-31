Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F642BE93
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506979; cv=none; b=aPjpib6XMv8nvCN5hi9O5AZWqxjDeCMwM7v/u9wMhnprR6S/evK4M8j7aXfGP7X4wi5O8eQ6hOgqQ9t+wJIo2u0mQXDKZXErMjxt2NlGWejXA2r5JXXaplOOFycKSwoRcouktTanfIiDjkPuWbeQ3OUbtBlyuCTcUm+eqJMTJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506979; c=relaxed/simple;
	bh=3EOf2/jCD8AncItiAAHs6oeZqNAYPx5oM9R4lgo8xmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4T+7NQks9aYjgmseNdk6NmzAAQ+5HNUPy6Bmy4fquSS/ij2tv3vsWFwzMRokpoeIVGKDYPqcYnHVAAV6r8/Qtv2eB6AAGmicQXrSfAaONdZHU2F1aCfYaSAFLX4dtF8F6EQZSDPEQcOhhD33oxvspBr9enHlT8+0cZ76n3/Uj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhkWKX5P; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhkWKX5P"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdce28edeso1038405ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785506977; x=1786111777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qfTZLKX5MXlI+65GiAcv4sDb6zyKTd9ns9ffnwjJXko=;
        b=mhkWKX5PDoWgAmcXfVNp0XUlYz1PPHyqI7gvQ1vZLKrPHmfMAJDHQnoosd+NaU4JR4
         R1G0fOpNuDGm5Kxx7EOXloQvCxIaBMUVNm18xEocs1JoP/ZgW9yTUybsD1zgb/+6jhd8
         u30EcU0j1yJ+FJokT7DsaflSDIdy5wKqxPS6YEdADFFmPvrBKNmqxpVphiQ9baOqxdqI
         7qIiRrP7I5ytwBKZYLJMk9QKpYq7DhVVqJ83xsIbK/3hIq3RAGlOZvqwcgFepYpYP7ax
         vSt+8eywrUF955DmnPLFeEvwtWd4PQie1pVjKz3GWeudAAgFrDkwARs88dZ7YGprg8vi
         Otxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506977; x=1786111777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qfTZLKX5MXlI+65GiAcv4sDb6zyKTd9ns9ffnwjJXko=;
        b=S1CQEc2uQ3qpNJi2OeVD1uM9VWW5v7Sxq3AfjFlhbPEE42NHJ47HZTbXbVTVx9ka6n
         wuY+GbnZP3NgG6ojdBKcvBZu0PxAoEpjVPvdnRHLmj8IQhqu3hRE8f7PaEvJVJ0jckCf
         Lqiok/arK5X5f5Iku313RqVFzl3iFhFbFRpxDBuhWryVvw5IvIOr4uc+kLya8MTKJp5X
         8SOXhcp89Zux2KtIIU2a/RQwTTISZ6wqh7QVVmyxcJHXG4nBZdnXz4CRWP/BHLlzffwJ
         Sufp/7hOSz0rtvFIDhLm/waM6px5mc+lHDqCdhODgB15aQ+rGcsI4UHHk4I3wiaaM1f+
         vFEw==
X-Forwarded-Encrypted: i=1; AHgh+RruIDw3iaa9Z/e5NsReZQXzC6AWftox4VgiTPdOCwEesyYHjAhsdOlVLv8FC3tnCwQGSCWlQ0ej9tEtJ8ILTdZcwYtrFIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExXsw8rkWCcGRmSKDlmdd2ASmwQbTjZemw697th3MOPsPiUGH
	fWGpN/WxKeOurNfSv+LOr1RHvNAcxgdxBl5/WvI5f/HuWsR2E6cymnTF
X-Gm-Gg: AR+sD12LcqyHVjqazFvXApjm1dWYSdJzRUJHhFZXeT3hvo7p+MDocI6dvCB0onR29EF
	zfpgClkvHez2WiySCfFrU9Ri6CNvPx1Fq+2YkeaUT++zg/6SIQksCVQatbEReaQ6HsywPlGUK0G
	+UEnP7clLRkuIOYbZFc8NvEJJMfYo4XlNq2eRTlcobNrEJYtmrPCCNCd8Rgv+v67sfY377V/Drm
	mDmhF6Df7H1O3T1NQ1gzV1JuBhSEtesxaDvKn+qMpaNhPzU88QJSxpcFnH3mnFn0+6aQHHOX3TQ
	uTa+34YGjl1ieoTJ42UaUPi1RRyblfUvZJpEZ7qj+y43WUFcyFLAvXH953Kbuo6bIZtqjj4xFi7
	eJQJIjFm00DyQAYjDJ0DYQWMlMZwe3HgVqzDpaBYHqa+q52fZu7UuFdQ2QU3GxYajpp0cwj2/ng
	X/jXcyG0+fPindFhGgtapBNJRAJqNKl/U8XeG/dFcAvMiPz8Lzc9xl+8dG/7jVvDQIMwUVVI5C9
	wLN1c8/ODeIN3Uu1T5XDQX0Q9jhEHnjMJZpMGeT9sM7k9l7YgcDFaI=
X-Received: by 2002:a17:902:f546:b0:2c9:b96a:2855 with SMTP id d9443c01a7336-2d051f078e3mr3246845ad.0.1785506976879;
        Fri, 31 Jul 2026 07:09:36 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddd7a33sm6268159eec.12.2026.07.31.07.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:09:36 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KEYS: trusted: Fix TPM teardown ordering
Date: Fri, 31 Jul 2026 22:09:24 +0800
Message-ID: <20260731140925.2973492-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trusted_tpm_exit() drops the TPM chip reference and frees the digest
array before unregistering the trusted key type. key_type_lookup()
holds key_types_sem for reading until the key operation finishes, while
unregister_key_type() takes it for writing. It therefore provides the
synchronization point that must precede backend teardown.

The current order permits this interleaving:

  CPU 0                              CPU 1
  trusted_tpm_exit()                 key_type_lookup("trusted")
    put_device(&chip->dev)             trusted_tpm_seal()
    kfree(digests)                       pcrlock()
    unregister_key_type()                  tpm_pcr_extend(..., digests)

CPU 1 can consequently dereference the freed digest array. The chip can
also be released before callbacks stop using it.

KASAN reported:

  BUG: KASAN: slab-use-after-free in tpm_pcr_extend+0x1f0/0x200
  Read of size 2 at addr ffff88810872d000 by task poc/89
  Call Trace:
    tpm_pcr_extend+0x1f0/0x200
    pcrlock+0x42/0x70 [trusted]
    trusted_tpm_seal+0x1b6/0x570 [trusted]
    trusted_instantiate+0x293/0x340 [trusted]
    __key_instantiate_and_link+0xb2/0x2b0
    __key_create_or_update+0x61e/0xb50
    __do_sys_add_key+0x1b8/0x310
  Allocated by task 88:
    __kmalloc_noprof+0x1a7/0x490
    do_one_initcall+0xa1/0x390
    do_init_module+0x2df/0x840
  Freed by task 90:
    kfree+0x131/0x3c0
    trusted_tpm_exit+0x59/0xa0 [trusted]
    __do_sys_delete_module+0x346/0x510

Move unregister_key_type() before releasing either resource. This stops
new lookups and waits for in-flight key operations to finish before the
backend state is destroyed.

Fixes: 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 13513819991e..8f57c6111e7e 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -987,9 +987,9 @@ static int __init trusted_tpm_init(void)
 static void trusted_tpm_exit(void)
 {
 	if (chip) {
+		unregister_key_type(&key_type_trusted);
 		put_device(&chip->dev);
 		kfree(digests);
-		unregister_key_type(&key_type_trusted);
 	}
 }
 
-- 
2.43.0

