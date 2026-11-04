Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826546;
	b=zTYu3w1/5OjCuLTH3kbInCajAfaMSvBGwiK7nWkMSWNXxX4/aEJoD2cTPqEguYkuboeD
	 i1yupM6QDBhCp8lKZYl9QG+ozs5buIcYAo8/Vs1an0CkhhFhhBxm1gm9lh1OBi0+TbeOy
	 x90imwmICQdJKmNbm7W8ogThXD5BaC3ViYEwaTYe0B62hSzCbvDjfb58CFXDsUui8Gzou
	 yUdsksczfQZFNMZyTRgozMPJai0pdLchk2g9iu54m1EgEek/0WNXE15WWiyRIyaLCIexK
	 SW65p/Y3hRsi0CTCv3qLKhBgde+1jd/05qRNmsSkrCzQpjnKercuNGUlshKgsiUnUgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=+BAJiaHT9SMjEKcOpf7f607KYh+We/BKby4YKSOmSes=;
	b=turn5Qvkg7wElCxcgYpqUfd0kRHAvw3T+huWmtZp8QDqWliymJ/fKje2RU98C3U4tzXN
	 IFxLIb0TvDjvs1oK2+Uco4RGnV1OlYNS7cn+GFJvNuT6Wtcx1AqQbr2aiafIUfrNlLmUK
	 kGQJA8InT03TS9wZqzXGRkR73tQ8z45lLQSPlUtWW/nlD65Bq0fRW1/r9KDKRJdDHKczf
	 /nPeKbdK7ygdHkggxwZG+Xqla9LrOrKwk3lsMmO/SuXXXly9mInZcZV4ss8CjuF3MIMGC
	 xI15SX16sWX/abYu39uM6SuFG5tRYvT7m1s2mhdFpxcH/OgR/MPOQwCDrxMKeHNswhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7fUPbcN;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F314609CAFB
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F314609CAFB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7fUPbcN
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e09aa5264so620716f8f.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826544; x=1794431344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+BAJiaHT9SMjEKcOpf7f607KYh+We/BKby4YKSOmSes=;
        b=H7fUPbcNiBtA9vwbtM3wZKPmxv7HQZ9VU0ZRU1v1mVB441glYnt1BQC/BjaOrJqUvY
         XrMhTpnk5PhH88y57oP9KaCi25Hdx8QcZ7ocyObi78xLA1mzMB3vWCM0PFHY/tSxSJAj
         rKKY/GQ1DoFUzku0ALQDKkAfn3GaiS5DTvDydQmqebSVlZlu7UAMo/BNfta4GniKSDND
         1vIilRJMDtCPLZuf+thkbCkHi1z+90tugs1Sh+oZkndLI/XQtl/rH/3Ha9WqZiCqMsXn
         uxEDU58Lbj7j29GgXnKut8IwanKlnKD+ocY+lyLKxZ0tdNj0pbvHw/xV2OQSqk6y7OhB
         Z2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826544; x=1794431344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+BAJiaHT9SMjEKcOpf7f607KYh+We/BKby4YKSOmSes=;
        b=Qq7PvVDatbYxxSdHh6pe/0Vy/vEh367VWRiLa7QY0QxlPec992NMVbnaRd+cMygIGK
         rcyO2roquB03tvPU014+oSLqApemAontPjvdrr1BUAXmLoXoh8BDlvQ3p0XA76yJAAr4
         RN0jEKSd1XhbYlCmI8hW79C7IZ7eWvT2/uerDNc8GUJMM2TZT0C1nOsiwUlRWMQWSv7k
         XbVUfj6i9zGHyfrUV1gA6284VnrVxZpJf0WcgBvOoUsMqDbyqjJ+6z0B7VZYyH9BiNSS
         BVy5qsVwRM2FXJgTEfiRBARtFim3u4kcSCuOo2I+wMceh8Vm8SzOi4D5us7MB2RAjanT
         RMQw==
X-Gm-Message-State: APuU4Z8JiWJ9SnnQzwlMPXvhPj1sQkopUrWavg8B1haxyCWYVN/wMaCb
	wySXhpIlhbYf4rMdUWl7IQYB2MAIHogWVyGxlx5+kVX57zDRmK7rP39d
X-Gm-Gg: AYBFou2hRYyUwob2p9nNKFk78fbPO+BqKUpux0Or3+lBjPXwgPSSPMbxJh8G69KzNGi
	38tqRu0F+L0edgIQHf7uxRYoFiCfBkgqzwKpkiDGALbWrbsM19zWvAFAZUK1DqOWRLXKdlHyVBz
	MnG4vKsd5Vurebmso6v57VYIMPnwe0+a1vkt36hBd/D0PfiJV+/LS1048OVmcz0NR6CCHkDxffO
	Tz7vqEd1JmHUsuUWaC8chHSTymMulwoFHR9gcBtbyWTXVM1kLlEO8+x+4reqB6lTyQLVBnVa7Uz
	fbHAjrJ6kniCghAcPrgPM3TwbMYzfJ1VZJ0So4Cqz76qNC/h10/DBiKvO1ORZJ7ypW2MdlTDNwF
	ty7cuCXS1TvTwYmFt9OTOUQ9PETpAm0ayOoCzPqYz1qvER5oYosDEphviUsfcLWob6hYu6Z0qpv
	eS0UPK0ZIfm9nI3Hj+lwE0Zg2cWOz3+qO79pO04BG8r3dX0C8CWRHyaU5g7jvjnEp5Hf1CnXzUZ
	ObPFxexcDggzoaWRHjKvZhzzGOpKdCR4rPPgU08Qdrvni/MsXd5qdWHtX8PjENyjk4HB/L/VtZj
	Ja5hmhwisg2RaVmLfRclCJ7VtvO6LE8L/AKTpiaJCjFnjCVOnTbzxA==
X-Received: by 2002:a05:6000:420d:b0:48e:7508:bc12 with SMTP id ffacd0b85a97d-48e7508bda2mr36374736f8f.10.1793826544040;
        Wed, 04 Nov 2026 13:09:04 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed08343dsm5986455f8f.30.2026.11.04.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:03 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:52 +0100
Subject: [PATCH v2 06/27] selftests/landlock: Fix the reported clock tick
 rate in fs_bench
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
Message-Id: <20261104-selftests-refactor-v2-6-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Since time is measured using times(2), ticks per second are obtained
using sysconf(_SC_CLK_TCK) instead of CLOCKS_PER_SEC.  (c.f. times(2)
man page)

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_bench.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_bench.c b/tools/testing/selftests/landlock/fs_bench.c
index 78d1efcb2d20..05082562d272 100644
--- a/tools/testing/selftests/landlock/fs_bench.c
+++ b/tools/testing/selftests/landlock/fs_bench.c
@@ -32,7 +32,6 @@
 #include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/times.h>
-#include <time.h>
 #include <unistd.h>
 
 #include "wrappers.h"
@@ -206,7 +205,7 @@ int main(int argc, char *argv[])
 	       end_time.tms_stime - start_time.tms_stime);
 	printf("User  : %ld clocks\n",
 	       end_time.tms_utime - start_time.tms_utime);
-	printf("Clocks per second: %ld\n", CLOCKS_PER_SEC);
+	printf("Clocks per second: %ld\n", sysconf(_SC_CLK_TCK));
 
 	close(curr);
 

-- 
2.56.0

