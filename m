Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14E15A86D
	for <linux-security-module@vger.kernel.org>; Sun,  8 Mar 2026 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772939947; cv=none; b=LdSlduGoEflacsRI5ACxFmJRsB5ZvstBKNhFseUPpqyMMHdof6/CoxjcYvByybB2XaPlpzJ/m3hcQAuhZQFmcSFqMk6ahOTKqqrBG5XCr0UeScr7LNB6E/Ukvrih2dbSoaDOk6GJ9tYzRifhB73s20rDvMGF25JrGq06sXoPyHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772939947; c=relaxed/simple;
	bh=dy/k8Ld8lreAZZpwnSwCEzMD/M4mnZXel/sJ/te+YEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSFFKychKTP0utAk2jRJ+omDMKdMjsArwEMouy1/lVxyt1BEdkM5NwGn5d/opis7uo/t4nHyZFEE7hrCUctp3Ae+M6f5XnLi4SzY8k2n5oxUHgTA7RNAWmzJ83HqiLfYLABKFqT20gIquCGsruZPcd3yvy4ZXf9PaVoXS9XahZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVNlos+5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVNlos+5"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899d6b7b073so114477126d6.2
        for <linux-security-module@vger.kernel.org>; Sat, 07 Mar 2026 19:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772939945; x=1773544745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/5PPTP1bytZy0bNsMCBbdG+U9hPc2DiZHiMu5MgnVGQ=;
        b=GVNlos+5TSYZQRR8TNnt+Q3TmNtfjaw2icEcv5T6aQOcNq/GD4aR/i6ZYvkgsQFHln
         PbvykDXNovS6KMGt6pfzRjYJu67MmVR7MLcWM4dW6fb3Qn68AqcaxJItdXr28k0EZ69w
         EqvlgsCh02mqaiA36iSqiIPxxmnqvxb8VzDm19zw0w+Qfhh6SGm9XhEPZWDRfy+EWGpL
         xdG3JZ4cemxOod04rPEj3VoED+vGzAsbZz10Wl2oO+drTkDiird9AZN8XvtQQuqQRzsW
         0lQaXh8x+7OrFhcI9SN6ncWsCn3aIWasuV2rGNBCWTeHGMIrIJMY3F/KbqzzEsTsyJOF
         EZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772939945; x=1773544745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5PPTP1bytZy0bNsMCBbdG+U9hPc2DiZHiMu5MgnVGQ=;
        b=eD0n8qbylXR0yvl62k/b+xzddxrhYUPHXct2YSKNdqX/JZ9XunT88sgJkiSq3aZgI5
         NjqJ3DJoxzmbgZWuqMSvWBXcpdbl5i66MbN4akAVxHgEs+ft0SYEBWWPoJE3VteRZnsG
         Ps3nWxyWubhskFgHdYsrSevZ1YgVqfugZrc6rizyf9DvFcRbeJqYF48UNYweJC9jX/xZ
         /KFhiiyntxEY9RrGXlpwu+F+tqFn6t1w9xP/5XT1n4ndxAT8HI3QopmDrKGDtXDjA8QD
         dKTGDO2dZB5+Na3HkXSsoFDCCwZRt9ritObOwEkg3UncezDdeSUH8KGjCU1A1t9nXxmj
         8T1g==
X-Gm-Message-State: AOJu0YzgyXWui5AnIL4uyrsCPgMd3+HrrLfpiNyioig/BIdfuk8oGCsH
	dLF+SU3AFIaUQFDi0zuFhaIzXUi4wEZ/7D+UVTMIWaVws7CDg9fwUZta
X-Gm-Gg: ATEYQzwckjeNrBrhzUHTzia5/9JDuSCt1rlC5zZWUi1VxgqYvjcPstrD7YBEIkoBgP9
	NARxJM5JxDQzQwOvGhUuT49CAY+xvQwSmqYf/kg0I95YCsF5izefkzQLmw43JdGlYlSgcuhUzDD
	sWRH03qe09dT29Peg8yEYpvG31E8aRJEOGflJQ2ZoVZXM5BXJ3Bx7vNqJ7rFdIfJpSpU1ARrGFx
	a58nXD/4vUq2TxVCGWDLTWvWcrBUUiy53JKOJMufAYA6ZNpiKi7NOqIU7vzXlQeqEGjqXofa9rM
	uxU21WZymfn9MGKul9VUN7ESDWeWykU6EEd/vO1zDNR5km//4++iWHQZtr+Nq77txdsVODUFXF3
	UHnKYyoyc2u3kdi7o0QoBM8mlpya0ELyU+pthBMHKweLQIo62fuXIs2Xcz1k+oxWsDBrk0DBVSX
	iruPtB9eUqe2aiy7FsqHmOBPXQLVH3fPXkS7wCEgSYf25x4LEhAsQqTaaVfI3x1ECKNw7kp0kq1
	Ssz
X-Received: by 2002:a05:622a:1914:b0:4f1:e9da:e876 with SMTP id d75a77b69052e-508f499ef56mr92284771cf.62.1772939944685;
        Sat, 07 Mar 2026 19:19:04 -0800 (PST)
Received: from Ecomp.localdomain ([163.252.225.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508fd453ff3sm31481581cf.17.2026.03.07.19.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 19:19:04 -0800 (PST)
From: Evan Ducas <evan.j.ducas@gmail.com>
To: wufan@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Evan Ducas <evan.j.ducas@gmail.com>
Subject: [PATCH] docs: security: ipe: fix typos and grammar
Date: Sat,  7 Mar 2026 22:16:33 -0500
Message-ID: <20260308031633.28890-1-evan.j.ducas@gmail.com>
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
 Documentation/security/ipe.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index 4a7d953abcdc..d29824d7fd2d 100644
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
@@ -235,7 +235,7 @@ Updatable, Rebootless Policy
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 As requirements change over time (vulnerabilities are found in previously
-trusted applications, keys roll, etcetera). Updating a kernel to change the
+trusted applications, keys roll, etcetera). Updating a kernel to change to
 meet those security goals is not always a suitable option, as updates are not
 always risk-free, and blocking a security update leaves systems vulnerable.
 This means IPE requires a policy that can be completely updated (allowing
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

