Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473E92561AD
	for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923283; cv=none; b=dE3IxnuwV46kXL0X+X/KDxIG2V0ksFPxYZukL2W56uWxSaxIBbGqBkl5TT6HrDEaH7NLXG2aDyT9To9Zm//cV9vvYDGAwQQmimGNWvR/4tHYEzvFwd6KIg663+aDUTuXhxwv/MO1p/wf99MMgViTnn9A5PH0wzNumuCVmO8LoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923283; c=relaxed/simple;
	bh=NPknPnvDYpCkn1uRCPkw+yzN5O4OIPBJN8iAy4E9wm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg70t0ii8nZbgt+0vrbmckS/rJ3KbFTAaNsPO+iRGUXmPpnZmntpZlO1JQ6ZGwAJtvPWnGDxDc2Be/R0ZlLQKz/3K6WL4bgZrKFG5S68BfHif78j70Jd8xOolNyoIEMIZ5HBGQuTKUUB39QEi/khcyt+pdTOIh9XX2a0SAlqPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=V9P2qGD7; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="V9P2qGD7"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d46fddf357so19019055ab.2
        for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742923280; x=1743528080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUIk8GuXhrJ6jaAZ3MspJDXmvD8FvwUk0pjUc2gjmR8=;
        b=V9P2qGD7NokJPLELzfKjurERrkoT9mBdkszmK08S3EnSwq9pJlw+IE6l/2WOWLjDm/
         bg90lLLYtk5AgkDaP/lA3T1mzMgomC1Gl6OIDFAQTsAzWdV/1i6NurlZw5ipCk9ST7j2
         okg5RIAn7zCgu5hoFKODix+5YwPZiER20PX4MPloTKdFDvOl3ERISdaATFnEj7YniPmg
         t59r/4zVdvHYDt3kymFG0MjArndqM+oxahR3QrCzJVjq7F4rnFuptPMNUjbsf1j6B1yU
         vFFNhN67TNJKnaPP6JzYxrSz+XVIbg+CnWw73+O/7qF8b64gxeik230t7He/2Tu3flOi
         HxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742923280; x=1743528080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUIk8GuXhrJ6jaAZ3MspJDXmvD8FvwUk0pjUc2gjmR8=;
        b=rqo34A+A2p6pywbt9wKQ0sSfrvt6rxjvLwZepTSun7J4NltDWS+jbs7xXmD6Kr5YaY
         LKp4YYZXjQKWeeHKbwUB/n0n1uuHZvZauwVXNpC5qgvXjJcOPFWLZYkZqu0P/xTDd3YV
         l6oxi0mRj4pcJV6ziZVSYH+mx0s/VfSEChiEd6d0dhvSnWBKMWX0DCAdne4Sv7zKbhgG
         1sta98gsqZzYZfkPHEQPFQdQopLBNoyHmzqxo/tGdJAuH9olBVw4bd7y7gjvC/aJkr1/
         qmACFO1Ll6K2dB1KX8vprE986xg0f9LD8DaE4Oxf2JXePFD80US79Xmyrmz981lQVkZ9
         PHQw==
X-Forwarded-Encrypted: i=1; AJvYcCVl0ZUPa3YTJ1mIFRI8jBvmITM/IoXqdQfXSqtwmtzJ+zSH+ptR8r6jbGxxhUJoh1NpibriPM1VA2obEtgzQhZK0J4c0J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDihxf8sJcpvMp2rimFvfAGL7mY4A9kWB6m0S3qT6Tz0Nupo81
	xZ4lGVyYiMyZiG1c78DLUJbY5i08piF/GrLG869eo2Vy4ib2G7wINyPFNza02+c=
X-Gm-Gg: ASbGncuKHdKP610AWlfPatmlNRAzotjP5rGVHfoqV38aPEZMDyrFoBh5e5vW87tTq6U
	mi75SwAI4hlqU1FbdAVfgoVBz2o1v09s4F2vNSZuF8FRvhVgKx+D8f29BygBCDb8dtNCCAeeRvH
	gfA2jZEbGmVQWpipvdOYyqr9EMpspAwl8oX78rntOQnLktjFUE2Lkuudo8/5orE7tN+TZlfma/C
	hfdGP9xVdPhFowc2VIb23h/lq8aEC9kxAq8UO8iVuhMPhPxLpNgGySYdhMPgK8SDwvjyqz3oKNT
	NV8oVufyLoQ2Sw2IcozvPQJ5Bw==
