Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E26315D5B
	for <linux-security-module@vger.kernel.org>; Thu, 11 Dec 2025 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473374; cv=none; b=hHW6QKjwE3XO5pBif4ry/GB30G55RdveXLxaPjv+4eraHbFZlOrDVZ2cSh32KsyXAZPl3VewIbeSiU4Evby1VRT5E8XNn7tBsZhOyW0YA/ZZIxAic0a+cby3Suqg/HhIhMsP3wKda+lN5dmYlH+B6a2FheTS25eGYoZeyslL0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473374; c=relaxed/simple;
	bh=PWG1Uz/7pwDZMqUJE8wpnS6Sgs1oh93ryPafYte5lCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBk8Cnn49ttVWUX6Macs5YujsUfR/w5mIA4GZKyn8iO+k0VqC70ZsU90tbXnNQLnU+89A8bjF3ncI0PwsRnoC34w+10iiCVPIyc5G11TewlaFkYNE1gUI9fdM01dOI5LvD+NezhR0LO/oAonJRm4ebhveTzvU8GWpUHX7u065GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=evrcycxE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="evrcycxE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775895d69cso1959745e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Dec 2025 09:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473369; x=1766078169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tX/pvRZ03DwrZb4C0GHe6B+z8lS6Bu0suU9z+WmGCw=;
        b=evrcycxEyxXWRxHBsgB/8CiWvdgVxTbkzR+AbIVAwgMBS0rklVbuYbV1jcrqjeR02j
         W9y5+yAgrKU67wc/TGQ0Tfm7U7bU5oW0sp+drCXaSO+YYajSSdjc6iA9zRFIPFUzTQFa
         egeHeXGe6df6Jve0kbp+0ZJyIli+mEQWmHg+nqNfwxdo1fILDnGRWUXti+E2eZvmJ/18
         GMHLT5xdjpR78Bod/OaH45wrMu9/QV240SEc/dmm2TVG6FUkhMmplCKWAsRdshlS9ocE
         zt4rElplny/M6NUCUSVOaQDQ01WfY56kFq31mzrV7AKJSGipGN0Ugli3MbxPWSUSDESW
         NpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473369; x=1766078169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8tX/pvRZ03DwrZb4C0GHe6B+z8lS6Bu0suU9z+WmGCw=;
        b=deIQrW9bUSXdttPYJ1qbMJ3j9/JK0JHNTyJQS3hHQLCt/aAsmyOf6SfIFbgz8CDqNU
         OgOhaV2cAGcQDS2jxoZRazHkgX6amaqR/3K/qQjVf6qIUY0OqCKKGb5vIK6ExFA5Y01f
         kQ9SLI3Mg8oIqOTemcuBvVDu5LOb1azmW6F23GHS19jRk9NrHxZmZ97x8hI5GOuEF+LQ
         Olqnk5NOoGDwxDSFJAgLFxLY79YP2rRSeKRkpJ6Rf4WgTs0NYifvK2LL02J0+6jFz/i0
         uYqizKm9hnUbKGlpbxWjhqgwyawvDGa2cojAlfnzfXNkXOQFyRAaqG1dycBuQq4EDqhm
         d+zw==
X-Forwarded-Encrypted: i=1; AJvYcCVz0jstDKYZL3uoJ8gb/ljaISkpPYP0lOmXtZu8g+5QhlVrC2ca2yND/Adb4jBJgtGzArbnAXdtpA1mNKUd8GSKoVfX+ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzljHUq0ihK2AKbilEGXTMnJEHifFTKjTiD3ie+LIpzCgpee5e
	YYuagSJlzft4J34tunW3cZIlrmAFFNd/TrCFnExPkknSTn9kvwMPTvM2zpAtBXDoWghpX5fBtpp
	9iy26
