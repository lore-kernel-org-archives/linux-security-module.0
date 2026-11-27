Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764761;
	b=iJNxyWvVnf1DqKeuqscORN9WP0pdAbWs3KzBnHFyoclpZ4N8dVzwlWb0j63c76LaXVdI
	 ZwkFp2Jch50RVHYj3I97FjCkZOpJABO+Us/tg5+nm80B0AjEAdbAloGq5rz5k+cDJOyEx
	 P21GzvMrU/Kb40vYoFGLAZCCoMweiUBIuBnWk2r69tdzkThj3khjBiFGXfBRCeEwuas0E
	 oM5+cUXxGiThAULEXN65d0Cq0tVn5xmvA3KXKrLeNqJx8zJzOwT9GTotAjElHWhfXrkHf
	 /rhQ/trnMZK7CC/gJC3SlQxlYEMkNNC+RZU4TDLIsjcxWVt8t262B4xb67MHyfseWDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5CHKL/ZtHCrib3BVjwLtVv0WqKmxeKuSdrXUeRFBD58=;
	b=2z1A0bfTBnnZob4uoZqQkSNCbYUpYuonu0gFA6n1fBTgvrbuR3/NuSwtr4W0sN0DlIfB
	 OwD4XT4rS7qASLxwX7ZhJoqJk98gKtTH/f/RMdyMBUYM4GBDpnbONuqrKPhZq0zfUhLtu
	 +yS6Oakrem31vUHcw/xvH4WqULDR8yLy2U9CYbwYyeeg7PeoYOwZuHVmBCiDwWu/8hzGY
	 yfVTU9waJBrrNMbQXUJPwkFECquoQNJG+3d9iWa6Bx7JQMJ+PfXKr3pIgMlHftrAMfL52
	 beQdXJohJ1QvaIPXtAf2xfs9rFYOVHSxHjiNPJUbeHFpLsCqBTkSR1Jy4cAfCYbMfsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kzx9ZZrL;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66AB606A31E
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 07:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66AB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kzx9ZZrL
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38190551625so14945078eec.1
        for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 23:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795764760; x=1796369560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5CHKL/ZtHCrib3BVjwLtVv0WqKmxeKuSdrXUeRFBD58=;
        b=Kzx9ZZrL/EDdPoNVDguy4uUQHvfrLbRe+5pu5vvCwHwBOKDtOYvENQXazWF9Q4QG9S
         RErEtlF1I8fl2bbP5a8rpgtSfrjD1QE3vdZHreBqkNFQYUqwQiN4PMOnyNYzctbcCAWX
         4+houz0x1MJ4+72svaeoYgBJLkQiZheUdD+2cHAY8jZb3xzDBcoc0Xm5MB1yiiH5/qoU
         PekSK3e7BHqIOObn2z/hfEQWeLVAYugix34HFADqzQoQRH/3t7TRgYZqPrFrFyH9ots6
         IEbgRQVnEzOTy5i56LoA0JcCJEwJbYRspYwvYu/qWQ0W2XD24HFFZo9K6lJadYizwakz
         os5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795764760; x=1796369560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CHKL/ZtHCrib3BVjwLtVv0WqKmxeKuSdrXUeRFBD58=;
        b=HFStA+keVeWIEOIXntK54mlRIFAsFB5CYprQ6viKFZy9RLe78zXKxfMwrHsoLuMm3p
         peWXNAI/7WE3m6i2NT4Rv8c/oBmxr+eClxrBeGFaa9GyPBOtjaCPRvNHLyRRBPJUenKf
         CgZEkAs34n/sp7CMiYI+YQT5ubRvK4Go7R0ioEQKmJ0/XzGGJzAwYFFNNPJNVz7MyNnA
         lLHEGQ899FKKKBTmSvm4VNZ2N+LVJLHCzeTRbi+l+7SiDT7pkzSiLTMsX0PqhgXEPJtl
         tbb09qF9Q9tMwgKHuGAJ3DCrkoXnCPR1IENCA4PPdOYHZdQu0V9bDdpqfg/QQUo6YWcW
         DWEQ==
