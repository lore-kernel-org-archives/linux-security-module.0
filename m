Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15213BED2C
	for <linux-security-module@vger.kernel.org>; Thu,  5 Mar 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723727; cv=none; b=sLqUZrPPJfPXjmBNj8CQxn3KMTIdHdxrOXeVTnzuW8oO4S4RRIULs8f4qe4YgE4X5fKNOaAjo3MKMiZP1QJu0Y8c0ionkmcAp+WD2oxD8Hn4JvDwvUKMDZlsxQ+WqOwNgEscnye6CMNFKdPI/le5kPP4UXJ4jzCv/9Sj9EJPElw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723727; c=relaxed/simple;
	bh=meSuvHU5VgYyQ6+0rfWSzMRfNWXJkQjM+eYMNcqKoOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWt36y02CE29q8S8ljNO9QIcmYH4ENPbf0R6PyMGoynmVbhJaoi413Kh1H/ziqG+23g5hHBt4mKxQ8ULkrnmsPZaNwu1T5ey3k49zf01Qbe1owi5phnyeBBR81GUqqCllwrjKq7Su/qJAz8HsSZINX7BmIWISduJsu7Fc39hDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf6ZqYj/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf6ZqYj/"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79898953985so40679677b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2026 07:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772723725; x=1773328525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ufc85M4NN7/rM7t2+qayj7cI6+eXovKQmBlSGxXUsiY=;
        b=Uf6ZqYj/cymZJA6g/SjorIvdXl3c2Lvs3RCeX5CdzW2ZbUC6XUDDrTv9BnFsSZMOcL
         NCL/+6BMvvqrrHkEJYDwQFFGfyQMYjLvXzUo9bVwfiiAh30gZ5syN3N7il57DEV+49AT
         RouTqfFdZhHqRNw8LleZ1BqctehUmstBrhpnHA513TBx0NOoVSzRdNe4BTVIBEO83B/f
         2zPq7PxTQXO7QXAEVl2UZ2JSh8KrAlJDzTUg0Q1dshJpb/K9WHfJkbvMAWxhc7EqR+pP
         r/cUTmOBus4SLGyyUOW0vjpndr5Zi1ggUZLGqUailc0adLCOGwMpuu893S3KMt1n34jr
         eDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772723725; x=1773328525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ufc85M4NN7/rM7t2+qayj7cI6+eXovKQmBlSGxXUsiY=;
        b=XwWYHig4/Hb4OOfLk8L0Ouf/tWALBW+U8L+gw/aoW3EANg/+ggZwPrWlvRhHTFZznV
         y1O7UiUHRoS+Nlim9xcmLjLKs37LYWmBUPguD3rj2VH8IrAXG1JpoCIljKFu7jnMA9XM
         lv3BFQAC5A7SvrHV/NrYF6U3NGkF/ZCc18NHl3S3kN3earGt0Qnjmvg/goijNti+dfa4
         gBTnR23aP3Xuqvmu2NHiht1oxoosR4nDRsPcwlTS2UaolBfEB87wApYvIwEcfB/c5uLe
         EFQ1kNA4x7RlmqJZhbVEb2YK3ZeQntsZvtUGB3Hyuleze9MDLsGkJBKClpcBKAdcjZis
         tydw==
X-Gm-Message-State: AOJu0Ywel6hXhoYbROwVfL537XC7WpRkK20R7040aO4wPx1PSNP1RUEx
	+cLGCKERPJAtuHRAMQfylfrNrLM864Ct+2UXQrYvSD7JewpetJzg0m6nhIuyLQ==
X-Gm-Gg: ATEYQzyKEg/htfLp7oZwQ1B87OPELAFc85fadpGchFXkXb7bpJqzFtk4+WooWI7sFw3
	WqWrYfVeBbF7CSSSodySrLdUNZKbQl48dKv0PbexI1HSL53VphyPzoNzMpODxoSLQ3uDGrylSl6
	pr6/njr9wBAa2srgbFTWlJD+/vXcuSqaZ2+lU8woJ+T+OFK81jcbqSYfVxD00P6g8Q9hb3+C6Yd
	bvORaK32Da7KpmQ+WNhqGruhQ+NNuK/G0FRjgOoHnmt4c6DBPz7Nm1F1SnkD2efTGsKFp1h7dYT
	l2CqSm9DXdJAjcIGFBu2d1tDyXpscGsArGyjPVTajGLRnIlax52WqNC5e0dtHarKFw9AOxrz0/s
	GskE/62uI5opdrizhZd/WA5LtnSOP5lFId761YUi1pYp7Um7alJ3QqSbVrOwdpUFCB6oq720fEL
	svmfRpGq2qXgwbqN8rJHkya8JLtvhtCro=
X-Received: by 2002:a05:690c:60c6:b0:796:4f04:bbc3 with SMTP id 00721157ae682-798da4cee76mr1309757b3.35.1772723724497;
        Thu, 05 Mar 2026 07:15:24 -0800 (PST)
Received: from zenbox ([71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cf585d540sm2410672d50.3.2026.03.05.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:15:24 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH] landlock: Clarify LANDLOCK_RULE_PATH_BENEATH properties in documentation
Date: Thu,  5 Mar 2026 10:15:07 -0500
Message-ID: <20260305151507.2563776-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add paragraph to Landlock userspace documentation clarifying the strictly
cumulative property of access rights with respect to the file hierarchy.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 13134bccdd39..d02036bb2893 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -173,6 +173,17 @@ this file descriptor.
         return 1;
     }
 
+The effective access rights for a path are the union of the access rights on
+the path and all its parents.  For instance, in this example, ``/usr/bin/grep``
+inherits rights granted on ``/usr``, in addition to any rights we choose to
+grant on ``/usr/bin`` and ``/usr/bin/grep``.  Because
+``LANDLOCK_RULE_PATH_BENEATH`` rights are cumulative, they can only increase
+down the file hierarchy. Therefore, child paths cannot have fewer effective
+access rights than their parents. This cumulative behavior is a key property of
+``LANDLOCK_RULE_PATH_BENEATH`` and requires careful ruleset design to minimize
+granted accesses.  Please see the :ref:`Good practices` section for more
+details.
+
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
 ABI version.  In this example, this is not required because all of the requested

base-commit: f300a1c3a8ae4abca60913b4d26c405a905e4702
prerequisite-patch-id: 2b17c4f0b741a703f61294989a53677de0b1a54d
-- 
2.51.0

