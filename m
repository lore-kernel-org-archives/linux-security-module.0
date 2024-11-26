Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCC1DE2DB
	for <linux-security-module@vger.kernel.org>; Tue, 26 Nov 2024 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646536; cv=none; b=OgoKqaACpMz1SxUWtCspALPFgRdJX18Bu90jUp9/ifoypRll9C6P3MFhlyytYRyvaZVI+OJ0HXB+4RsyOzk4f1M5c72pf21LDUczPoBzH4ft/M8pSzXoltzqvIFuEpaGgMKBuvBpn/uJrEZXSElvgxYju01AlnkWAqHYPBDJlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646536; c=relaxed/simple;
	bh=Twl5ypj0+CDkFTQUNnh5Aon13c1lEyUu57FmqAb1EAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KIpFWUoXSbiQlU7hYlt+2UtxbKcHqjS1hYvyLj1ltqafehF03Ix1KsPpsR+HKg9oHxGwb6Lk7PQ42NB4r0Deu08rUfPmlMfjf8F8amab5C6TKfa7cJArBNjggVIsBNTHSSsU7wXzNCVLTf2UiA+z0GlnrjPq8De6bRrYjTi30/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK4HPYWT; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK4HPYWT"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3ea60f074c3so489054b6e.1
        for <linux-security-module@vger.kernel.org>; Tue, 26 Nov 2024 10:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732646534; x=1733251334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MXrXqESosptyKiwOViGdMQ3y49t+BKzrdrshLPbcwlM=;
        b=KK4HPYWT6aAXHFMnXLFRUxPZ8isZraRxnSJSDaXr+YQhaNncB8XXZxqAY3R29CXYfl
         lsSfZDByMuvUvJ8EPWevHSy08xmSTK+ZUMrZXHJKwW5Y9NA89+k0UdOtXJuATzqSVG6b
         36TLupz1xEvapMMG0CSzn3jXuD+uAg2yWcoSuzkGjJwiHnEydfxAhx3gxPfSE8fmHdAg
         NDMSsGaRF9Nx6R3kpXV3E5zJ1l4bmFe2yeafqbajGbgFuYQAwlX9gvYdNGS7xGmZzaI4
         6Zxi2HIPyfWKD7Z4JtiLisfzypTzjtqPngSH66yhMTIXVn0ydLokoLt0bofsaS2b6fyA
         HqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646534; x=1733251334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXrXqESosptyKiwOViGdMQ3y49t+BKzrdrshLPbcwlM=;
        b=MA6uVb1tvAIm6mWvNyomOVuNEECmhcC7oai4AXaiaKt2Rw3VD8Uwv5I1VRVjPaOtBM
         onLzB4vLeDAa/6/KT2p91s5oNczVYC6TT8xmZ9hgG5SBLmBPtMEYQIV6qREbpDrc3Zqk
         gcD6A9fF2m/rBkBGfz47MuBZs6rpVNVAuQtm28X/bZekUMV63TZr9FbivSzahPvNGrjP
         iwbfQ8xZJxeDYL8oyWZ9IROW2knqLs0Y3bb1kXPJUCiQqSjiN0mGFndL1q83LybPNQOu
         6IFTQYA0uL1+xsnoick6BXr3fQhoLtyIZox4t3BhXgCNndsEpFBkg6tcC61h+km4C9Gr
         WLNw==
X-Gm-Message-State: AOJu0Yxvvww4VMS4JrduTXgtLeFmN0e3DqXPq6PTEnu4VmxTM4+3TEVd
	0XFdhxVLANCo1rYlaCN9UCvF3kGaxEstez36qHX6xC5ILuhSZ4V0
X-Gm-Gg: ASbGncuDazrwhVqI8P1B5yllodBaf0ClRSXRi3WjterupbLIvhIE/aeQirDEKGPe0HO
	WIpVxPIUvZkv/+qYI8ifeFlQ4BF7t2Uh0u7lQnA9t09ZvaubzL2nu5Ei+Mm+Vk5AhZFH9PbhEg6
	qDx7KOgdTooKcPcCt7YyiAw8cdAis2MKm9Q0MqoUDd+AlxrfW4MWyOrDE0VpFlBblXFM+sXNcm7
	bvj8kdnxDUUq+RKekr7SSshXOUmXXv/uNzZaQVpd4+KpyndWLErFeekBnyzA3JJMm4pN+K4Cm2k
	Qx2BgrISZMTcyN25SRrxbwj3a+7LrDl7bZz4
X-Google-Smtp-Source: AGHT+IGBgM2zuIiFJxmCPgCUoWYag7TC45f6sd5q2buRuwIj9CS3n9I8YVuA6szlxUVH2DyiLMHWwQ==
X-Received: by 2002:a05:6808:19a4:b0:3e7:a201:dc31 with SMTP id 5614622812f47-3ea6dc2511bmr476790b6e.23.1732646533791;
        Tue, 26 Nov 2024 10:42:13 -0800 (PST)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b667a4c89esm268801385a.76.2024.11.26.10.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:42:13 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: linux-security-module@vger.kernel.org,
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH] samples/landlock: Fix possible NULL dereference in parse_path()
Date: Tue, 26 Nov 2024 12:41:57 -0600
Message-Id: <20241126184156.12503-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

malloc() may return NULL, leading to NULL dereference.
Add a NULL check.

Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
---
 samples/landlock/sandboxer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 57565dfd74a2..385fc115647f 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -91,6 +91,9 @@ static int parse_path(char *env_path, const char ***const path_list)
 		}
 	}
 	*path_list = malloc(num_paths * sizeof(**path_list));
+	if (*path_list == NULL)
+		return 1;
+
 	for (i = 0; i < num_paths; i++)
 		(*path_list)[i] = strsep(&env_path, ENV_DELIMITER);
 
-- 
2.34.1

