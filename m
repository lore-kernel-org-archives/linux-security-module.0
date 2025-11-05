Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1FA28726E
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377638; cv=none; b=grPp8EzgYH6O3e8+4TaSs5tuSt1oEHKVd3JD/oC8etkMA5ur1o/t1lBGwsR9H4iL8BrxmqldZapsxxMIt84dXeOxpKBg0X/nr1diF6sB3f4WLOr3e/G61J/7hK7yqI+2TuNQfpWWjFsXE7pG/akioZ/RY+d8vEGyVLuXny+JILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377638; c=relaxed/simple;
	bh=2pplFlMMvnjUl6FrlZeDRW3iPjYcJlrYy3U19WE/I2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RG6psacNytCEuHFGtNBuCrpo3y8agqOlWT209SndiOne7HHIrLoHQDYc6FQOtniWgXEg9PX4jCVAeAN0MfPoYOUtL0jvmNDjScxKWWGVk3spAZEz4d4kW4uuiC5U12oVm1c9wFdAYA86wRQSY7atpzUXtw6E0u+KZsZp9YkzvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3DrJn1J; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3DrJn1J"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477632d9326so692065e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Nov 2025 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762377635; x=1762982435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdLJGs3mR/Ak3xxBl+2P2SaXwjuVbkUq06ZP/Gr3rTg=;
        b=A3DrJn1JOySehDZuoyhVgOJjCj8Z6fOoSQFAB9ZZ3tmRRJw72nfZDI2SJHlrZvl/F7
         NiTOXTvbnFMyo/Dy3ebNkdyoJEqD9NrWLYlQ0eJBLb6HCzD7+68bRruNuWOPFcsNoJKD
         2LjYOBg15pM5bUqcNgtPzt13Q2969Fm9Pk4cHjF+I6FPkPEzYH/Q8dP2WIeSCCZhegTL
         Eq5O5V+Tlimg4aVxJIKkFMf4761msUOVwwGWsWagT+Z6b2Tk650HmxDw8MF000A+u1ip
         UMoDfuBD82+eEMYCKgtJgTXSLfnof6VK4TIW8WFrUDphXnM/um9gcgFPoqMXe3Cn7uaM
         5LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377635; x=1762982435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdLJGs3mR/Ak3xxBl+2P2SaXwjuVbkUq06ZP/Gr3rTg=;
        b=FT6OIQ2MSpGeV6SS+HICLJYHE+lPaP7UZuBYi4ogkvdumDUsUK7e6t+pVo8e4TqXBJ
         WEKmRoc0bwIgoQubI1V8mKrW4Zqsht4Sx9VDx6GK60lP12HmR/lzL4sVt1XOCl+2iBVd
         jWZ05k2HddxzDwZuDmDvzhFw4OVcDzXkOL61ZAe3V+F/rGcWntxu9BPria/oXLgYWWYE
         F8WuwaN+2PFPMn6owlLx9xWoiVIDBrDnGxL1p7AROWs2HPcTbF3ejoipAt5mK+5hOOWd
         qdsWAF0rurHR8brC/fMSREltGM7Issvzsvi2GNu3sZFcjInwqTzfPDne2sneeFFNp+ZS
         8HfA==
X-Gm-Message-State: AOJu0Yy1eDwBHBgiQ8a1lZuU3HHOQoL92ILv367QShVKi3oYHdC9HOAs
	/Lr2O+iFWbDOVeuEk8lY/VOo5IFnMRu/deDAbXaErf4XtEzzPsKWvumB
X-Gm-Gg: ASbGnctTlkAGWtq98Zf85jFxz35t/s8EOc77QRjvUK91WUr/nr9PVJmUdd7AgADm5gU
	7QUv4RzT/a3Y1rbvGKI56wNKDP9MUF31LcSega0eP8AI+lIPrUgXaLP9jMA1Xt/wdY2zWwK3Iw0
	O7dhB+zRh6VLf42GY3xN0TwcRNLmHwwTObnDb/SIY44gAlTltjKys3JeRGTQGfKon/HYoB3MLCg
	lzxWIYcfknc+CegYB5wz/GE7eQUbNc9cXd62uUbzAgsUUQyrrHVlJY4aQvngv2vSl5sXoxsH7oc
	tAm8Kxfxtne4qn19tkEDnbPefX+QzLbsfVOZvMeIasQO1f5lvr5KW9T/ZkZbMwfmnE7ajA8eqxL
	ZeTSdhCBcWDkTaJJio13QRZIuF7dpiaQAGzxQZukQHLj5qYq87xBdBllE+b7XA/NhD33kwBDRRF
	ubiL5mwIJpd7qlV++d3yULSPKQXNt7LOi5myfOlv3RWNVjOIWy
X-Google-Smtp-Source: AGHT+IEwpSk8sOAJvDtjfIMcje8WUONwpgtu7bj9S59zK+n8/BOyF98omCH07HtS0euQPIoNmLSS6A==
X-Received: by 2002:a05:600c:358d:b0:477:b93:a7b8 with SMTP id 5b1f17b1804b1-4775cdbd478mr43779465e9.8.1762377634689;
        Wed, 05 Nov 2025 13:20:34 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2f90sm8914505e9.12.2025.11.05.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:20:34 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: mic@digikod.net,
	brauner@kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	eadavis@qq.com,
	gnoack@google.com,
	jack@suse.cz,
	jannh@google.com,
	max.kellermann@ionos.com,
	m@maowtm.org,
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] fs: add iput_not_last()
Date: Wed,  5 Nov 2025 22:20:24 +0100
Message-ID: <20251105212025.807549-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c         | 12 ++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index ec9339024ac3..cff1d3af0d57 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1967,6 +1967,18 @@ void iput(struct inode *inode)
 }
 EXPORT_SYMBOL(iput);
 
+/**
+ *	iput_not_last	- put an inode assuming this is not the last reference
+ *	@inode: inode to put
+ */
+void iput_not_last(struct inode *inode)
+{
+	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
+
+	WARN_ON(atomic_sub_return(1, &inode->i_count) == 0);
+}
+EXPORT_SYMBOL(iput_not_last);
+
 #ifdef CONFIG_BLOCK
 /**
  *	bmap	- find a block number in a file
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..98fc088a461f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2823,6 +2823,7 @@ extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
+void iput_not_last(struct inode *);
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
 
-- 
2.48.1

