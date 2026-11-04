Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826583;
	b=29k1rMLyxNjDpgkEDkY0BS6Tzp4Hkh9U11jG3m/n3U/5hCUBzIy7k+IqmcHnubNsRhvO
	 xq2Eba2USamuwEwAamogLrRkPyJjiZRu47ng0rwTWze569/aGDH4nw8CIqsRsPwmIG3j+
	 g7ZozmefjAKgEfC4looNS6xwZt5l0vU/6UxdAkmjmcE4vHTHd53gNJJaTbasj5ZoBhZjL
	 WAj+40/DUa9Pxdgpnm0s8xY/fioervkjhD5znuhtnsI32l5L640mN4gQ8fmwLI0new6M0
	 kynoMh+zuC3MJwsSCurTsGVRufgyOxhvix8O1yKd99uKSQwk3LBFOIK9vU+mfpbQBTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=LKarLfxYEUZqeqqLWzc2n+DvjQXfdpA91g/AOtlmbp0=;
	b=TpBzDN8lybRx7DnnecM23VUcFwbEctZcN4YKUwD3EqTjZ3gsnSrTluYir2ooglW8IjvH
	 mx0rQ5JGiLgId6BEEG1bLwz8wOpXicLRiX8dNVl60Zjm81a3QJEAAzIw9Sw26/izaBfLj
	 suWKJ9Jkls7Ov5QhlnECCrmmoo6EyqP1K3I9QuZME+U3MsJCVL1+s9mPLUgOWO4iTw22S
	 hFnu04SexGNecqnfyu9HGh1Qu1OAwLeahpz1z1oNdwqN1yuDigeKy70dcA20csP/Mc08O
	 XXdQ8K9G5a76KOMb7uFHvqUNuif87t/JL+75Y+hb60UOhEiqmLdt2U3pUGKxJVDNbsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QU3uCnBj;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061160EA9B4
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7061160EA9B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QU3uCnBj
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1024594f8f.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826582; x=1794431382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LKarLfxYEUZqeqqLWzc2n+DvjQXfdpA91g/AOtlmbp0=;
        b=QU3uCnBji3jCmsbc6W/xxM7tCpsWe3NmctUtH8kaE62jbt09PpVLnItdbrgNkmSUCZ
         LdZ5UR8gHdHCE6qvXFxzo11SVQwDEFRIQSkRP/8oxLBKdbcN8sR1jpDOZrzjBlLdQ/7h
         2vGOGHMRVZXCODU0ykEtVGCaSmbtRh9BW6NlJLGY5OsoFU/iNPqBcyO+a8MR4WpWEDq5
         lQzSlamHimaotFJ19UUR+p5LztcA+nDaU+Z0+2pfBWz4OP4/xCGSlx3dGDEV1vOwX4nN
         jg9Zmqp6fa7L4ejxjLMMSayv37cSRyAuY32toltTTnCPvruByENzalD4H2JiSAM7hqKh
         y/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826582; x=1794431382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKarLfxYEUZqeqqLWzc2n+DvjQXfdpA91g/AOtlmbp0=;
        b=DclueLKbBNyetTlk43E0yipPeE7YOyTBexrfNzZZMoyd7SZgH46/mSGUgPVwZVerz5
         k+MrUEh0NOaVMfl9ZKlOK37pqxyJEyJz7W98iBlCn//lDhPcjEqTYpUSyqS9KTC65lYx
         tDma8f2Ede+mPcQZtGcqAsrPzQcROqPHZoLX4SOUAKCGDbZKKbTUTMemJKjyqLnpRW2p
         0mLwM9coAhLvbtJGA075ZtfZOzHPWpEyAATn2BgknHSgfuonOxChja2G7j9E/gv6Szff
         AkYC78fn2fOCDLmKvTLLMCxBsv3yLHg5eh8N7JZP5ZcVD2ja4FLTQLiiIKrnpYhcJHj5
         4vTA==
X-Gm-Message-State: APuU4Z/6kk35zT3LnoAfl3K8AlqDdIf8/zBBDqzqsNDfbaS0p/Obw0+5
	siHqMNCO/GL0NOXqlHXe90ldFSlLtaWnraENj3AFCiwbuj6VUV5z7ud/
X-Gm-Gg: AYBFou0HJDNwq2ysMHHZxn2hu8Ix4NEAguVdPgGq5J4uCirs2WfYuf9xqUKL1MeiFej
	md7ks3xJkZ6rmLhBFl4wk5eURg4tngmyhHdzXoC8st4YUdexaBxjJVYKCRRunebxg83r/3V5okV
	qoNgvlpUa+J8zggY3XvW7iC0FYcnltv49o/PCwwWHF3mC2nOBliEDqANggoznIl+Cjcl4TZEBnM
	TrvWdhR13xCTdHtPY9zY8Fo0r5NTLNE8piZCY/vEFZ/shhEh0tP3SCHKQzThaZ3S49OaJraA5/b
	xInpD/eQPPs+CCtPjdrnsX9hdDJCKZpXQ/wJLygELISfrmFro9FHQAWr2tU/033sCorwQPtU5aY
	yYw3M4Pl2mkaqgYdFDGgHLpWZPKFIlCTBsw+ODkDLLQP0qT8x3Ynf81zj9q7l21AW7VHz3SGBmf
	Ciju4F88h7JS3aDQwfGVPHbV+OtxqY8/sv/6KKCPbUjOFdcUyZJx4a9ruf958iNNk+PRL5em35K
	0WK01/uQ2Hqu+GYrChpQZ+w6JXpNmUt9eKs3GcXm6wEb6KyqMDbF2QrAVW1+eInNnxGmC2SdWNq
	4k9kiW1N4OK/54DzB6cbdHq7HhgMwA5ZI0BVfM5HcIgVyV5LRjpf74WROw0di0DQEmP3llDecpQ
	=
X-Received: by 2002:a05:6000:2204:b0:490:b23b:8017 with SMTP id ffacd0b85a97d-490b23b812bmr3010592f8f.34.1793826581845;
        Wed, 04 Nov 2026 13:09:41 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fe7189883sm6177411f8f.0.2026.11.04.13.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:41 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:07 +0100
Subject: [PATCH v2 21/27] selftests/landlock: Use _exit() in the
 named_pipe_ioctl child
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
Message-Id: <20261104-selftests-refactor-v2-21-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

In the named_pipe_ioctl test, use _exit(2) like in other places.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 1e94a3171e02..78b2bf06b6ee 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4272,7 +4272,7 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
 	if (child_pid == 0) {
 		fd = open(path, O_WRONLY);
 		close(fd);
-		exit(0);
+		_exit(0);
 	}
 
 	fd = open(path, O_RDONLY);

-- 
2.56.0

