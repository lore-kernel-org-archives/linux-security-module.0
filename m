Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C48BE5
	for <linux-security-module@vger.kernel.org>; Fri,  6 Dec 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445052; cv=none; b=lQbRoadKel0hEyC8HAndCoknuDWLHfpIWzyxyEGwgXy5+KCDUcYXCyQWz8wTXoyshdSlrzfKLJ063BJnlMPNCOPE9kBs8Pee9yrjA4vqCPLABt9PyFvQQIN0BdyPfDQa/5/5l3LxSnK4v0ClIOmIeemYFctdhfvmW/YLuNt6wVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445052; c=relaxed/simple;
	bh=ZVpk35Xy0VcY4noMVSjOgOVQmT6sANwi9Ktl7vC++qo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=mJeZxgwQClsdy2PQVuaGRy7opQCFUMZlrr7wKwCUISC++Lm2yuidLN2QbSgV/F4Wuoq5sfr1LnoA9NgG3NvaWdJq25LnYXtdijIXVl5Li6uRlscNSjQmmMGLFx8bqUqaw8Xv3B7BPg6n33PjuqB5ciVGwAjJUuGIWSdHEI6IToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P8KpZ9G8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P8KpZ9G8"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4668486df76so13193501cf.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2024 16:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733445048; x=1734049848; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TaUN9gc1Djzc3dX6IE8w4c+eTEm7u5dH4ywnDi0aU0=;
        b=P8KpZ9G8/BIUftu3uuGAPa8c+q4uNA0vEjXXb7f5CsOZ89tLnZ9Z2DvLylY0LBZAqU
         2Ua0iKbrWNDLiAgmJPsOw3gPD+HVAix8erFFu2KrBsVYJgf9gS5Wax2wjHjOTMmXdmLi
         ihK+3ISDOzhoEEkpk6N/FEev1oPTGLJWKWpffw9xEPpyEFDamukxCDSLpbdu/cv4ZrvV
         sSJVoPLp5LKRisQF0pXDf1CMZG5SwiL2BfGv6mIQU79XhiQggApuYMxWDgbZQeiLR0U1
         oOCWlCgTFJLqLtj+wxrk82uWmLf2Iesx65E0UkjyBEKKm4f/fRVZi3rt0mYGdCZsNu0I
         gQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445048; x=1734049848;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6TaUN9gc1Djzc3dX6IE8w4c+eTEm7u5dH4ywnDi0aU0=;
        b=GYQLccY7ZLMS9YmDY4ezfqaEWIfZ25h7OPO4f/onc/y7QBLOxLKToks+93UMBSVdrp
         iMsowEmdSFAx4thBJcdjMMvSYKHEwGS1uYctLRaI8brUfVCeIjYV0+IG+1B41y7H0vib
         oXwuvW+BCxcKwCfiTRc43cZPsafOPsi6jnp7g5AsA8nvQ54wkfRwjS5j3faws0sgniet
         6PyWsqKU+LzASUnpoAoH+6P98f+JLkCzpYT6Oa1LrVh84bkbyk5TJ01LoSadBTyDu5Dt
         wDqvXj3kDs2M+tq/HrmjG4TavdoxMovPTdV1EMWC4XZvj03Ajg6X61zqnc0TggbWn7Mf
         dilQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGUXidBAJWrjtI6sqnJjS8dJV0eBeryvQfvJSxwKxfRHn5AdO1DSDyfqNZI6x7cNHhEFAgYoCW1AbQMMfCakfKrHmcK0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6jWwUKiSF/ouruG+cHjUBsXHm3z/dWKXT+fO2WYBD2/TXsm5
	NREKOF8I+mb21OkAh/Ua38XnLVeumVRH1moHl9CCBllUhqa9K2QPeLBxDxg3Qg==
X-Gm-Gg: ASbGncs91Xhhk+D5lYmgMvMWj0e/ps95wasPNiHjcRhaddCHzgbGoBejjZu0Pp4l7C2
	ckIYGuCW5xg9BszX8z57zlR2vzlNWMoa5RXKzRhYpqXX2t+2jkGsohunzOyztjBtwvL8xzmkQa+
	4m2Tp6t8NQjBVH9INCyJ178gRH1aYOqvy93U2OgMINID3HOe7Ut8VLFTma22/7l4i72FHCvUzMI
	/HVIYDSwb8mKyEgZgjMoDzDZm58yVhNwKLMle40V1E2
X-Google-Smtp-Source: AGHT+IFDZJLMCz3nWoimfJa0RViiH6kDbmVW8ZEfAH6eqPnv25/IdRQdHr0MtEhEhTFoK2D+ovylnQ==
X-Received: by 2002:a05:622a:1103:b0:466:b2fd:3e10 with SMTP id d75a77b69052e-46734cb5cddmr22825661cf.18.1733445048494;
        Thu, 05 Dec 2024 16:30:48 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296cb98csm14086621cf.30.2024.12.05.16.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:30:47 -0800 (PST)
Date: Thu, 05 Dec 2024 19:30:46 -0500
Message-ID: <282573d0ea82ac71c8305d0c8cc89083@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241205_1904/pstg-lib:20241205_1757/pstg-pwork:20241205_1904
From: Paul Moore <paul@paul-moore.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, roberto.sassu@huawei.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, audit@vger.kernel.org
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
References: <20241204192514.40308-1-zohar@linux.ibm.com>
In-Reply-To: <20241204192514.40308-1-zohar@linux.ibm.com>

On Dec  4, 2024 Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> Like direct file execution (e.g. ./script.sh), indirect file execution
> (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> the new security_bprm_creds_for_exec() hook to measure and verify the
> indirect file's integrity.  Unlike direct file execution, indirect file
> execution is optionally enforced by the interpreter.
> 
> Differentiate kernel and userspace enforced integrity audit messages.
> 
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v3:
> - Mickael: add comment ima_bprm_creds_for_exec(), minor code cleanup,
>   add Co-developed-by tag.
> 
> Changelog v2:
> - Mickael: Use same audit messages with new audit message number
> - Stefan Berger: Return boolean from is_bprm_creds_for_exec()
> 
>  include/uapi/linux/audit.h            |  1 +
>  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++++--
>  security/integrity/ima/ima_main.c     | 29 +++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 75e21a135483..826337905466 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -161,6 +161,7 @@
>  #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
>  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
>  #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> +#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data integrity */

I worry that "DATA_CHECK" is a bit vague, should we change the name so
that there is some hint of either userspace enforcement or
AT_EXECVE_CHECK?

What about AUDIT_INTEGRITY_DATA_USER?

--
paul-moore.com
