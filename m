Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A015624B
	for <linux-security-module@vger.kernel.org>; Sun,  8 Mar 2026 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993399; cv=none; b=qchpifd1FgV3jeA3S5KNNeVitqGwD8VcSlhSi+KMLyAo4V0v8r4d6XUFStAC4K+tnzsB8+iw95cxBx1S8a3rQ/ogUsl/jwSmwZpKlX3TEtUq9rPxu3pEGka9+wqpYPo0GzD7roc6203SBlatJd1c3tkcwy8EA/bmTefMcDqiDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993399; c=relaxed/simple;
	bh=XmsYEmCoXNT/C2GWn7qZw2zbifEAERePDgg8h4oumeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYVJ1S46WFnjB82SRLdoclAZTjjMfdIyVU9kz+uLOxCiqKywE16qJPPwckq7AbbILfZgMQ4tTRtwhj0wDnZfHIXXY92cGz2LYczZrNlrthzpVwpaMhD5QxrPLWUiP5EOzcsdB3+iwy+GQMU7tc4/Mj/4zIHUNExA9UV82I9k6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtDHfvUJ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtDHfvUJ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89a0ece9f14so83498006d6.3
        for <linux-security-module@vger.kernel.org>; Sun, 08 Mar 2026 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772993396; x=1773598196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqw/4Eli0nG5osMBUIJSgBSBQi9kdXgUAruDyKaARRE=;
        b=dtDHfvUJ1WFF2sTZDvvFrFtg6D81PCInwoXsetZzb5DpU5b3C46gcNb79o5Bru/Q2e
         t82TkAz8NFOBBK8c4sWkeDrJhq/shnd6ZHBo5stpeKkGZ86evX39vddEBS4WyH3Erskk
         HW3yyKcL6vGKkd8tptIHDEFdMnF6QS6AEXs8XqbgHWgAIRkvgkvHOUzKRJxt9e8VzEBx
         LvwqFoA0NIsM9J1/VyEVYgsblRNp5ES6seqgiDcZ99Zalj+RSMVTVSjGB8mnJ7vWhGby
         S8lNiRDdpGqNLr0GEKLz9Wv8hgOi/6BNMfPkiJRt2jauNJJmnQW3BKcaPTujmSyaDQ5R
         oA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772993396; x=1773598196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iqw/4Eli0nG5osMBUIJSgBSBQi9kdXgUAruDyKaARRE=;
        b=Bjs8yk7wrufc8Pq3obO6wZgrO/EyM6KDuhBh6f/bBcQDSL5r2CC9faKO6FNWLVTnaS
         XE4/Qp/sucxXO98CnBRVvclGAfzLb00M4X674CxZ2evRB+I+wqEUDFoiy7cIVzMNxP5f
         3JJE8fP5eIWDRCpHxn2jzzotOoovE770H78sN1Y7IgjZO/kWlV8YA/H324nSg9Cxq4pz
         EVxD6pkmw0NDU8XhuqCS555JdTnFV6lwLpl0G9Nvo+Ei5wSrwjvlCsKVxLWmHaiMM+vF
         nTQRKz9qWwfXu03VBdag2qnMyxQfXOoBeNyp18cWwhDNgdmWDUf6DnquMiMbJinLZoPG
         M1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9+HZhZshKr5sK5BaqfZxwAo0z4aXmrJMhoHHEf0JNNPdH/CUWfgI2/QL0mwRd01938HEy4bVFLwyQBCuCaSGLtLDgC3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhcheiTRQ77oEFMeQrVqyh5KOd/zgGtlKgIfUnM3kkguup71p
	P6xIfaIfVsBBQbf3UwoZJMOFVoUOG3OcM/ZwHNJOVjJ4RGdOilvtTV1fnP+MHpmoXsk=
