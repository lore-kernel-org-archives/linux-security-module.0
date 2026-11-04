Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826558;
	b=q+Zo/rADXjRy+F4y2eTQaxyGcMCCimbSRzWbMwbv010yIaxiXTEQzXT8AJkKnT+2ciBr
	 0Uzb7LguZGqoizO/9ihEsxs6RSImOqPlj7i/4dGapW6Fe+C3PzVjjBw7/JgjxF58IZ/gF
	 5xraUdtpmxFOk2i69LPPOt6tlnJjlwRdHWXTpoXRhDIvcRYKzVgdRLn7aIhwzM7aGa7C8
	 NJGoGFsjIbMxfinRZa2nut+e1cFJoI5VNKK4TnA8Pf8I6wrBPlGb43p5SJjSQ9gyBaXV/
	 IObKhG9/D5uL4dW2WIsJbvXSy21nNnBz2GspsfWMDjBNjDnEHNKRZnVGCwMLuvr4RNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=8CsohqMXEeTvUvBbDJ6gCtmQRpYFrO8ACh2vQp2x8hk=;
	b=i2Gi282LTi5ZXRuHqzDIZ9N2dYZVDmr6iLK3ZFU0bwqXzFvGjSrj6S8x9/gPuS1wOr7A
	 KNC0V3yfkFB7fvfvZWWrRERLFBSVN4XRL4ugie41WgjElSF4HWI4TqZy1jCoLKj5oVSxN
	 rLJMJSALY0zCzzId8oegd+eWvOIAZ8tFw6AUzzDd2rjouIPPGdoo0HctQM89c1ClhOiXX
	 dbQ0eyEl3r8rg0PTketp0CsqjE/nBYvyduC0eQVVdZba7aa3MMdT0WuQykvMJ846VISmQ
	 fmBwuw2y/dq30Tv8g4pID8CFca4TA0QQb8fCOqxhhYVHFwLQ8FAxWGvbLyReGODa94g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oX++8FJC;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC3607E92F
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81EC3607E92F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oX++8FJC
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48bbb06e746so755186f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826556; x=1794431356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8CsohqMXEeTvUvBbDJ6gCtmQRpYFrO8ACh2vQp2x8hk=;
        b=oX++8FJCCxku5U+GQGQw67eK8Chub/aAMqjWqSwhZpapRvc6a9EhHorokWblRDuge4
         t4GFnaPogsTp0+y40uf7V2jma56d7Xs0gWQU9vWXT6wn8V2kLxnCnzrUDc2T3Lwrc3/M
         a6fq+xBg/NWgVzVFt4iwMl2q7/jH9ObyoogHUZb68+auN5UKzXczZ+UWVawnVLQnbRMI
         JDbGnLZhQsOxBTfiyquSmf1Iit/haHWA52577F/hZCVJbKeFcqjFL0rrXpbgP5rBQP54
         q7BdXyuzgctp+4V4sLJJeR96bPRG+YZ2w9gWAJ9DI4Fbx7uwSX8ZCSai4doqpvTsxgYU
         +qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826556; x=1794431356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CsohqMXEeTvUvBbDJ6gCtmQRpYFrO8ACh2vQp2x8hk=;
        b=PTWTIluEU+UVCV3bRIUd4LA/4DGz/JwCfLsZ9Du2fzkLZ8FQ9sJzSFmuGPieAdyycw
         rjHG9Lo5H3ULzblfidI68iObNbX4XAfS8hq901e3NMI4hxwRYSLvhTOFTvkpva8pkN8n
         kqj9f484fHQGBQOkXB/Ujhvb6DEXJFxQp8QBJwiKPUhAipZly7PvGRnb6PfBkWBaBWxG
         eYsbNr+zZKowHgZwvgYUQZ2+k+irFgI76UlnypAikGmdw0SlmwLlZJQy85pAjVplJNus
         JDmxwUkbIpT3mqxTwIz193LUCYY6P5NL5I5QZuSUjmZH+4RmYy1bxVGeVJ70jBJvepAR
         VGhg==
X-Gm-Message-State: APuU4Z9SfJodtzHJieLksepi8oiHeeInPyeQMk7V0OE3pR/smLFRLKIH
	a4JA9VfnAJ5B/LJp2TIPsw8ZC+UzAdD0zCvd+YU4ai0D6F9t78IzXv8w
X-Gm-Gg: AYBFou24K6CXxaQuyqhjX2NXD3xUaz+5ik51fdf83DfhoGA7AgRSzbD77OXzAtVr9Q5
	PEGFTiEPZA+vYGU867zUjtWG2VP254fcbkSsEgsd3aiuK36emSuk3RIAKbWy04WplBGotts1WDi
	WdbM3gxUDA9BAtlFS3qaqTXnAlGxIkeedlzEmolvnUcMZ5aJkXcYj+6UYP/Rj68IrirnBeWYsSm
	nt9rgC5C4IKaCQwHta2+Slp8+xwTSNVI1bCrDwr40GRT3rQosvxF/PV/8zstQVS+d0jGpv3ORr6
	yebuSAeM+isFrn/IVtTUPDVDtb1XGQBRDSh0osNolsEd1aA7OWGcMq6LYrlA7sZ4A+nK5rbFbw8
	KG4I62jszhFFHhZGUBVway7A3lHLXTH65do/wvYRPeiA7HpMlubQixfFf6TQd4n7dDkkPnZFv6n
	ymTfEfiQz1cE9+Bs+bhiHDt2Km2n/m2XYnFofR42Q9I0gEuTSyxn0kBPlPVqJE0kSCIKBnaF7SF
	s7NUGRnNBP71KHF+76VMfh/1UWa1PjF9dnjI+RvIVA5M3ffRBeqyVSPHm3C4SSVYrX1CBpdZ5nE
	b0eOiF5c0waMqaSR29vzglBAfwoCmyxkH77ffvNO3o4qTGUzuBM4nQ==
X-Received: by 2002:a05:6000:310d:b0:48a:f59f:8b70 with SMTP id ffacd0b85a97d-48e6e4f8c71mr42004728f8f.46.1793826555914;
        Wed, 04 Nov 2026 13:09:15 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac17c1sm5654092f8f.10.2026.11.04.13.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:15 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:59 +0100
Subject: [PATCH v2 13/27] selftests/landlock: Fix memory leak in
 audit_init_filter_exe()
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
Message-Id: <20261104-selftests-refactor-v2-13-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

audit_init_filter_exe() does not free the buffer returned by realpath(3)
when the path is too long.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index d428ce802f49..1e533b4e26db 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -507,8 +507,10 @@ static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
 
 	/* No need for the terminating NULL byte. */
 	filter->exe_len = strlen(absolute_path);
-	if (filter->exe_len > sizeof(filter->exe))
+	if (filter->exe_len > sizeof(filter->exe)) {
+		free(absolute_path);
 		return -E2BIG;
+	}
 
 	memcpy(filter->exe, absolute_path, filter->exe_len);
 	free(absolute_path);

-- 
2.56.0

