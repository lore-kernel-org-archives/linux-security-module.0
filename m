Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723267;
	b=u56j0nSrrqoMZXIRWAZI+goLi3NnGTtmHKJfeKPtsNqbffx2avna3qrm71hIFYAIRXzm
	 16yny/smoqS8uzk6O3UI5SX6EB3JUAsABL6BV06Rd/5qHHBjYXhvPmFRGZxOCrGnSvLdf
	 7r3pzrBX+kYb+9HbSSsDBtwtsJAqXN3hbbfaGFPf33+DoWqUoeviFZQCXshd/UHytE5ko
	 Y49Jyicsv6Bdv8UvsTzL0zFq9+azs2hZ6NJHLLuU9b+noU5SoC0XcaEPUAcwk191N1VlM
	 zNIy+1+a2EYr5MG8xmPoZhjaUOvtqSUDoBbrPEr4+fONN+DboUAgKzvM4lrpZcNyxUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Lsmu86na7LP1yXQ9d2E+j8k+hfLm8TriJbzArNXJkMM=;
	b=DnXIK16fxWMmnXWMoUuFKuke3W/uBx8FgWrQA4odk51C7+JNHQ6Rv5xWS+O2rY4CXVjX
	 OXgGAca9IXLcIByvQON9WyRmRKQaPdgI858V6UZsJk5UwpKUU4OSHphv2Nlc8i46ecHsR
	 5FLH+Amn4RxlClW+R7AS0T5NPQMGkX8XNAM1znP3/8FVrD1TpZDy7Hfbu0cwk0UQpD+EA
	 XfFb1Wsz3mqbOf09UHwswcBDkg6zpDzdXeL37hcyEVEqY2nBaV3vaWTlserUDe/RdyinQ
	 9AXVDfgyGjeJZIi08iSCGd+7A3DxWyZA7ZaANEtC8udsip1KkfNpWFUrz0GRNLkEUxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="QxbdqK/L";
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C4606A326
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 20:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D9C4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QxbdqK/L
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4c55ba309c2so8341946b6e.1
        for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795723265; x=1796328065; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lsmu86na7LP1yXQ9d2E+j8k+hfLm8TriJbzArNXJkMM=;
        b=QxbdqK/LnysLZNk3giLpFCC6miNSsgKre4H+NTcH1r+SzCQAHgLQjJPSGK2ObW/qzN
         GWtcny/72I4JywhjriFo845hSsRIgBL8Qn61amypgK7xmosCZbyAMNGh9+wNqkeQAS/3
         e3yB9Em15DwqFj7E6sJ+kanQZEH6Zj+3w87sJUaABY/62hZYCS7LPZOZN8GzYybXkyiK
         ITCRd3uCHyNC3U9n3jrN5z41tP5KIGzy11YUBY3dzvJBqqLf+aeVTvHV5wYx6p4LEatc
         Mu/1V27sS6i1N/fPPvoWuyTpe+jPZ1ldCSUHCe8jYC8zZuoJvuDctYZAsRcZNrw8xa+R
         f7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723265; x=1796328065;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lsmu86na7LP1yXQ9d2E+j8k+hfLm8TriJbzArNXJkMM=;
        b=TSlqMx9a1gLywMAQxW3qnJeEmQj1eYfImm+JXRMMu2x3AkcLc2U9kVwvVbFuCdYBWi
         EpUbwYNLsIrWAVfR02r2f9sEht4Yl8dmMFYfhhODhei17DX9GB8B+pwHuvPFuFo+BJSI
         NsnxXmgG3Z++02NeVPfvKqXutVvCeFJJzOwMb39MUxxzYhtFSERNS2kDPykB/S6wg3gV
         NBPHhYUL6kPepInbGjeAGntjmXfqQdnjRX1gXsnx3UE4nJp9mjbn+qPgkAVkJ6Tv5pCi
         lNgS/+ZGLOL8wotbmel5RmuuKXqaSyw4AFdvRClHAD7X5YpLXOlJh+fggwzo6IHBvmH7
         2lUA==
X-Forwarded-Encrypted: i=1; AL+hErGH+mm53CSs4LCcdJffiZyIxB0jC/zEVs0dp7W2ynHV0WZljIjKGUaHobTZnO8Q5wQ7h7yqBrXPB+r/v/QZ+MZpHXyfh5I=@vger.kernel.org
X-Gm-Message-State: APuU4Z87GJXCuf0LAZljlrfzMbBBXOAAiqUVqhBJNybmUvgn4epWoLJW
	9q6zwGna1Ku/GElzn1oHk1LYSY77XC1si1AsqczG1g0k0dIOsORoT/rg1J3s8LAFuD99bEu7F4y
	s+VQ6PK1qrcsSnGHGJVnjPNrazZIUqQ==
X-Received: from ilei11-n2.prod.google.com ([2002:a05:6e02:61cb:20b0:54e:86af:fe5d])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f2c:b0:4d6:90f4:48b4 with SMTP id 5614622812f47-57a0cae5223mr24227154b6e.54.1795723264869;
 Thu, 26 Nov 2026 12:01:04 -0800 (PST)
Date: Thu, 26 Nov 2026 20:01:02 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126200103.2806716-1-zhenwenliang@google.com>
Subject: [PATCH 1/2] KEYS: encrypted: Wait for RCU callbacks before module unload
From: Zhenwen Liang <zhenwenliang@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, 
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

encrypted_update() frees the old payload with call_rcu(), and the
callback, encrypted_rcu_free(), is part of encrypted-keys.ko.
cleanup_encrypted() only calls unregister_key_type(), which does not
wait for callbacks that are already queued. If the module is removed
shortly after a KEYCTL_UPDATE, the RCU core later calls
encrypted_rcu_free() in freed module memory.

No new callback can be queued once unregister_key_type() has returned:
key_create_or_update() holds key_types_sem across __key_update(),
key_update() checks key->type->update with key->sem held, and the
garbage collector switches every remaining key of the type to
key_type_dead under key->sem before unregister_key_type() returns. An
rcu_barrier() at that point therefore waits for all pending
encrypted_rcu_free() callbacks, as Documentation/RCU/rcubarrier.rst
describes for modules that use call_rcu().

Tested in QEMU (x86_64, TCG) on mainline (7.4-rc4+) with KASAN,
ENCRYPTED_KEYS=m and CONFIG_RCU_LAZY=y, so that callbacks are deferred:
add an encrypted key, update it 20 times, then call delete_module()
right away. Without this patch, the rcuop kthread hit int3 at
encrypted_rcu_free+0x1 in the freed module text in 5 of 5 runs. With
it, 5 of 5 runs were clean, and the unload took about 30 ms longer.

The problem was found, and this patch prepared, with the help of a
formal analysis tool we are developing that uses AI assistance; I have
reviewed the analysis and the patch.

Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
Link: https://lore.kernel.org/all/20261126023538.4160950-1-zhenwenliang@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
 security/keys/encrypted-keys/encrypted.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 63f0245e6f74..fca809819f8e 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -1000,6 +1000,7 @@ static int __init init_encrypted(void)
 static void __exit cleanup_encrypted(void)
 {
 	unregister_key_type(&key_type_encrypted);
+	rcu_barrier();
 }
 
 late_initcall(init_encrypted);
