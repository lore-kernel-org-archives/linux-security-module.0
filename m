Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F93312826
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207937; cv=none; b=cr66RlvyEl9YBfSHqSp67GwT8UcdNq1FD8Nt0CGQ7mAkRLVDthGEOVL7JM3L5oxHCIMXuh/FPBMSfNtqpiO71+GCjiquO1a1/BmzeYudqSNu0FDc3t9P+JNtLyQSn8cp7F8SEltq/zPD262VIsR6Osaau4OqcdVLmljvIL63xl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207937; c=relaxed/simple;
	bh=bUrj5jpB752v6HMszHuNqDo5qMCuJByI7yKMX4H6k1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg1d4k3sW+Bgh76SBYp5upz4SAKSdrWWr5PPkasWMxLGsv9pdZ7xO87mB5wd1E+UpWQUL/n7q6yeH0iMtfLPlbr6wpwXBNUMmDy/Vzi2dE2EWxpR0nVBAnGtxYnoHNa0TuX0szrDtZypwIJSjArjGXLEWurtRtETTKFetmbQm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDGClLqZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDGClLqZ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4924593f45dso37204235e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782207934; x=1782812734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8aAn7vW7HnpPqB5+lrJ5PjRff9Jdkjq/Q3glmHe6HFw=;
        b=FDGClLqZu/XweS2IPEjW795DtPZle+xwRQa2xvfHyK4aWcrT6+k8E3D+07zejtqhKV
         zFAuiOiNjHLmVx5IhYn6K6aiD4ABmsRHFSWFXZ5XYDidSI6gjTWkuG2yNYcRbjihW1A+
         FHD9br6KlBi5u7jqHe1xCqDkkSjjCwITE7UudfacrOq57tkvapVfeSkskIS4/l7L6g1H
         0EEhhUo8u5N7CQIe4CNB8QPgI5kDSvGn1E24WlZCjjg30c7GGyBSCzXa+H3zdZ7oCs0D
         oQY8krgEaN5CN5EBL0qzMhOEpnHjAdXfg27hCvXRPrXr9nB3zn+yg2HMt7S1sl9kzc+o
         8oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207934; x=1782812734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aAn7vW7HnpPqB5+lrJ5PjRff9Jdkjq/Q3glmHe6HFw=;
        b=HsGb0IjI/i6yInOgU9Z6CAgrt6ZWf5+LftE4a3YnmxJ0+SyJoPhcNoYWNJQdmDTARg
         EfehUBrmKb+tbUVR0IWBTiegkVFhXZDa6MlO4yQcOBI/9tRxGsUto/z+cVsrA7IbnahO
         swxsysZt7bmf98yYbvVTX69PVN8yh4YE3kbuq7lFcBZ/CIza3cfTVZw4bHYFJFDs/0Bo
         45v+4XwJfRbaVvwjRha8eFP+8enUiRqfIq6TUUnY70O7tkcJXD3DkBMexPbM8kU7tUZm
         /COFy2l4q3exoKi4W9S3rY886r+fJ1d1jfpVZANjG+CuyazfEKsPAZh+E5blrtCezMMO
         u9Ew==
X-Forwarded-Encrypted: i=1; AFNElJ/u2mBC58w2OxC0D/v+V1j6iNEwo0/QpKdgjpY9xRXP08KhpHxbi0cN/fsT+HEslFP0Fl+anKf+XR12sx8wHcICYfkaFUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlzFrg+tRjMCRQxL+WHfx0HK+MoTBAYqJgqXceJVJNQoio3EZ
	c0075MnwHairl1sO7dxYGBlk7kHKwmH9AORn3wp4UlXGpwpDGKxdWFmPrFLi9P0WOP6NTo16Gm/
	EWlnmNrOo
