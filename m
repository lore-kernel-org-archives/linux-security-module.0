Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5F21FF5D
	for <linux-security-module@vger.kernel.org>; Thu, 24 Apr 2025 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533117; cv=none; b=ibzVjZkgZDycZb18kkMGgZ0v2xSIyF0OSAkDlSTl0pAjf45ZYcA0mv04UgUPKQz27BOoYj+NoOMFDBGLGfS1DS2A10bxlrQYekffuM/W9Ao8vwBXF9E1nkkwyOioPfQy2FtgaEH1kd25XldM7fFM1oZ+nMEfS47UbFnJd5fuW8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533117; c=relaxed/simple;
	bh=X4h7FN0K3AFnFkrK7uikaQMdM0fvE4Ke805Jw4zseXE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=l2jlyLMevp1dzYmsgF7PdSCQdxREjBaGrwgdhn/PGSliby2VOVfz7O+w6pq/5cSV9jDiEhFAOp/WLtX8rWzdj5Edb3smJdk+ylRNtlG7Lej6Ac7ydnr/H70eCeai9hl4OUaov70nZr0yk3AYvvgbFxYO0/gK1W35kErIxGPB9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hja4uQdI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hja4uQdI"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c081915cf3so226306085a.1
        for <linux-security-module@vger.kernel.org>; Thu, 24 Apr 2025 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745533115; x=1746137915; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0NabyRe0e3LwNpls9HOHadDr3ssMH+3gnQlYlzw91o=;
        b=Hja4uQdITa+eenQfjoIj1V61UqOroOW29mbhUUy3OBZMMna4CmLimvZ2NhvVs+Ahs2
         fE5x9kGpaNfHR2vgPJa5iM6UV5a/6HQX6hX98J4OqRSFGXII31L1gtMvVU/hMRSIvNAq
         f+18NsnPBUfpO0Nn1Of3m6laMZzb3k03ufDZAjTHULm66aG7UTRFPp6N2BDrxEh5H9VN
         u7W0taaQLswlPgTjaR5UTR+mkJqY3r5xp9WfECpMHtqvIjEc28E3HaYeXvVOtQNTwDtp
         ifq4JOxKJmvTmALR2UauDs7AGcF6unUcaYk/v41bXYdjJ+ubNbrFu8lcSe0ynD18cmne
         wFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533115; x=1746137915;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k0NabyRe0e3LwNpls9HOHadDr3ssMH+3gnQlYlzw91o=;
        b=YEmx6OAqZysQeNEClj/Fg7ogvhKrCwVsqvrBvllQ0SOYEnznHBLz/mHDi+Hq4o8OpP
         QQZAnHq8xORc7+RqPVmurapqtcRe0t6WLkUAgiZMs6Xz0HKIXBUt9WsR/5QT42c/BkFC
         Xjf3VYLu3tYqznU412Mj3TVvBz6VvHClF83mZ4K3BDNFGCz2wTlcc8ZOyKelXJzzrRf3
         WijL68aZ5cxvgmw00FsdTpzB+8Iupo30G0rztpRjQn0to4vkRP0HMmqa6W3Yu3CdxP7X
         kVEeWAuWOlREAtw8raKM+9EifA6vjb2KqMfi06vQbMC8TKylL4urSth2TeosFs7QJvwi
         9Plw==
X-Forwarded-Encrypted: i=1; AJvYcCXHMvQMv8cVfKQQEALm1VLHcruIYsP92tRkqML7MCwV2SPNZUHHOxKN7p1jLfOjrNJRiuwq+1A/mhJeMI8JkwVmL2ENoto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9730HA5QipOg5XkBCxyL56xY8076U5X5LpJVdcUUgGmsxzwB
	MhygEt4m39XyyCWoXiolUeOvxH0MT8NKDakgPPc5V/yku9ZfrsH+UL/1sKzcgg==
X-Gm-Gg: ASbGnctE/h3IMookVF2G2zZxjZScgLF/U3iXAfxFR3POe+cwzG/8jfO5nSlkDaO0Fm/
	bQTaCPN4GGV0yZIpA1eIKFJIMuN818OvSGCF/BAhKrg7TTXfBrvrtOQBDqAcL3X20iajfFu7TZq
	glB0RD1yS+yvZ9ZX0o7M6NH1n+e9sQvZ7+tHKDB5c/T+AiyEbgS2C08+ynzCD0H7CZP23/HUAx6
	SZdJwnqBUCJ5H8u0MpmXuGOhA+2yncVYRefGTT4P2YMPvOSousiuJgkw2SVUixmToBqqaKpxJQl
	kYlBNN6EEP319sVTcE6LvFOdN1yswEUAQca0etQJ8wPPg7LX0/wrZkKs22biQKeRZDnEOSk+XtP
	hsd0CzWhV89uyrx+p37SN
X-Google-Smtp-Source: AGHT+IFXv+GKneGs4dyxpna32Ck391ho+kWorlrs9AQeZAzriLk2fUEknpnAV+uKlCt4qAUgszKdaA==
X-Received: by 2002:a05:6214:490:b0:6e8:98a1:3694 with SMTP id 6a1803df08f44-6f4cb9b43cfmr3210286d6.8.1745533115060;
        Thu, 24 Apr 2025 15:18:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0969657sm14659426d6.65.2025.04.24.15.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:18:34 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:18:34 -0400
Message-ID: <5e95e5d8b2b262548220382f14fcb3e4@paul-moore.com>
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
Subject: Re: [PATCH v3 5/5] Audit: Add record for multiple object contexts
References: <20250319222744.17576-6-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-6-casey@schaufler-ca.com>

On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS (1424) record is:
> 
>     type=MAC_OBJ_CONTEXTS[1424]
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  6 +++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 51 +++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c           | 45 ++++++++-------------------------
>  4 files changed, 68 insertions(+), 35 deletions(-)

Similar to patch 4/5, this looks fine modulo the obj count changes.

Related, you changed to a single subj/obj count in v3, is it no longer
important to distinguish between the two?

--
paul-moore.com
