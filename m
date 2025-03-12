Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EB1A256B
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779162; cv=none; b=nggWifubvhg8Z3il9nU6iaA+cmiPSyCaAVpsOenQDRQQNW2N6eygOiev0BDb9Ymxek2qxCOfqHq36G58JlWzjDRHe1mhY6cl5lFnUGpIWmOnZDhm3dpYrDdE+66b4Mt7YNgNGhTdimS9iSyeUn+efyJyXVTleyP3ndXnTRLVA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779162; c=relaxed/simple;
	bh=hB7cbA7EyRC+l9Gia5ItRMy3LSkB6vp0fujxrdtaHIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDx9tp8A8JyB1NPA6ZTdP3eDTvVYMLzjv8ieqMbnxeHJ+5ra21Xdmj+fLNGGWDBWgE3NHkqZq9eXMjf1mAkFDzTjtDRPUGP7m9uzNho/pu9tYS3FL5aQ4gDJiEaMpqBIJUJLD1Egk2EqqHUEEl9WTnUfOFDPSlAeBZkZWlCKAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rmL6SMsO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmL6SMsO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912c09be7dso3603844f8f.1
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741779158; x=1742383958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3nFEoLpFF9YtTM0gdngJeq+IrxApmUKsC02THXL5Nw=;
        b=rmL6SMsOlKFJqP1f5WmpK5Xh422oaXTPM9EXlQEpaNIfGlZSIxTQ09jbifjdYFZhjB
         UNdiuGTkbgMLN1E58mhhQhu34LctOEw+t432jZcWeF3G0a2mtFogvp766p1J5Pf5y5RC
         zL62Be+8bqeyE0afVmCKi28QN71xp52Z3MQm3t9NxBaPPK32g3dAr5jk9DmLeLbsj4hk
         VqjI2JFPTgkb1tVtj9tZ3cvEIzmZCowbxRVJoWAkbieQUaVpHqw2q4qQ273D1/OWMNnE
         0Jq2R+XsZ0WgI6/yMr1Z/y+8nqK9orvelgJjjc1n1oH+VI0T431VP2XjVSA5204c/YZf
         tTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779158; x=1742383958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3nFEoLpFF9YtTM0gdngJeq+IrxApmUKsC02THXL5Nw=;
        b=cCrz+X22UmR6dAa5Fja/x6OlSBSjMim8rMcYChzCFm2WDPqxqF+1PYcMwImXs1jhmb
         QKi/FN5buFtS0lD8qANUUmFtAHUdKnI5/oG6LSjzr72BMq+gfk9fDeNuOyA4OC98g5J0
         CM+4nMA+XpzQbPOMdXcdiPKrGSPH2sf+bdNvRxggaXuzZ9hgL2VkVjqHRlcT7OzNvOXD
         opM7w3ZTTprMQjigmi6ssvlV/BKVm91VyZ9Xt1f9nrnSspy+YjQS2f+2ZxNh5qAQuPKe
         wczvDFnFCLirQ8ROfj1wQAeX9US8332N7dopwAjGiABrNoSPCx3tQ7pO11hV4LxIweoS
         ZGhQ==
X-Gm-Message-State: AOJu0YzzlJxZV3b1aNZOC26X3pXuX9DcV0an21sz91s/4EVeA8jcD62m
	sTDMLM2on7DPq6h/+YtP+y0bxbCBr1oRkoM+fbZtJIUDiMgfhii6o41r81rt/b4=
X-Gm-Gg: ASbGncujQY1pDzZwBowM2d5UQMnKaDQb25G/BUhEMaGMv4MPjruvm2cxzIRJr6VPYUG
	KyxfwKgtKBk7oJ08Mvglw/HJNUYtDgmr3qim0Jzdn6shEj2JersPfxrZO40v/QANS3DpZ0a+uIv
	IwVU8washjv2aVZ1YHwd2ZLTeRql42TIhcoSWy7pbTfdPsj6YfZQpatztlqQR27KccpKq4VU58B
	Bio07DJtzfmO8m0GYMlgcweMGoVVtUb4dS87HcIZYq6lY+5cYtwV04WtV3aSdvQ13S+rmzkfre7
	4591RKlpJP9WZGwZPFkt91vX3kdEnXZFqFOIZl13oZpVI9xW6A==
X-Google-Smtp-Source: AGHT+IGtmxBoSDmmngQTkogsSff4+yQy9CBM8kT4DVnLREQSOZYAQrOn51uqevokUlFDQK4fZ6Ax8Q==
X-Received: by 2002:a05:6000:1f8f:b0:391:304f:34e7 with SMTP id ffacd0b85a97d-39132d985f6mr18882223f8f.44.1741779158367;
        Wed, 12 Mar 2025 04:32:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c1037b4sm21003703f8f.92.2025.03.12.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 04:32:37 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:32:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: [bug report] landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain
 status
Message-ID: <323222e6-f15e-4950-ade4-181e46b46469@stanley.mountain>
References: <2425110b-b5ca-4b33-bf75-e6fca0b0de63@stanley.mountain>
 <20250312.ungooTh8Iotu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250312.ungooTh8Iotu@digikod.net>

On Wed, Mar 12, 2025 at 11:50:31AM +0100, Mickaël Salaün wrote:
> On Wed, Mar 12, 2025 at 11:33:29AM +0300, Dan Carpenter wrote:
> > Hello Mickaël Salaün,
> > 
> > Commit 96cc6f48a8e4 ("landlock: Add AUDIT_LANDLOCK_DOMAIN and log
> > domain status") from Mar 8, 2025 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	security/landlock/domain.c:66 get_current_exe()
> > 	warn: 'size' unsigned <= 0
> 
> Hi,
> 
> Thanks for the report, I'll fix this issue.
> 
> I'm using Smatch's kchecker (commit f4f26f80d4f3) but I didn't get this
> warning.  I tried with and without build_kernel_data.sh but I get the same
> result. Which command are you using?
> 

Ah.  Sorry, this is an unpublished warning.  It's not far off from being
good enough to release.  I'll dust it off and publish it later this week.

regards,
dan carpenter

