Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302AA1DF739
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386660; cv=none; b=csds02P/6lp0wAanMuYGPi0rviHJmnhlQpGkU2uflQFr1xw/ZzqsAWk4Kdsk+AgF5UnobNgpKJQUYmcZ+XAZz522ZHe3krSsVU+kMQPvu1E8/PDPcGZF2twMz2GW9CkWMxXpEAWnmxbySuE7dNkVt7UEc90MW8Yrwz15tC7BdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386660; c=relaxed/simple;
	bh=xxZBrAr7xuLxFWpQoPvGCikqZd+FmR7ItSb67tOws3I=;
	h=Date:Message-ID:From:To:Cc:Subject; b=izlVEEnyJ8mEQJqCSwvkseQC6HweNEqH7jR230LWtNs9JX+Viw2dfiCePvzXQKs1+KXmsz6uR8dMjCGDVKv3fwbqzQDJa9gOvTRCSfjp2cfLibsuz1gwcIq/4+Z2pDcbPXPkZhnj6h89r7vfjsHpa9zO7G5VbrT3RiQBWTae/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y74NfYzn; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y74NfYzn"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c59e7039eeso512779285a.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 15:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748386657; x=1748991457; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvY+J8VouKuyfHSeDGrMrPhRulPXXQ9kF4LDLPXFzhQ=;
        b=Y74NfYzn84JiXU47ZqJuV6/n+U8ikoo9NBnig9ooHR8YTM00wuotHIXmPGwHN+uoxB
         /mVtR7Ob8jUQAKWz7fMmeDZY4iFvmPX8/4pX0Vj/4FGssv97fjwbgMWUUwxI1agAgI6V
         iTSKbWSUjq5bKKDYlOKI1THYfLIprh3xdxO5zm4ls3VY0Fe8wseZK4satzgm1bkiOnsU
         eyljXYoNUitgxydAwNViNWfVSZrp3zLkwAouAYt+vVujfHL37V4ipH6UiIwUxrT7WxJs
         JyBiguV+exKGFUHdjCvGAb/El5rz69pr7JaDQEuL7/vfRiP7/QbCSFk+gTB3k9VhcAjy
         4G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386657; x=1748991457;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvY+J8VouKuyfHSeDGrMrPhRulPXXQ9kF4LDLPXFzhQ=;
        b=dh8eFFc+ABFui6MNZKlQWb++RMet8k8aIO04U/qFa+sptwlg+XXVUfcOEHOmcrykwJ
         pC6HodMt8zj+nlC4Jziwatwo5Y5I4AjQLlJQheb3x36VjwRMmAG/e+vr2bwkCdYo2+Ga
         4U2AH8L/LLIJiOx4jrWs0uzhVgoXa3NnvXV2IOmWSq0EUJ91lB06CE78oZD2IiTOFu10
         hGH2FBy5XRJjFlDSUT07BFP/voz2FsGpL6xnyO5VCMA0mOQ5XscvfpFtgo/ZDlOcwAJL
         kQm1rmO+URbCi45Ozq0H9hNXYUxTgrWvEUabZjXszR9F0BE1tKqo156B5z7x3bLGUehX
         26BQ==
X-Gm-Message-State: AOJu0Yz2lA19t53FrCUvemOU49RsLDV08lnqwL8pU8jEDcFXoa6atPIr
	I51QwMJ/wH3e8rsoMXnWPafFR/PQMx8QtHiQyH+F/Fh9/W+SJa1tFDhuL3M3cOQl8g==
X-Gm-Gg: ASbGnctIx7cIlg2fouMj5ryypxCqo2WxFNHCubIIWbtnHigfQXznifMJN4duTEk5LFE
	tPjKK97XiZ+heVbxw1tZNEAqWw8SlixXEnXn1G9jUKgS/nuH5yPYgpbv3Qs3gb78bNyu8tL3c34
	F1g9CiWxweeF929U2GYerB3cwHRPot+bC8FsStDmm85dZlqphTKyZBCP0rqc1FZL9BUQ2u2CR/J
	eV/VVuXWvwv8MGjcvESH6IPqYMNnVShTEphx/18TixEhd0xtndsKbKRf8J72uWK4CP8nmSf+OiQ
	ozwKTVAj70NQsyz6dU7MvNlnav66DFh5SHwGJ/Yhn6q5P8+spDyfZrsiyt+AZmZ03/ej09Amj+l
	0gbEgUJ1DNRktfSyy6VOK
X-Google-Smtp-Source: AGHT+IHef+JzAiRFgd4pUHXsZSWyWRQzXidOWBXH1Bdf+wI/wJpe39G5qNeUjzYpkwEeDloHQNMO8w==
X-Received: by 2002:a05:620a:2544:b0:7ca:f039:7365 with SMTP id af79cd13be357-7ceecbbea5dmr2632357085a.8.1748386657020;
        Tue, 27 May 2025 15:57:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cf19d9785esm15817585a.99.2025.05.27.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 15:57:36 -0700 (PDT)
Date: Tue, 27 May 2025 18:57:36 -0400
Message-ID: <c033219926c0701369d6477cedda170b@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20250527
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

One minor LSM framework patch to move the selinux_netlink_send() hook
under the CONFIG_SECURITY_NETWORK Kconfig knob.

Paul

--
The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20250527

for you to fetch changes up to 74e5b13a1b0f10c5a5c6168f6915620a1d369fae:

  lsm: Move security_netlink_send to under CONFIG_SECURITY_NETWORK
    (2025-04-22 15:34:58 -0400)

----------------------------------------------------------------
lsm-pr-20250527
----------------------------------------------------------------

Song Liu (1):
      lsm: Move security_netlink_send to under CONFIG_SECURITY_NETWORK

 include/linux/security.h |   12 ++++++------
 security/security.c      |   36 ++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 24 deletions(-)

--
paul-moore.com
