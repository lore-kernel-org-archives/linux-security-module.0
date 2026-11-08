Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169469;
	b=f4iq0gYbhcy79oFoQj4knjMCd9G3A2fu1cYZmj3EqIGmeZpvi/1c/zM5Efy/L4fmseHK
	 nZ3jg+pkv+cfFgxIFUTntuQbZlnvd9mGO3/lL6dOM+XCaOLN+VNGwillQD+W46SImYwOa
	 4gwWKIfiCT0tj/P7Fg9e7IhSD+Tom6If7aQ3QIAM6U5RENdXUFRwjMWaB/8dOSl93e7Cp
	 6PvLBKDqXhA5qoOkZLfuO8v5m07qGDOLnzwptMmQt22NFK8MA0nQbDomO6kyB6GBPxaWg
	 8pMIuZyxRYSUkc1FaA0W+i8ausl6gDkOWYsUX9N6CHZAQhDiRlTUstAcBpK4uxb+X2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=sl1RiSecafJJLjcGJkmLnXileJoqiVI5c1VnjtgRMUs=;
	b=26r0jqxrQ22tzZJcp58mxVAQRiAU9+J8td81GuL85aaLcbkIuuXSkIyyHvOaCQdca43l
	 RpiYQG+u0d4V5uT9TGoYyMNHlIoP1upwLwFYRbhVjA4NpuPq68L7s5t34DEyrPph7Mn1G
	 cwb19oxRDFE+UggCzhkGUf7dQY9hKah1mjUfkkxNuKK1Qd4r4ue6z6ADWv7RfE+tjh+Gt
	 PwioUnVQE5xSjjhO5jGIi3PPEBq1rIUQB3SayAaSFRe+nxUsffBGGIbvXK6ILlzJV6lvo
	 pc0om0A0eVOhFHD65CzrXOKcZcy3z7zRDJVWPKYAJkqLFSblWoPCI706+JsBqmnPTWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qh/J0nAf";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25119606E035
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25119606E035
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qh/J0nAf
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49134c8509fso212749f8f.1
        for <linux-security-module@vger.kernel.org>; Sun, 08 Nov 2026 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794169467; x=1794774267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sl1RiSecafJJLjcGJkmLnXileJoqiVI5c1VnjtgRMUs=;
        b=qh/J0nAfM6eBV9ItcrhQzKqEOSU/vZC2wJNodHwTQe8F+q38Va1rm0wWiivcjb0p4k
         SJERNgoH+ND5g41BxVpsW92mxP0kfxZeS1o/0Coeqk0D5RJdR1XkTjkkXjMn/cXPFYfs
         4QK7REVIOvzccmpMVzMxDJrAXuaDnesijlli94ob0iI9HxJ0f3/2BHWYVZgb/mHIPrj1
         +59b3DXoHQ2HTRhHxhqiiUvz2P/x7YKj8dHjnbjbzGj3FkXWtAgVyr45TJr3KflskABO
         QlDVIVHUbVnLzUO2ssGOKKfaXDQoZs4T06oeB4LP1670qFZ/EYickeqF2B6YtyDEIg3W
         CyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794169467; x=1794774267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sl1RiSecafJJLjcGJkmLnXileJoqiVI5c1VnjtgRMUs=;
        b=gqlMQWEuWdZJmvTVVOyHeiAl54hp+qBy3VeSxfHo78BbCFHWuO8ymGZHSUq45yr4S7
         TfAK9VuwXayI4JaMqoN/GdijKlE9yRZKi+7LB33eEYGH06l96pSydvEJjDSlREtFQpCD
         PLGjNE638lNX+D7Wa6a9Nmb2UQnM9DLTMTPhSZKUppPefczQP3vIoqAQcVaIq8pjJZ7y
         +CeRQUX8/IVzfE+MKX5vA5ZxGA8Rf8qNe83SdKqMALSFlH0CY7jzvPkS3WqKRG+em5+M
         gYf8rWrVm9paIgB9uWAmHntaGYQ0plMKKcUnNADQL+/bLktTdJIDN/Xa/q2eGVLoSyLi
         ReUA==
