Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806072628;
	Wed,  7 May 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616334; cv=none; b=RO0q0OAZhRPhyHm4DEG2htvrLrQmYlFsgQBZBRkcBqDY1kPMZwh+TfmS6mKMCkZZreGK0D8EtxMwOE73GWs0n0txR7PeYOFVNLEJl0UdI9m7p9ijhIsG8hLmkwYjZshS4uoxufLJQmV9vX+UTOrEiD3jdWl5SYskPMQ+U8aYbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616334; c=relaxed/simple;
	bh=AWug2EJD8Zb0BHxi2TAv1N/jAtrFEH1V7Ij6zoalq0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u7wQ12Uc8kazdLb6jWfFNsuIjmGQZW3wiYcT5RA+LYz76gqbW/pavtmsvwWnzQcpCVOoBfU4gBZndGmT45CpUQpyuntgcu/vM13vyOZ6i0fxCD6NHY8QSQ56rd4XIrMqVzMzb3yvBHgx9+omIZwu59syzvfncmWCP2liuBHtd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh78cifO; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh78cifO"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af6a315b491so6097377a12.1;
        Wed, 07 May 2025 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746616332; x=1747221132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CsBfD4Pb9OMNX/WaFeLXYdbl+5f37DSDVYvpAffwCyU=;
        b=mh78cifOutAHTfVnDmaOhEUuZTaKAMQnFWgX4mn8RzTc09wU0/+gh5HkfUQbc6Zyqr
         TBEL9faImAP1gfHXuNoKi2mYD0oQDnUqflcHJU8PsnmkrxCnqG/koMeuHCXyFs0BRsG+
         7PDgzqDmUPCX+E8H+SR1U6hkVusPgygpmI4WJZntydT9y1h7nhBu+KVboSdL7lFe7AEK
         OAQdk7WVzz5aYUO9CHWQPJdy/sKQiPq0RUq9YlW9ekewwQBe2hSlRP6FFypIXwO4DFhT
         Z6N5/6OqZ2OcS+u0aEuZWwaOmkddXKZ6UHLmvrO0U/5Jt2TZE9CFcCV3PxBzQW59kID6
         Nefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746616332; x=1747221132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsBfD4Pb9OMNX/WaFeLXYdbl+5f37DSDVYvpAffwCyU=;
        b=Vf1jjc+kjz3imly/MKvrAYt3sJZ25vjcYbj3JaewKaf0wbOAie0cyLB25MZLW/1KLc
         +MxEU0d0+IZ34T9dVQ+FarmHCntfZzTFx7gkKkGuyz9PWNr29rrTS20tKfVtjatZc/AB
         b6DSTU3ZWvWlDnjvnJO6OOVl+byJAFlyhPQLU6ZIFIPLVmUza/+rkIgOZp1PIvH6GzH/
         kgjToAz74E2VAMH7jAf28wTnvdkSrnZJ7Hi4eRUmPHgWRNhkXtU+qpTStsSzXA9hShv/
         +0dluhAZgsFcVl1DF48V0V+4fkE4dsgF0APObc9pHEr82+pCesn9lp2J5eVxk5lOXr1i
         nVaA==
X-Forwarded-Encrypted: i=1; AJvYcCUFFv/z/uuh+RPaysG0dMf03wNvil2q8nWnODWkQdCtgJO11c0FLnqX4N0Ik7DDvFBt9YyB+4oKWM1mPSY=@vger.kernel.org, AJvYcCWBtPWiFBdMZXTnTj2SaC2ChdfuWqsJ9+qj770ODva99wPh+aOyrGIFp0seUMEjgUmIQOYVVlNHW67jw8DDwI/wa1smeLMl@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCDyE0tI44+oxpE6t5Y5DArkb/jHzRdfMws8tAKgw/q0PbWes
	dpAEYdzOAt4AMOtwkFEtJ/s55xamsh2Fjmto1bU9EgRLzFEcGx15
X-Gm-Gg: ASbGncupaWKuMQy/uEYAglPwx0Cyf4MTQkJzk8gNb4a0vIqXakUnZJrE50lv/4X+vI3
	nN6VZBYh/d673m52KVJSwQPCud8GbmARXUXlTDhmra3zWXp5e/GdN2VATkWM7Km2n8MlYu5e9KE
	EdY8exuGMfUAUYtaDLQuAvdguMmDmcZ7lRP5sXrbg8JqPZQr660I+LsjHR0BGAQjMIm7maT6KQm
	4v6XJ5EtZwH+kb4ILJqMSXHZQucWn128W73/U9gjTPMYMZ3Qo5r4HX/etUooz4jabFbEsxrFL+6
	dcMLE2Q6W56xjFWq3ii+oy3tlh/C6HN68anRFwQhh+Nw19Q1l1HhtH5EmWoEPbfzpYHSKw3FNae
	bpoRZnUzghGnXDw==
X-Google-Smtp-Source: AGHT+IG/CCghFGRg+QmTrGaDvtys9QtKLenO0TPTE91OHTJx6hqL4uN/Huw3HaDc+dTeyr0qlGbDFw==
X-Received: by 2002:a17:902:f381:b0:22e:663f:c4b with SMTP id d9443c01a7336-22e663f0fcamr17324135ad.26.1746616332484;
        Wed, 07 May 2025 04:12:12 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e6612e8e1sm11326985ad.132.2025.05.07.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 04:12:11 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: greg@kroah.com,
	chrisw@osdl.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2] securityfs: fix missing of d_delete() in securityfs_remove()
Date: Wed,  7 May 2025 19:12:04 +0800
Message-Id: <20250507111204.2585739-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Consider the following module code (just an example to make it easier to
illustrate the problem, in fact the LSM module will not be dynamically
unloaded):

  static struct dentry *dentry;

  static int __init securityfs_test_init(void)
  {
          dentry = securityfs_create_dir("standon", NULL);
          return PTR_ERR(dentry);
  }

  static void __exit securityfs_test_exit(void)
  {
          securityfs_remove(dentry);
  }

  module_init(securityfs_test_init);
  module_exit(securityfs_test_exit);

and then:

  insmod /path/to/thismodule
  cd /sys/kernel/security/standon     <- we hold 'standon'
  rmmod thismodule                    <- 'standon' don't go away
  insmod /path/to/thismodule          <- Failed: File exists!

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
v2: Modify the commit message to make it clearer
v1: https://lore.kernel.org/all/20250426150931.2840-1-alexjlzheng@tencent.com/
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

