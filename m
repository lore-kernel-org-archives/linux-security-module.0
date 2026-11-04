Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826588;
	b=2XQxCphIPTcQrYEi4HNF94/zBKLBM5MPEMcAV0LPOy9Es2HBBmjSsmL5aIq/w4BoLMvm
	 tW+gWIlaX0TANO2DOzxZg//KRNSHsuqWc18UqRZxQeWd70jaHIvm+M3lueypRqQp/4xa5
	 GijeTjGMlKulMbtE3Ga+vfZ3+/wByHCD5uCurYd4wPQLo18o9DOo5eoXbiJvcbYckospr
	 En5VfQVjNFZSHbVwQqvL+OsaPzoWxjamVeY3la7wQ3rx8Qtd4fXmZAQ1J+bAMR5zZWk+x
	 V7JqC4zcS6S3kOpbDOzDa3XNmOyhqX1XlZFByQ7/A+qSdg+pskAA+wIrQDpDeyaFZqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=PFZjTRUWdaKfWivVftRvXEOJccYw+XLzyzCwbiaKvjY=;
	b=So4ii1WtkuE3M24qGPbK6rP8gQ4nk5N4yqzi2FcFzywiphw1A/AgS558NWP0ZUNJZKmE
	 Y6ZNkBsxvUwDnhWXfx3eV1YF+kjB9fu706krkGVPMxmJYBhqACtLhNxpI6Sx6S2qTs2rb
	 k2VS0hQc4vc82qbHv7am8hpJnvwHHTlJXKSzwEadEhinufzGTluWP15gGQCjEmKSxUr2d
	 78vikbA4dYE4nav3MKHeGXwEZyrkDhzrGOFgyqdaJBBNP2RwYp/bqzE5dn9/EWqIZOgZ6
	 y+pMPjJd5Sk54olD/dWDasbuheqdFSJdzIQ8pmjiN+bEE3uv+tS5cMTq4QzheFeBiGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6n7oLqT;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAB607B9FE
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FCAB607B9FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6n7oLqT
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e0d885929so947498f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826585; x=1794431385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PFZjTRUWdaKfWivVftRvXEOJccYw+XLzyzCwbiaKvjY=;
        b=L6n7oLqTe/+BXJyAs0QY8eUk3qcZ4vKBgAjjrsHHtPP/KqSep0aWbQAdocebtNn3WP
         IAxqjH3uJOeAgLuVz4fvWK55RpMdzhOiSfgCxFoIujsO6QTdMtcCugGgb/8oSwrbE+bM
         /IBGAIAUOj+1sML6BJblUv7SK7TG1mY6pGdcKx5K7StjZUy/yeTLNTIXO+zIrUlfgvZG
         ChtgMSQCZKIM55YIcwZ4W7Ynb+IzBELdo+l2rtFhX78VTxYiNoioHADyjn9w7/0R3ZMl
         j5OVp+MyVkOFlLHrnxPQLDQeJcQg/yS2+Wm7WWD17+8jZ+5d3t6XiXjHnrBkxnBLAF0l
         PvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826585; x=1794431385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFZjTRUWdaKfWivVftRvXEOJccYw+XLzyzCwbiaKvjY=;
        b=MCU+VRD9miAiS8ilvngWTx0EqrCP0HyNqx/Nqpbe4VS2refGf3b57y0fRU7EjITOTZ
         ueEm9f+1ekzyIvhR7988dlRWucZVjcrJllZId5xwnaXEACUvBEH4GB/e4lNDTpdECscp
         PHxgASHY7pW5JBmMABW+dttenB530KeMdfA5qRaA6cRFVNWjjAMfPjzpLm+64sc/oRmH
         RhvpBnPRDcZDVO/cmwt4VTe8KYo5cmrMnuUS8dIT7SiYgWbzr/IXVqV+38QketLyWfy5
         yT2donoN9zSrZqGacR+NLQhIvk7bz07aFLuJdMGuLkmYjb8WolZCaDMEL5/hZ7+0jp4P
         W8QA==
