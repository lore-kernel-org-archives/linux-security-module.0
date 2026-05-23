Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167061E834B
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779551907; cv=none; b=qYqlB8l8vcATJWs3UDiFPsPQKNk1lL1lR/23p7yVWEeXcJGbBi8EXjVhxAo5mejQ24pXUiJL+vN7BTu/iRgV37axkl1MG+TEk+MWnajXLwfWtAwk3Eh1pBSGrx3/cm+gmRjZAClhxB3puKv7GxMT8X5m5O+Qo8xCU6GSCZf4DPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779551907; c=relaxed/simple;
	bh=StNawboxTwMPXwuTZAwzz3RCjWKkiTv1rJq16O6Qss0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfBQIkha+/l68je/YUdyAaSTykAcOSHTeEhUzA0APDmK7TC8rlw27mZJJQlur0Gx5rK+vlBuDnYfdRanQzh70x1oz8R9txnn0lxgBO1NTqXGbG5m1GnSl5OtSS/hgcGpx6IJuxwBl2pWc8EQeRWXJEFQr7S7GN9JPMrx2mViE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yy8CRERC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yy8CRERC"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8acae26e564so106802206d6.2
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779551905; x=1780156705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k6mAZnQSeqoEfU8SQHSpA2cfUhnUPACaGQfp/SoU+WQ=;
        b=Yy8CRERCw6DmWPY+ziyP7rs4jbz8r1zx18KNXHHtGcn596F8zD8TbZaezhaHAohM9r
         Kxk/0zGarIqxy71cLLaMb1/DtuAoDpYmPd67pl8EVJBYRUZPfSbl9J5vj5JhUBYwmD8a
         gEe5YMJYrq6Ik3FmalGzMZrAqUkAUO3wpOQWMx2PI41TiAECLq47iFRxoE6ZV/HBYVtP
         d1e7VsnBVLW+H4duqUWV0XYmDETCEUs7LNZ1mS1LPJVI4Zt6jdA1rwjtCHSl2QUGc6PS
         V0bEubHW90TQaWwde9ASzCBbO1zT1wCtlNz/G0BrK5+CXv1mW0CI+SqE4GcD+V9g+nIA
         OKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779551905; x=1780156705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6mAZnQSeqoEfU8SQHSpA2cfUhnUPACaGQfp/SoU+WQ=;
        b=DHcmnUKslO1vO1zgd5d2KKOHvrCYeVjvcIrNJpS8LrPb6jmduMU4jyEdDEJ59d2ofh
         RcAxDD1ACGBZB0xesyzIE4GzMh91K/G83t34uY+0RNmmWdHNIKZhjjfc7r4TELhTaA70
         QaxK07lEAVqAW1dJrDgpsqTATKKKfbbUnS1IgVly/+N5tGxiFlMqfcWzDtKg0lRGhkz+
         luQRs2SxJ2D59TM/Gz/tZ64tGnc+Eq9T4LU7YqbsI8MWWjlMHr2HHDtdqZ4ogiG2zZlI
         0RY0/thdo35BY5aVCvN+EImBeYHEvf8eRT419IjR8COJ3TJAonNlqkU8VMERFy4GHD7I
         sjfg==
X-Gm-Message-State: AOJu0YwsF53L3CnAFmW6nzZ1qDa33HXkEiG7pDulWwpK8upUB/B5MLEu
	+rPuLui9tL9cca1UW+k4t940VzmAhSPY/N82o41/8dithWXBrGHNg2v5kBM6I//CP00T0u0YSH+
	joinTlQ==
