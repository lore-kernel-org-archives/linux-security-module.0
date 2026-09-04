Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA804E80A5
	for <linux-security-module@vger.kernel.org>; Fri,  4 Sep 2026 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531473; cv=none; b=Ooui7OzHKCCxGOT0KIoHjkZax6DLiw8cy4V+zjTi0B6nGADAPhER8x0T3MWrMO8xY9ckZB09dNVF3WzY+n8s+v6wb7P+mc09/b+EW0/Ag4U6Usm1idUKaT+xv/UPeZQOZz4bARGhrJpFA+yTSjc6i5H9HLPzYcywdCg4UktcCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531473; c=relaxed/simple;
	bh=FKrZPhDJ1GCIJZVpN2tDpoC3v2fy6IamUrFTk3by3qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYezRaGsqAoDnFMsvQDABIBAHQARuQnjv3VqzrqiARNCBj7qSgP007RP54qQjBDw16HPCqaKkikHhm6/OBOgPBvBHARU2dnI+MbdzA8bjYI3Y3bpqDgLyrgMWxiMW0rbH5CvW791B7XqR1gLtim9nD7TlbSh0SOPv9cLpuBPfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBf3CYFk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBf3CYFk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so7827525e9.2
        for <linux-security-module@vger.kernel.org>; Fri, 04 Sep 2026 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788531469; x=1789136269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+G5V04b79HEeNAXosD3Hc/0FZ2lw1BU2aPbUrIPj/bo=;
        b=fBf3CYFkopHXQCnkuc0n3zwFynZ8RKqO3LmXsykjctl+LayLL/iKg9UFRFKPQNWiWI
         1Lv3PSlsfWV3ADBE4+UAUtzB3oHbY6raIoU7Ef4Jl4QQ3+gqAv5g8YsRprYMSa3RYyLk
         SqnHnd1PQKIwT2Xgn/jBt9wWQetJtstdKhzX0dWp2r4D7f4xzRK9b80Fi201cKFKpR1L
         X0JP89PXLM2jS4omxjl4NncJukmRQ+Bk6qO7inL6MsV4S5xaQCmwmM2tmwzdsSzwWfVc
         0KeCjW09NdWXlqN9Jqkx7U2y6S62eBPyrpiN3l93fQZhbTG841S/T/COxM0ZAs6gZLmW
         TtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531469; x=1789136269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+G5V04b79HEeNAXosD3Hc/0FZ2lw1BU2aPbUrIPj/bo=;
        b=WxOK8YH4Nt9KQcGr+CsRc8QZNbaCTbzIKwGx+W15hRVX1aK4XK/e3WMJk5yS7KSPJz
         VzdnmwXdwkSFriyhIh71rr+fMrCxq/6OmStfwKFxRQuKgcNvoJuTqr7l4Li/wvPly5Zo
         aMXRp5y1IRt/ge9nUhwSaWxJpn+bLMJvjpM3oKg/szf3DQT/WeVK7eKEgN4ONhCNngES
         gxRWhMzLsL9VqhJMcwf22Sm6k3jO/fxjzODvniaCBxc2Jniz9eYGjLma5EensEL2OZ7k
         0V34E6vJ3x/yul41iI93OJr5Qfa2ZnC08CC/Y0Sjg8S0U/u8OlHv9AGNjZafeRCdkKTT
         hPHw==
X-Forwarded-Encrypted: i=1; AKwUvByzewryD/Cn4lhH52j0ubQbp26Ru2VAyGXPFaUaRb2OVjquyI/2sYOj0hVjB2RCP5PK5IYQxDVmFzC6vIj6/IdKeTPgzMM=@vger.kernel.org
X-Gm-Message-State: AFuF++lKPuhFix1nxnTZyaoIeaLWSCkr6vEf9eu6ym/BWcwOnaIPqepf
	Jf0pdXD45jqhgTANssWx9slt55mnpVZy/3NgexJgPnye61Bu7FDudOu5fNGSKdbo
X-Gm-Gg: AYBFou10KEOsZtXsA5peGuTTa/VV1Ce1gxQKd0AvVNBj20OKrndX9WjribuK52SjK68
	p5eix2o6k70eIbYZ3V5edKpA06uKRT7tLTNEex+BmCYxRxTL+OG1llmLSTUyOoKGG/cPV60ZRhM
	dATPrfLD2RXX25d4yUeXogk6gagsk6vfYL4JEnDRWN6YtquPwUfIkVr9qoOrWHd6/PHjEjEmSRF
	OIpy9HLnphC28JN3xigAOKfUwUqoz6HV320zUAjqr/Wc+8kGJ6BRElXFIIttEOHu3CmJvj1+mLz
	NXX9p3EhY2+ZpYf6l7o7XiV6JfVs2JIy13k9qBEYHPSDHNO9O92NAlRT4ct7NGsWmnnL/4GhTR7
	21wzOpLBGddOHmF7RUfXyMC14I77FfnemJjWVHZvSCy/hDsn8ujSG4ZPSJTNDXAd1yULUgGLGT6
	bu8R2dgaYpgbCUOfaDSGOT4FNsaFKYAgFh0btq5qgWNSZWMFNe2ChMimLU42yUkRQaIWFX1rcLt
	gHVxQEMhkbINUxFx38hOTZBPd3cYCU5KYGJ
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr38594935e9.26.1788531468344;
        Fri, 04 Sep 2026 07:17:48 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883959f0sm7139278f8f.10.2026.09.04.07.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:17:48 -0700 (PDT)
Date: Fri, 4 Sep 2026 16:17:46 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Ye Liu <liuye@kylinos.cn>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] security/landlock: convert thread iterator to
 for_each_thread_rcu
Message-ID: <20260904.01fcdd4c37b2@gnoack.org>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-9-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904083001.553587-9-ye.liu@linux.dev>

On Fri, Sep 04, 2026 at 04:30:00PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace guard(rcu)() + for_each_thread() with for_each_thread_rcu(),
> so that the RCU read-side critical section is scoped to the loop body.
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  security/landlock/tsync.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 0b71e158c3f5..f1c08aae179b 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -335,9 +335,7 @@ static size_t count_additional_threads(const struct tsync_works *works)
>  
>  	caller = current;
>  
> -	guard(rcu)();
> -
> -	for_each_thread(caller, thread) {
> +	for_each_thread_rcu(caller, thread) {
>  		/* Skip current, since it is initiating the sync. */
>  		if (thread == caller)
>  			continue;
> @@ -376,9 +374,7 @@ static bool schedule_task_work(struct tsync_works *works,
>  
>  	caller = current;
>  
> -	guard(rcu)();
> -
> -	for_each_thread(caller, thread) {
> +	for_each_thread_rcu(caller, thread) {
>  		/* Skip current, since it is initiating the sync. */
>  		if (thread == caller)
>  			continue;
> -- 
> 2.25.1
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Looks good, provided that the for_each_thread_rcu() macro gets
accepted.

Although, I find that in the Landlock case, it does not provide a very
strong advantage over the explicit "guard(rcu)();", and I find it
normally preferrable to use orthogonal APIs.

–Günther
