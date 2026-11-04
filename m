Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826559;
	b=NOdqEVzgve+sY5+IT+I0uhpPko9pEKTvVajmUw1N9IvVpVxMZwFZ8fDf9CAsvz0ilD5k
	 48iPDn0x0s9RLiXDSKM6pbM/3E2G3eSMd63mRIySgAArW+XPZWsJRPfcdWKonvC2RYAwy
	 aMVKQr7wFBz1aNkZCjf3/Uu+NQ3SQnaHXUBUE+fZwAPr8w3Y6XgfbzVkyoJECY89q0Wlq
	 g2myD/rxoTOn//ZR9vwlTh/sA7rDdvNHjbwAp4uaFP+8b6Bw4NW+O50uXzoTJwqKVXV3k
	 /7gAoETlkKroiVvxIz15iJL3Ihq4I/Z3Jgv5AJPBDFf/Z4qz1bTsAQo1aArZXi66nXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=zyZpk01DLf2QnC58+UQV1wk4CBVcfTT8UP8IdGyE7ZY=;
	b=UfAq4dSaMv1AI7b3GmIMjHZRpndm0jrxy65ANI37X8Cutg5KqRFLvwZEtswlE5SBwab1
	 IBL/jXQ1Q6q6mxG4Lk4hzaiM1pZyVWPAGqmAo0do+mi72o7+IgRMO1DSt6NdVg6tm2qFx
	 0O6UYQ3ObnjLjw53LCz0606BbLuVp6CnhqFvqiPXoNhhXyKTjVvO3atnKJj52L7ip7bBT
	 qf8cVCuAGqx5EU+rszr5hxs/QqLEVDA5yxR5t1ukZQ0EzUcd0vN7VB0Cc14bzLtQ8eC1o
	 G0jqORyzqIjWWuepW/Wwpnaamlxti9LwBEsYTVZGj0OJu5/YuNQbl/LI/NK1KriXGtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmPUDHJn;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4360A67A7
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F4360A67A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xmPUDHJn
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490a0e72588so469524f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826558; x=1794431358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zyZpk01DLf2QnC58+UQV1wk4CBVcfTT8UP8IdGyE7ZY=;
        b=xmPUDHJnkAI2JpFOCpLn7lbCItH22ZZ1DeIqLMRulnAOuDv4bnFCWi0nCkut1kpz+t
         Q8lcYX71cv2THd452ojIMF7hyqTlxoPhhF9UsnBQU00ZiqVsW+uItNBQ99Up6NWjzMZY
         rbV4d2NaZWDCEHJumFJXbbSYP6GfzQFxMoTnl+SIv68thPTInzWVLzig8X386MGJpTNU
         pwhdPqBI3zD1ewhdNW2j/QRKMi3dAp35SYkNwBNazXqK8tAXtYmnh0kiSSo4NwBFI4vd
         kMnk7V+k2B9lqBiChIwp9pW4JxMG2G1jf2J3g8S+n+NOzVxoS00Mhc04WDeXnFXki7v3
         F4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826558; x=1794431358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zyZpk01DLf2QnC58+UQV1wk4CBVcfTT8UP8IdGyE7ZY=;
        b=Fk3SrasIMjgXZNC+QCUVw5V7BLNcvh0YSgiI+7mLXdVaSzm3H+3Y1K5vMS91PC6ouL
         Ew9MUkaccd8U1DJGUveW/sCF7kKT5pvBB2MULVuG8oQxMebsEpX6VnATNuL8OK1UkU1I
         FqGVxiUCkTuV7hK3772UXwnLqkt6/m43vidwejKPISzyIQzyvsVS8AaOXzgYN8qZ8f8X
         O19f+WwdbrCazmi0fkdBgTF8wAdKhzYoX+8R9vWLO4/9m4jrKXAUezJQJEzEwfKzsr9D
         ut3N3F9v8shYkKxPTsPHNBrlii3cNeNojaU5V8CZjpGowDA3PpKkzkXyuBu271RmMhiC
         JYOw==