X-Gm-Message-State: APuU4Z8GtVSSCv/ZbBGm6mJbUhl4Mw7Xd0pEF3nUcbuU6wc6CN3cr/Ll
	PFmzXXhi8wHx9m0A8myZ6szpt8UfqSscfWl6TJJgcYp1UTN1x9EVs7A7
X-Gm-Gg: AYBFou0i1c3fN60VF9U2kcpXcRHaTG1EoEgtMlvLLLKyfqj37Zmhfmx4ePml/86bJdm
	McroH92+Hkd8enaloOyCVxBz/HPFsGeFziMQEGfGcz+bjB9Yw6CzE96a5ejWYXKVNZFInDGj/F1
	3VfwBDlozE6jesb0WrdNWZPGJwE9Tr8wjECnzeOFExOoJzHN5QGhnaAKLB9jgYqQfL6KjaZVLWZ
	pQt1/DY7Ws+3j2HF3s2lXJkhAIDeVJIhBiYgqme+ZwYKr5tg7qYf7bH1+oTvWwhctKm2VOKKUin
	SD76DOXyibG0DpYd32nEF2GMA3Y0zJFJksJql3y5hWAAnYY61fvcKxMvBwI6Sww43Dtf6n05N0w
	G80NA9gKCA1WQn8rv047In5O8JKyvincUncz8wO5EdNF7x9D5MINCxWDIaZJiTYeBQ6ATbjARR2
	jGQggpxUYIjck19w5FjNF71ukL7UKFZuBqCxzdV+JoLw89PFkviVR0eyHlq75MBx3YQI//+1/Hk
	1zMXx/LNL2091AbEFMiIRSO7uXjTHkH/euGMFFNLX/sflqTw4ZMQpiIm4KSR0ZM1rbMY2tLtVZ5
	6QG5/i0M013AhIxm4Hz1p5xjoeew890JtKbW8/n6oYKBO5+XadCTeg==
X-Received: by 2002:a05:6000:2c01:b0:48e:7e15:406d with SMTP id ffacd0b85a97d-48e7e15413emr30075956f8f.11.1793826585471;
        Wed, 04 Nov 2026 13:09:45 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feea5d4e4sm5738727f8f.57.2026.11.04.13.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:45 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:09 +0100
Subject: [PATCH v2 23/27] selftests/landlock: Fix stale comments in
 common.h and audit.h
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-selftests-refactor-v2-23-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

* _init_caps() lists more than three capabilities.
* A 64-bit hexadecimal domain ID has at most 16 digits, not 17.  Size
  the buffer accordingly and drop a redundant domain_id check in
  audit_match_record().

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit.h  | 7 +++----
 tools/testing/selftests/landlock/common.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 173dcd1088db..d23bb2ad3a30 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -274,15 +274,14 @@ static int audit_match_record(int audit_fd, const __u16 type,
 		*domain_id = 0;
 		if (matches[1].rm_so != -1) {
 			int match_len = matches[1].rm_eo - matches[1].rm_so;
-			/* The maximal characters of a 2^64 hexadecimal number is 17. */
-			char dom_id[18];
+			/* A 64-bit hexadecimal number has at most 16 digits. */
+			char dom_id[17];
 
 			if (match_len > 0 && match_len < sizeof(dom_id)) {
 				memcpy(dom_id, msg.data + matches[1].rm_so,
 				       match_len);
 				dom_id[match_len] = '\0';
-				if (domain_id)
-					*domain_id = strtoull(dom_id, NULL, 16);
+				*domain_id = strtoull(dom_id, NULL, 16);
 			}
 		}
 	}
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 0df8ae88d4fa..66d68a92c6cd 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -36,7 +36,7 @@ static const char bin_wait_pipe_sandbox[] = "./wait-pipe-sandbox";
 static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 {
 	cap_t cap_p;
-	/* Only these three capabilities are useful for the tests. */
+	/* Only these capabilities are useful for the tests. */
 	const cap_value_t caps[] = {
 		/* clang-format off */
 		CAP_AUDIT_CONTROL,

-- 
2.56.0

