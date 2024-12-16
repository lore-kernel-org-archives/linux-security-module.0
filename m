Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC268F9DD;
	Mon, 16 Dec 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734315336; cv=none; b=BW0sc5QU1PddBFhweYKwPkskZhvDXVEdXa0zHK7FHyD4HoH0O4m+gIXAKNsDBxZl1IIWY8lRZw5Xbl5dxpSs2of+ZLSDt610Af5Ngserf/JLIoBAV0OQgEpRZsMxBd2M0UAyU4MjO5E1rILBIEsXs/1x7q82vffKKvxSciDoA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734315336; c=relaxed/simple;
	bh=g1ew64RhiorXQF0KIQimayCQ3duY7awXhUEcCjeyyvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRCvXBjmDbpx157VXg3irWQgyugl+jvMa+ovlgjX6jA0WLqW5wBYlL3aucWxQ0aVhQFqZh9Oc9usXxBuwDfBYODwZhGIEGMPQrruMTQWDAP3aLPYCNiFlx7yQSd2UHsW/TOGx35VUHF2Z4m/pXnCnIM7/ytcwc8Cwt29dmPqCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieQYgobW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieQYgobW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21661be2c2dso25127295ad.1;
        Sun, 15 Dec 2024 18:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734315334; x=1734920134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DegakvG+kcadAkVPXaNTk+h1UmQKvrfimmgaThYkXXA=;
        b=ieQYgobWg7Q6GCSC/cDMMNZJQm2dWybNHRsOgiwiPi/rPUJZgbSRAkrDWREIhRf4OW
         MjnIasP2pyVGHK3aD4HRu883g2DYy86pzvNRV+KkIfkZiuNH/JPcOufuH6iaVIvaB3aX
         6XTVZaKTMJhaC0/Xni86gofcqfiyYtd7Rz1pg/xBX+XHF3+DBmv7blN40Jm5U+6MZuk5
         dSLOrDW9j5knUezrM7c3UKZIzyiZsg3KkusaXUoNvBYXEuBzbJnHuAYECG6vt1Woy/nm
         rTX9ihsZ6dtEKkNOYF4m3DrHnbsROj8zNd3D7JTuppulB0v/c5C++QanGMWD8WQyqpk+
         pCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734315334; x=1734920134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DegakvG+kcadAkVPXaNTk+h1UmQKvrfimmgaThYkXXA=;
        b=DwpxO4JrsuCt/34hx3v4t0+PGjmYbxeELGIU5tB+C6x7xhjzRpTvzyz9LJ+nlP8NgK
         epyJ1UsOzFaHgKB8ezQrtUcuAKHDwyFwAvyhI54Uo42tJslu8rfN9B+7NvQtSWW/VeUJ
         T4QcYskqr287elVlvnAD9xecsdte0ESVXGkddGu3P82wU2iqcdYUpzeE/M259IevT5OW
         ZME7lQH86pq6rPSTUZSJJA+P9L2NYo7S0IuqbmsRgF5MuVrJWiPwRaT2TggkdYpk/UQp
         uXj6oo2/r5++sEoXOZv01JppxbX+m3780xskAD4mO8JFKcglyY3h0PZ0cmyf70IHnZrS
         OC1g==
X-Forwarded-Encrypted: i=1; AJvYcCUccUzimbMz+L/+uIuP7fmNkIGX1o8X4RqrBzV9uJ/JUNAgTImlxw6AoBsslH9EHC27H89j4TpKunzXzxI=@vger.kernel.org, AJvYcCXyNlIgjIgCWYLErAG+eoyus1uiRkFXkXndQWInpPtOG9r6nRsdQUNGwI3yYTQMHFGGhQqHvobEKg2z54OkHlEQ1vxtz+fg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16DsdXO1To5OkAVySVbRGPxElP2147GyUEj3b2NWNWipkoUR9
	gfChyj0oqQcqWTLtQBBI9/GInuUSXbXRtjwoB6/QjzA6ZXX4p5Vp
X-Gm-Gg: ASbGncuULrT3iZfaDkynWhEveBDamdcQODImZRS/LM1G+hxVVVxpjeDYnVqtXN3DXDB
	8XMGE979YcibqvkvQaXtPuUEseox+bOQna0cnzxJCsc2sfrZD/2E535l9sb0TFCR6TNPnx4RcNb
	nI+a1yxR7dgnP0z/j3eRl27GUIjUbTcLv+nf4pQh4q79F0hBOrgZCniv6jTaaK6d0q3Jr+wlsxM
	s3MsCWEnC406OnTLRIHiq7+36hakq5v+7kuqqbZaCcVesW0IgrhiHrJ16ObCLsLrjrCvroy
X-Google-Smtp-Source: AGHT+IH1wW0tKh8Z49W70H8AdbhL/CTjNrnMQ73ELFzK8oUZJlcbfFxMG+Du9/H8mOt8pY/bLMX/+A==
X-Received: by 2002:a17:903:41cd:b0:215:8ca3:3bac with SMTP id d9443c01a7336-218929a1f14mr155514245ad.16.1734315333869;
        Sun, 15 Dec 2024 18:15:33 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:d782:c275:5ae5:7e7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5404csm32452495ad.150.2024.12.15.18.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 18:15:33 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Cc: Leo Stone <leocstone@gmail.com>,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	serge@hallyn.com,
	syzkaller-bugs@googlegroups.com,
	takedakn@nttdata.co.jp,
	tomoyo-dev-en@lists.osdn.me
Subject: [PATCH] tomoyo: Reject excessively long lines
Date: Sun, 15 Dec 2024 18:14:58 -0800
Message-ID: <20241216021459.178759-2-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
References: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot creates an anonymous memory region, and then issues a
write syscall from the new memory region to a sysfs entry controlled by
tomoyo, specifying a buffer size of just under 2 GB (the actual size of
the buffer is ~32 MB). Because tomoyo_write_control will double the
size of head->write_buf every time it runs out of space for the current
line, and everything in the zero-initialized buffer is on the same line,
the function will eventually issue a kzalloc with a size that is too large,
triggering the warning.

Reject writes with excessively long lines.

Reported-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 security/tomoyo/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 5c7b059a332a..0c75be949c9d 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2665,6 +2665,10 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
+			if (len > KMALLOC_MAX_SIZE) {
+				error = -EINVAL;
+				break;
+			}
 			char *cp = kzalloc(len, GFP_NOFS);
 
 			if (!cp) {
-- 
2.43.0