X-Gm-Gg: ATEYQzy/sYTzp/CmZRda5p+93KPefCk57Vg23a1fdt7TWuG6We4Rlvg5be4BBXEHM2h
	wvL7ltvECZNG7KMDN1+ioS3NeafZ9EvnyE1JYs0AgBD/4hCv8R5VelftMfW6wQxEkmx8FkFbLjp
	k1CQ6O2UyuFPf9c19pFdDfW7NvCSYSD0A33fehXCgOvusd1s2GGxjVD0t3ZiSWPMNw69fAf8GAy
	y+b1LN4lNhktbR1ZABzVGRJlxha2IDasg51sMDCLVP7N3SunOHeUe2ZvCkygrVYUBgRz7kj1SNY
	B16+EOvzTI0RNbMcGOawExak+J7OCTcP4FfXSKAMk0nBzLHe7Ygn7UMrKs0fiJa9jm6O+YBLDgW
	MoxHNBif5fZpJjwgONPJIC1ULiLbgugXviYAvyCHsi+jDuzPM6vEdP+QWMcT5aM1n4c31hobtgP
	xpQMDzY3uj1QMliMIlHKypwq9+S70eDQL7WnegmuQhnJCcyNmSFK7NkgAQxpqg7TLfWw==
X-Received: by 2002:a05:6214:c2a:b0:89a:1536:2529 with SMTP id 6a1803df08f44-89a30a31b87mr120367666d6.15.1772993395869;
        Sun, 08 Mar 2026 11:09:55 -0700 (PDT)
Received: from Ecomp.localdomain ([163.252.225.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a31719574sm63773696d6.48.2026.03.08.11.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:09:55 -0700 (PDT)
From: Evan Ducas <evan.j.ducas@gmail.com>
To: wufan@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: rdunlap@infradead.org,
	bagasdotme@gmail.com,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Evan Ducas <evan.j.ducas@gmail.com>
Subject: [PATCH v2] docs: security: ipe: fix typos and grammar
Date: Sun,  8 Mar 2026 14:07:34 -0400
Message-ID: <20260308180734.5792-1-evan.j.ducas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several spelling and grammar mistakes in the IPE
documentation.

No functional change.

Signed-off-by: Evan Ducas <evan.j.ducas@gmail.com>
---
 Documentation/security/ipe.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index 4a7d953abcdc..5eb3e6265fbd 100644
--- a/Documentation/security/ipe.rst
+++ b/Documentation/security/ipe.rst
@@ -18,7 +18,7 @@ strong integrity guarantees over both the executable code, and specific
 *data files* on the system, that were critical to its function. These
 specific data files would not be readable unless they passed integrity
 policy. A mandatory access control system would be present, and
-as a result, xattrs would have to be protected. This lead to a selection
+as a result, xattrs would have to be protected. This led to a selection
 of what would provide the integrity claims. At the time, there were two
 main mechanisms considered that could guarantee integrity for the system
 with these requirements:
@@ -195,7 +195,7 @@ of the policy to apply the minute usermode starts. Generally, that storage
 can be handled in one of three ways:
 
   1. The policy file(s) live on disk and the kernel loads the policy prior
-     to an code path that would result in an enforcement decision.
+     to a code path that would result in an enforcement decision.
   2. The policy file(s) are passed by the bootloader to the kernel, who
      parses the policy.
   3. There is a policy file that is compiled into the kernel that is
@@ -235,8 +235,8 @@ Updatable, Rebootless Policy
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 As requirements change over time (vulnerabilities are found in previously
-trusted applications, keys roll, etcetera). Updating a kernel to change the
-meet those security goals is not always a suitable option, as updates are not
+trusted applications, keys roll, etcetera), updating a kernel to meet
+those security goals is not always a suitable option, as updates are not
 always risk-free, and blocking a security update leaves systems vulnerable.
 This means IPE requires a policy that can be completely updated (allowing
 revocations of existing policy) from a source external to the kernel (allowing
@@ -370,7 +370,7 @@ Simplified Policy:
 Finally, IPE's policy is designed for sysadmins, not kernel developers. Instead
 of covering individual LSM hooks (or syscalls), IPE covers operations. This means
 instead of sysadmins needing to know that the syscalls ``mmap``, ``mprotect``,
-``execve``, and ``uselib`` must have rules protecting them, they must simple know
+``execve``, and ``uselib`` must have rules protecting them, they must simply know
 that they want to restrict code execution. This limits the amount of bypasses that
 could occur due to a lack of knowledge of the underlying system; whereas the
 maintainers of IPE, being kernel developers can make the correct choice to determine
-- 
2.43.0

