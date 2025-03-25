Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1D25BAB2
	for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920939; cv=none; b=HOoEGB0VbYzsLj0c09TQIOvdP0XEm10+6s4Yqum9I5rG6EuevYxvdH2TFhZJZqtgfPB3UWkEQPcWGutEeUEm3J/xFWebz5c11GpAM005xmQSxDoR8xE87xUu3vZ5HOM5WQvNmFZpj8f6C8ahvxW9x9UqsrCNZHQQ0QVZJwa2qzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920939; c=relaxed/simple;
	bh=y7OamuBAgjFXR+Jvr6EGbrgHFrZXlUxgR2Lvs4CxHO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJmS2jWnlT8duAf/wYEO5ujFFMHRhif3+qqWUOHARUbz6QDoBXoItiCujVFtIp1bYYJJbLpgM+ELfoPN2o71BXiP6cNn2HVgGed02TLNtGwMManaq6SFnNkb7y/qxsJ6oM3D0ww5KQvAQlQvIsKkSRMvk4dX1HZev7WHELzCsbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fqfea5kj; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fqfea5kj"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85dd470597fso169854739f.2
        for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742920936; x=1743525736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTTJMQh4Q7DaIdKz4FEr6Yox4Ji7tjGb+tqy7Vmt25A=;
        b=fqfea5kjcd9YySAuH7CSfe/UMHjJiBldO0bh80dNDyrhvUFdyBzS8CUDoijwa+j1qo
         YE6rBPMEEGVBqVJDmGiQbtLfbUle5WJ/QZQ9qb4TsxRkiIablo1zkZ2StUXw7IyfapIf
         NjdGXgNOJQWXu0knkLm3zYp/hwAhnnIIUfBSWLzb4Cs6Y6M8dLR+mnOwvBgDrvPQTGxn
         uygkgQncOhGbgCwbVhxZ/u6E7ChD7Lwiulx7GFVnaA5XzLJ5vx/AvL7D+kSk5M2Rzikz
         BgNgITzsdPuy5MeC/y/8Y409QPue+EvafFuXx3n6UfHgeEQVCxWIzDfRNM8FiPAy7md1
         HnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920936; x=1743525736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTTJMQh4Q7DaIdKz4FEr6Yox4Ji7tjGb+tqy7Vmt25A=;
        b=QqXQPlQsx5QjOzz8ytMWaUtlnvFeB2FCCDoNalGfTj6mo3wf+GmL3VH0Qqyj7FzBP/
         PxPF3BmggXJo699utK4D0179KDSAYMOggW60bXLsiRZVNZMXowOev4Ukn8BnetfI7iEq
         5zELF1nle3vWer45Z0udsnoNiwpLCbxJ+f6pk5B9wPqEz5DLexO7t82oDSZMi49r/CSj
         vGXhTrCfYmkBaOMPEcFuOvF9zbled4NhAdWf+y3P/rEvull18cL1gEYkQck8ZxR3FSkv
         Lf9u1pMj7n4mnOHFB6HeU3jqMXNZNT37XgNceFzaF4TPtrkL1HZMD8F8ndXGke5S/Dbj
         HSww==
X-Forwarded-Encrypted: i=1; AJvYcCWkOgdmuR1VYiTgpdojZtL1C1nhgkGYTRZ2QOoxU8YmN6zxgksyWd3LSm89/sNYeRXKYNCM6XRTp579qjwNH9CeJILfBeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsfl6dzb1BSGSOIS8/ZVM+CR5NR6De/WN1RZY6aERdFzwuqnX1
	v1mYjcJ7Sz0r0MsZSy2Nn6+TPPvExXH8/KO4qX5HmhjONDOJ7QufBGKYlCiZOcY=
