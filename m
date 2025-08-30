Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A4228CB8
	for <linux-security-module@vger.kernel.org>; Sat, 30 Aug 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563296; cv=none; b=p22CwCB5PK6KMIjlkhCMkdL1CoBxObx2m9CRscF9cOaz9somoDsES9Z6gtn66vYvQmLKYDgPErLM5B+TW0HUhoaBMnF/sdAmFJv/JDp0tuhldAcq2ElYYdRLNwgAnVGX+A6+txJFRbIF9vrJCUaTSV5YBeF0Ra4AggmP/gXq9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563296; c=relaxed/simple;
	bh=NLarFhy3kQ/TjCF4gbAzrkvsWHYogEKJLhKX1GQRe6E=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BISYdP1hVjkbF1IkDOUXj/23rVh0/6lFv4yRTH3fl5p4znf3ZSZw8bhgdG0h/ZrJehS3iCbipHl17ypLFT3JQYG50q4ejFCyyeIJvuNcQSi1vwbVdXz2SA4yj+nFaUqG1eV+QUQf/gpRIwyAEyGBQbCjWQ69fZXUM9Y/oOZa7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PzTO+rLX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PzTO+rLX"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-771e987b4e6so2390718b3a.2
        for <linux-security-module@vger.kernel.org>; Sat, 30 Aug 2025 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563293; x=1757168093; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vhRNtUPsZDFJYGrztPkjMPFnVe+Rwz4ScA0R7wbO7c=;
        b=PzTO+rLXWFtNInMn5cl2f5knPnOvyE8e/ZqjD6aiCCgQ+BqEwHDYo2HM/3A5Bp3ZZy
         kYJ8hDu8Ienhgrt1uHtN16ectKQmQN08h8U2JrVHJuXTQ6jnCisyevIRb9LNG56KJ7oN
         j9nGMxcgPfM/4aK6n0gGcpk91LIAFAwD81DpLOkPe8CIUGHcG0gAPew+VP5xXWRp+/oJ
         13bFkvkb0Hk2b+Zp87AaWQUa4siq/7PfpHEC/vTtqCqxPZSIK7weWF5prqkbRimVzCQs
         1jE3rlj/30EYzDkgEAkf6paZLUkCmynYaNk/jQH8zHBcHE2K6C+gqg/WV6lz1lY/VXVe
         YRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563293; x=1757168093;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/vhRNtUPsZDFJYGrztPkjMPFnVe+Rwz4ScA0R7wbO7c=;
        b=O5sHHuk0FH1Zcy+hfI9IWBqGwqn45X/qAgdg692FrxEi6d3ACbYMoYbcHichQhlotG
         KM6j5IWq5xm1GpUSSlzovVb6AunWv/R94t80qPsyX10LFXk8bBzwi5TJODQ8SVvHmSwS
         jpxO6vtYGFiZA/qe0ZGfp7/7GRtAhaTLOcP+DlS+WYSTv2zUaa5WOH1E3+Hq1RetjGc2
         1A2J8SKn0PiLNfWWiqj8NY8dFEiC7X1KSynvjEQTi8SSaWD2o3W/jtMc4toCaR3I/D6A
         +hCo2QMYA01aw9vPSLZaLlf0x1OBhElr3GJlH63Cfwt9Z+kXdRiuVDvYm9gBrtOUhcK5
         FJGg==
X-Forwarded-Encrypted: i=1; AJvYcCX61MMWuzJ8iw2Kxpi1mzXG9emadzAwJLQ9T36vfl0Arz8DzQGt6TOLyulsAu/8knMQknK3u3A2w6LWKPQfsvQWqengamc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoMgwQP2bx6khscj58b6psQlajGIvpkTbfAPSzd3PEuGsJZ75
	Ih61LY3szhDM2+a3wLWbaipkUIxbZrAQ8w9aRJAH+V5qA9NPXGCHKZqVUtu/y4IWiw==
X-Gm-Gg: ASbGncsY1bnhtxU85paZATr+GDqPb65IJCYkozgUXXfhOrtA/oK7adgnVL3tk83M/6r
	Aos1Hz+A4QjpqOGqNlO12II9wm6sFF0nIi2CoffxjG3upfXlYIr0Oxw2qNq8W8ZviCw5xIOpxb4
	NNnBk53E996XbzDwi6y0M+UY7h6RJ5oYrHAilpuOuSAB1S4KVZud3mSTPohN6+zMjuZ2t4KgxP1
	bo7drgzrUQLzedpCiNVblq1WH9kAfGth11DUb3Ji6PpAEEf3I4r191+NXmDDjNMXbbmsNrIa2An
	ffgA1eywa8idEIz5sNJZZGDTQbioee+MujhWzYTdTUpPsiBD+QqzIxjQMn1XsRMsm3nB+2L9EhS
	p6+VK8x3epCDFSg==
X-Google-Smtp-Source: AGHT+IGXGDxudBPOQGj+2n/Xq4JGPNY8rIEn5BPaZdBF3FLtxzrLU7/7VkCvAu8X+BdRWPuL6Qz8AQ==
X-Received: by 2002:a05:6300:210d:b0:243:966e:21a with SMTP id adf61e73a8af0-243d6f0b8a2mr3512373637.36.1756563293102;
        Sat, 30 Aug 2025 07:14:53 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3296c8c11eesm1319169a91.19.2025.08.30.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:14:52 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:14:37 -0400
Message-ID: <e6e9ea4bacac5553810f7963533a71ca@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 1/4] Audit: Create audit_stamp structure
References: <20250816172859.6437-2-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-2-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
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

Merged into audit/dev, thanks.

--
paul-moore.com
