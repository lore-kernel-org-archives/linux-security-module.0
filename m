Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966561ACECE
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180070; cv=none; b=oqc6xlmbnR6jKwixRsP/w/sTZUzkW7detd+el3E94GTNRzstFld0m+glSJP6wTN1HM8qKzW0uHNMGsaahc9IwNaEYUsE+pfJ3qazf4cPt4ilkNhIMkQVM5JpUlJbckptetqbvvpXjXfKbKTRrr2Wfti+Y0UQijDI07pSCNwL4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180070; c=relaxed/simple;
	bh=/pD6byJwwoL+dEhytK8MCJ/oUKZrInT4N7XnOZVa1pM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EuEUBiZEB/VNNxztMe76MT8eH5oYCIeyz6T+shjmyv4S0sqZl2vAQRdgYiO86oACpyaJdisvKfwpRbA9NMC8o5/4QRry659xAPMPKDh8GnJKewmPvx1s2gzHptb2CmWhlEI9NQ5OhwRGIvunJB6+KlxIcKpCzG+qhWNjLGy1O1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SZT54UID; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SZT54UID"
Received: from mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:50cf:0:640:8bee:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id DB5A8C0041;
	Thu, 14 Aug 2025 17:00:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id t0NYYe9L9W20-mEcMfxzb;
	Thu, 14 Aug 2025 17:00:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1755180058; bh=O0fCqlCKXl91Od8ehDJN1NOSKvov52FWb8+K5LH/gWo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=SZT54UIDXE1J7b8c7l0sqR7Mqlu2iZ3uXSUymO04CnlNMPTmqliktS5c1MxfzTqXv
	 5+Jnc7xdup7uRNZTiLZb0hTAcIfB6lDeCJgFFNtmdMxp2BTAnBUdsK+a9G9ZsTSfMz
	 p53Q6LZG/Uqg/TCz5vMGk2/+hCxbkoLbS/GkfSAA=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] lockdown: avoid extra call to strlen() in lockdown_read()
Date: Thu, 14 Aug 2025 17:00:20 +0300
Message-ID: <20250814140020.1344691-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since s*printf() family of functions returns the number of characters
emitted, avoid redundant call to strlen() in lockdown_read() and prefer
snprintf() over sprintf() for an extra protection against buffer overflow.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 security/lockdown/lockdown.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index cf83afa1d879..10537d7c4437 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -106,9 +106,13 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 			const char *label = lockdown_reasons[level];
 
 			if (kernel_locked_down == level)
-				offset += sprintf(temp+offset, "[%s] ", label);
+				offset += snprintf(temp + offset,
+						   sizeof(temp) - offset,
+						   "[%s] ", label);
 			else
-				offset += sprintf(temp+offset, "%s ", label);
+				offset += snprintf(temp + offset,
+						   sizeof(temp) - offset,
+						   "%s ", label);
 		}
 	}
 
@@ -116,7 +120,7 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 	if (offset > 0)
 		temp[offset-1] = '\n';
 
-	return simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	return simple_read_from_buffer(buf, count, ppos, temp, offset);
 }
 
 static ssize_t lockdown_write(struct file *file, const char __user *buf,
-- 
2.50.1