X-Gm-Gg: AY/fxX6e3NboaN4irbY2F4QpEAmOPF0ily6e7ZGS5gYBD4UenilGDADCuUhrypkXa+K
	8O9G8MSccJ3RfYdgL3QCEc9D6OBWoKAIqF+G1ew2XjrCHa7mk+AIlgjkcV9XX7ZiEFJjUXvWC5V
	JAU02fvArEuEaTodmULDWfmVi6XvYzTCcNM8XaAVcQ+tMi6uotro/9uhw9hvgxlPUNkUwf6mRJ4
	WvXmBbVnz6QeDf8Y09mPAuehFZ78u/X5YiX2Ex12V5errZnZ7KBsX3+oLCH869MJk5eIuWDFhiT
	5T5C0h8t+opg3mLQc3rSf83ttff44ppovi8/GT4KX3ifrU5UMUnREEW81Fww71zyy/FvRW6m+WW
	GbbMaFqBj3OKqGkwAOSL+XnwKhAmSO0dzcZWfjWFX4THANV2Q548Vkf7RNMvQpyGXnzZ1V6EEsW
	q6StdXYk8wenBcvKMCj7KV4+b+p9ZWLW4KuNZHoZYM9gjhx5KIvmzAlEeEWyuJctnaUkg6Kg/oK
	Jc=
X-Google-Smtp-Source: AGHT+IHGBUOwE9r4ORaulvN3C5ZVCojqUo6qjWJCQQ7Y+7ElotvWRIvUrk2Iy3v9fIQm2AQbku9BvA==
X-Received: by 2002:a05:600c:8010:b0:479:3046:6bb3 with SMTP id 5b1f17b1804b1-47a837aca24mr61787215e9.23.1765473369183;
        Thu, 11 Dec 2025 09:16:09 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89f0e42asm44521885e9.14.2025.12.11.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:08 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: op-tee@lists.trustedfirmware.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 14/17] KEYS: trusted: Migrate to use tee specific driver registration function
Date: Thu, 11 Dec 2025 18:15:08 +0100
Message-ID:  <0b3ce259fa26e59ef24a91ca070e2b08feeede82.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=PWG1Uz/7pwDZMqUJE8wpnS6Sgs1oh93ryPafYte5lCg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvw4fJEaOX0vcpHk3eLvUdGT9H5CpTDKlptW8 lA5zTtov2yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8OAAKCRCPgPtYfRL+ Tus6B/46H6BzlY4ooZ66vBemZu+u9k40M56CS1npEuvxZzdqVdr5+yYBtvf0sFepZiA1kZLByHC qmvwOMfVSURaQxhSnUSW3sf5PogyKEeJGChX0Aet1HFsu5I0s3KtUZq9MwTR+bcWJnQOEU7xT1w fhU1DQ87m1Qu3KgVdq1fZKtzmUPAQHqXryaG1Onoy8LTkDRF3SQYO6h278bsvtBs38kRzaOcAvz hOgLGCS5wqtWh94/e0lQHwClfg0b+BQsNClTafeNu0B+HnvcDhTyHoEGqOQk0MWRf5Pa3laE0BV XoyAv8patZJKyEfoJDbzwDswrq0Vny5P+AXykut/8qQ3Ajgq
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The tee subsystem recently got a set of dedicated functions to register
(and unregister) a tee driver. Make use of them. These care for setting the
driver's bus (so the explicit assignment can be dropped) and the driver
owner (which is an improvement this driver benefits from).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 security/keys/trusted-keys/trusted_tee.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index aa3d477de6db..3cea9a377955 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -264,7 +264,6 @@ static struct tee_client_driver trusted_key_driver = {
 	.id_table	= trusted_key_id_table,
 	.driver		= {
 		.name		= DRIVER_NAME,
-		.bus		= &tee_bus_type,
 		.probe		= trusted_key_probe,
 		.remove		= trusted_key_remove,
 	},
@@ -272,12 +271,12 @@ static struct tee_client_driver trusted_key_driver = {
 
 static int trusted_tee_init(void)
 {
-	return driver_register(&trusted_key_driver.driver);
+	return tee_client_driver_register(&trusted_key_driver);
 }
 
 static void trusted_tee_exit(void)
 {
-	driver_unregister(&trusted_key_driver.driver);
+	tee_client_driver_unregister(&trusted_key_driver);
 }
 
 struct trusted_key_ops trusted_key_tee_ops = {
-- 
2.47.3

