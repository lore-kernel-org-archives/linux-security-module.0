Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556497;
	b=J4kzfz/NTa+9jIYFuYdrc2oYuyPac2+W8o6ivrHCd2LD66t80YRjiLCBiXAKdbyHIPWq
	 Eu6vWy28VcTQoDwIDX0+Kqwsm6nFgdLOGil4mcHZnaIE64N+h7Me1emlE0d6IqQX1+9y3
	 jVVvMTvZTjinDskWuKMAw4zsClv7/l9e88pAmN35KWJFHvRx6dJMacCLLNZ8QPl5rRcBK
	 /H5ynY0CW00DDFJBgj+OUhhL6dEmo8QVUuX4Y5wv80cfndoRdJNVw+FctunQ11WEqnEnR
	 1MmjYcuxidu4cMW1as36x8Tn4Jq2XC67FeByh5+8vEFQ9TtVQyI1LbX1t0iaz26/zDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sC418Lw+Cxfpv60Ui/bgj9nml+ea5R2G+4fhinGo4II=;
	b=nYUSxdWBVaMUa37ZCrCb6wio5OS6HvUKlByG56Hq7YvqDBlsxw6NKQPhlXYVgieLlEUP
	 U34eGKS4pmHfLfVuFxfCqJDDTySb+dhHD9LRqGqSOI6UWRH2nBP97hD3cbN6oSr2RYnGq
	 sG/Dux31kKTbws3oBvvoONq71AA35k1xWWiemDOjU/EtpAOULGEVJyK11WsavmsJPcrl8
	 xYhRPJYpU5xq7swN7QCIF1TOFLEmUEh/YXOEhrSJUMoby758go+7gR6wka1MXmLUGm7Tq
	 lQ0yqQLmyAiOvRu3Dbr0Z8lDs6F4ycd8SxjGUFafihUWwi/PEO5Hh3eAnXQVJAhWzsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtSrbVdv;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271D606A31E
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 21:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A271D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtSrbVdv
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so4379750f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 13:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556495; x=1796161295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sC418Lw+Cxfpv60Ui/bgj9nml+ea5R2G+4fhinGo4II=;
        b=MtSrbVdvXPESULp49wFyKVViyU6uV845m7VObPFqQPp+cyXIAZJY0lPMcSZaqh9RMU
         N1tn7Cskb/nzr5TmOpSei1JbApwJPvIUOkkSfAmWzK/tZT6ItSWCfbM8Dqt8uRrm6ILw
         uAxYcp3P/gS4qEes1+47utnIUp6VHolN9lPusRgZZNHcsMeZ4aRO6PXyE7zt9JRzN+of
         s7geRWDZ2G5R369y+x98KK0gmNXD5A+NLVUkRHcLq6qgLwbJ523zzN2yhGFEmYMiWxsk
         XHOahvLYAKaR6JTglJyNLuiV8s4uu39q9ZuzK277Cjv85T9Pg0iVNzTDL3rWXY+2B0vz
         bRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556495; x=1796161295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sC418Lw+Cxfpv60Ui/bgj9nml+ea5R2G+4fhinGo4II=;
        b=W42CZ9BpNl4mF7K7PX5xe5wGDmpt4C/eM1EHGCP5Qc4VRFQ2Vd0D4BAoo/lByF0zzC
         Z7w+UbmuaRCtk1dkPFScFOnj+3YkF5kE0iCFrXlFhpoWu4+aC19DmTskVt/3lZ6hXb8Q
         pkqIRpY0RmEBx8Ohz4A8RQnA7cnRGukjZbswMG0FEBuQjdjJIC3zjoj1yQLc9zqcgvm+
         6yQifju7uTKUvlIOr8rzFAnfzznynnNOpbUYr8xDTXJE0jxBQjC1TcNRT1ErISCenuqS
         hSPeXwE2lM6uyqHLKM8YHPPLESr4fKYOEGQXefyRTlnsWBeAQ8MO5ZqHoAoohuqgG7WZ
         +MIw==
