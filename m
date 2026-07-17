Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891AB3DB32A
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325817; cv=none; b=Q0Z+Z/bAUOwL4+AL6iS5+aEBgmHrqWSmpr7Zx2f64FQT/ib0Cysm+vGXArKlGyWKWPX6Dp50ZXV3mT7swvPRgwvzcuMYmisUL28ruNl7iAKa/qAr++oe59Y+dvZ8JMUdp5ZbAla0FJP2KPtIkfR/AXAlq3y7t3d+eIRZDKKKWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325817; c=relaxed/simple;
	bh=3poomQvjnpiX7997GNYVbUJUsBdzosz9y/dadMphQQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhfnGovHDjTB0muh1cNRKjOE/38uxE5bwgRGsT4DR4g5MgEnMW256fwMvtQy//vUzoTqg/hk0WjnEo50acadWf4Gv07H8ii2bYvbHuNAmRbBxH/U8Y/rdm5S0NDr6BVB3XILMYSpvBPL6AwE87fsQUj54VikQNYMVdBc6dCea8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVx/MtE2; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVx/MtE2"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81e6f0b4610so87941877b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784325814; x=1784930614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BotXlHoC1KXrTMIu+7NHh3EH2wogMGqSsV6pAxUtFzQ=;
        b=HVx/MtE25U9X189aYcv5jTdse8mjs3Uz3YbACwtNP9btF6bvtaWuhSWmr9BxzgapTV
         uwcadxtnCxcqufQpQ+EhnVEneB75WzS9lkWCfeB/7m5LeNPsKMOoX5PlRkaBYILTnSlL
         +sfJdEKRj5ii1jB9N721EWVop56hbn0fyrq/Skk3t0x28H1uQMvXs7RLmxH1Z2+j3z+4
         P1UctmWW+IghtrL8aH36xtG1+WwrGDOtWkNP5G/Ja8C1BPckO7MrT0tSyZfPEe3VXdyR
         pL3O1IP/I+nGPT9y5NEYlBUqh4W0x2nVUdSCSEAs4SqXDYTCXI6e2ufMJUsfHHBN1ZQp
         FOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325814; x=1784930614;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BotXlHoC1KXrTMIu+7NHh3EH2wogMGqSsV6pAxUtFzQ=;
        b=Vo93BMcDeWSOrAZlNSVpqP1XIF5OsQQVto4fUYn1K306LqSZGwe2zIEsm6DAIl8hYE
         VxOpTL7efdsSI/KoXia3al+EYY73B3UuNe+6Z4AUkrAQ6fNP8XsUAefFXwin/m3/N1Y9
         V7qkfi+j7PtYnCarWF1YLWglzSwsCWLVRUfA7X3ARBUtrwK6b38tMMY4jdx3+Ma/5BsI
         AkcM5x6qoRFC/1ig1e1CgMWkzF3ICDUCUUR+kjLhh81UfOSRpOzFqh1c4XUsKXGwebck
         dxqVcA2hXv0bCTnRS09PmXmBiZSDvqymo3i5HAt67b9wgM7T3CW+wV5qlRKtpOCw2uQQ
         tWNA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6illtRA1u5IXZFd4dtzAFueJslF3+EtK7OgZeg3k8VLE+PzVSWN0ggA3E6PLujbJ/vpHllEJu69pAWeAagpQxyMQ010o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhNCtrMOehfeI2IEY8wR71jr/guFARMqM/aGq2a6Rpyhc+MeQ
	r3e5BMnFZr98GRkq97ZVojXmfSOuBzOSpQKRAaGuYOjxIM34fsf+92tR
X-Gm-Gg: AfdE7cnypt99GsthrmG9vyJTgWFswOcdljsfLQtv8jQKcZTGQq8HI9OM0/lLv48rWQZ
	ut3BRXR2D9iDkDL0aMDp7uoFS9pHGVpkul6Daa73mhyrT9YvX8irx7S9gw8jo93fcj8AiVQZnDW
	G90TxfMN644TcjAal0GID+mJmsHLq9gx2hm7LiVWdeHhHbCpUVZ9QnW98BWHDUDTnEc9f/V9dSy
	+EkMkMw7gVCRvJfypha3A8IpJEFHasPudDzzCwoQM5i5uVwfL0Ic9gnvGHSlWFlVi21WN7/3UjZ
	zjdNR/ZQZR77NE2IRLjrLiT5XD63tgYwvoLJYCF+WzIAxJavgYnj81rLhOfddA7dD9pvmHwJ1al
	GRYtfFuBAXci5vyI26O+Xr5IAYTTjlA5Z7Qa6v0i+zpUSzHuR8jP2qgm6t3XfQRP7kCvBCvykFv
	VBUM9GFTlteb/ygMtRu0UlS5Cj77+QL+vC3gw=
X-Received: by 2002:a05:690c:690b:b0:81e:ad1:8e5b with SMTP id 00721157ae682-81ef26a5cefmr15353267b3.33.1784325814348;
        Fri, 17 Jul 2026 15:03:34 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:ee56:9b10:53f4:188])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef401728asm20572037b3.9.2026.07.17.15.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:03:33 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 3/3] landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Fri, 17 Jul 2026 18:03:19 -0400
Message-ID: <20260717220320.1030123-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717220320.1030123-1-utilityemal77@gmail.com>
References: <20260717220320.1030123-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document atomically setting no_new_privs with ruleset enforcement,
following the same compatibility section style as previous ABI
additions.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 5a63d4476c1c..ec87d35f4715 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: June 2026
+:Date: July 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -789,6 +789,18 @@ when at least one sys_landlock_add_rule() call is made for it with the
 ``LANDLOCK_ADD_RULE_QUIET`` flag, additional add-rule calls for the same
 object without this flag do not clear it.
 
+Atomic no_new_privs (ABI < 11)
+------------------------------
+
+Starting with the Landlock ABI version 11, sys_landlock_restrict_self()
+accepts the ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` flag, which sets the
+no_new_privs attribute of the calling thread atomically with the enforcement
+of the ruleset: no_new_privs is set if and only if the call succeeds.  This
+removes the need for a prior :manpage:`prctl(2)` ``PR_SET_NO_NEW_PRIVS``
+call, and with it the ``CAP_SYS_ADMIN`` requirement.  When combined with
+``LANDLOCK_RESTRICT_SELF_TSYNC``, no_new_privs is set on all threads of the
+process.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.54.0

