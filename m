Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F11F03DA
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814580; cv=none; b=KzTYvjBkZBiTXuBJwEmf4cILzOUY0jQO+N2AvN38jv+1n3Y5ua1gjO9ZQQwpCa/IhmC1zULoxg/oVL965Q3ilJ7JxX7RskaGq9blIUPdO/JXdFYRR8OYqMwcageRnv0WayQprd84HnyUGc3GyoCEqPCK6QnQQthyzM4yPtLvFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814580; c=relaxed/simple;
	bh=YKJUOhSAlbceCTtQeFmVs8IFwOcyWaVLfzVCuOajKmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itV94iXdbfpWp9rv2KoqXHHb3H3vKzoslk1qVdfl9Y6zXJUiZh3F1waAJcEd2SbRraTzHIRRDrH0LOGbp5VXi8vRhhzDqHVQGGeyaVSBiAGYwcbIUuaMNEamXKAq5bAi94buRZwpCoi4LBC+rwYrCKAzh6zoJn9v/6X12ePeST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vmL06F9F; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vmL06F9F"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 828C73F731
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814570;
	bh=bQ5ilq+qjctbW08HSKcwKvLmj0dzCcpGagg2F3uVrL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=vmL06F9FBtpJLaaYr55tRaWWAuRysWlSghmlHws+4ccfGIOKu/r09XtkJ0t2XeANd
	 i6mp2xCB2TcwZfGBQQko9G7AptQBV6tAVGPPt+Ny/IdmUxR3AsLJcRYT2JF93t6Tbr
	 KPIAH1xPhRWNs9Yaat8RznLCojnUFhn1uD77B3EU+nWlfhWXPS9b7txWNmiy7XJQSN
	 VEq4ftfPlpUlroju6uaPfkAmUVq4lAYrho/T2qX/+pcv+/MHxlKcIfnPIKu7pMUieM
	 I0sgw/skR3jkjn7NgU72gDmhz8J2SOkyySW3W8l80To2O+b7ga9qDH1LkXYoZkSmiq
	 C1faCZS04BR3A==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff69646218so756867a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814568; x=1742419368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQ5ilq+qjctbW08HSKcwKvLmj0dzCcpGagg2F3uVrL4=;
        b=tcUeBQA2ebEltfV89FQ9zI2LJY1cw7Dw186FC2sCFdbCdznTYSLw6slTGnKQO87hVT
         /smVD2iDhWS4lvhqVpWEHE+XM4deOMXxLR/+v/EeyqpkidfcWj7fBkuLAvt4nR2bb3up
         TAf8kvPP7n8xFX28fGAAbY3zifQcHlxBdyaT0mV54RInASuizi4HLNvSw949mDK/ZvJ0
         L4g3+wQPG0nBql/AI6q6JbZ8+sVCO72uWDpYe6+N7quTfQt27UnKsAHErN+jj965m5a+
         Tf831UF/TZScwE9TG2PMxqi12TcdFvPSdfeKW8/R6lSHntwX8K8pt0hJA7RyJRlU/DVx
         4JpA==
X-Forwarded-Encrypted: i=1; AJvYcCWmaUv8IqQU4XGexe8c1zrsRBvn/cLE+fGn+R8J+lYkiZ4cXNh4/UR1+jUk4LwZFWfvAZNOEb8kRdph4Oa0AQ5bsCsVjVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgDEXQCWhED3iyP1HT1R4TPyF6EfljE1WOXAGRo2laaqvZz1U
	BIAOauzXsnzn+JC2l4wKdPNDVHUSCQQtTGFfHM6e+QnyomOCHDNCWuFVExObXvnj9kQJA5C8sQO
	hXPQW+Qr6Ks3Q+qx9Sbq4r9i6d5V6nH0D0+IRq6PcK3Mij7f6plXy0NopPIYzZHnWKWItqjPhRD
	j1SVW8uI3Yx++UUg==
X-Gm-Gg: ASbGnctvxfZQpq8RNqEIyT0egw/zyzTu4s0wkjjMO3zR9uppROQHqscalPBMi6ac53c
	o6AHJ269uQmCHuaJfG10/LdNLAXypvNNVeJMHwTRv3GhpIe9aou1eQoJLasOrH4rwUXRhSdmPUm
	O1GSQXSkvBXL+z9Yn/9Tm45XD9vnIt4MPtS3fgwBRBqnDVOviO6YNEGoy/UYjFgjhOXcVWSiWqf
	L1jsKa2TMPaztB+dj/D1KWb7eZZ22CccXAxgq9CBTMqwucbOqv3zGONvQ1R3tnxVvN/scgSgDMy
	fQrSJBp0Ej5zDNkFNRFv9tNgbHfvWq3gDi/waPPYaWpy9GbVeHF05v3iyrWO6Q3Qun5lBIg=
X-Received: by 2002:a17:90b:38c8:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2ff7ce84c7bmr34243248a91.20.1741814568674;
        Wed, 12 Mar 2025 14:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6kNFGkR2Ar2yfV2Wm7/OWkigwZeggzkNDef+VFj2HbCWbxEzVxXle+EcNd+qkPs6JAUusng==
X-Received: by 2002:a17:90b:38c8:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2ff7ce84c7bmr34243239a91.20.1741814568350;
        Wed, 12 Mar 2025 14:22:48 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:47 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 3/6] landlock: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:43 -0700
Message-ID: <20250312212148.274205-4-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Landlock currently does not have handling of O_PATH fds. Now that they
are being passed to the file_open hook, explicitly skip mediation of
them until we can handle them.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/landlock/fs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0804f76a67be..37b2167bf4c6 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1522,6 +1522,14 @@ static int hook_file_open(struct file *const file)
 	if (!dom)
 		return 0;
 
+	/*
+	 * Preserve the behavior of O_PATH fd creation not being mediated, for
+	 * now.  Remove this when the comment below about handling O_PATH fds
+	 * is resolved.
+	 */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	/*
 	 * Because a file may be opened with O_PATH, get_required_file_open_access()
 	 * may return 0.  This case will be handled with a future Landlock
-- 
2.43.0

base-kernel: v6.14-rc6
