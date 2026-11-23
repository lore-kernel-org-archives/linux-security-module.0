Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452893;
	b=JHwX2vQMYmJrzXnfQCxQ0jwFUR6MkRcnAORC78QNxJtykPROvVvfZ6R1R70DSJaNsOsR
	 H+hjIxsVjH+hevH9PSmTkKmvP5/rqARubXW0lWNkRfLNjRjNZ/QJx69eG1v0BUfLjechd
	 lg8sJSyR5sjmfEt/HeLnbNeyTUnVEvRi31i1Yn1QeUXi14ljWEU6tGFB463EL2Whru5Lx
	 FO9SWVGbjZsniFWk0SasOGLdUh0B3PPBf0ZGM284btHKBR0vTUYZ+mHjB+T5icrQXAOu+
	 QwR9ZMzY1GimQ2VkPYSH/+czcR8mE9oMtQ7erbDNDV3ligU9oO0tu9WaovQGcW2MZDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U3jRYscVCj/T0+Gpz0itoENJP/iaPGKFrItTdO07iJo=;
	b=397UEro257TciBATqHGmrxMiWoXhbVbyz6mVuJv9LiQgJCHHheiXz2911M170fEds5cs
	 oNkCoNFAD4efmjs4uItpqHhIHyRKWai/QnWO75DzkCXwtorQG68VMqriZ19SJk5C52K1A
	 W5cIvdv8/4mU1PrTZ14Vywp60OGAKkaoYqz2ZmkKWsTgmEenXLlvjf/c10MYD6aEzLWH7
	 0Hmw8k5/LwvBS4W3L2upzCJXm8OxCXlxgqYw8P5sYfRl2YqAcxFLQnMXp3accpxIg4s5D
	 0jYjZBTRMZG5/1jjSqMI1Sy6tx97HP81tT7v4ROIomAQcSO/OVotb+X+EC47c6dEvfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jRVc6dku;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD147606A31F
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 16:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD147606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jRVc6dku
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3b426133d98so960345a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 08:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452892; x=1796057692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U3jRYscVCj/T0+Gpz0itoENJP/iaPGKFrItTdO07iJo=;
        b=jRVc6dkuxiaILyjn3zOynVacIqXrH5QflVYpsKlNkgLk3UCKb2sQuPbdHJSGwdnSMi
         kFftJfIPGhAT6oU++QqxP8GeB1r/3QJObdGm+O6P0UtASqHZEpBDeRfuMEwV3BWyen8g
         tTC77mh+gIBKILgyqXc7uLa38W6OPscd3VDlBHgAhGUv8Z+niJanDUvXsE48gBjTz3F7
         GvIKu2o6tYJXvCRpTZTPMLI6tuEwcbARUc3QgkuRpBBsHXsWHEphwUj5ERWnaBMLwtIo
         eRcI2BZR97JZubIEUIIMkcX8hCHuvclMhyt7bIxxs0GnOQwHaB86kApjpWye0UOqnSSs
         k3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452892; x=1796057692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3jRYscVCj/T0+Gpz0itoENJP/iaPGKFrItTdO07iJo=;
        b=u/VX76RnMuWVv19OW5Oh3pFGQNdtX4TYvM+ScaRoyl37SjTxH8C0xInUr668VWc7Qz
         iWQw1KiGGngd4MrJX/2ohceMwtdx6y4R6yk/27wDL9BsjhntXKYQhzxQyPuhDzP3D3/v
         WU6opG84w4Jy2ECnjLtZcxeQo5tjqkqgcWAFZumeIw4DKruslOOZW4STlHRzYfe5xFkB
         JYm/KcwE+UG/hTf8AUuYTP7ol+EQOuwOb2tyHnM+2BncaBehwksLlftTFmPMlD0ImSIN
         LNQ0k8KvfwnnyyrUmyHAg5LMd8A+Q/XtQjB3dRlc06MqnzQigD6gU2kCMdy0KSjbWHVq
         FhNQ==
X-Forwarded-Encrypted: i=1; AL+hErGQkmhF5NLcdBZwrnwGlqL5FIeZkzL9w/0iwy0pN/WJ8i8531YdOzb4g/ilHou6JsqXb4qj3mm02FOIdV9Ke9eoEZmFXNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lKzP0cwKpPqeYm3xlcPJ20AQJ99ke4M4jzIpdo3v4XNaQ6fGW
	TQY6k4F6xmF5wJ6gujVcQ7eSpQdUUzB7JxxKImFa41jd5GUNOT7jBdOY
