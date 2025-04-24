Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A99714E2E2
	for <linux-security-module@vger.kernel.org>; Thu, 24 Apr 2025 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533113; cv=none; b=XileqjvGie3fWmJYhYJuLnA7NKdEgOK7HMFHMvYX57LUDVQPR0J44Ugw4ISJMUoinWgZOUpeRl8BQkz3FIg6V4MGLfBwPG4ozfulVpWq1nUHKGV68C36mq2hEL9C0vWCk6Lsb56NEhCqbgxwfLUzvwgoz5rhnmljbhkZlaM05aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533113; c=relaxed/simple;
	bh=l4f1xNB2dwWSdrG9upCnzaeNTP8GCePr0kItE5AT2h0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=SQhqh/llwjfah410feQ9SD5q9HrIdbsvrNAZKMatYnnWewXLl6gICuRjJxzshHo9ocOxhDKK/n30YWhFO4iyyM0HPALcvNap8tEac/c5v72kZeLTQubaJQMyt5RLIie+gm3Rwq5MPkZjudFC+LM694Q2oxFYfOPGnZVstitDq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UPnInYH3; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UPnInYH3"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5ba363f1aso219147285a.0
        for <linux-security-module@vger.kernel.org>; Thu, 24 Apr 2025 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745533111; x=1746137911; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=251+9C3n6HOhFKPLs3FnNVOnITQVSwoWuSTYkyfbN34=;
        b=UPnInYH3rId+B5sBPw0zXA8lCBZADPzWSRyQqsf5t8lwYqvuQVvPuReZ0XNwcfAlmx
         rCXglJDkAkBuHXRon4A4TNs4GnrOrq3LfncNhcKarTW9D2x3aRwoNJZZ2aOUpYf0Sd98
         doUUeaWtNBE1IS8yTA+GaNzXMA3y6PcwpCZJMtPxOtXL42SrwfTE/ngEUZ0SsFdTfd3u
         +yPiGM4ByJH++mMyC4h4lMCJGLYcfvOF0N1WJf86DibbP/Z478gJnF9fFojlwSHMPQ0j
         IFp4EvF3f/Y4OV+GJOrPMFoR2qQP5a2JRFIhFqw1jLEh6lxyIjR0VsAfTdk8Q1xyK+qq
         +hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533111; x=1746137911;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=251+9C3n6HOhFKPLs3FnNVOnITQVSwoWuSTYkyfbN34=;
        b=RAmz+xUBbv5TeFSJNsgoe8qLqYCvkyeCBaquNOBUXLXNdLiuSZFgnBIFrjyYK5FuOT
         DVIpU6RXo2nUXtVXnuhrTA08WH7jY+bOlNmRlykNVI3Sb7GAMHL/SXs11OBhGjkdWgeQ
         vuyZXfqs63kmwt/tkyGuyzAhnL4YTXPI3r9dYxw06QkwCejNh7oPckADmXZHJS+MD/Hi
         EOOQV11BLwtafMA752FJMkZHYoWjLRPlhb9JdD8ZNtkqsO5My2/eUdUcxSjLRmDAo6he
         hNVdRrLDicujJH397kPpQP2km8KpmQVMnEvB8uvQfa8K2vf8G7Bo94k3AFuKj7B2JW4c
         lg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULdu2LLLnlyTQosePOgt8dgijIu6aoslSb6B4sEHrHTDcroCbLEy1lxvmeXR/7fRnGXnJus+MrpnbAxv2Rpoy3PfsHofQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziCAqgX8yBe/lVfReEeBsDBH89lfYOY62rtLbgms6vrKYL3GXV
	BMduI4oFg52L9d8SrdHU2aYXW1VlxToxg/vrLZ4ixUofr37dETvktX6fvo7v5A==
X-Gm-Gg: ASbGncvGta2F62amxruE8OrsT3CwFBWZ1/GstZuBarERBgMFAD/yEm5fcKICIQKCMLk
	9ptDHI3Kh6jogkkbSAPAJHytHq3q+opdJjfWBsOF72R4Gkuf4qJD8kKhrO1P4+uWPFwHKk7R4Qa
	uYhd7myjt4m4H5mclIGsM6LkFkDPag0V5f03QHEWPP5JP/msJllOFahjouML3pp8nj7dXR/0AAg
	RcaBCjRJ7nUyqEmk08WLhl/bQn3DEkJJ5yP60HNWpIKfr6mPWTY5FJju2cPZQQ0re/EGosLipwO
	uJdLllUBQQqTcWfkj9MXg+I1Z06biV2Jv1KY4yqlUXCR+wsGagQVFe9Uhf32BLHlODBPEA4E45e
	jsX2mchyO6w==
X-Google-Smtp-Source: AGHT+IGCkjp7bhibsegJvEnhEdx+029sejsn8em3hGJ2OLmGOtsJSHM7xFwZ7JdT+eFzXvq5AWacag==
X-Received: by 2002:a05:620a:430f:b0:7c7:5ad8:aece with SMTP id af79cd13be357-7c960719efcmr44339385a.25.1745533111053;
        Thu, 24 Apr 2025 15:18:31 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958c92193sm141850185a.10.2025.04.24.15.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:18:30 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:18:30 -0400
Message-ID: <a64a1877ac344c22b3c86058e97d1d33@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250424_1707/pstg-lib:20250424_1742/pstg-pwork:20250424_1707
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] Audit: Create audit_stamp structure
References: <20250319222744.17576-2-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-2-casey@schaufler-ca.com>

On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

Looks good to me, thanks for moving the timestamp and serial number
closer together.

--
paul-moore.com