X-Forwarded-Encrypted: i=1; AL+hErECEQNb0FwcnZHtCILoIL24/J9I9fPl+iVwywzfnM0YdR9IkoBKrLs0kZfOzNMmfNrFUQoYX/MwYDxPzGNEwR+s/Lfh8xE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nw5yo+oi9KouT885HOOE1Zg3nWVY8G6E8fweO64xhZP/YXEeJ
	T+AkPUD2yRTxyO9bPoPwys0ib+xi/YsEMIOHZ9K+Y6q68R2RUC5yA0Hq
X-Gm-Gg: AYBFou3wAP2aGK1D39MMXtLoPUf47mBQXQGSGhMWj8AKuKBHXvD+lpmkgUFpZvG1+rb
	W3AqILzUfbhXOzw68mggPMPG/GOnUgFIrU0Duk7LUa6M/LH5xZwapGmTSi0SwsJw4i21ZWjSRtW
	zsTpeByxypme2J099oRGZZPbg92RuPRQaR4w+iyNXP8rHz5Tm/sReK4cn6LoDmhkAajkyDD/mNc
	XSSHd8hQBYRJ6ep6pL1N4kqCFvh1oXerw0bI+xtaw6UzanRj9rP1VLLKXsdbQ/yjpqYubo1lolC
	CJcZn2kk/RMdVe3SOSLfB50kHgEpo1VAuiKmsdsl7ONDyux2rR1WciRmOsDSSyjrSGGoR9NF0Lv
	zgQPmVAO59dBuhFaTAOO7vEmrVsrP4c2PpOOFh09yqhB/UaugwKotwvDnQaBBFIMe+QZBfedgNh
	qVD6J/z/jRpXAGwjRIDUB/aogdh9JnOe+z471jwGNJNfPi6kdgGX0jZCnxSlEskmxb42dhftzaU
	mfUchYPlf4Ij2qXZRRaouiVvFsVR9qtHizpUZG6QL+ZiWf4gAPpnIneermJefHJ/1m5XHf+gd/9
	hyXEskQQe7RzBGgpk0mxOXF7Vcld3X3BeUFLHWwEK/BMx4OWDsAZYg==
X-Received: by 2002:a05:6000:1a89:b0:48d:c186:dcc6 with SMTP id ffacd0b85a97d-49585f85ae7mr5659490f8f.57.1794169467418;
        Sun, 08 Nov 2026 12:24:27 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596bc3ba1sm6034100f8f.24.2026.11.08.12.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:24:27 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Sun, 08 Nov 2026 21:23:50 +0100
Subject: [PATCH v2 3/4] landlock: Simplify landlock_get_fs_access_mask()
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
Message-Id: <20261108-b4-landlock-refer-nonfs-layer-v2-3-2b405fc1b3aa@gmail.com>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Return the handled FS access mask as it is, instead of artificially
adding LANDLOCK_ACCESS_FS_REFER to it.

Since commit d6c7cf84a24f ("landlock: Simplify initially denied access
rights"), the merge operation already bakes the initially denied
access rights (LANDLOCK_ACCESS_FS_REFER) into the a layer's handled FS
access rights. -- They don't need to be added explicitly any more.

No functional change.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/domain.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index d9ebf4857fce..812c324cb6ef 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -262,16 +262,12 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	access_mask_t handled = domain->layers[layer_level].handled.fs;
-
 	/*
-	 * Handles all initially denied by default access rights, but only for
-	 * layers handling filesystem accesses.
+	 * Initially denied by default access rights are already included for
+	 * layers handling filesystem accesses, see
+	 * landlock_upgrade_handled_layer_config().
 	 */
-	if (handled)
-		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
-
-	return handled;
+	return domain->layers[layer_level].handled.fs;
 }
 
 static inline access_mask_t

-- 
2.56.0

