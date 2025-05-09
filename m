Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061223C8A3
	for <linux-security-module@vger.kernel.org>; Fri,  9 May 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816073; cv=none; b=CRAb0zR9w4CknlY/JwfI/4/ttbSJRXhA7SX6ihNPH8UJ6yy8KhzoUtB43Auv06EOo5csdkhqewQ2cDjtscxkkSPWMhhWvfBAu7LmBvVyJYao3QpYURTygjNX5bFEWHHm7rEFs0xNqVE29SlvApqji1xFBINoy5cYCOtk7FaMP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816073; c=relaxed/simple;
	bh=LgF5BtBmfpeEAq5nMJcPYE0NWNHuMEL3cucPPBu6hWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZyluvkwFPPVnez7ckR0xJIpQmtKY/DAL2brHpXVMwFYYNlnhqTCXiqHPHWBvHLk2jjzKWppu50VSPCh3IGD2D93aGICGbGTfn5KwgC2C9vfCGnzlwhaEUBVYftQB1o95rJVFDawRADQ5x8OSfRjB1MBMBRe+y24I+Dh926Zd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=C6Cf05nh; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C6Cf05nh"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso16090955e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 09 May 2025 11:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746816068; x=1747420868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7xH+8c9IQ/eMw6xixEvFtV7xITokTNj2ogMwiKa5uM=;
        b=C6Cf05nhNCJjbvEsVYuE5aFzTaeikmpl8ajkagMnTkI5oj7x4jZjQC1xMR1FkikHul
         u92mm8Jx4qtLBbDUbYqxx4MK1kjM4kkcvUTiYHBQN/G+jYp7PYJ4gkJ0OgLjqE/TArDE
         vpI9oPB+O5H0+BJsPRAa17z6O3r+Cm6yILTwDbhXpetZdAGInOSlPnO+oxJAlFj9PO4c
         Bgoj4v7EPMNg8oDl29EWUncW3KmI0gJN3iKHmad7JKYo8aeHiXJWKpYmhnp2UbtiSsOU
         MBnd9aNPtKxu03jgoG40f45VK8dZHkPwYccLh4SMco+Xay6A/EF1IIy4lflaMhR+UhEx
         aNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746816068; x=1747420868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7xH+8c9IQ/eMw6xixEvFtV7xITokTNj2ogMwiKa5uM=;
        b=NPOh0nvtxo9z1EQHhPGtHdCq9j1VVDkhH7O+B7X3a/NgRwnBshzdS8fyNAymhsNHDm
         p4YPk4+7t+8k5WNPaWWrft5ctsZqUUNNyX38bP0IjnkqWZYI97cUDXE8GYk1IZ45sc0x
         FbYll7kNJttQQhoWsYV5RsXSIjOVdgUl/Qhg4+EkoHyJx2rG2Mm861jGmmsE1OLBNZ3w
         SZZ2NmVT0M75NIqnYTQa9yWfB9YFYPEh/snrZXSRHhTBgnbqlcobbQT3S1Xz+u3+OH0N
         KA/ma4X4cfhXLNZ3tO6aNqq7RgnDMYL2eIsQQc8ge5uBeDhAikQqlqL9WX3ban9xnYrU
         rm6g==
X-Forwarded-Encrypted: i=1; AJvYcCUTeg8NdmvY0dR8cUcuhxiZGtu810fexTNWsmGWmn8eYH8//GkBbvksat8iU5KwMsJlFpD0kUK2Cegq0STP8ClHqkeJXK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFeXDcf0erJ7qjhrKwEFCfbKIksxd8cuGEh7j/zLU4P5hK/KKy
	3EdCjiYWiQI+RVk/HP2/th3IOEK8MqVoT8zTffJFlL2zcz6XD1NX8lXHRLuiPmLjsjp96+CoJbU
	f5PjcQg==
X-Gm-Gg: ASbGncuoLh9whXyhr/iM/FiCOSpYR+2wc/0OvyUPuqkCobukGlhvy/kHJtm5536RUjC
	6PcAV0vvfQsU2t/oVW45cnNZhYSv2HV85PdKADpfi+/eNd4nv14Yq6Xd+R5qWjsVtLvyaqArvIO
	BiJBMlpaznbrvf5xlMiKZCy9rXnxNZWK1dKJ//VDYlSMyGmGv0tLhgFk78Kmmi1Sa9JBMifHxaX
	d1Xmngx9dJjyctgDwr0SYIFDhqGpCShccnLLIQwaJAIZCyl5yrapOgBJzvLv7RU3e4CijxgCbqD
	u2mRdUfUxhcN7d4xsvTbHfykaATxPDwjphVARe7kOygOazHq81bw0KczWasHyv0jMzWeB0P1By+
	VmyD2KCiTJo9QBNWX2c63o6JiD80PSfC/0EFBjzYx7nDmcegiGPliEVSQFciQEw==
X-Google-Smtp-Source: AGHT+IEzxzujGMd8NyxttjwFQjGc0xzB3QFdRjoydO8AuIWtcO29Kaq/G1I0ZFKFFTLzQq0b8NjSHA==
X-Received: by 2002:a05:600c:3b85:b0:43b:c5a3:2e1a with SMTP id 5b1f17b1804b1-442d6d11fdemr38097465e9.2.1746816067774;
        Fri, 09 May 2025 11:41:07 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67df5ecsm37756915e9.9.2025.05.09.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 11:41:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: ebiederm@xmission.com,
	serge@hallyn.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] Documentation/no_new_privs.rst: document dropping effective ids
Date: Fri,  9 May 2025 20:41:05 +0200
Message-ID: <20250509184105.840928-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <87h61t7siv.fsf@email.froward.int.ebiederm.org>
References: <87h61t7siv.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usually, execve() preserves the effective ids.  Many programs rely on
this to detect setuid/setgid execution and will disable certain
features (such as rejecting certain user input / environment
variables).

However, if NO_NEW_PRIVS is set, effective ids are always reset by
cap_bprm_creds_from_file(), but capabilities are not revoked.  That
means the process looks like it's not setuid/setgid, but has full
capabilities, and is effectively a superuser process.  This breaks
userspace assumptions.

It was argued [1] that this surprising behavior must not change
because programs might rely on it:

Of course, this leaves many programs vulnerable, but if we decide the
behavior must remain, we should at least document it with a warning.

[1] https://lore.kernel.org/lkml/87h61t7siv.fsf@email.froward.int.ebiederm.org/

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 Documentation/userspace-api/no_new_privs.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/userspace-api/no_new_privs.rst b/Documentation/userspace-api/no_new_privs.rst
index d060ea217ea1..89b0884991e9 100644
--- a/Documentation/userspace-api/no_new_privs.rst
+++ b/Documentation/userspace-api/no_new_privs.rst
@@ -29,6 +29,12 @@ bits will no longer change the uid or gid; file capabilities will not
 add to the permitted set, and LSMs will not relax constraints after
 execve.
 
+A successful execve call with ``no_new_privs`` will reset the
+effective uid/gid to the real uid/gid, but does not drop capabilities.
+This means that comparing effective and real ids is not a valid method
+to detect setuid/setgid execution; the proper way to do that is
+getauxval(AT_SECURE).
+
 To set ``no_new_privs``, use::
 
     prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-- 
2.47.2