X-Gm-Gg: ASbGnctxx8XMvlrPqFyrkAZhyKNZ85EKSVp1K69bJCdIQkO3ZqAXTCxp5auP2P1st0H
	0QzWR+qfY0m2GeZxeJH59BVNWLBF1/1K4jgqnbwCuMHmhHhgVSJw1f9uIkVoYP0Qz7+Pe+9rGKV
	qa4cXOpAHwXHIdTZTva2l7NOoiXeGXbMku3wZcamsepw+JjYWupHe7WSQpvJOkkAdDICzET7sd5
	V3p+xQqQ5kN71i/AreL7gmFQbZejt2JLvEdObCv7YPCkDWhL2SEHHVzMLScONL5llmfuo8qi8Q6
	IH3CMbTFcIc9fz6Ch7cChiyB7w==
X-Google-Smtp-Source: AGHT+IEdPrW1IPp7TaRd95u5F0Qr/v/DMqiOQfCe8RwxVTGAx/HzWij7cnyT7kVBsmL45dqQiPVHww==
X-Received: by 2002:a05:6602:7206:b0:85d:a5d3:619a with SMTP id ca18e2360f4ac-85e2cb4e77emr1733704839f.10.1742920935834;
        Tue, 25 Mar 2025 09:42:15 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbeb3817sm2454206173.126.2025.03.25.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:42:15 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:42:13 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	James Morris <james.l.morris@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-team@cloudflare.com
Subject: Re: [PATCH] ima: process_measurement() needlessly takes inode_lock()
 on MAY_READ
Message-ID: <Z-Lc5WxW7NRA6AiT@CMGLRV3>
References: <20250325155934.4120184-1-fred@cloudflare.com>
 <ed260472-c07e-4172-b389-deb8e92f416f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed260472-c07e-4172-b389-deb8e92f416f@huaweicloud.com>

On Tue, Mar 25, 2025 at 05:30:32PM +0100, Roberto Sassu wrote:
> On 3/25/2025 4:58 PM, Frederick Lawler wrote:
> > On IMA policy update, if a measure rule exists in the policy,
> > IMA_MEASURE is set for ima_policy_flags which makes the violation_check
> > variable always true. Coupled with a no-action on MAY_READ for a
> > FILE_CHECK call, we're always taking the inode_lock().
> > 
> > This becomes a performance problem for extremely heavy read-only workloads.
> > Therefore, prevent this only in the case there's no action to be taken.
> > 
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> >   security/integrity/ima/ima_main.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 2aebb7984437..78921e69ee14 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -181,7 +181,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> >   	action = ima_get_action(inode, mask, func, &pcr);
> >   	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
> >   			   (ima_policy_flag & IMA_MEASURE));
> > -	if (!action && !violation_check)
> > +	if (!action && (mask == MAY_READ || !violation_check))
> >   		return 0;
> 

Hi Roberto,

> Hi Frederick
> 
> thanks, nice catch!
> 
> Thinking... in fact you are saying that there are conditions for which
> ima_rdwr_violation_check() does nothing.
> 
> For better clarity, I would add the conditions for which we are doing a
> violation check in violation_check directly. So that, one can just go to the
> function and see that in fact nothing special is done other than doing the
> same checks in advance before taking the lock (the conditions you are
> checking on are immutable, so it is fine).
> 
> So, it is not a write, and the file is not being measured (this would be a
> bit redundant given that we are checking anyway !action).
> 
> Thanks
>

The ima_rdwr_violation_check() call takes a action & IMA_MEASURE
argument anyway.

My initial thought was to replace ima_flag_policy & IMA_MEASURE with
action & IMA_MEASURE there, but I wasn't sure if there was a race
problem that the ima_rdwr_violation_check() is trying to catch for the non
FILE_CHECK cases.

Otherwise, I think the checks in the ima_rdwr_violation_check() demand the lock,
and therefore we can't just move them out to that violation_check
variable--unless I'm missing something. As for other conditions, I think
it's _just_ the MAY_READ we care about.

Is what you're suggesting to move the check mask == MAY_READ to instead be in
that violation_check variable than the branch?

> Roberto
> 
> >   	must_appraise = action & IMA_APPRAISE;
> 

Thanks,
Fred