X-Forwarded-Encrypted: i=1; AL+hErGQ0ghZcMpZfRQNYRBInF8hAMaLWih6+Vz+J70pYzUN1ybvUcIBOtbpwzvW6wQlnLpBGq/0U+uoPJpq3+JV+l6PSCOSQi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ged82kNVxyx3eM8OKjxjya52eKfwNZaWufihrofchXfBJ7GP3
	CAltJSxj1WhzKgb3UVpO+8cPM4V1ektxVtkk2NhO9617fZIEdL2Mqq4v
X-Gm-Gg: AZFdTZeYs4cpaOLJr5zp/RKpXrSN85qxZewdd9LpL1EZh+qQ2SmxC12V4Z5yxhOqL4I
	Aeh9vr91L2TMd9P5oI8qLqjz0LkqG6HdMyl4k9V0x96mt5Fn4iRyA4pj++A+R2gTQqgD0Dky7An
	XCYBfLyqHEYYsuZT3VWWoSPSsFo415Y6vW3MF55K7irkw95uGRDi7SvoKAZotRFwmKwGlH/xiPr
	pE8W82bItY4XtEu7o3m326tV+o/ipMoNcdoc8WAdhi08WjPmIJR8DeXjoNNhGoNExydLHzfKukc
	Fih6Ak3p5zEC5K3kv5jIH1cZCwPNJvUhjvNLl7bBQQYieiTrHR2T+tVF5C/X4MIw8cnTyyYkT6K
	NTYYttoFBubvnTLvXuKGns885nisCel4jNtC/P7nM4qbxkU4vqSkZmTtqOlyuFhGmHzTNRbjs6m
	V4fEktJBxQd8hUCajJXzV8ONO7sISh0qrp/yT40NwvZOA8PDXlyReKYuZuti457br0X6NyUNHGc
	fpGuYt9rHKP8sJy5amgfoc/AuUo5NfOl8gHNHNVzwPzuEJ3woUFcGoavv2rb3r6k/6483S11PXR
	wTCIR+dhDNxj/eBkJzyXlsl6bA44Ev9HfL2tLar2HTxiYco=
X-Received: by 2002:a05:7300:2301:b0:385:4c54:3c8c with SMTP id 5a478bee46e88-3856c0c9403mr33946786eec.1.1795764759968;
        Thu, 26 Nov 2026 23:32:39 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm62804163eec.20.2026.11.26.23.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 23:32:39 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: free the restored template entry on error in ima_restore_measurement_list()
Date: Fri, 27 Nov 2026 14:32:33 +0700
Message-Id: <20261127073233.181925-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
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

ima_restore_template_data() allocates a template entry that the caller
owns once it returns success. ima_restore_measurement_list() breaks out
of its loop without freeing it when ima_calc_field_array_hash() fails
or when ima_restore_measurement_entry() fails, so the entry, its digests
and its field data are leaked.

Free the entry with ima_free_template_entry() on both paths.

Fixes: 1ea973df6e21 ("ima: Calculate and extend PCR with digests in ima_template_entry")
Fixes: 94c3aac567a9 ("ima: on soft reboot, restore the measurement list")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 security/integrity/ima/ima_template.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 16154078fd70..d5256da8f76e 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -526,6 +526,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 						entry);
 			if (ret < 0) {
 				pr_err("cannot calculate template digest\n");
+				ima_free_template_entry(entry);
 				ret = -EINVAL;
 				break;
 			}
@@ -541,8 +542,10 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(__le32 *)(hdr[HDR_PCR].data));
 		ret = ima_restore_measurement_entry(entry);
-		if (ret < 0)
+		if (ret < 0) {
+			ima_free_template_entry(entry);
 			break;
+		}
 
 	}
 	return ret;
-- 
2.25.1

