Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123341;
	b=xoTiwFMyfti5PkEAoYZntIy5DJGzIHv0CrTcq3I9ima0TWgDf3nw5qE4DmPE4NDTmzOC
	 1MPE+omCSgeL+cyzIR60wj2bDNYpspM4queMOzMfZxlFbsULba6Pry5u82K+HBcDZcBML
	 k9CbqIfD3cTFEz59TLL369uXNl1/pwgDfpBNcA3WtJIFow1xnh9+53ax7rossQxgDZvNE
	 7ZB78m5YXw0vzHQuCVxUvEuCFd+sWkx9zr6cG30Jvj9XtFLPquB5VSpYug4kUQDuShtpx
	 F1O6S/W6VS0l3qekw024tfhRKXJ8RqvX2/jDLFyUoRvetu/UZrobr82V2nZpJrps6Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject;
	bh=qcjEcSxMerUyIcJCb5LoXrpksSMmt9uIaMrH55NR/bc=;
	b=wlNrMS/kVkddo+Q0P7N/iogHwGr6EknnmmoZ69Io4DrSFjhjSh1/eug1s8olw0O1kZoM
	 FLjfVC7f3dmw0Q302x8TytRLG2bnuBzrVW2SJFmXOkIDM45rigxnEnwHrYc72v+WpJKM9
	 QKKW8sxX9zqMymG+CSTOhQ9z04LZx4lnaJb3bxXPeja57SRFthFsmYMh3O8BTv0X+7MR+
	 dE35/hflGtMzbHa9yhGlJUMI/798mCf6U4N3EYzog+Dem8ZsVnAxpOqT2FKY7NdhgvfbW
	 kbkD2njtCGjm8MrcagCy6M7JG0jXBmbDgWvNu3Y2qsvsNunW4/82S6okR9G7/BpzOlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=b4kyZD6Q;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5D606A320
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 21:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C5D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=b4kyZD6Q
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9496400270fso21382585a.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795123339; x=1795728139; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qcjEcSxMerUyIcJCb5LoXrpksSMmt9uIaMrH55NR/bc=;
        b=b4kyZD6QXm+GEEGwq7TKClxnDVyHew5vDgtJgHBG8EG2okFDdAH4+rLSZVU+CLaD27
         o41y0HI1+10Tu+/uX0munx6pDHmyNXMuU6pm9SGYPVGwUwx2fb4wXToFvXHOtZq0A8Fk
         SP1GtOx/ty2rXiaapHazDej2BF5Va1HQ5szRrQHS/IEB4oRVLnUKKNLbZEjHpj6NJ74D
         DxAcyJmGCCCbf1Zddy8R9pc0U/RH5x2Tcdyb/c0uyv/yLHAhHCGr3JmSM0snMIgsZjXv
         pPGZcRIGfXTTXb7GbMJgnft3SYyL7hVt6RS7H8CgK3fTS/WSANLNtm8c0B64tfnvIGS1
         cNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795123339; x=1795728139;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qcjEcSxMerUyIcJCb5LoXrpksSMmt9uIaMrH55NR/bc=;
        b=026k70+zx6e7IRnWgGLj+4U3GA59JohDB6w3yulfa5d14hNqs1guJ/Wt4xojy5MqLp
         wrEd/N/tF9+14rJfBrL2nXxANr4sov3RdzkeggE0LVAYpF4J2CPQNpR1ccQZVw4OsLtU
         wWUSFgPZP9ju9j8vrppTlzOvN4l4x310Y0c8eJG83ucHOpPLp2drZpBubPEAI4OCW69g
         PIAgCL7FXUPxN7rW7GVUIusaVNCp4SsosqT3yyaSAUy3LiZ3NGJUjOLNnP49pULs2Mh0
         iAvlrhlV6h3TtpKZcw+hxofMnf8quf4Mu/VT/HCFgUhizNraptaJmsK7eUcy47cZMPLW
         dffg==
X-Forwarded-Encrypted: i=1; AL+hErGC0cvje+4d3Y5QAe1NCcv3nuP8aj4ZFjSEgYZvrgVF/En+dfS4N1sQZDdemM97D2JDv6h+cr2Df6PscmSeCnj2lG9x3+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/j01lbxs3r1B9EQ5hf559c/Zes1pszbkP8lM83ZMklTNQQMszC
	omHkqJA2bZCIyjemvM17WsHzmckK1+WRxLQQ292O7TuBCpVPp9vCh3+E3Pi/bgVMxQ==
X-Gm-Gg: AYBFou1S0aURzoQ/wkI2bwPShf7SXVEcxpi2q2gdjQB+VHo1EQFdhrUrpD9Uh4vtc9b
	7bTn+GXYJWnTXHLkk27a66OGr95eRLdR30CnvQQ4ebrFwlv9SN89l2A7MTqrt0fyw814QqGZzXb
	enXn2jq3tdE+iixy1LpHJUju6NGL0zHBya6yua9VdDZDrmOCvRD1m4FvTRkP3JmoW1yF+z9bNPk
	4wTe3uGLaimsrvxeaqSWomuxGNBNYVKEKFsyQJl5t+t2Nlkt422sqop4l4m273VOpxkfn7OzmK/
	EsWh35wRZ++OHNhapv9pAOychSlNiUWBr6mp5vx3Jfr4c6BbrX9wgCbMWKq2xUJX1ScXfs0nvUj
	AUbXVsTKu3ObiCmj2KHiZwQz6V65ODUGrbnKk9B+k0RiqmEHz987ZzzXyhF3jW7i6EBKkL+2Mms
	rHu8n8ftHccLwHzIqOCnaYEwvsa8UMX7DkDUoU5yoFGu4bozJcxjBFkvItzyG7aPe7GmkgHqYVS
	CQyxnjTKcBi3Mvnj1bFntJZlhAXymfSSgDHJELCRpim64QbCNpm6oUeFCEcRaelRtQd04Gv+Sgr
	YZAbfYn4wDmLI2Lf7h7kUiGG3KEXURgNSeIW+yLzitd9zhXwg1kMjxcZbMcOY6tvlyB+XlBfxlo
	RN/vODiXOhMcfhEMuE/yAKBpjaylwsQ==
X-Received: by 2002:a05:620a:6c18:b0:93a:11a4:223c with SMTP id af79cd13be357-949ba81a577mr150251485a.9.1795123339444;
        Thu, 19 Nov 2026 13:22:19 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb40ea12sm49176285a.35.2026.11.19.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:22:18 -0800 (PST)
Date: Thu, 19 Nov 2026 16:22:18 -0500
Message-ID: <d583b944b32f1a6f9bb27005d628ba9a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20261119
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Linus,

A single SELinux fix for Linux v7.4 to fix a problem where we were not
properly handling MAP_SHARED_VALIDATE.  Please merge for the next v7.4-rcX
release.

Paul

--
The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20261119

for you to fetch changes up to beb0ae6bcd7505e2e61babe5d98a8dd3b3f03c7f:

  selinux: check MAP_SHARED_VALIDATE mappings as shared
    (2026-11-09 18:32:04 -0500)

----------------------------------------------------------------
selinux/stable-7.4 PR 20261119
----------------------------------------------------------------

Stephen Smalley (1):
      selinux: check MAP_SHARED_VALIDATE mappings as shared

 security/selinux/hooks.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--
paul-moore.com
