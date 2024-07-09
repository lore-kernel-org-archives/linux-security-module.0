Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E21514C3
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562885; cv=none; b=ZvwNMOvHePsL2yKWgDztZj1KXDMTa7YNq2Zji9JMkWOLXCP4jS6AsxA9wqgHCs40WiENEnsfdrRJOilSyF0keROgnch/HZawdVIfhnaBdpcwavP+PurH9oFayHYrTzvbSq5waDOyxcoinL2ifUggtOTgExGp72TcjJ7isr9+8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562885; c=relaxed/simple;
	bh=nmxPAIiEyed0KpqwIcixdXXW+OJCD7FTGecSdBxP0Bk=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=KKSmfxhpU1qHMCirZHK9ZzaNR55vnJV0D4GipCcNb+iCPy2ElFXocCm8n7+sCnm+v7vK+JJJtuATQ174kgajqASwwKqa+sn2MwBYu1a/oypggRGS6CPjXfLYqFkFfj0qxKqV05GuRhHzIz09RJa+yDtboEpeazx9M0oihy+aWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W99ryOqV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W99ryOqV"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-447ed27aea2so16360761cf.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 15:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720562883; x=1721167683; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JkNsOCjWH2lUDQsahymUcMcXSH/koucrDaRpCORy5U8=;
        b=W99ryOqVj37hugNNFhdfs8TJtFasXHZJywg3UrPyqw+cGwKkMtYra5IE1ExBo+4YyS
         ybn31T8iLzIjAwwUWRAq669rArbVhF+KXoZdjtB8SGS1ThORWuTcC+Rpw9p9SxeGSz50
         QQpjSQn+ZUZiDxe0FOTk1cWcGm/wBc8VxRYYQri86y6E0ZJOn7E8QVz4aG4yXuOCejjw
         y5FpQUDYswMJ7Pf5wR6FYqC8mnXTIzoOPdMnyNMRXcDHbbvtn04OsvBCNVX+VWzKN6wF
         1FUppXnre7JkBwOEkiOsjDF7/x6KclwACPvpS33MFhvgf8YCt331lvodOQ4Pct39oPqv
         mgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720562883; x=1721167683;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkNsOCjWH2lUDQsahymUcMcXSH/koucrDaRpCORy5U8=;
        b=wzsUbRgPqS1O3FYMSkqwEq+a0XO0x+cklzjKSWGj/v+sWQeeJOk0Y2m2OE2MDnmoLN
         cM1GCuKMElDAp3dqd/hzW+fCoZzJ4NViDXA51V6bv1UEnIRpc94+i0gLrDHZd3bz422+
         ae1IoJI6qXPqv6E7FCi7X9KJJZPBPQ8UpQteIKWVxTW6xNPNGpI47QJFZRXT743uRyJ6
         U6rLS+acjS+hGBrwgwtfAs4DoOL1neW01MztOAX+yTKfgnm2TrjZnlD1LBMjWxHfRSHy
         A8+NYzS4llLBhCgsfm3mRk+zX05ct0Zlnj3fjazCLbFqSS1V8AhaIGcQkR0+bXObSerc
         S+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWV9czr81A6RO+z8bWvAXTm5+Kju3qDN1zTyjpTn4+87W1IfJNnLQRf6MXtgQbsUOIjH+zttNG6yELiE5USODEiHm8ZvmR3BvMNSli/bizFTuPYik/M
X-Gm-Message-State: AOJu0YznQ/4YznrmPrOkSRyuZLXACwD7TOMFCgEeswonlR1UaON0xpml
	yy2rZG+KCNyHnbuSK5FRxIVVoCxypODnR3f8Lm00XbgFZPIkn2mc9b9l/wgNVQ==
X-Google-Smtp-Source: AGHT+IE6qX9vGp2kW5WeCiJEdCESMKTqnf4skmAkw4vwTMsYgIJe5JtA5KrMVp7JFKLnhqCmJpyLNA==
X-Received: by 2002:ac8:5ac5:0:b0:446:342e:42fc with SMTP id d75a77b69052e-447fa8adb39mr47689901cf.8.1720562883250;
        Tue, 09 Jul 2024 15:08:03 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b269b8sm14617501cf.5.2024.07.09.15.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:08:02 -0700 (PDT)
Date: Tue, 09 Jul 2024 18:08:02 -0400
Message-ID: <a7b378b26bb6b6cafb05d9102da61558@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, mic@digikod.net
Subject: Re: [PATCH 3/6] LSM: Add helper for blob allocations
References: <20240708213957.20519-4-casey@schaufler-ca.com>
In-Reply-To: <20240708213957.20519-4-casey@schaufler-ca.com>

On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a helper function lsm_blob_alloc() for general use in the hook
> specific functions that allocate LSM blobs. Change the hook specific
> functions to use this helper. This reduces the code size by a small
> amount and will make adding new instances of infrastructure managed
> security blobs easier.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 97 +++++++++++++++------------------------------
>  1 file changed, 33 insertions(+), 64 deletions(-)

Looks good to me, but as it is dependent on 2/6 I'm unable to apply
it anywhere right now.

--
paul-moore.com
