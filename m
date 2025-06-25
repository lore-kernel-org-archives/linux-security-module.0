Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521D2CA6
	for <linux-security-module@vger.kernel.org>; Wed, 25 Jun 2025 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810254; cv=none; b=bU9t7wEflfO6bXHhb1TiCyQ1U3CC3zxp27Hro6HMsr0rtvN34Pgv8Z3ol+DxsHIvqe2r6ZRYpE8cWM3Q7qBTTHjwqVmk38vUWPpimMeV5Z+jGE+neU/hjloFYNnl8zdoxj7G6LDOsyn09/ilWVxeHLoFF3b3tNMLxEGd22S/UF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810254; c=relaxed/simple;
	bh=9ivD5AaMhRDnIDnklljlK+k1JVxliQvvRwvsCgoM9ck=;
	h=Date:Message-ID:From:To:Cc:Subject; b=pu8f0M+kPhqd6mzE72lxPH186d9x/WeLpKFYJyfh31PDKQNcBFL5xZ0Ii+YtC42pvYUaKAETkuBPkF4swRhiQN4OGDYwX0IgfHM7b+pyOtn9Sav6E5C1N4/GEbgBDXpzWPnnVprDmvE2Ew5pfDw/DvH72V74mYR4QM39CZpW4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TqG2G9Tm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TqG2G9Tm"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5b8d13f73so599297985a.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 17:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750810252; x=1751415052; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL28Tc4w5+Q9+lcS6siAOTOvpsM1FGjQwIS4zdqxK/Y=;
        b=TqG2G9TmsT9W73nwV065TYKqyDZr540bCvd78cgAbDNcyt+VkmQidpBM/aXHlkUBrw
         BScrnBJktJj9q64n0RnxMRJkv2hSA9z3kB31gGbnB7APCpyfm9p5qf20U0rgkvhzkVqe
         2X7fzK1fIIRhuNH70P08WDm8LLWxDlNRjVAjqVNkzlKf/4043NFgeU9djry35qQFxEta
         QG675alk+W2bSgqK3JYCSPytVS+rfuUE6HmE7Imi6yHzRpAJcQOEKFvpnlvIGpUPdn0y
         pcCf2WppCQRpHA7uAidxYgHSuKoUjp9Y9JBkfr+AoCi8sALC6AbOf1Usyk9+v602464T
         3xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750810252; x=1751415052;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zL28Tc4w5+Q9+lcS6siAOTOvpsM1FGjQwIS4zdqxK/Y=;
        b=rNdGwOmHOxpKt4PElkvpJ6qrt513pVgPtes5YBXB7671kBMgtgmyoO5/ECwZKcGj6x
         Aj8Ur7kTQdrme8oCtGQwDYJv4gOrHceJo9eDyO8EA6NTIGQnpKRyCfScI3V09hx79L8N
         yJbRTv3x6JaGn9juDSaQMs1YcJR8hn54VNojSxIwDLaoy0fmzilxjvOfkN3fc2BlMQ3E
         iSBEmUoabD9yKXPI7NE6l87voYeF3z78vI1T5xJR4nDOIjrYuf7Uv/qc+aUZigsJQmky
         N+ZbZ08UapRbVP0xI2A39FA8hGn1TtV26CXgY8gJVrbSvyr5J/xIJI1gq2G6kxMZigpp
         MQDg==
X-Forwarded-Encrypted: i=1; AJvYcCXD3+O+LAUkvFLf7u//sjFO8vGeCTceSzGWPR9O6VXv7FJZ7/c2ELd8C6VoQRJjYTO7kIDAobJ0vfAt6BBAFxoo0sIJOHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXlChNbphbU2MnqcPmymP+swhymSVIYjsKkOf+antgm95KE2P/
	jBnn5xYAiHGkz7F9AMv2eRIzNp3qvnGyMYbMoEoZnl1zKdqHJGCBkd0Ber+zDA7O1MPMxP1NaF5
	CXbw=
X-Gm-Gg: ASbGncuwEvNJXnmg9sRs+qzTAiVbpkJw9OglN4rmY+9GfRNX/xiyUl3I02UwwS3RY5M
	tUeiEsIKqPy5Jj5W9DxfgcVL0DxD6y9yw4YePMWfgspA701AyTrFdg+7OwqtOKf/A1TsdtFJy57
	Us2gh2AviI+fIjnBekoxm/h6ZgRr2ONOvfPaxji5/A+SNw67rQ/sgscZXtHLrTonwkGteavq1dK
	Lq1+GZLfKHZ38B5KEPJHb6AdwhnPCzErybpbzNb0F6aAQAwe04KGn+HG2xzk0dCDShaoeVErFZa
	tWuT4izovLYpIJc6KkkykIEOzd3nbcssoI8/UtZfpdjxZepb9n9znDYyxPFj95f8JS0hsCIwoa7
	XyWPNJ13swngkF1byKboN6PsKCJmRYHM=
X-Google-Smtp-Source: AGHT+IFL+HjknXTXoFRm3XUtKW87TK5WTKCaVLsRbT3brEr6WmdayurdNBDLXUWYy5PXbZrC8PQy/g==
X-Received: by 2002:a05:620a:370c:b0:7d2:18a1:ce0 with SMTP id af79cd13be357-7d42974ba31mr151411285a.49.1750810251876;
        Tue, 24 Jun 2025 17:10:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fd09442d14sm62087126d6.34.2025.06.24.17.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:10:51 -0700 (PDT)
Date: Tue, 24 Jun 2025 20:10:50 -0400
Message-ID: <190ee36309adb0efa27e3b39a1a93de3@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250624
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Another small SELinux patch to fix a problem seen by the dracut-ng folks
during early boot when SELinux is enabled, but the policy has yet to be
loaded.

-Paul

--
The following changes since commit 86c8db86af43f52f682e53a0f2f0828683be1e52:

  selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len
    (2025-06-16 19:02:22 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250624

for you to fetch changes up to fde46f60f6c5138ee422087addbc5bf5b4968bf1:

  selinux: change security_compute_sid to return the ssid or tsid on match
    (2025-06-19 16:13:16 -0400)

----------------------------------------------------------------
selinux/stable-6.16 PR 20250624
----------------------------------------------------------------

Stephen Smalley (1):
      selinux: change security_compute_sid to return the ssid or tsid on
         match

 security/selinux/ss/services.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--
paul-moore.com
