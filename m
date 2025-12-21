Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888AC283FCF
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346204; cv=none; b=Z2XA0UHd22QHEJlvyGHMuoGR5dNUk2P5sxRViWEp+q7CAypr1YvuAR8PYUa10mD5QiyZsuvfipd1CXV4i+KYkBJ8j9W44xqYOtFBTABzW9yvE3YWf8aU+C9ejQ3m9NwuOuVImOG8WzGrWg7nFsHwPY3xKtrE+tJTVRuxCtgr6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346204; c=relaxed/simple;
	bh=CppXod+OJhnOsVbY0S0qmZbK/Q0sRnJMy1IVVZsD2RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoxgACzCnKc0r3Zm6Kc62zLRIrQqTGJavna/Ihkhqwzp219GhZKeG/LHWGPEVsaD+ADSyDXuyNnWMZgOpHt/VSdBucjo3I2EX6bJtGnkq9rQ4bB07k8KBNVp7KZSlqPp0ZCUlFUBGlfHQzsLXnX7Yqy5WLk11hEGyNY25kyjRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTjWoa6a; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTjWoa6a"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64471fcdef0so2464755d50.1
        for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 11:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766346201; x=1766951001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyuZGoUl/wnIty8PjaTmUQtU1lWxhKrCn+wsAwEbzKs=;
        b=cTjWoa6aKjuyz7EDx38DD3Co2lZt5yvnJJoMlg2XPUqPCBrxIb4012Xc4axT2NDzMy
         7eyVN8RzpHp1yyAI5H4tCPdKvcAi4fkr9HeCcoTysh/CYDJbWdUBsu64Jo6Z9x2TdEHV
         I/5hHBtCIAIWvvWRJGTH555a1PFjp78kcY8bWeCunBep949cdTOTN25i7C8Pfs6QAIKa
         beNckoUvPBbRXuiWtXQgISUsWiC0QYs6PisnceHy8qyyUpo5IDb4SdKSRIKbaj9cs+y1
         +CD4la+o8EwXuyfTpauqf2eOfwT+g6ovu78KMLyVNbZNS/HNaialHgdqO1URVCRIeTnW
         dizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766346201; x=1766951001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CyuZGoUl/wnIty8PjaTmUQtU1lWxhKrCn+wsAwEbzKs=;
        b=c5SPZ1VlPCrUnXB3vu0PXFXF3hpB9rg3qtfnesID+CHfW/Vy4heHV1SDq/iopVZq+T
         ypKJwqSCMITPEaFIV1BOwtttF+/GrBbs/vTzhYWzIP/nUBYPTsymPMi9Av21sTQvKnqm
         AN2m/BbvTKuGvPQ/7b2OvgeRmTClsfLIr7i+M3gKDKUhwkbJJdlIYUl9tNmR2YWF5l6Z
         8lA74843dYdZKYZ8nGYUHtwfIX13QUG3o1TwZwBpAVK7HZ6hXqDEu3Fiye01iMmtFN2I
         mDFK1Y3OnV3PQQ08ptHwe82oHFLrOtqvApgjAOAovH6isph6z4Y+O/+RVWzI7AKyw0+2
         dEfA==
X-Forwarded-Encrypted: i=1; AJvYcCW3L5poFRUYfw72aL0Tg5CApeBy2fDgkXXlds8A/2qZQeWg8acc2taBNjVdls9JB/070ow2pYuLUXjap8jhnqHSEuE4AQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMW93yHWEGIpE11T6LsSDFDoFOBtPMsDLrpi2gTojMLOAfjk4
	3XgcldzZHGI0nmayRQm/A3R7kMB0+5jFLcsTkqWoo8jY92fHG6kmt4Bq
X-Gm-Gg: AY/fxX5gzPlwr7u86/UF+iCHBirv8tty96vPVGe5vBYkpqJR7shIbd9uJ8sK3uxZAHB
	85AsP84UcQfmvGVXO7RtYeVlFAr6t3GorPwJ3svfH8eXVtz+YnxxCLUNAFuk2a5qd8kSvwj9Hwj
	oqeDirVLFBqApspR/yvbFzjJdJ/dhh+mLlRgakcQEpi5t635v2Dto5nrOkJ3fcRqqrd0xKkXdgI
	yt7SnA0sMLKoyIditzY/0XETbcPhnjaNwbI7dj2mVLBnk31AMTG/DnRpbZpwH34aWA7PYOd3kaM
	2S9doELykeNcn6uWYJOdabMZZz6ibIilBTnmv5PTZV0YyqEiwjdYRI6TH7NWNY4OUHTGTZMlm+u
	7jNwVdVraxL6NJqkMkxJa0NsrCIRI4xTfZ79D1pTfgOzt9YTrKF+8f3YrBK8d8Oe40DZtEQtA/3
	tAdOOpyph4YAvwfUIttzMytu239y8iv2kWklxmJzb3Px/UJSU6RTXQGl4DDH30
X-Google-Smtp-Source: AGHT+IF9gPDyi0qYJoLmoDi2FIxKtwez+ZwJ6gHG6rhcbIqkDFRodqSklDAAOLTTpG85qUiQFgQNVg==
X-Received: by 2002:a05:690c:6186:b0:787:e779:9eb3 with SMTP id 00721157ae682-78fb40be119mr158663167b3.62.1766346201479;
        Sun, 21 Dec 2025 11:43:21 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43701c7sm35628707b3.8.2025.12.21.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 11:43:21 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 6/6] landlock: Add documentation for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 21 Dec 2025 14:43:01 -0500
Message-ID: <20251221194301.247484-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221194301.247484-1-utilityemal77@gmail.com>
References: <20251221194301.247484-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds documentation of the flag to the userspace api, describing
the functionality of the flag and parent directory protections.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v5..v6 changes:
    
      * None
    
    v1..v5 changes:
    
      * Initial addition

 Documentation/userspace-api/landlock.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e..3671cd90fbe2 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -604,6 +604,23 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
 sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.rst
 for more details on audit.
 
+Filesystem inheritance suppression (ABI < 8)
+-----------------
+
+Starting with the Landlock ABI version 8, it is possible to prevent a directory
+or file from inheriting it's parent's access grants by using the
+``LANDLOCK_ADD_RULE_NO_INHERIT`` flag passed to sys_landlock_add_rule().  This
+can be useful for policies where a parent directory needs broader access than its
+children.
+
+To mitigate sandbox-restart attacks, the inode itself, and ancestors of inodes
+tagged with ``LANDLOCK_ADD_RULE_NO_INHERIT`` cannot be removed, renamed,
+reparented, or linked into/from other directories.
+
+These parent directory protections propagate up to the root. Further inheritance
+for grants originating beneath a ``LANDLOCK_ADD_RULE_NO_INHERIT`` tagged inode
+are not affected unless also tagged with this flag.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.51.0

