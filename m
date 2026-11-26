Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660541;
	b=zlSqoOQqMv8q/GMZEcQmg+2l1kN3N5MGzrBmxz1+/L5H1n7fjB3/MByPQcx+ZfR63ddv
	 1FQqoxu9+W/wuXV9AAL9u9O2GjFsSXb+BnHcaxdtn50Tmjz8AL2qs26SaxIAbfggm7tFv
	 zEchMHqpY2dGI9AJsHpckR1XbA+heUBjUaz69aVbY+95EBRRjeoBd58egieFniSsaOaJX
	 W5phWnbjBfANVkDjxFgR6UluG1tLRJ/Lj0H7ilZNbds4FJsKavHejz8c8g2gtU0oo0IpV
	 EfbE8S6uUrLO3+Z89pY9PsPfrY7jReCIKLtBMvdX1vzIWklUZ1WDnK4fiSBPGngbwZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=g3rQYEqeb9KItcfmF0Y01uIIXY4X06TFOeBbAGovoNY=;
	b=hxV28MtMV/+FxJTfzyfeFleeHhB6FcjR3qymhF5QBWQWbiGJ5hB1ae/Mkb9aZzbGQzYt
	 5HAfV6OpGkctW7Ud2aYKGQ6n/LKogoBJkRp18SGImxnw4W3m+RE6qenR43kRQdmOGRTs7
	 6qMBfw1JQFo4vYfP2+PdesyEPEGdufq9nJvJhYD6sGwnwPZLy6x7NVqI9EGg2EG7JXvKZ
	 BPAQMEXA8gOkb3wrPiTVZddWnOb2GtoZkMUpoBmb3Zc21DpyoWs6vZfaHVXOYcVdg7Ojc
	 4Dqhs1tz9jc8JZyiYp/xVP5J+wrOjZXxymj7f61Eku62ODCo6rkRcDO2s+MxJ6a0vnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="X0uaxh/Y";
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81197606A323
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 02:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81197606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X0uaxh/Y
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-57e469f8312so1873616b6e.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 18:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795660540; x=1796265340; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3rQYEqeb9KItcfmF0Y01uIIXY4X06TFOeBbAGovoNY=;
        b=X0uaxh/Y6FfGkSOerIan92Tqs5wCFuIdc1o5XtL4Lp9SJebTXEDKfoYaT0d1mgLGfJ
         uoAVeT8sSBexKcX+QGe9G42pp0CRDiIJhSP3qZA2f/FOsb082jGJIvvEV3P7BXZs8ZeB
         Ress+qPpeZPkiXc03IVbd3m5MIzK0IHO7sS+usV1OTXA6oqQ2Ej/nERYkA7FBbeJdmJJ
         GkzFKj6LmZxnkM7Ihigc758BKD76oTQ3eoHpo54UdpLrp4Bia8DJcl2pH1ff1HLjzcqW
         0ymVp0eXrXOb07GAQsN5oJws8pLnn8QStbpGHlQTZ18RhJzXyqUORM5q5q8E3lVOrr3u
         O39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660540; x=1796265340;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g3rQYEqeb9KItcfmF0Y01uIIXY4X06TFOeBbAGovoNY=;
        b=2XxEs5wvhOOzJOWFJWN/MC+zeh5XerjfI4QEsBrj8gR+0mlCQZhVPkwQR30mgPbCsA
         g/Vx+eUVmp0kNX8rNgM6s+YwzwqWbWCOLX+o4U5ZEhlC+jPxCkBCzsqt6egnEq2H1cZ2
         9Z8+m8T8zsmA5pCbFw4V7fOamjuqeOp8+BdeflAy4BI8rJgxW90yfQH9aqEIMDR5OfcH
         ufF2s2u7nXGHk3P75i+sPWAu76hcDRNsTZcqPUQKiajFdwYfBjJZa10GN/1hYHDu8i0T
         CbQMkJMM5t7AH0aiBq11yHu/rWwT2igjOJzJi+Z0zFFBouTh0dfd+9egkzo4AkBp7z+9
         NyrQ==
X-Forwarded-Encrypted: i=1; AL+hErFbUrBgRsH1bYCg193/JgOZqorpCCKiyib52swWs9Z/UZNI3A27X91AW+2vkmIMyQWnm/WjuOIqk46sHSHeeYHK82GN1HM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9faVG+RdzY5kAr5UYCLUZBuAUCFexotngimh/4l75lA9p+uhcO
	lYAe/IuV2TkXFenEMs2cjvpFy1Vc/F+uRKciqpb3C4iEQo69OIMDrJaE0ssr7UZ6jW8pL10oT8F
	j/esoKf75PHSkfXclgnQ2nlXbpuNixQ==
X-Received: from jaac8-n2.prod.google.com ([2002:a05:6638:c748:20b0:620:5ab5:d384])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f49:b0:4c3:db9b:3ead with SMTP id 5614622812f47-57a06b1eaddmr21898545b6e.3.1795660540254;
 Wed, 25 Nov 2026 18:35:40 -0800 (PST)
Date: Thu, 26 Nov 2026 02:35:38 +0000
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
Message-ID: <20261126023538.4160950-1-zhenwenliang@google.com>
Subject: KEYS: encrypted: encrypted_rcu_free() callbacks can outlive the module
From: Zhenwen Liang <zhenwenliang@google.com>
To: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

encrypted_update() replaces the payload and frees the old one with

    rcu_assign_keypointer(key, new_epayload);
    call_rcu(&epayload->rcu, encrypted_rcu_free);

(security/keys/encrypted-keys/encrypted.c:898-899 on mainline
ebb7a8dc1e74), but the module exit path does not wait for those
callbacks:

    static void __exit cleanup_encrypted(void)
    {
            unregister_key_type(&key_type_encrypted);
    }

When ENCRYPTED_KEYS=m, an encrypted_rcu_free() callback queued by a
recent KEYCTL_UPDATE can therefore still be pending when
encrypted-keys.ko is unloaded. The RCU core later calls a function in
freed module text. unregister_key_type() garbage-collects the keys of
the type but, as far as I can see, nothing on that path waits for
already-queued call_rcu() callbacks (synchronize_rcu() is not enough for
that).

Sequence:
  1. a user who owns an encrypted key runs KEYCTL_UPDATE
     ("update <new master>"), which queues encrypted_rcu_free();
  2. before a grace period ends and the callback runs, root removes the
     module (no dependent module loaded);
  3. the callback runs from freed module memory.

The usual fix for this pattern is an rcu_barrier() in
cleanup_encrypted() after unregister_key_type(). trusted_core.c uses the
same call_rcu() pattern in trusted_update(); I have not checked its exit
path in detail.

Affected: the call_rcu() in encrypted_update() has been there since the
encrypted-keys code was moved to its own directory (61cf45d01990, 2011);
the code is unchanged in mainline ebb7a8dc1e74 and next-20261125.
Trigger: needs root to unload the module; queueing the callback needs
only a key owner. Impact: use-after-free of module text, i.e. a crash or
execution of reused memory, in a narrow window after the unload.

Found by a formal analysis tool we are developing that uses AI
assistance; I have reviewed the analysis and this report. The tool runs
verbatim copies of the kernel functions with stubs for the rest of the
kernel; it found the interleaving above, and the interleaving was
replayed natively on that harness under the tool's schedule. Functions
involved: encrypted_update(), encrypted_rcu_free(), cleanup_encrypted()
(RCU core and module unloading stubbed). It has not been reproduced on a
booted kernel.

Thanks,
Zhenwen Liang
