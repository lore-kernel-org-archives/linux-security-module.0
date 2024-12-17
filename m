Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884301F892F;
	Tue, 17 Dec 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460060; cv=none; b=lCOezRrLlncj/UWQBsU/9K3jZWwgA9qn0CmqWf0UUrKAJrabCy/JP1ts3JJakfkOOkNWn7Z6LwbyLbNRqPyGwHw1v0sXDCj12UfjP9GPJe2PGLYkvmZvVyItua2A4BV316fX+uveOzhUNwtQpoqOkcuOfWtdiYAF5Ezf/eI52dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460060; c=relaxed/simple;
	bh=gGzAEDfO/sAUcikngB0aTjWjVvFST6QJkjZ+eyGWxB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoPnhjo09ejjdCbIoz2mUvW/D9Hdy353KoX2AsDhg0ALNFC7rnYqOJClEOuOacDBY21YlVTnD2CEdyMHbp8z1Kk1vqcfhTLM0Q7fMO3XNrVclRhGWPryRCIXAEtTImdzyjlUnkn2LkSW8VR73hV0Gm1391aD77GzsM6oEsNpdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9oKlqJH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9oKlqJH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216281bc30fso59073855ad.0;
        Tue, 17 Dec 2024 10:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734460059; x=1735064859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuBX0m9KGve6qqIFa5pHs2fskV9fMCeDvPNQRVxmhdc=;
        b=Y9oKlqJHO+YC0xTt26O7dImAc244KBcaeFHnyoGp5dR2Pm7ApcJDagU7xXzYS8PkrI
         uKeUzl8Ne0Dq4U/Z2kR/4RYJ8bsv/urD3MMzfuqijLMTif/UP8SZrLLB81szAEaNHZMJ
         wZbQwXf9WGV+ju7BvLl+0yPy/TkKFVQ5oGvNcCy/V8HKF62VvQHFsN0TP+mN4d0FKa0e
         cvtpDlDD6T9yUbzXK6fulHFb03eNOrTolZNTyIH/UuDucsZU+D1SSEYbnh+DDLZdaNrI
         tdbJVcmUBcPRa45nkCD6t9IP+q0JbVOS4qibV4xhGRHqQgtb4s3y0PO9tjpDwTMQg6M7
         lqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460059; x=1735064859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuBX0m9KGve6qqIFa5pHs2fskV9fMCeDvPNQRVxmhdc=;
        b=es6xxrPJxXFai3zsXBbwCQ7DL3aC6YJX1O0REkaWP0PbkFDmAUHzpot4z+wR3lFsJR
         3lDXsVk8zjFvLpkmuu0ryiUyCt+iDxv7dFb+BRfc4NbIhEaAgGeyrWJ6nDDwR/rKiLvv
         h2esjBzFIftou2h+4TMxVWIgBoqatZjRVz+wIYTl2HPaMgigjVnQTYlrgRhz3SLs0n5p
         ufiNJ90Q60Za4YFbMGcbaiGqclRF6x1xJr4rMAoHHYkg+06WnYNNR21yCEDsdWGtxBiA
         TkS10vSm9JAzIK0O8NIvBJKWliaPx7mBaHkeq7KTKlpmDWSMWOCYdGzqmH8M5z2vTwdp
         DiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx8lAGQ+40DAYDk8U5wIdqMhkbNtg80i0JPFMl2gosZKFFZvBxWRcnIAa3MmMrAIj2kGqp4mfrC3xhORhyxq/g7X0vw8vc@vger.kernel.org, AJvYcCWceHREBeKGRQ4srdK1bSge+TlcOXCftos5QMrrR2jLFZxgBYiS8ciYYj3QVxbKQDkM6kFf3HAwq7kezvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNA3PHeXpQaCU6Hqs6AoCDEnrAo+5/1ihQ10briIhEjXu/eGf
	j7a0SPlYJEP2ZrPH5ZM3+qJx/FWJQxZyuoOGWMrGdNPEtfVxqM0u
X-Gm-Gg: ASbGncskr0HJGl7ztEj0HfmZgfrvCjLl1UMG4C46tPjMnKaHV6vKIXa0bsAqrPVWM3p
	odqtYAjMMxCYbOCCRPK5jlHBBR0+dxzk2HBbaMBqa6SVbaMGDYmIprk7UXfcRHd8F/pi9LQBPHn
	NjhfFfR+RPuKuUvu7LVLYioSLVvFJtlW0UMgT4Er8hByyzlXPH2sYIv5XQGg8tLztIqP1yN9tkO
	LIHgrfqEJegqIBScZLy3dZSw76/NJgRlrhOiuitJypofi7zNAg8gHvxZ2JEk+HFRqXcHm3u
X-Google-Smtp-Source: AGHT+IF+DHcqTZiYeQlV53vHMwdV1xlZDwwl73xCJZ0PjZ3QI3/2docUFFGlPr3r2lVOeKR/Bu6Rsg==
X-Received: by 2002:a17:902:fa04:b0:216:1cfa:2bda with SMTP id d9443c01a7336-218d52b1033mr6956665ad.43.1734460058766;
        Tue, 17 Dec 2024 10:27:38 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:ecbe:ab7f:849b:1fad])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6c110sm62929085ad.257.2024.12.17.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:27:38 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
Cc: Leo Stone <leocstone@gmail.com>,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mortonm@chromium.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] lsm: check size of writes
Date: Tue, 17 Dec 2024 10:26:57 -0800
Message-ID: <20241217182657.10080-2-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675f513a.050a0220.37aaf.0106.GAE@google.com>
References: <675f513a.050a0220.37aaf.0106.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot attempts to write a buffer with a large size to a sysfs entry
with writes handled by handle_policy_update(), triggering a warning
in kmalloc.

Check the size specified for write buffers before allocating.

Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4eb7a741b3216020043a
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
v2: Make the check in handle_policy_update() to also cover
safesetid_uid_file_write(). Thanks for your feedback.
v1: https://lore.kernel.org/all/20241216030213.246804-2-leocstone@gmail.com/
---
 security/safesetid/securityfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 25310468bcdd..8e1ffd70b18a 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -143,6 +143,9 @@ static ssize_t handle_policy_update(struct file *file,
 	char *buf, *p, *end;
 	int err;
 
+	if (len >= KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
 	pol = kmalloc(sizeof(struct setid_ruleset), GFP_KERNEL);
 	if (!pol)
 		return -ENOMEM;
-- 
2.43.0