X-Gm-Gg: AZFdTZfNKAwkox6jhWXvQy3ULH5JuCIC0Jv7BDDd7L/AGeCkC/AgPm2CPJ9BcIPEBuu
	mewNezUV4tQoidV9eYV7WomUCOOHUBCnbtT2ahMDzifMsNcKKiijVP5LaaxHVpnjuvohY97sr7O
	ZBQUgiTGSPLoSrPBwbge9eUn9zFW6clzRP22TMGNmP+1hD/TBQpJXagxDYoLE0N/LhSFMNyQfOG
	a4s9cDSSlFGrl+YE9yidYUA8OxZ99K+Ogp68aG6sIKWFH/J+krMPLS2ZsPty27nyWOzLDrelEQM
	n4caYVqqlUVubZJXcHX+WdL1BlfQsTrB6Iqundn0pQyCT6fCppHmqygKAhNHwlNvqxSt9z/iejl
	7lqtKP+330S2sY8g6W6JLY6CAvHWvwvzWEkyYFTcbml7WLBMhC3P8VieTbBoJw/LwcdrI6E57VN
	UbdurSX1rjYXtKihhQbsaSN1w/9n2EH1vpluinXMs9JTZGAKRAsZAkNFa0IFR7u99UEeemfeE3n
	MOWIqetMA3M1lFZNmO38P2iKjUQdif9zObXMuFb6xGTb4bLfzVXIFwYu3XmaYJyfMGjSmDpZWJF
	qZCTgsBnA4miIv7JltzJ8GXgojWWyi2Ngkk/Uc6ik79zFcyeXRaIH2+P4N/jGoO8YWg2gqoPkIQ
	=
X-Received: by 2002:a17:90b:4a48:b0:3b3:b5b4:e4a9 with SMTP id 98e67ed59e1d1-3b41c7ac07amr11177322a91.3.1795452892153;
        Mon, 23 Nov 2026 08:54:52 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b792474sm7976358a91.3.2026.11.23.08.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:54:51 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	Jason@zx2c4.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] keys: fix crash on big_key read or revoke after a failed update
Date: Tue, 24 Nov 2026 00:54:43 +0800
Message-ID: <20261123165443.4092852-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

big_key_update() destroys the old payload with big_key_destroy() before
calling generic_key_instantiate(), which can fail.  The destroy drops the
payload's path and data but keeps payload->length.  If instantiate fails,
e.g. with -EDQUOT when a concurrent allocation grabs the quota freed by
the destroy, the key stays positive with a gutted payload and a stale
length.

A later KEYCTL_READ on such a key follows the stale length.  For a
file-backed payload it hits BUG_ON(!path->mnt) in dentry_open().  For a
buffer-backed one it memcpy()s from a NULL payload->data.  KEYCTL_REVOKE
passes the NULL path to vfs_truncate().  All of these crash the kernel,
e.g. on mainline v7.4-rc4:

kernel BUG at fs/open.c:1145!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
RIP: 0010:dentry_open+0x7b/0x90
 big_key_read+0x141/0x280

Fix the ordering: instantiate the new payload first and destroy the old
one only on success.  There is no need to release the old quota first:
a big_key payload always reserves a fixed 16 bytes, which was already
charged when the key was instantiated, so the instantiate of a positive
key leaves the reservation unchanged and cannot fail.  Releasing it
first was what allowed a concurrent allocation to take the quota and
make the instantiate fail after the payload had been destroyed.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 security/keys/big_key.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380e..3bf371f6c28d3 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -193,16 +193,31 @@ void big_key_destroy(struct key *key)
  */
 int big_key_update(struct key *key, struct key_preparsed_payload *prep)
 {
+	struct big_key_payload old = { };
+	bool positive = key_is_positive(key);
 	int ret;
 
-	ret = key_payload_reserve(key, prep->datalen);
+	if (positive)
+		old = *to_big_key_payload(key->payload);
+
+	/*
+	 * The quota for a big_key payload is a fixed 16 bytes that was
+	 * already reserved when the key was instantiated, so the instantiate
+	 * below does not change the reservation of a positive key.  Do not
+	 * release it first: a concurrent allocation could take the quota and
+	 * make the instantiate fail after the old payload was destroyed.
+	 */
+	ret = generic_key_instantiate(key, prep);
 	if (ret < 0)
 		return ret;
 
-	if (key_is_positive(key))
-		big_key_destroy(key);
+	if (positive) {
+		if (old.length > BIG_KEY_FILE_THRESHOLD)
+			path_put(&old.path);
+		kfree_sensitive(old.data);
+	}
 
-	return generic_key_instantiate(key, prep);
+	return 0;
 }
 
 /*
-- 
2.53.0

