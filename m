Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489089;
	b=dyGh/SMCzm8CjFelNnI6vJ6PF4jQ907N2ihX2moBUst7QKNDUmmzjvZcm6g0YclwA8xw
	 QLg0YkL573dNVola60SR5xEmVWTJjFQ9LjPuKe3u064ib2JSPW5OKDTKHTG1x7BgJVaoj
	 4ko7nDJAaJalHgMFQhfFztG4MtNYRitCNaHw0f2X3V2sDqPs8kQlNQjLToZUktr1ggrrY
	 RDYksmhzFK1xnXV4ztVoj9F5qfen2tZ67tEO9DBiAxIKWuovECrWmg5L0jszyhcULFG0+
	 BUqqE8Q8Tv/hK4BhR7I0YXcIpY1Gnf41k0H6zVFwAZLNnQLXE4ooiZas2RSZzeFaPow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yur4tOxm2ygBh4jOsPulqFe9YZgZ9r4tQ95a2ZsCDLs=;
	b=H53JPOswDXnguSHW6npdKgAr93ZQ1EUITXAc2SFCOxOotZFbhIxkdKN9xw8lyAvRSq/9
	 oUI+cJmKTosIdceLGzy7UAq5Y5abgENMycyni3LkKfKfqkXIYAXKi/PiqmZbAd9JfRBzz
	 i8ZU3S7v1eS7nPfMLod+qR8z6bED3oPuCbKIROfpSiMwID2Yq9lg9Ikz6/+3Q8goPYRs9
	 4ICsnWMRf8ML3NJTSTYt+6Ri8x2qV1eqDUeBXs5+jijqJsXw5B/9QLWJAbJ/jhgJEteEQ
	 L52NVGWFlg/A6e/bn6FPRLj110R8sOBky276xT5E0nOZlJydXnMlfERqCTCvLb0UTCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuqElge5;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAAD606A322
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 02:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BAAD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuqElge5
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3b411059cd2so906840a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 18:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795489088; x=1796093888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yur4tOxm2ygBh4jOsPulqFe9YZgZ9r4tQ95a2ZsCDLs=;
        b=MuqElge5ywtfzHq35FtslzC0hNsAzaejU1E3w15IRDL67GoXUJEVd1UciPryn+W6j/
         AS6vLAdUSzJuhweHqzFvtsDTmqWz+rzVXViNm3hCfMRw1/6/WFln7DYh6w7gH4ZxZ5kE
         WVIcz7/jncarv/uz8Rzv0MXitgIY7U3AxFhyTjJH3l7BqCjjWPJQJLUbinj+gXE9Ice6
         pcByujUfFzq6RbnXQEWF0mBvdCb+gP6sv1bmNamAYjH0KDL1UHqR77Ta7yItgmXCdJDv
         jlc6w9RpY7oMrBKaIkdRDNFnVJ65j+8D/qoJcGhNMxb78wY5MMmCcF27LcitpWWpMU94
         kd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795489088; x=1796093888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yur4tOxm2ygBh4jOsPulqFe9YZgZ9r4tQ95a2ZsCDLs=;
        b=xvvv1FtiCB1Asm+BVfsczHYY6FALIAroVMWDx8UC5BogPNHS/K7lvZlx/tgwKUhMyv
         /5pbuE/fkHCVmO96/Vt0iORRDGchkCjlCrA07iV+UvPt8D+Vrk9fPkl5HGvkCvYVoBzw
         TembGkSt5ix9N1Nb1WdKe3aCTRpj3F1BmjbIuAKKugrXIllOywq8oBX9GfiEoRn2c9VM
         QqR2AXcoIJltlAOO/31ELVgMxubo1ZfZqNbEgduGlvP5RcayLgHMVjMoVHi7Ci48ON1k
         dprhLvjdFsKBTQtIFXlY4w0NB+2IJq/vdhMICIDyEQZDZLcmXOmpkTV/IH0LNa2tgRjK
         DR+Q==
