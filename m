Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826549;
	b=zSOQOhNNLpibisb2TeX07QUkboykTvosvpjrQdZhvuRs4EeTBTALFi75ApYe8p6vORo/
	 RVEKSDl3bWUlKb2mJsG2ykxz7Ih+0ShfLyeTJ5dCHz2HlGcmVp7LaunNf4NR6tlm2Jyi8
	 lX/87A/EtcrJpjz131v0vKfycH34kPnThA6ZthZkd2m2ldbhMUIlq/AE4onadr8OLRuzK
	 /9byRzbsz9hY5yUN9+WVMG7wHiKNZTioV40cidFeJDW9OVgNMuPne46NNTV28/Jq7JBeW
	 WBdnybQZELKZmfqXbJJhhuP8bKWUTijMFppyAuPZfcq06bYcB9LzqUBM0cW7BEQhKDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=KSffZYDq62GP7tnRprhjIEMyyX/StOyoMuUB9ic+kKo=;
	b=sb0sn2NWcmdYbsA3wWeKQChNpYv0uleTZsRJ8ZQFPYgB4G9UpPaz5SsGH2vEG4wmI3at
	 VamC3a3CM4lsA8rF7lAo+JhUD5g+TXVuqyFO5HBm8gBMoFNjsJ6a7/mH3MkY4ykUA3Ton
	 PQJCum0huprtYuw23XwalB29RWVMg3pIHG3sgx4cnyE5abuP++k+czQwDwMymE2hZsjX0
	 S3HBLrCBE7EiZK2eXwTWU0F0sv9uQB6JTLozF+dJ0rTg17ywOzDHzxyG8Mb3CPOLKAqZT
	 X4enTdNLNBFOfFqPy2NKXleZ+SnoLeQg3Fixvjksj1vitEOtB9/PP4dCa8ilr9LACgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PHieJn1h;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC160A16FD
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03AC160A16FD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PHieJn1h
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so9649365e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826547; x=1794431347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KSffZYDq62GP7tnRprhjIEMyyX/StOyoMuUB9ic+kKo=;
        b=PHieJn1h9CDxFIUEuSOfcKfnu93q/RQyKGNzAHGbgtTp7cd4pW6mfHqWIjMfE1u546
         UAIkFsE2uDf9ZX7mmVdnFNKLhIEWQamCDDH6Q7ddinEkDbXlMbvjmgWcTCqCEt7dBxok
         gD3jkzNt5sSiHocdHA/Q4UOhraMvQdfRSDdDBAFjf1G9cBk3pxdqP716Tx37ie0uYRLN
         3uqe6dTYMGooJAnVQYWTUrgg4j0WzG23/PihD5Rdc/En7Y9PjTUvfTemU8TeqLT8Ozm+
         /EDYVFkMcvRzL60yzyUVYRk4KryaPsnxuHeEBPsElqQuzRzUVT5rv+o3q4QFbvUuWd29
         Mbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826547; x=1794431347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KSffZYDq62GP7tnRprhjIEMyyX/StOyoMuUB9ic+kKo=;
        b=O/B3liYTdheGieROMvhghNSPsDXuwrG4zTdlUZKx0HVjlq3n4FKoMzwmqFz0oRSnre
         B/vIpD1Mn8npQV8fI9I7p7XQWYu0pREvfAvvFik1Jn4UIRusMSQWHenXejM0T/M2QOXu
         9elSv0m0JdjVyVdhLUI1MIEMQ1M6hpbMP3e8V3x6VMw89OlmXPrYfTg/iXM4bpP/LBx0
         q4SVeIk2pyy2N9/PX/6nVDipywl7rMkRVsAdQ1fojkZRVJp9EWb41kYRWSpNP8FfhjnE
         m4gZV/coh4/I0zHGgy/ALUgb9p5QdbLb0flO5BsMwcTyxM0jS7yB6Gry6LeGYI7hH7G4
         LOrQ==
X-Gm-Message-State: APuU4Z+LRtRwcF+duRwxg8mSpJ0SvpXla6v8p5BN8+FV4dh+t7nZ+i97
	6x7MslHzLoWS5VWRt/qL3ftDsZ6W24n+/oO0lwMuvp2BvsbC6ZesiBQsYeZhoD2l
X-Gm-Gg: AYBFou1X5BEZcikf6Q5KCCHIWHazagC4M18PaQwx6uQrRacOykRnW7H0ABMPTtFVEsM
	gYIr5ZvY0Bu5IrhplEH9MRHqutp3S/AqKTeHXdJgjjcDp+iGpPUjOQksNNTmkugCYat4NY4pTUu
	348P3+JJF7vunPDajCH6KMbFo7Me21zCDY6s/Uv7a4/SnUABO21L9t70wVk0suJ788E0UJuYHDU
	DSjLsRWkatfNqJbLhzzADnjshCiF2n6XXY90XIJyYRWph/DJvjkiOt23FnYAENhnWhJs6D3Y29V
	8NcFKyTc/m6iLCxESA3uXt2yG9no1Iuh8oD+hyUXiW1ve/C6piRYGQLqwdHWDaFfxZfLAkvIhWg
	VX2htchT0rCKRUUpeJjfox+8uYTTuM5eMkT7CjxXujT3sXsuECb7GiORGy6GZU2lLuqCxDnL06x
	+wlM4Brj2UxyvidWst5ak0pJ3IniMG3LvBwbH4Tayk/72TgF9vwmjARZE+IJtogxUNmcNjfVT+4
	vSCFJLQRutr1M76Xg2qX7furkBmy1tM8aR4huUVCetKngESykvv00e12990Jsc71/wUd/jF2RHG
	KhHIjeQLvhwpzt5sNQrVfgzRz/loAUhlGKuRq9U1nzzHgF8wC4f+LeHA732ww0uy55XzGPkX9Ju
	Q
X-Received: by 2002:a05:600c:1c0f:b0:4a1:ac66:6059 with SMTP id 5b1f17b1804b1-4ac19233381mr384799355e9.26.1793826547408;
        Wed, 04 Nov 2026 13:09:07 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b414b170d0sm55148665e9.1.2026.11.04.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:07 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:54 +0100
Subject: [PATCH v2 08/27] selftests/landlock: Handle a missing control
 message in recv_fd()
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
Message-Id: <20261104-selftests-refactor-v2-8-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

CMSG_FIRSTHDR() returns NULL when recvmsg(2) did not receive any
ancillary data, e.g. when the peer closed the socket without sending an
FD.  recv_fd() dereferences the result unconditionally and crashes
instead of returning an error.

Return -EIO in that case.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index e29406900c04..6c2aa913ff11 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -171,7 +171,7 @@ static int __maybe_unused recv_fd(int usock)
 		return -errno;
 
 	cmsg = CMSG_FIRSTHDR(&msg);
-	if (cmsg->cmsg_len != CMSG_LEN(sizeof(fd_rx)))
+	if (!cmsg || cmsg->cmsg_len != CMSG_LEN(sizeof(fd_rx)))
 		return -EIO;
 
 	memcpy(&fd_rx, CMSG_DATA(cmsg), sizeof(fd_rx));

-- 
2.56.0

