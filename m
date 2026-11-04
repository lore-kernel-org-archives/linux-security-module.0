Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802317;
	b=Xv7pFUtQPiuJsV6LEauCEgpoZh/Pbu5ulurRN/mNWzUK07EiANlNnap5tS5PrsgpYOvZ
	 Rvv2HVUdahQkXwHHbOLBokHzqHNxY2W3uRxl4yNGnp4gc5OgzS7KV6RhGvckkkv8DWkTg
	 FrmB9HdyqVA+SwqOdLHX2YEAKDNvwHGsWgF2zKyrI0pN3M2vNmesTcSafYn/hHz37BPpL
	 MNqATb8eFP8bQaHj9LE3UKs1NqxiHnk3G3Y5e/dBKjsXOQZCVTNppj8RcQvSfqKHvRcrw
	 I+wyvbeW3nb5K8ttoqy+5B4y9CFdC3G7UY+/YK+aNlWkpDMzTYzycWzBonHg0Xo9ojg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=XZBBh+YtyvQM0pdcafD44t8IIIPhs3RkrgdBT3qDgR4=;
	b=0ym5+ksLSq4MTvw4Ct5u1RmN+g1lSyLQF+DwAywb7o2vyeZNHEu+aBS/YOaI94BgXZB2
	 eKt1PNiUwTSmmDb3Kj4TwgpA6GR66iJceiknKFTERMpPi9BsGktEDQ1jv1b0+CmVdNeUU
	 VwxoYXtuVR79MfCdaJ4yf4Hgd7hSwifrak7tMUP1ths97j3jKZeOAtmFIRr+ICd7A66E9
	 92wlsrFRsdxzF8+AnXypXuKW0V4wrB7Y9k0WpeSz3ecDCm3jxBQHY88vE0STL84eNuBCU
	 vB49IUH5jDk29smVUiYcfiF60kgUZYrNZxbzibVab4YiD3bxcEyFDnl5Ong0q4sIDWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Hg3tCNnl;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E79606A31B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E79606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Hg3tCNnl
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c162febb9so7955826d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802316; x=1794407116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XZBBh+YtyvQM0pdcafD44t8IIIPhs3RkrgdBT3qDgR4=;
        b=Hg3tCNnlzOc+NfSRMJPD9yjsGgSrDOB/iGXeOelBVQQ/GjiO+hL4fzWBeDcqmKfnt/
         McwYJR2yfuvJVvm2Pc3WbbsWF4UGkFzg01gBA6IN48KxeeLovLnRgtCzVoSDHFZrqiki
         4Rx7jcgMv8LDokJ2c+CRCdiINoQE1vs32GjvO27sX6auNg3xKQj7R8iVWL785kNDCek/
         FJX5V4Y0ga0sL+OEfYaT+umpMi1YgKtqb8Xh134VMEF2COSWKH+wvwDrSw2vHZr0zKDD
         q1Z8Ku4DIjPuSEG6CZfVeGiX1tUTnQMK78XQwUbdRzdR3dQ6FyaAK8a8js4zqsVjTDz6
         ZHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802316; x=1794407116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZBBh+YtyvQM0pdcafD44t8IIIPhs3RkrgdBT3qDgR4=;
        b=0s+W7HBTV4uYiZxmLTJ2PJs2c3vK8fzsVg38cT5v6ZfkEj+Dh+VMTghjBjw8bwzRrU
         gqZAno1AteiWYIHpdDHTxvm6QUC5n0fS6jFJQzixV0vJ5fSO4+n/Ko7nMOXNKLLgjdLN
         vI3FMpPbico1wonuqNTvzt6XdVC0bNTRmay+9vfZ4dVnt4E35/49JnH57+18M8/YmaL/
         TInnHuyJpeY3kmS5UUOhwn1DnQ2on215aILVgBzkLGikZA2ZVZsVTqZX+gQzGKqMEyyq
         VYpNqJ6gIl5oj5O1cpkWDOj2z/Y4+Oqmz/CO/vbVx7yP09k4EaQQNmReZjVyeUVqO9db
         it5w==
