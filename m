Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725CB370D57
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018765; cv=none; b=rBLnqPpkKDQfINlceeNYS1q6txKcfUs/tdv/K3llVih/SpoTG4ZzCNXzdqTr+IXbHmTLiHoY1Y58B2itLcbRTCedU+Ln9DIh/8QuX19mE0sQIbbpmsRHbNXHK9KQWnTI4jhRONzEBdkUfJz5EuIwnMGRgEOZmUSFR/hD4CyQgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018765; c=relaxed/simple;
	bh=otsnMu4I7OXfYVRjpIrnueEy5Gbe8TPV6cPMFXHFTRY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=dqRKHve6xEPZE/e7UGOsGuQJAveMJgDggIeSjgn2qqt8xdl0oSkDX5qd6KbOQ76+VzOL1Mi02mEZK9OpT0kTWNp0rPv6doaatbAlj0DQrsJh2myGkhanrJvYXG3UoR0ltBSM6BqiULpNwJKcemWm5RZMRKm3mHesDXjAt9jcrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KUVE5Utq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KUVE5Utq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0ecfaee7so14013161cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783018763; x=1783623563; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6qxP8wYe0PjQRudh2qqy2528DA/tzF9LJXvJXYmmKI=;
        b=KUVE5UtqdAK5AYNP1mCR4eT0Q6EwTXrK2yGFn3XyKPiHM6Ww0Ld4MAM213FdJ+xG1r
         hVE9AeCF6TXIXcW9dkJ8wyJAS6CXHI1E3AR/CeDx2B1yk4Y2Vea+18Hi60W3xxxjg0Mq
         R+XDGbNK9B2TLV5XoekwFg4RwtdBcCSHUr32YaSY/ICEsNqofPhKq362qFZgDhKTmBCD
         Gi+wS2n7JiQg+XLTgyOuqYps1hR+oc/taQTuMxnYu4M1HTFIJ2b0NjoR8YPskPQgSEuC
         hLw6DKPwENKpNw/N3wjNxbSqYBkGKkNs7M2YylmrEXaDfb0WFgrVeaxYTdorvwWoGDqo
         8LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783018763; x=1783623563;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6qxP8wYe0PjQRudh2qqy2528DA/tzF9LJXvJXYmmKI=;
        b=V4RsFzFmgHVSPxAZjPIqzP6WTrGBRZm0K/SauU1rdiJdT9g7FvL6pc9bXJXd6KwvGh
         XYk+MCEX3xREXoVrsk7JqfhMOYCIHGaxU1y8I8MjMKjHcuQLMOEt/rxI/mBLjn+D3+cb
         tbqIvfJoqewYjNOjKXhbpSlkE41F8Rv+C6O4TkKzW1MmpC91e4JIF1TF7n5/f3nIiXwj
         82gIf+1MNKBhDQ+BsIB8I5xGF1HjNlS5PFx5HZNoOppktnmNn/tylmcFJRkELbV4wk5/
         0mTuw95pZAOS08YNYaKVIieToOQ3Bs/rcB/sEHoqtSEb6tEb3Qjm43UUoAfnjc9mcunS
         zCig==
X-Forwarded-Encrypted: i=1; AFNElJ9bxgS/L4YLn2kFdMGS81PZr9QlpCoD5rj77gB/fSEK8V1P0r4EY9xd7FXHF4WkuQvDr/dlxBHPOSO++vQ/rkUxQwacQQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6p3v3wvC4nNrVbzVJ5HEEXDO6ICTgoGpg7VNUxkTbB5ZypSx9
	+iZG6HPqI4R4OfdHRpcYTFPctoulXrdbXh8ZEaBRlaCAzIzwhK/KTAAt2DK2ZTL/FNNGvdJqRxM
	SXu5B6Btk
X-Gm-Gg: AfdE7cnxj8FZOQbGNHmCyr1RvWZ2JouCztkRDVVZSVkm9uGNTzjGEn/4mT+q7SfdpXS
	5Et7embiLYQY+8oX9LAFq5guqEdheDYuPBdg8UysEn1GdOCax4ESgfHcvI/Dken0pLnGzoN2cH9
	vHGH9Jpb4w4zc5EjEZvbyBccofMKJ+8RlXCdJFdNzbFzjXQhP9YDt1i87bSdMsBGauZED8Zvzkp
	+NCnICPqPqv2FrQA83n8GVmRrAF7D0LgooqcKCI3ZbXZ/nCgARkbhUK0yyUVDH2wXoShknAaasL
	nfgRanEmP4V2SHQA2KbWQQXbCak/uD1jDNe/EqSaYzjGdiBGC2p4oyW1/gourqKk5zEx87nUI81
	ilSGbDFO3jalh7ABo2fadE/zo62QDwg2ox6V4hweiHLLIDEXpCQWxc2ymPE0u1g9mFfog1voO/y
	rNOqaZdnDq2HWfuNx+LBl32K7M4gy+NU4DW4Fc/JbpQCCMqDpI1eTrukdtcg==
X-Received: by 2002:a05:622a:2309:b0:51c:1ff:2515 with SMTP id d75a77b69052e-51c26b49877mr90634191cf.65.1783018763537;
        Thu, 02 Jul 2026 11:59:23 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30c1582esm20240991cf.16.2026.07.02.11.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:59:22 -0700 (PDT)
Date: Thu, 02 Jul 2026 14:59:22 -0400
Message-ID: <e1bdf10ce11733a11975523b23f79215@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260701_1640/pstg-lib:20260701_1540/pstg-pwork:20260701_1640
From: Paul Moore <paul@paul-moore.com>
To: Bill Roberts <bill.roberts@arm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: casey@schaufler-ca.com, Bill Roberts <bill.roberts@arm.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: clarify task_prctl hook documentation
References: <20260615200325.260057-1-bill.roberts@arm.com>
In-Reply-To: <20260615200325.260057-1-bill.roberts@arm.com>

On Jun 15, 2026 Bill Roberts <bill.roberts@arm.com> wrote:
> 
> The task_prctl hook comment incorrectly described the hook as checking
> whether a prctl operation is allowed. In reality, the hook exists for
> LSMs to handle LSM-specific prctl operations.
> 
> Update the function description and kernel-doc comment to reflect the
> actual behavior. The old wording appears to have been copied from other
> permission-check hooks despite differing semantics.
> 
> Signed-off-by: Bill Roberts <bill.roberts@arm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  security/security.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Good catch, thanks!  Merged into lsm/dev.

--
paul-moore.com