X-Gm-Message-State: APuU4Z/ibYwTumR0YeEngcqlEdRin/rd3sm+miffczNvgpN1bJGXzWEL
	y8czk+xDsDZIpiUtpjpJ8OX4fLjoa8RdfltbjjnDQlS42llZPDZnR3dg
X-Gm-Gg: AYBFou14SFbL/b7DMlMyJSvJJjNvFhnwaNYqpkX6YKozLOcaR3jQ2rZkCm+47vkJlFD
	Kmu+Qy609A0b+PdOAKfrn/HmaWr+WwRUBWmXlGa540MAWuKaNvyPxJzX3l2t8w6X9jMDJM0Rf2u
	ljQuVPAXUMA2rUBmDCZJ7otjCmJVORgsUcJ/M+Q75Nf85XAZaJ7G0BrqiyEVJAzsROJkZMgw+Wy
	gwOKzrRwqGm34dq6k1XY0TOu0q9BOhbXUD27gkAq5Qg2lchCTcaMRcI818P+3N25LetjakXiJh1
	32B+hSDEfOHPRTFdv1Lif2iPa5FS92QaKBRDm7EGBDDDwmozMVUCM4Uyfgnx4B2q4DmaDrrdQzK
	v8QLojTraxqQ701hmz6Qilhn/FTIOezOsQZBBd06kdPLBQTwXvwd8xqJB0KM7FWp30zNGU7nIVK
	2Gd90i3NXWFMFddbAHKvHM9nyPyuW191jAmA9OJdrZFxieQq04TJctKPHn67Tae87ce+ylyvQjJ
	nuW1DgscIeMlNJ9iHkmTqyKlGph3vPrSnynppEBlBkQATecXunFv7vi7ctHZqSB2sOKEHixt3vY
	PuzsZfvdkEeXWclesplnJK0l52qGbrZuG7IYVZbfnwv2vFsCUmmfcYM=
X-Received: by 2002:a05:6000:420d:b0:490:a481:7ac8 with SMTP id ffacd0b85a97d-490a4817c00mr3361546f8f.29.1793826557552;
        Wed, 04 Nov 2026 13:09:17 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed92a753sm6643541f8f.45.2026.11.04.13.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:17 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:00 +0100
Subject: [PATCH v2 14/27] selftests/landlock: Make audit_message large
 enough for any exe filter
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
Message-Id: <20261104-selftests-refactor-v2-14-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

audit_filter_exe() copies the filtered executable path after the
audit_rule_data header in struct audit_message.  The message buffer was
sized as PATH_MAX + 200 bytes with received records in mind, but
struct audit_rule_data alone takes 1040 bytes.  That leaves only 3256
bytes for the path, while the kernel accepts up to PATH_MAX bytes, so a
long path overflows the message.

Size the buffer for an audit_rule_data followed by a PATH_MAX string.
This only makes the buffer larger, so received records still fit.

Also check that the request fits in the message and return -E2BIG
otherwise, in case exe_len does not match the filter's buffer.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 1e533b4e26db..173dcd1088db 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -41,7 +41,11 @@ struct audit_message {
 		struct audit_features features;
 		struct audit_rule_data rule;
 		struct nlmsgerr err;
-		char data[PATH_MAX + 200];
+		/*
+		 * Large enough for an audit_rule_data followed by a PATH_MAX
+		 * string (see audit_filter_exe()), and for received records.
+		 */
+		char data[sizeof(struct audit_rule_data) + PATH_MAX];
 	};
 };
 
@@ -171,6 +175,9 @@ static int audit_filter_exe(const int audit_fd,
 	if (filter->record_type != AUDIT_EXE)
 		return -EINVAL;
 
+	if (msg.header.nlmsg_len > sizeof(msg))
+		return -E2BIG;
+
 	memcpy(msg.rule.buf, filter->exe, filter->exe_len);
 	return audit_request(audit_fd, &msg, NULL);
 }

-- 
2.56.0