X-Forwarded-Encrypted: i=1; AKwUvBw6q2xvXIlLyhnyfV0NaSGK7nWuwHkxXE4wcnpfloR5O/5IAeJ6ERNBkTlO5vXZVTg0/s8ks8OO71Smrtt0nB9rZ7S9XI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+b24oqdLkExYPFIMzKdUNqtY/M0NVX1bH1OJCp75xFgOnwEIRP
	qXmic3JxRS9gykADSq7HnpUYpeqVdYAS9yVFE5D+DlqLHp/f1+gbQ8Qz2+71EkNA7oU=
X-Gm-Gg: AYBFou0RtCqsCo29Csr5jO4/ONpqBTmG31Sbmm+eikHQENeODeqkwYiqQdX/LqClbUc
	n9OGCqQhRnrqykv8fXaoMBw+se8mo9MdFsiGXSNYSJ7oJDt+vw1kD/Y/rkM1PJOPa/VEZ44mUd5
	9gxjiPKJVtiFWKyq1A3Uh0v2CHPMumdVhsggz/fLYvg4BDdIVQIxtKb8ZJYWHEzM06sDUc3av6a
	/fxzHxJfMAfX/HtHlwfDHZ9qM02XVp5gMflTvKNJWPOWvvcEn9CDznJKvsZFIXxomssLkoiCkFD
	0iPjeRjjxTqi2C7gAVw3GLvRVy/gDnvAS1kaLtQUnrUZNMCqzdJsiFyt1hmha4itckchus1T6OX
	+JlcMp4K73Y2VJ6GXisLYQMez3fs65lQTftANcvIEJZHax9F32papJzGAkP3KdbTV3/ZlwI4Ixn
	df5qGQc6xJ8HrDsjEYOOh615zkUBs2+4pFMK9M58txmMJpoA0V9npz2SldmsOhZg9w/tw0HZ/qm
	UqmotBFf+oxG7p6OHUahf3u3+P74iuY2Mi04wAcgymnKTBCm0rDKctZPB5PObJK49yVy+nBnOj4
	JnMZrj7bkKjM9eCDYZWMjF2RTCKiVshE+yZdNgUZYhwBWw==
X-Received: by 2002:a05:6214:c43:b0:91c:6388:a45d with SMTP id 6a1803df08f44-91ca49f1bb7mr266381586d6.5.1793802316221;
        Wed, 04 Nov 2026 06:25:16 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb8c99sm20129386d6.11.2026.11.04.06.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:14 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:40 +0000
Subject: [PATCH v2 13/13] keys: use cred_ids_allow_control()
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-cred-ids-v2-13-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=1044;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wU/wUNQ22CJbdsHXhdyhPKydSjViK+2b9lI6dkA3aJQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOAYiq0Qci2l7bb+IWY9NmqGqVlOj+7fxxp/4a8VZxK/LQUURR7UVV6elrGIGXXmHSrqT+zywVP
 V/5MpmjYNogg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

KEYCTL_SESSION_TO_PARENT wants the effective uid and gid of the caller to
be all three of the uids and gids of its parent. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/keys/keyctl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 36ffba0ebba6..cf963251a87a 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1692,12 +1692,7 @@ long keyctl_session_to_parent(void)
 
 	/* the parent must have the same effective ownership and mustn't be
 	 * SUID/SGID */
-	if (!uid_eq(pcred->uid,	 mycred->euid) ||
-	    !uid_eq(pcred->euid, mycred->euid) ||
-	    !uid_eq(pcred->suid, mycred->euid) ||
-	    !gid_eq(pcred->gid,	 mycred->egid) ||
-	    !gid_eq(pcred->egid, mycred->egid) ||
-	    !gid_eq(pcred->sgid, mycred->egid))
+	if (!cred_ids_allow_control(mycred, CRED_IDS_EFFECTIVE, pcred))
 		goto unlock;
 
 	/* the keyrings must have the same UID */

-- 
2.55.0

