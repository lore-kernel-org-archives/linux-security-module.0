Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826580;
	b=xvrawmwfHtMcGN6PQGPargq23xmU7eE/Ed6nWBso7nzZkeRaJ0u641+Ibmw+BLY/HvfB
	 7IY5M/Nj6T7qoJRYlBDLSrRAEdH8qScIhPvmsHofIhjDUNGG6He68WvVOKExVB+rBfZLS
	 c9XcZC30sN1r+LAOJoSdVO466Lxtyn335LnxtctpLeKY1HSRqUyp3gJfZyjHbX4+Iv+OH
	 32gBoKgvpw46A7fMpfOdKNJFRl9b13DUcciBBGPKDoP+k/IxWgQgm7GcJtyXyA7kaNzbQ
	 +/l88f6Tp/gktGiCse/Lg+hiL/nj8iT06bIgUKJTwEOrVcTlRXWEEOoLiFosQbWiZvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=qQtHtLjeirdrtLdAQv/bdHNkyg2XU3B5gSMb9JJHLSk=;
	b=LSgPIRBhejlu420SOuTPBmQsD2EcBIJCXXCo5wxLV21vDC1SBbf9e5hSNXN+L2ITjpsb
	 eOAHhX1FTBUBrZwe/F3wp/6amhNNOuTaY/SpFq8xSVoBcUQgdUCUkUC0U8CaLXjU4MoxL
	 T3VOHwSFXcTHxlrcD21pe2RG0/5/iF9X54L8rsN9oMjrrHztto0nChpmbP9ppXrpFzYtq
	 haOtN9LbE1RF4zOfb/09cw4jZRHiiisiGH5HQybJHHaaQT8rrcXg50nFXy858ZLCGLZ7Z
	 N7ciOXFmGkHJ/OA8MQmcrrhqvwXHxZy1etd735RaTtF120FNCzputRXZ9WIttRY+nUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nXFAr6hb;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A64607F2B2
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30A64607F2B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nXFAr6hb
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4649b35bso992325f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826578; x=1794431378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQtHtLjeirdrtLdAQv/bdHNkyg2XU3B5gSMb9JJHLSk=;
        b=nXFAr6hbJNZyEpoDanjCPM43/J7m0ZqQCSqGipufmLsCZZ6TvVZm6EJEwQ8nJUIA01
         7RybbeCmUtHjEm9Buh5mJuvj7vpQSGwbjWfGEzLn83QIRLmdv6Z2zJuErj9VK/vDjrsJ
         E4pLs/k3VZbZE6Q3jpGN+8CoQdZGKJLXnZ+sNJo3320QX9k1WjDEQZZgZE2X6nJ+7Fno
         YoR5UZycfuWGtjqAfJAtIQtFhwdWYbrkAIsAGoKPPP3I334URM/Cu8BrP/X/StRGi1jy
         95dlPE5d9Oyw8OYyA6hXzTcYyuLw0cY1o6gZ9cYPZmHIy5Xtc25SPKiEA3EaOSwdyn7J
         O5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826578; x=1794431378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQtHtLjeirdrtLdAQv/bdHNkyg2XU3B5gSMb9JJHLSk=;
        b=GBcdaqy7ponh3+FRovZbCIoC/plU9xcv5NdI+VQJ+931wOKRAkT2oFVSVAYdQZsq98
         mUBgjDzTkQSF/yn7g2MaX53I/7bicr+5cdq6Nmj/lTPq7OEb4eNd2cPaPEafZP3ZfgtD
         Mu5qFt3zRVvosYfmKVZDmlx+NeWxEH6BQBk0Bx8+O55cmIoTq/0S7m5JyK5Wwidfelus
         dTA2WLfW25zGeLwxlMWaUw+Xtd2ulKHQCP7MV8m4LKNNHM05JBltUMc/rzUuV6u1Buuq
         N6Zt3zVR5d8r8L/sSqrc27w0XgcMh4DeVMAlOz2+C/xD3NyXV/YN6LdpPnomugxe8wXQ
         0rTw==
X-Gm-Message-State: APuU4Z+X8Cg4Sz3Lea4A6ee7I1S+IurKdggPtxAW6jtEUCtalqkWOcW1
	WJdrCX/WdU67XRbdjQ6wCEXXvTFFWrdf95XkIM4x/WQ/ElCotXwSi8mn
X-Gm-Gg: AYBFou1KS4W/Mzn4aqdWO517vjsk/rW7332zv4HM0dWXMZJpyYpW316it+Tu759zLK1
	GKJn3ytwfr03IRR/jYuFEqIYf7Cn/S5+I9ZqvU1MucDihI4htmjQkI6bu8GzZHhrbMXjludQSjK
	2hfbQ2bRnpvS4PRKjFu9IIYzH1Gip3w+q/jpDw/NXU+9r8H+mmnZ9exQL2ycsltmqWMg4Cdj3tV
	8u9WEX2FvwEUC/TFASOWucVdePRiEuvrHbfLfDifllA5xjvBFy0r5U+Tfx+9gaYhZoMs5wRRmH0
	epFkT0i/gao0vCcCyCSDgBGTqT0MpAGYXEyatl41rJ0gfcbo58zpts7oTt9G9+jS2TfNflmpuZ5
	I/HLon4r7MI3C3mUNXnACbyilZpaxS7f7Hclv1PqyVNEJuKWSZVtcjs7eKSShPTys9I8kEeNE4c
	hu+tQOKlMk9n7SWShD5tjXrumkmbE+x07FMErUzm7HPpxb+yNK3UfPV980wsVRazyTgUNO120Wg
	wBVOzPvJ/GkiTjMjg3oSqCmO/VayTp0G/agduk09L865+OVSHmm5+xOcAsGHyQ+gtaL2tQaTvHT
	7QLBWz4ziEkjtJegtk0Uqn82sbJRCsnafhG/LqNeKpj8MXIKIQx3fA==
X-Received: by 2002:a05:6000:420c:b0:48e:5acf:48f8 with SMTP id ffacd0b85a97d-48e6e302726mr38283835f8f.16.1793826578564;
        Wed, 04 Nov 2026 13:09:38 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd43bsm5726190f8f.14.2026.11.04.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:38 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:05 +0100
Subject: [PATCH v2 19/27] selftests/landlock: Fix off-by-one in
 regex_escape()
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
Message-Id: <20261104-selftests-refactor-v2-19-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

The final check in regex_escape() was off by one byte
and should require one byte less to put the NUL byte.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index dcfdcfecde86..0df8ae88d4fa 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -307,7 +307,7 @@ static __maybe_unused ssize_t regex_escape(const char *const src, char *dst,
 			*d++ = *s;
 		}
 	}
-	if (d >= dst + dst_size - 1)
+	if (d >= dst + dst_size)
 		goto err_nomem;
 
 	*d = '\0';

-- 
2.56.0

