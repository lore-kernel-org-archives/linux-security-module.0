Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A34052C3
	for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222191; cv=none; b=J5hAQtQGWSiN0Vn2tjWJj27m72Csls0OgryxqNKNoRaVSjahau/Cf4QFcyJL/h57raTzQl7S7eTiDzSNg0XYq1/V7L/jmTVCZR0b+zwnM6DVIBo1wQCEg8/U76MjjSyep6yhonQyAYnDk+h5xuZAoku4ulJsAmqkuq5srIuq7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222191; c=relaxed/simple;
	bh=FsZofWksRuzFvPkX/+F6Criwr5kIGM9zzDgOXysn/mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU9KkSIqZcKwXlUoqNDHoCER5uuHDcJ7XwFJROvu/UvyzQUySR7gOBhaeraYkkassiRqli6lkKm4NXJwtRN6k3Y1P7GQ1n0k5saE6/tRnvOZK8KnbZkVNnRbBkqTVeZVZqilCYAKlMrGECyTSJq43+85/Gi9+/K8SRJgLEWYrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pAetInl6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAetInl6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so22271315e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787222188; x=1787826988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6er9iArCEFrdmjNmw5e8mJvsWGPCU5zllt9FnZFURwU=;
        b=pAetInl68weZ9sG77Lw3RGSefSyK/2PCNiyxHUwc7cNBUvAPLQ2R76thEMRC1Ex3aL
         GnB1cc93O/DAaUwBXeIpSCHBTkMluwUVuantMUrcP424ZC6yCW5dTEGToIw/obKNMrvH
         Zhs9aenNtVO4XoMy2DyMVlv14heRAFjWpRk+T8BXSYpDZYDz/54V8ZYpGPzgEsMSX/Jn
         vmM/F/rFufAs43rkOVEX5lw6bJDZI8K782h580i39DF1/QxP8AnbPnncTSAsFSKJAP/f
         62IPLVHfFhojZ+TYkXn1B29tQROhWuFabH9ldMBnmSQLun4q8/bKGDzqiUjvrjKZReSU
         qxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787222188; x=1787826988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6er9iArCEFrdmjNmw5e8mJvsWGPCU5zllt9FnZFURwU=;
        b=oJAi2CV2/Q7Nhw2y99/rDtfEnE+D+BXAufad88V5lFWegpkpvkVk203neAuh0XXDhe
         CmIG3kTiOOrzSHAS2qeb2K8wTd2XDPhzdA9eYY5z/GKNd8DoPZyHCeMeU1CFAByzuMBC
         7CxLD+0DeIit9nSStphK9sey0K8SwggiZOs28EAhAV0y+xDny3gUGtFZNweguWSBnCut
         FitoI9ISvzplp3ihVGWEUQ56MIgU/UMMu5x+s+XH868YCbitHBDVEwshHI6rnDnjdoOB
         fmYYP7fwC1MJbfaMFxpGA5oms5ukxEKfU7ymQHQxvVoT8EQtZ8HDtWuZU87NeJnW547i
         EzoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4zGIf+ZNeAw+yVeXGEpVQa2DldyU+0yLBH3YfaaZXqM8WT5BlL//ulmqs0uU/JHQ6ScNmS63wEUyUY28rLjlPMZgjW6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVGHhDAzfxreTJMWowAkUH8oaikkvXdyEJzfs5qkXHo9HmIAx
	f91sGO3fTIMEZhjK56J7TcImDqBWjWkFmI1fCdP4ayu9XWgoCJHbXVQUCaVt/Icd4A==
X-Gm-Gg: AR+sD12DU6r2p9PwuWvbEHnR/N8i5wi4TYymLPTwrzyxBkCGi2d1pJWqBrEn0Zc1b7I
	nkjUMrfp1J/5Qia9rjUH71XtakCHa3PMcB0vD7bjMkDU2IJRsAVh1ifA0TRwFUsg8991ZzLHTbj
	tHmWjYqwgHC0iPsl68kkGozwM3TkDpN8faqauPGq7haoIoi5xJ6GiXKBIiyUQZmC/5UmykOPOHB
	zuQ2kpz846YCFH8e7xQq+m+F4mwtLuuHE96drF2wbA7PvyuTfrG3hrQS1NmKFxpO6Jov4+7tR5e
	Kf7lbbMADH4Me4dA0KyQ1XGsTA8Un044bX+DlpTvTvMILz3ZkQUdDYMedAhiOZjK8kmVZBDuAiR
	olSUQIV0YtdYKZ/nQuprUVxx5ybvaiPmOvO9AD8aHuVHK45j+SzzLaq6mocWAV+WYZHpwXa53FZ
	feh0C377uLR4D3cSe7IzjvkfNzNHr6XvwP1BmIVi0uipxvT9WnklbZL2JtpDNRoEwiQ7y6fnhdP
	49Kx3TtcnOrbikWIjw=
X-Received: by 2002:a05:600c:3b95:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-499aa1b97ccmr193609775e9.11.1787222187463;
        Thu, 20 Aug 2026 03:36:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d956:c85e:ab42:2c9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b29e19f2sm31708775e9.4.2026.08.20.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:36:26 -0700 (PDT)
Date: Thu, 20 Aug 2026 12:36:11 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/19] landlock: Add create_domain and free_domain
 tracepoints
Message-ID: <aobYhIt3vcs2xN0b@google.com>
References: <20260811094338.288094-1-mic@digikod.net>
 <20260811094338.288094-10-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811094338.288094-10-mic@digikod.net>

On Tue, Aug 11, 2026 at 11:43:23AM +0200, Mickaël Salaün wrote:
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index d0b35ccce122..7651eee8fe02 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -427,6 +426,7 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
>  	int err;
>  
>  	might_sleep();
> +	lockdep_assert_held(&ruleset->lock);
>  	if (WARN_ON_ONCE(!ruleset))
>  		return ERR_PTR(-EINVAL);

This checks that ruleset is not NULL, but the newly added
lockdep_assert_held() line already dereferences it before.

—Günther