X-Gm-Gg: Acq92OHaNPB0H2sVeoz311Mx49vUD4iVCeXszhIi1DUyXBUezA0AqGj0Yy+K7wuJ8b9
	3QmeHQfFJq2ThNXz90ovlUGxRS51/ei38vy/Tt+QmYhS1PhYlER217aV2Cb1Qyk//hZtF8UlVUs
	PD/trPiE0+gyz2VqUFpQEHot/SsGKzbfSTR/1EUXluE/qdqBOtGHrYd1h+JSpicAanWwWXEgjp/
	NsQuElQjQwZneLzlkZmHqEPJyZovOeVL/zfqVWBvpkjTKYXFhiszlkp/PUPnrZfO75UJ1Hs+Kl9
	EtflTYYnbI/OjCv4L/DZvP4Ke8A0uxLKZ5wtFsC/LfnB7vfz7yxmpCsYZlBEPEVvM8vwk/faULY
	0ooa9ycHtlXSs83REQGEScNy8mgjZPzuhJx4Izd7WK5Etv6+hZ8INvb1Fp2dqBigfs4l0j93DvD
	plwracAPJpjeNxg5vT3vZqpCEh8MvJ+27aZDpqSw3Dc+ZJ2KUgVaFn/FU9vEvwaEPQXeXsLQ==
X-Received: by 2002:a05:6214:54c3:b0:8ac:732b:6cf1 with SMTP id 6a1803df08f44-8cc7b674477mr151745366d6.24.1779551904934;
        Sat, 23 May 2026 08:58:24 -0700 (PDT)
Received: from localhost (h7.113.131.40.static.ip.windstream.net. [40.131.113.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf895sm54031166d6.1.2026.05.23.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 08:58:24 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] crypto: pkcs7: export verify_pkcs7_message_sig() as EXPORT_SYMBOL_GPL
Date: Sat, 23 May 2026 11:57:51 -0400
Message-ID: <20260523155750.16157-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=paul@paul-moore.com; h=from:subject; bh=StNawboxTwMPXwuTZAwzz3RCjWKkiTv1rJq16O6Qss0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqEc5/Hlu+F/KJlPJHYJWXpYQUNuZ1uINfGvZBV TK+iiOOCtKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCahHOfwAKCRDqIPLalzeJ c31uEADQLlfu6HdvQLtIH1KzcD01uFvYOy2w5uNkIzbzxQl8lmpc0GyKBdzAm0bszEw8uyUUg4L 66fiAOOIVZ8PNk3km20EwAVk9MWiPN7CtCChYl8lpTJhgu8SKktu9g3KXQU+tva+4vos2w0mwHN EVjdgRpThQL0QINxCMrqELJ0n6Hr8YrwKQCyAeMg7WdfIBZHrBPV4VmVQACuymv6yRohgpalNQA zloXTLFmUJ58kO29h9lso7dhvPCWjcilQWbJb3qbQRcdsSUXFCNw5wW+ZkZKkwRmKpfGFKjPM12 qtSPKZs9+VfYiIqgaSM+jU+xEgZk1tS1bnb7l3/2YxMEtEBd+KgcWUTrQM9hmIwrLjBp5A1Opw8 etU2krpw5531n3jf5TWeJQ3Oq5CHzbrv9pG0HrUNvCVDCqxqe2rjljmDiAVJy6PopPtXHsfrXog YpaZTscKvn0nzm6T5lYCq0gRjTBOgBMXhB9PDYEsHfPT7Ze297HdtFCgj5rY4vbxOGkKJUogkQU IB1qG3Q8CvQZxZC4P7JPnOU3lXn8zJF0Il8USJ0OFy7rcMXFHLlOunvooA4fCd2xQD/JjrpkQii OiquE0vGV/fC6JHXTlYKiwMs812b3P2UbmwLnsI7piie6lwUJ+w0RQajHuoXZzl4GimWCQD5uY9 Kxx1mspEhHL6aAg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

For the sake of consistency with pther PKCS7 functions, export
verify_pkcs7_message_sig() as EXPORT_SYMBOL_GPL.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Fixes: 188cfb7ec81c ("crypto: pkcs7: add flag for validated trust on a signed info block")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 certs/system_keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9bda49295bd0..e1268d0cffff 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -380,7 +380,7 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 	pr_devel("<==%s() = %d\n", __func__, ret);
 	return ret;
 }
-EXPORT_SYMBOL(verify_pkcs7_message_sig);
+EXPORT_SYMBOL_GPL(verify_pkcs7_message_sig);
 
 /**
  * verify_pkcs7_signature - Verify a PKCS#7-based signature on system data.
-- 
2.54.0

