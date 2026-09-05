Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65351398915
	for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2026 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619065; cv=none; b=s+k3+9rNVIxiZK2ByrZ8cUjf1U2Mxu88EIQFAwb/AeMLBSalWmMkemgyxI6LkP4ibq/kGxHNn0kSHE/FNK8jy6BJIke6kZM6jIGcM6vehCV2ZRjxpu2EgLbZPqBhKUQYCaxtGeUjlM04YDnRYpJlxaHE5KCL310zpj/AVcoltSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619065; c=relaxed/simple;
	bh=ysevVIWJ5TtntjDXiekqdlkXzHSTlLCPSnJtv8zueuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMOjWwesC6v8tSQYXSBcE1cRkAn7mJEW1X7wXWGurJ/fDlW0yd1xDI5uiJdlYCru4IavcBnGgus0AGF8ZGB2QvHNZWM973qQw+h9O001Zja99xZKuTTseBHzxZf14XpI8rwWzTicEz9bFj/Qz+q1LSmQ5QB/HcfeeeTUbT4BqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDUdNFr3; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDUdNFr3"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c7c57e637eso910929e0c.2
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2026 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788619063; x=1789223863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ysevVIWJ5TtntjDXiekqdlkXzHSTlLCPSnJtv8zueuU=;
        b=tDUdNFr3V0K4/yIuRF5DH2iYLzo4cGsw1Y1EeTA16NZULeqbxDsUKl5AfG8CmxrLH6
         2/k2RbG6bC28yn4wJC04aTqXXxiGbK8fkFNR5MXE9b/XJDJZ/QHZzuHxA4Bu825F/5Zl
         euFN6Bf/yKMJC6fHG4RvbhxfeGFS7Z6jAk2enrVb6Caj09VcvRQ58B41W+lPBUHOlzrc
         Q+gDFQouF99rwdnlWXyTHz+6s6XFrbarVNBGACKrFvsLFiW1UBhypQ44FcqSYR1P2GeS
         Ln9nF2fS4FKRxodQAGbtEy5mdFxYMreBY2zZtJOz6qmPa0T16kbLMg5BF5Gf6hy5kn3K
         4zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788619063; x=1789223863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ysevVIWJ5TtntjDXiekqdlkXzHSTlLCPSnJtv8zueuU=;
        b=ZaSDjP84I1VCXsR9qe837EggtF76A5x/tZfoYHvCcArZ6aj9TOptuTMFrS7CVTgXP7
         DK2FWktJwHIF3ELxp1W60S6VM/AsmEeeBwVHi2Iia6KjsC+YTZ8s7H2W0WNRLHTsfdcV
         OiDf+yoTpz1QbySt+h1LCoDe1sYWImpUyYJ/2rcdSU0K0Ebs6kfMRi0R9v6MuEXuYoWH
         SEknFPeJOfO/rJRrPdTWVbbLaDXCuXcFEVc05zPDRuqSwtGUb1KYvkk+diibgnqNytyO
         n0ML31yunFbbk1i89/7g8wmkXEekhMXbkkztSKVjuALWrSPYiiq+O5e6Pm6vcmlSDl7F
         dEdA==
X-Forwarded-Encrypted: i=1; AKwUvBxo/Kixh7gnlM9Ojhvb3Q/RfXIFR+m6DhsCg0J9h6GBAMz7OBmec3uCVW9WkTEZ3AfpjYUX1uVYDgUhutgvMWTxOt3lZaY=@vger.kernel.org
X-Gm-Message-State: AFuF++k8LDjEzfohqKCh+NjFIGhxz89TAUjfVLjLBF8xNhzXQlSceIkk
	hrsMSofJ85+KuAMxm4Ccqax8Zf0s/3UBxclw1RTzX5Ha48J4yh6ne8zk
X-Gm-Gg: AYBFou3PH64lPGYTNGVUIIfZ2U1dtHwSxMIlenqjiiPI4Mv+YI6M5orD3djowNriUhC
	C7yI/ymoFFoI1oYcy5h/l4ONySdT68R6hAdHgZwtyFX8qPFa+ylg++IEz0yIoLXSAi5+TbvMqC9
	uh2J/LUJsq88u74BWfE9EpAMAmOqU8sWfVLU9fJPpBOTJMfGNDCcBYlCZIT4O81nOKYaWIR0uJE
	gTPKaSMVtG80LuPh2BXTsfx0laW4GLrwrkFaWR+p0Agg2woqVDAqEHMas83F0ZoSfuV4nlg8Fc5
	XM0fmxzonYMGF8nWFhDDEXrwBjDYAPmxjzXbUfmZDMZSyFraOOswAKpUGu4x05nEDh8mjuxLauw
	wZTwdWPL852aOI6Lb11Op3PTjwGh6JC4/DNvzrpGy+ltm07GpRatUgPBESeKsEOeWrj21TkdUBS
	stsvqHDnksfCjgwBfil7mAe3a3Y4ON3TNaT/MrrUECht2oYUHU9XQqgXyhSUtB4Tj3FHMA0oNeS
	Ps/eVwqHKCXIgcwwN9CPiGDpDtT+n74pw==
X-Received: by 2002:a05:6122:1d50:b0:5c6:81c2:5496 with SMTP id 71dfb90a1353d-5c7ed7a8eaamr4533368e0c.4.1788619063063;
        Sat, 05 Sep 2026 07:37:43 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ecac1033sm4248210e0c.18.2026.09.05.07.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:37:41 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-media@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Request to withdraw all current and past patch submissions
Date: Sat,  5 Sep 2026 11:37:37 -0300
Message-ID: <20260905143737.25125-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Please discard all patch series and submissions associated with my name, including all past contributions and current ones. I would like to completely withdraw my contributions at this time.

All the patches created by me contain many errors due to my lack of thorough review. I am very sorry for this kind of behavior and for any inconvenience caused to the maintainers and the community. I tend to overlook these verification steps, but I promise that in the future I will review everything properly and correctly before any submission.

Thank you very much for your time, patience, and understanding.

Best regards,
Breno Rodrigues Alves