X-Forwarded-Encrypted: i=1; AL+hErF/mRICkrn2wbbVx6D2/gSs6e0JP1E3cBJIgi5OcJBfhJCJnjTmkc25yjWCBhwXJPZQW/9WWz3NTbwGarwa6T4cCGYRS8o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+2NUfXHgK1CXFp1N9rr/ND1NgTfYa+8BkaMxTXfNO8XayBjPE
	+c1QKDuLH3GTCjcjfce01mCZjhYivCgMSIai6TABEgUe1viV8D265krI
X-Gm-Gg: AZFdTZcfvk4NNjXbbfG+xiac2B9GwrhFOMUrtG2ShuikKUh/pzSPVqh35JiWInyvuC8
	57j89klwcR1o7IbnuQjOZ3ryicKqbZ+fhApogD+L5+u2WfQ2S+Yy8avv1u09yK0TPcOUaKqJABk
	CqtUe+nRtbObHyi0BJcJKcyAboP7KFwHewxhY2/EZBN5AMno+QjusMByO/0RylA1U5/LbTMfSuG
	Hka/ttF0cqxE4QiSVHEa/Xnx16Q65a4lA0tsWWbvJogjMCNx7G4Iuzivnw9p1S4pC8O1tsHCAZd
	z5CGS2MV3ZDWmACHkgXoo+3mEnEZmFhU3rvxME/VwxuP3KIBMT9KcNUE48ycyrGZ3J4YhcWP6b+
	C2rZTmBFJAe6El0x+ps94bKdAId/0WNB1umz5UVlwDircjX7/3DDcnal8z1aBAAKZhxfSUT3oa1
	puD9Ve7E4f46uhi8d9mC+m5xH6LgI3o3Td2TTrOziEGogFnhKsKwbn4ZxF82eRgXbJZTO30YRjm
	8Vj89sAurOa6I9mCh8XA0dAftCPsBW5MzKiclqwssrA1MZ/dDMpbepTJJhyH5001dKwvEqSgAoe
	DjIpFARJAKgo7YpOBAf/XVNj2Ocwqx4kNcmmQ7upCApALlgKoh9dVSS/3gWq/X5U6NvljIOwBw=
	=
X-Received: by 2002:a17:90b:2792:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3b41cb0c476mr10628516a91.49.1795489088382;
        Mon, 23 Nov 2026 18:58:08 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm25195844a91.8.2026.11.23.18.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:58:07 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] keys: fix crash on big_key read or revoke after a failed update
Date: Tue, 24 Nov 2026 10:57:59 +0800
Message-ID: <20261124025759.39344-1-bsdhenrymartin@gmail.com>
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

big_key_update() reserves quota with the raw payload length and then
destroys the old payload before instantiating the new one.  For a payload
of N < 16 bytes that reserve releases 16-N bytes, so the reserve of 16
done by generic_key_instantiate() charges them again and can fail with
-EDQUOT once the payload is already destroyed.  big_key_destroy() keeps
payload->length but clears path and data, so the key stays positive with
a stale length that KEYCTL_READ and KEYCTL_REVOKE then follow:

kernel BUG at fs/open.c:1145!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
RIP: 0010:dentry_open+0x7b/0x90
 big_key_read+0x141/0x280

Instantiate the new payload first and destroy the old one only on success;
a positive key's reservation is already 16 bytes, so it cannot fail.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
Changes in v2:
- Drop the comment in big_key_update(); it belongs in the changelog.
- Rework the changelog per the review below: the quota is released by the
  removed key_payload_reserve() call, not by big_key_destroy(), which only
  drops path and data.

Link: https://sashiko.dev/#/patchset/20261123165443.4092852-1-bsdhenrymartin@gmail.com?part=1

 security/keys/big_key.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380e..aa3e82ac93ee2 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -193,16 +193,24 @@ void big_key_destroy(struct key *key)
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

