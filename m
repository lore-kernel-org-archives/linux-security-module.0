Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236F26A08F
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161841; cv=none; b=ST51C324ORpIjbXutOXydlOUQo/ydf7pSYu1AoN713KZtCpWj1Chs9cG2dsF0ZT39LiPQwLrhDhjbcoOEksRwxkcTiIp5OqWdueDCK+uRAW9DJkcrErwXcwVsHJ+D94lAh8MCFZXksEnlrl5GgFwppoYk2xkVS1I8aBviIrfhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161841; c=relaxed/simple;
	bh=gdFmDy5c0jrATO0ZaV40UIMaul6zbEjW48AU2qrMLIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcXmxQlw7F1SD1lyhnI/SRk7+J7iFyxPW+0f4JcB1+rGQvKwItV9rkAtuJ/Oah4Zcl70dVhi9g0CraQMAw8fl+LLN2SstKK/1DY7KG9FyfAj7fk8v672PDrvdVjKbbWXhb/A6Y0YfxraS/kahxiZhpUz45TerjV+/3jsfYKS5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gun54JpY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gun54JpY"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfa33a983so845570f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Apr 2026 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775161839; x=1775766639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZoZIuXbaOTq6CxvkGG5/h8HZq/8fo5h4kB+aDed2D4U=;
        b=Gun54JpYKF0b2nRJUOZNr6+40+G04rFghB8wKGbqxG+erbrDmwxNYrnFtqpn2hE2ZY
         n+y+NJwdU1kdgj6mjFk1oRAypeE0J5u//ItEhG/zApufdyQoHCZZ4qsmuMBKF6MqfFor
         GkybrLhznf9bx5f3TY5IQfLSjmoKH3JCU/fVGMxi8NlbZz4JoiCVSOOCiTQYC8ByXdrl
         y9bYxt9tGz6cxK0ujBInXj5sPkHZLCVTbtrw+O7uQH+nht5tZ2pIwvZqXXaU2MJsu6Ck
         hwnAES2uRHKeePXZPlFZWpCcmZlFkBKbGKOs+joDSrFu1qZiX+Z6CRDclvF5sst3B24t
         8nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161839; x=1775766639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoZIuXbaOTq6CxvkGG5/h8HZq/8fo5h4kB+aDed2D4U=;
        b=pSxuXV92t9+rlIntqDop0/4DDMB3h+Ngac3Ts5Ir3PHGd1zxZreOgpq54S7S+FybOn
         YWUv//qRm3P6BEo1nwM8bAQYALoZSPe7CzllACRDhDYAodZSB3SZTwxI7GUispHiLdnQ
         L2pQ/Gpp6r+h8e4ZNRzxxc7KH7k7FKREJacSyCJH3VNZF5bnssPM2uY/Jhsnryz0RfY7
         oGblXvtyMgESe3rQ7rvXrgNSsD7WX0I3lb3/RARhluCCMnKPqRuPcaZ83mLD+eSk3Niu
         iojavWR3vOMMsQvXK7o4VhYpvNnDC2J8GrRL+3OSFDuDl2b2lkQI3guaebKcQcwSDBUb
         fMMA==
X-Forwarded-Encrypted: i=1; AJvYcCU+5goiypueR5GRh7YiigSebr1VBSxQuK5L8r7uzCmDRKzAsc5Z9ckC4dWt49PilqCACz+gM4nokl9R5zF/lLzYB0Bwnmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwriqzV0FlrMa/5Zba4ELzkt67SKy9m9u6ZiNF/HRkaxgZWU+NL
	yGKOpr1Kx/JYv84YDA+Wa81AH6IJT2uvPnShregRQIRwvDvqxaGk8QZ7
X-Gm-Gg: AeBDietU/rXHmTOeEyYtD9aLQOMK6678NOeTPvHwmtwpPM7yiBHtydNozro96G/ifk8
	aQWzrNPHwIgTJM5b5A1FBaZQv7H9kSm3Zc82+rotTq/90D+mNbRjNjweGNqjxVQoWnwUYMdg6UJ
	c+6VcdtqXRNirtAaJ0N28lYtpDVX4P3gamZ6ZsO27jtYMzSU/L0Sd0OmasioK5cimpQR2/hq8h0
	//yRdLIEGEwj47swib8P1Hjaq4bGVHb1U05i63MCx+ph80L3YAjUf2f4NRSSAIDckNZLDnSGTTl
	VmIrq+2LTft9gXL6NcMoDdekvTXELuNDrU6AKboSu5TJf5eUlP3O+oHxTJNmUyIPWqkysYYQEta
	7pinVhY5FN9EdjlrelrOtZjHAQW048juvx3eQjN1O5mlrj3K7bcSKsJZHN4daVFe23GL8yEVxJt
	7Yl7+fFDM/9SHYkf0W0d0tkMSRHpsD6SiGFqp1awG5+vWUA8Kl
X-Received: by 2002:a05:6000:18a9:b0:43b:9227:bc6e with SMTP id ffacd0b85a97d-43d292e1935mr700218f8f.24.1775161838691;
        Thu, 02 Apr 2026 13:30:38 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f73sm11320543f8f.8.2026.04.02.13.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:30:38 -0700 (PDT)
Date: Thu, 2 Apr 2026 22:30:36 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] selftests/landlock: Fix snprintf truncation
 checks in audit helpers
Message-ID: <20260402.554667d35637@gnoack.org>
References: <20260402192608.1458252-1-mic@digikod.net>
 <20260402192608.1458252-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402192608.1458252-2-mic@digikod.net>

On Thu, Apr 02, 2026 at 09:26:02PM +0200, Mickaël Salaün wrote:
> snprintf() returns the number of characters that would have been
> written, excluding the terminating NUL byte.  When the output is
> truncated, this return value equals or exceeds the buffer size.  Fix
> matches_log_domain_allocated() and matches_log_domain_deallocated() to
> detect truncation with ">=" instead of ">".
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Reviewed-by: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
> - New patch (split from the drain fix).
> ---
>  tools/testing/selftests/landlock/audit.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 44eb433e9666..1049a0582af5 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -309,7 +309,7 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
>  
>  	log_match_len =
>  		snprintf(log_match, sizeof(log_match), log_template, pid);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
> @@ -326,7 +326,7 @@ static int __maybe_unused matches_log_domain_deallocated(
>  
>  	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
>  				 num_denials);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

(I noticed the Reviewed-by tag was already there, re-sending to
confirm that this also applies to this subset of the original patch)

–Günther
