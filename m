Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E2225414;
	Thu,  8 May 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713087; cv=none; b=IC5LQGz+S550OG/wMPld9s+oEnyYBoaZu+nuXyAydqgQv5Qm9Z2fa3yU67+iiU4FSB9oAhjcA3bPusXyOjUdPXMeuOI0bNrGnAqVBWrYOxz1sk+vRDar+71F8Edvf9f/nru8NghJAFiqiHTkeX0Kv2STXoFgZlHtJGxUZCmy/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713087; c=relaxed/simple;
	bh=I5AYjiY8VUoBHNQi0KyZfpF+m4tQwY6m2Fr4MyzfSaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhD+L2tpl+VWfRPJu5e04PQ/lOnwoAE1zY/mB0xcSZKunFoE7MN/YyaGnLLJKsMeibAtfh//eDw4QS+BYt2zC4C0uSEMuNrLwJc1bt+3DxbGT+0yYZ+vPOrxUVi1BNgyAGCAvpOPtTdFrEtrN/+f0548d6V3RwiqJnQsA4rPies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTuXt1Tu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTuXt1Tu"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso1312088b3a.0;
        Thu, 08 May 2025 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746713085; x=1747317885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQdOLgCX3HOEuRvc2wEO5NPaR0RD7S1qSIiFGmRjaOk=;
        b=MTuXt1Tuf7/Qf2ey4J7GJnYW/3g0+P7JbXRIV0dPb3vgFEH/T59Ax0n0RYUfHAYK2P
         H5OdoUPxd85GTbm9ty02A+u99rk1W/lM4b8P4Q4I71xEOg0IL4iHUGK3dvPZj+hNqKCl
         4K6sTzik34WmHtcpTtwYa81u9jmLThVvI7vZu0hIVisG5/2lJrfMfLwAn/qkv8LVdM9c
         haDAKIW5S3Q3xCCob21U0rQcOrB1xnacWNCL0rSAgQqH/dyG7wvHW313Tdl2IXcWLWSj
         lBFzjCJOXM0/Lp2/aXzI9vj/y1PbQC0YZfxoAxnW/LobyVpcWG1qDMWdZnpnYi1SQ0/4
         qbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746713085; x=1747317885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQdOLgCX3HOEuRvc2wEO5NPaR0RD7S1qSIiFGmRjaOk=;
        b=qGgotPaNqewDF24BR3yhh7bvgR8dIVb0Kzr8oBMzejv37d+h3F2jrvgKm4E54v6iue
         cWEaZT5RfiJw1sltMRTga470hoPa8SekZwnbZ5a9VoqchxpFcWMHQyfLOka3NiM3EoDW
         zi983OcJH48m9klhOS2fJafn7M5kLtposbd0LwVPyzHN2/+y/J1W1vYvV/+oYvANJJvN
         cW30Sw0RqzOhXCOZQf34LK1B/TY6JSRvQwW61eCrIURyWqfi0G+hrCgjfz/EVPa8FaQH
         IAnnX6Wpz7kfBBzrurbxNskLuJInAL8KJXKmSeaT3s3Kl5vhnUPS2rJQjdEZSKE5xpfj
         j2sw==
X-Forwarded-Encrypted: i=1; AJvYcCUM9uFsSJfdDu3OpGs5Dl04nrzZfhjGlUS6l4O/Ok58uVx6Cx0zP/cTgLOz2NVNroEp8GvLPmbl8rZWsbU=@vger.kernel.org, AJvYcCX1Zzll3r9W7Eb/eDfPdEM+9CZdmEe8ajqRg2ZPW99lr5Y4H0ouqUZfzXhFpWT1IEot3iAhoeFGo3ILGNdyT3l9OiEV1gH1@vger.kernel.org
X-Gm-Message-State: AOJu0YzrXUvAzPxB5o6YVcL0RCowZlWdEYiby78Q5QkxXTNdXghUR6Zv
	ak4xe/ygW59JARcB2X2ziqWvb7cGG7v/kFVSkdQJm4NuS5xIYj/6BOyl7Q==
X-Gm-Gg: ASbGncunK/efAwjZtgYqFiX1IDIMuf2NRzbNxdUDbEzSI25ozvXHhuYlVOw9xRRM72B
	c8s9VrjnAtWSRg/g/dmOcS6mApVTv/zRDhfVnRqLfIxEj6us6gotDB3NJT6mvI8gozcc9Z1K63i
	pdoYTKWYS/PAJhsFHQme0TXV1QDPsEOfg8hQ8FEvwwrt2i7P4ATHr3il9wkgftP8CaX2cD2TK+O
	fzsXsJWst3zePRUILAyJ3kV9fcuoutFNksFthswvtVIdXHTzbPdZUIFCtTH1N6PL/JDsj80nTfx
	B03FNTnmHiJPd9NXZM2llwGJlld6hKk1jTQV4InQey71F+HLPfc=
X-Google-Smtp-Source: AGHT+IEHqHiTAH5HAyh0OHYt05cNXNldRr6if44Me5asjUB6jdOUWaqC6iTX3R5KvLcN76DUc08YlA==
X-Received: by 2002:a05:6a20:c90d:b0:1ee:dded:e5b with SMTP id adf61e73a8af0-2148c40f940mr12458973637.24.1746713085394;
        Thu, 08 May 2025 07:04:45 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740650a6081sm12108318b3a.139.2025.05.08.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:04:44 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: paul@paul-moore.com,
	jmorris@namei.org,
	viro@zeniv.linux.org.uk
Cc: serge@hallyn.com,
	greg@kroah.com,
	chrisw@osdl.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v3] securityfs: fix missing of d_delete() in securityfs_remove()
Date: Thu,  8 May 2025 22:04:39 +0800
Message-ID: <20250508140438.648533-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Consider the following execution flow:

  Thread 0: securityfs_create_dir("A")
  Thread 1: cd /sys/kernel/security/A           <- we hold 'A'
  Thread 0: securityfs_remove(dentry)           <- 'A' don't go away
  Thread 0: securityfs_create_dir("A")          <- Failed: File exists!

Although the LSM module will not be dynamically added or deleted after
the kernel is started, it may dynamically add or delete pseudo files
for status export or function configuration in userspace according to
different status, which we are not prohibited from doing so.

In addition, securityfs_recursive_remove() avoids this problem by calling
__d_drop() directly. As a non-recursive version, it is somewhat strange
that securityfs_remove() does not clean up the deleted dentry.

Fix this by adding d_delete() in securityfs_remove().

Fixes: b67dbf9d4c198 ("[PATCH] add securityfs for all LSMs to use")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
changelog:
v3: Modify the commit message to avoid readers mistakenly thinking that the LSM is being dynamically loaded
v2: https://lore.kernel.org/all/20250507111204.2585739-1-alexjlzheng@tencent.com/
v1: https://lore.kernel.org/all/20250425092548.6828-1-alexjlzheng@tencent.com/
---
 security/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/inode.c b/security/inode.c
index da3ab44c8e57..d99baf26350a 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.49.0

