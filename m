Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E169219E0
	for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807971; cv=none; b=JdYRXyz45uXQu6vyYeal2zkOvlthK601xYuLHglgzXmoWISIkY3YOtmj9cpFyEPW+d9u2mVdA5aWy4LdzkBoV9AWH6nhe6f75/BqfsIuSFdoYNviuFGGEk6DFhk8b4xBrVk7fzpzv8bc58I0s65SY2+IxoRqLVIfWyGwHksEg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807971; c=relaxed/simple;
	bh=9plsle3xhilIscWtN80aVYEmbDNhgd7b9z+Vcv7fJNw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lqDR7Qto2g/0Zg+GeXvs/ZfN95/3GfAyqk61Dq5f73QeNtd/tSoameyIVCVVoE7sHVoO0jEk5uL5Em3yspM0pPqLpe6qqskwxZbnDN+kMtvHhQYV5RFRTXdXIbXyOyrIZV+ZaI6CEALRO+xqkCPRPctKvjDTuBNPaOPa2YIt4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Kt4KOY5Q; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Kt4KOY5Q"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d41cd4114aso147277385a.2
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750807967; x=1751412767; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeW71QVolHQc9XFtJ5X/We4h7FBJVSJJ3quBDuyBJMw=;
        b=Kt4KOY5QvevxhjR31oBXxaQRWgMES/N2zEePcT80JzurJMRrodDmOBCly633i1Lha2
         js7ms6/eS1MpNpdOdOIPxtMUPQoZvPQITSR4B5jd1wSX1cI+mwdqOVSnCxxpFGxyLT1p
         S7BgJASFaDCiPkLmqTKeIwTP1JNFz0NwutStH6FFFebK+S5zgOucd1nCBlyXvLalaNod
         JhaJAgm1iZxaDgxJbR/2wJIhLKGrUdo0iAIUqusuXsPLT1yuquJjN8HNMeLZ558K06/3
         C1vHfsJaVjnaLp8IYUszmGF5tgtw5DvFtXpCvhLOxSJsC/79MSIIbgqRrTWOyjszjjwz
         tIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807967; x=1751412767;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XeW71QVolHQc9XFtJ5X/We4h7FBJVSJJ3quBDuyBJMw=;
        b=JLXYvxKc//2F4JV4hTuUDPu9374EAHW4tPbTxmMY1UuLSOhM0nv1pQGvDMHaOxuoOl
         qjHV3xBv7KauzQBa6eua/ksBhxOGfQaDbvA6xtNKGKEHuGRhoNw5dzSvMfu2/sBdaOd/
         G3EurOIAD0Dy6K/JFIDLx+6rMWPaSV/JjVOSNRdNdytNiNu9k4zGxsm8qWpKIVT5w2rm
         o2K3fEKG5WTGG1OOUue5BW7CE5AqmB7DXSy+WfmJKL4AWe/ed9oW7cIDnie3M1cDo1JU
         d7HPj+0/I00smseSYQQJeiC41WTU85AM/nas38EihZbSQ2IApvpn+6qclwZ6yjBUr9V+
         04Aw==
X-Gm-Message-State: AOJu0YzUP+IqrQur6+n0m6PiSM3YK4VRyaphBK9wX9pceu8BrQ95KueY
	GS7/Iw0FXDfnKevHZ0rwGjUifj55jMN/dqgBkfPljBSbLUDkrQBPtdP8wkBFsPRLkKs+jy859Y1
	ZjoE=
X-Gm-Gg: ASbGnctuHNKz8+aGCCy1qa3NNnux1C9bSNgnYGsG19zUQCZ8cV4cAThsVACxJmZKHZY
	VgynQG575fT7qzeodphaJFl5w1nnp3/DxVSt9EW6xGSANVipFXAsMKgNaHlaEZQUwdtTV5F7P3A
	FGTkHT+79ABtlt+RJLENERKCINirXyQel0E7CPJIEn2WIjbKDwnHdlLOV6NSnq3kMUGc2W+k6x6
	aGJ/eOrKraiy+4e2omQILbK43l6y6UE1JbDOubBT+JXO4GiH0XvDvbNiREgXVnTEbPJFmveYqTT
	yulTSLdS5qs4scDEBooSyYJQauNP4nEBsbRj7/ECFFtn3OoqMr2NU6Uu1F3/6Xon5v5RYwCm9us
	Tc2ImyU9ZcbJ7ElppFGFFdGvb1elGxrI=
X-Google-Smtp-Source: AGHT+IFmpTDa3Q7jBgXHoXXWbdTLlDC6+XgCE8TmlP1MQKwjZ0tjBgSroBHg8qJ3R4JT9IeEALD73Q==
X-Received: by 2002:a05:620a:2589:b0:7d0:996f:9c48 with SMTP id af79cd13be357-7d4296c9e4cmr152296385a.9.1750807967077;
        Tue, 24 Jun 2025 16:32:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fd09538369sm62013446d6.60.2025.06.24.16.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 16:32:46 -0700 (PDT)
Date: Tue, 24 Jun 2025 19:32:46 -0400
Message-ID: <c6da4c0e398d393b06e4257c8beaac3f@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250624_1155/pstg-lib:20250624_1155/pstg-pwork:20250624_1155
From: Paul Moore <paul@paul-moore.com>
To: Yue Haibing <yuehaibing@huawei.com>, <jmorris@namei.org>, <serge@hallyn.com>, <casey@schaufler-ca.com>
Cc: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: Re: [PATCH] security: Remove unused declaration cap_mmap_file()
References: <20250624014108.3686460-1-yuehaibing@huawei.com>
In-Reply-To: <20250624014108.3686460-1-yuehaibing@huawei.com>

On Jun 23, 2025 Yue Haibing <yuehaibing@huawei.com> wrote:
> 
> Commit 3f4f1f8a1ab7 ("capabilities: remove cap_mmap_file()")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/security.h | 2 --
>  1 file changed, 2 deletions(-)

Merged into lsm/dev, thanks for noticing this and submitting a patch.

--
paul-moore.com