X-Google-Smtp-Source: AGHT+IErn2yVyz/LPwGN2xKKkAB0TxbWGFBbv6OD2treCwqPSm7m+FrwT6OtLiJJGQdJfF0D55qkhA==
X-Received: by 2002:a05:6e02:9d:b0:3d4:2306:6d0 with SMTP id e9e14a558f8ab-3d59616b92fmr159808305ab.14.1742923280121;
        Tue, 25 Mar 2025 10:21:20 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbe80a3asm2455156173.95.2025.03.25.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:21:19 -0700 (PDT)
Date: Tue, 25 Mar 2025 12:21:17 -0500
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
Message-ID: <Z-LmDe4E4uMZlArE@CMGLRV3>
References: <20250325155934.4120184-1-fred@cloudflare.com>
 <ed260472-c07e-4172-b389-deb8e92f416f@huaweicloud.com>
 <Z-Lc5WxW7NRA6AiT@CMGLRV3>
 <c1185901c99091a29a865f7a862bc979873301ad.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1185901c99091a29a865f7a862bc979873301ad.camel@huaweicloud.com>

On Tue, Mar 25, 2025 at 06:01:09PM +0100, Roberto Sassu wrote:
> On Tue, 2025-03-25 at 11:42 -0500, Frederick Lawler wrote:
> > On Tue, Mar 25, 2025 at 05:30:32PM +0100, Roberto Sassu wrote:
> > > On 3/25/2025 4:58 PM, Frederick Lawler wrote:
> > > > On IMA policy update, if a measure rule exists in the policy,
> > > > IMA_MEASURE is set for ima_policy_flags which makes the violation_check
> > > > variable always true. Coupled with a no-action on MAY_READ for a
> > > > FILE_CHECK call, we're always taking the inode_lock().
> > > > 
> > > > This becomes a performance problem for extremely heavy read-only workloads.
> > > > Therefore, prevent this only in the case there's no action to be taken.
> > > > 
> > > > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > > > ---
> > > >   security/integrity/ima/ima_main.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > > index 2aebb7984437..78921e69ee14 100644
> > > > --- a/security/integrity/ima/ima_main.c
> > > > +++ b/security/integrity/ima/ima_main.c
> > > > @@ -181,7 +181,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> > > >   	action = ima_get_action(inode, mask, func, &pcr);
> > > >   	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
> > > >   			   (ima_policy_flag & IMA_MEASURE));
> > > > -	if (!action && !violation_check)
> > > > +	if (!action && (mask == MAY_READ || !violation_check))
> > > >   		return 0;
> > > 
> > 
> > Hi Roberto,
> > 
> > > Hi Frederick
> > > 
> > > thanks, nice catch!
> > > 
> > > Thinking... in fact you are saying that there are conditions for which
> > > ima_rdwr_violation_check() does nothing.
> > > 
> > > For better clarity, I would add the conditions for which we are doing a
> > > violation check in violation_check directly. So that, one can just go to the
> > > function and see that in fact nothing special is done other than doing the
> > > same checks in advance before taking the lock (the conditions you are
> > > checking on are immutable, so it is fine).
> > > 
> > > So, it is not a write, and the file is not being measured (this would be a
> > > bit redundant given that we are checking anyway !action).
> > > 
> > > Thanks
> > > 
> > 
> > The ima_rdwr_violation_check() call takes a action & IMA_MEASURE
> > argument anyway.
> > 
> > My initial thought was to replace ima_flag_policy & IMA_MEASURE with
> > action & IMA_MEASURE there, but I wasn't sure if there was a race
> > problem that the ima_rdwr_violation_check() is trying to catch for the non
> > FILE_CHECK cases.
> 
> Let's keep as it is for now.
> 
> > Otherwise, I think the checks in the ima_rdwr_violation_check() demand the lock,
> > and therefore we can't just move them out to that violation_check
> > variable--unless I'm missing something. As for other conditions, I think
> > it's _just_ the MAY_READ we care about.
> 
> Yes, of course.
> 
> I meant, since in ima_rdwr_violation_check() there is:
> 
> 
> if (mode & FMODE_WRITE)
> ...
> else if (... && must_measure)
> 
> 
> which don't need to be under lock, then I would have modified
> violation_check to:
> 
> 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
> 			    func == MMAP_CHECK_REQPROT) &&
> 			   (ima_policy_flag & IMA_MEASURE)) &&
> 			   ((action & IMA_MEASURE) || (mask & MAY_WRITE));
>

Sounds good! I'll make the change and submit a v2.

> Roberto
> 
> > Is what you're suggesting to move the check mask == MAY_READ to instead be in
> > that violation_check variable than the branch?
> > 
> > > Roberto
> > > 
> > > >   	must_appraise = action & IMA_APPRAISE;
> > > 
> > 
> > Thanks,
> > Fred
> 