X-Gm-Gg: AfdE7cmhKw3WMYabuKhsw2LyA3ZJQ+QQnMpvPyDQapi+CKglb3NUWnNbriLD4cJdPqG
	6MA6Fj6veKyaX4ptpuWoX7SebfKpERBidBA+8TpJ0f9yVmpN5KyY4/Mlh0KP3QxGlqdON/JD6UU
	zlmku537O03IalU3cBqw6jIw1BwszXRo8OE34US3cwCw6nSeEIgvdkSwi0k/8WGkq1nBV9IR5Y1
	p+QJWqRagGyPWlFAz7IDeKXk8I7vndAFMaVGm077B+ZSl4BO4B3vwtmUlCxQ2ld3LJcEv33NjIn
	GoK4TL3mo16vCa0udJu00oXB2yaF3JtsANLsnzZFc+o3vTOcaaebwcJqQugu6JDiNtUKC/99Xym
	WlF46cPALzb6PDKbIM6XlnYeG0cdLGBMZGyT6mSrVZkPbQy4ovuZ6SKc9Tep/lZ2iF+Mj1SvXZB
	X/K1tTzsMmNWLz72Np9LEpSH7oQR3mKLgt/XAiHIXfiGM=
X-Received: by 2002:a05:600c:8b18:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-4925b38cfa9mr27355855e9.13.1782207933647;
        Tue, 23 Jun 2026 02:45:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:73a8:ec64:c132:744c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4d9csm33593205f8f.4.2026.06.23.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:45:30 -0700 (PDT)
Date: Tue, 23 Jun 2026 11:45:24 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: mic@digikod.net, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: shrink tsync works[] on partial allocation
 failure
Message-ID: <ajpVtFfp0ZxJUVc6@google.com>
References: <20260623050127.48247-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623050127.48247-1-flyingpeng@tencent.com>

Hello Peng!

Thanks for your patch!

On Tue, Jun 23, 2026 at 01:01:27PM +0800, Peng Hao wrote:
> When the per-slot kzalloc fails mid-loop in tsync_works_grow_by(), the
> already-enlarged s->works array keeps uninitialized trailing entries.
> Shrink the array back to its used size on the error path so no waste
> is carried over: free it outright when nothing has been allocated yet,
> otherwise try a shrinking krealloc_array() (keep the larger array if
> the shrink fails, since tsync_works_release() honors s->capacity).
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  security/landlock/tsync.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index c5730bbd..356ce94b 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -272,9 +272,23 @@ static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flags)
>  		work = kzalloc_obj(*work, flags);
>  		if (!work) {
>  			/*
> -			 * Leave the object in a consistent state,
> -			 * but return an error.
> +			 * Leave the object in a consistent state, but return
> +			 * an error.  Shrink @s->works back to its used size to
> +			 * avoid carrying uninitialized trailing entries.  A
> +			 * shrinking krealloc_array() should normally succeed,
> +			 * but if it does not we simply keep the larger array;
> +			 * tsync_works_release() iterates only up to capacity.
>  			 */
> +			if (i == 0) {
> +				kfree(s->works);
> +				s->works = NULL;
> +			} else {
> +				works = krealloc_array(s->works, i,
> +						       sizeof(s->works[0]),
> +						       flags | __GFP_NOWARN);
> +				if (works)
> +					s->works = works;
> +			}
>  			s->capacity = i;
>  			return -ENOMEM;
>  		}

Can you please clarify your motivation for this?

To paraphrase my understanding

* You are not addressing a logic bug

  The invariant for that data structure is that s->size <= s->capacity
  and s->capacity <= number of elements in the array <= number of
  sibling threads.

  If the array is slightly larger than the capacity, that does not break
  the invariant and should not result in out-of-bounds accesses.

* You are addressing that the array is a bit larger than the capacity

  This is in the case where kzalloc_obj() failed.  We set the capacity
  to i (making sure that only the objects 0 to i-1 are being looked at),
  and we return an error.  Sure, the array is overallocated a little
  bit, but now that we are returning an error, the caller will
  fast-track to abort the tsync due to ENOMEM and the array does anyway
  get released very soon now.


The state where we use slightly more memory (with number of entries <=
number of sibling threads) is supposed to be very transient.

Is the delay between raising the error and the final kfree() long enough
that you have seen it cause problems in practice?

Thanks,
—Günther