X-Forwarded-Encrypted: i=1; AL+hErGfyXkpi2ODY38aELxlmd/OcDm8b/B0PRsr8BmtIwTAOT2HyGXm9Y+CtNbUx/KVB1KOGnToRF6MllGZKEBlr9M7QXarEuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aKJB6ONCtQOTII91q32sCvti08HmiPdGQtdkMz014fr/z3N3N
	+8KaHGVbzmgJ4niCz1h2N/HMqLREwy5t/a5yv9xkIH/j/Dv30DEn2Gc=
X-Gm-Gg: AZFdTZeCzfuceWBj5OByWnDr3wCF7fJ5tW5KZx45jeQFGnKr12vHT0AXVVhC9aBJ0HC
	GcyYqh85L+zcAHs+LTVjoFk2X/AffoemYXGfsF1sBX43Mcbx/FiLwHMlptZPEs3lrAURdVutOq1
	U0S539di5Z2Y6mwOQ2JR0+Fl6FxTUvIudhO0Y8MckJ5zmCnZzTRVXn3pWFydsOmxX8o2EEngEy6
	wmnEsXkVjHA3JB/E20iQoKSDaBFGpU8M5QHADYC8QFTu43FJsjAbg6yQxihAUyNZAYriOzZQirT
	Aa3Mr6MWAwZy2AJCdZxD1qiFVMnLke55RpKhLOJnFjNfQj8sWdzfJGgskhQKXAc3YrXPHdeKlSa
	4ROfHBW+lew+Rpqyl0zGE5a3EdMi86GRovTKnTigK0BK4YZVWkj8Z31iGHIf/uzQ1v2cCZBLlGc
	3wIr09inKtlSbkWdj2qY5M7NRssMvnSdmkBzZIOCIOAPOmeAEG6n3YM8vQ4RSDEkgcNrMRGXKdk
	fbtNOrJVeFENrpQmALTf8MGIRAyuHsZmMPWQzFaiBA8xSQvVlL93RI+d4SBJPBqfJzMgMbq4dnO
	02dt6B/bMrVmDA8=
X-Received: by 2002:a5d:64c9:0:b0:4b3:f000:1bdc with SMTP id ffacd0b85a97d-4b3f0001c13mr12286559f8f.45.1795556495020;
        Tue, 24 Nov 2026 13:41:35 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb98b4dsm31041908f8f.53.2026.11.24.13.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:41:34 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] KEYS: protect construct_key type dereference with key semaphore
Date: Tue, 24 Nov 2026 21:41:25 +0000
Message-ID: <20261124214125.3198541-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

construct_key() reads key->type->request_key without holding key->sem,
then calls the resulting actor function pointer.  The key garbage
collector retypes keys to key_type_dead under key->sem write lock when
their type is unregistered.  Without the read lock, construct_key() can
observe a stale type pointer if the garbage collector retypes the key
between the pointer read and the actor invocation.

Take key->sem for reading around the key->type->request_key lookup to
prevent concurrent retyping by the garbage collector, then release the
semaphore before invoking the actor.  The semaphore cannot be held
across the actor call because call_sbin_request_key() blocks in
call_usermodehelper_keys() with UMH_WAIT_PROC until the userspace
helper exits, and standard helpers such as key.dns_resolver and
nfsidmap take key->sem for writing via keyctl_set_timeout() before
they return.

This follows the same defensive pattern as commit 925c84e3cc21 ("keys:
Protect the read method check against type removal") but narrows the
lock scope to the type pointer read to avoid the deadlock.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v3: narrow the lock scope to the type pointer read only, releasing
key->sem before the actor() call. Holding the semaphore across actor()
deadlocks when call_sbin_request_key blocks in UMH_WAIT_PROC and the
userspace helper takes key->sem write via keyctl_set_timeout() (Sashiko)

v2: hold key->sem across the actor() call, not just the type pointer
read, matching the established pattern from three prior fixes (Sashiko)

Build tested: x86_64 defconfig + CONFIG_KEYS=y, gcc 14.2, W=1,
0 warnings.

 security/keys/request_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a7673ad86d18d..ccc4e94197423 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -241,8 +241,10 @@ static int construct_key(struct key *key, const void *callout_info,
 
 	/* Make the call */
 	actor = call_sbin_request_key;
+	down_read(&key->sem);
 	if (key->type->request_key)
 		actor = key->type->request_key;
+	up_read(&key->sem);
 
 	ret = actor(authkey, aux);
 
-- 
2.47.3

