Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC31F4734
	for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616091; cv=none; b=dngAIrbu/aSEGwZlOEuH0uO8aV91zGEJq8+NlY/fRED4TCc0f0aZe0BOBaOGCZRx9WaHgq8SCUstO1qo/i4F97dzYQtFR/8UcHw3QDGtcuRbxRzEjM5PzFOHW2lcsJETxWbSgZlcvqxg9Vzm/mRBJ0LIwgBkBi6PkO/MWSzQ23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616091; c=relaxed/simple;
	bh=YLuBWG6/qc7ga5aPtQTIDDS1RpWthIDoLcApXgrfLZ8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=S5cyC6YBBuAxhobCI9Xl5Mro4TEWGDNj57StF/h+NPINEbDedstD/KZhchBGr9mllQjK6yApBoTMTW0JEMbDLxwALpZ2Ui0h2u2h/3nmtEG/X1fDdu3qGjpXCaouSCfn7Imo4uoMFzSy5amPIxcx3psKCSQYZEtpIQHqEgoXaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AtbSpvr2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AtbSpvr2"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7afc847094fso95758785a.2
        for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728616088; x=1729220888; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBDimyqC4CJK4p2iBMj8GbFo0/9rbwMGrV3N2csFsfI=;
        b=AtbSpvr2QAKK1sYFFWgs6GGhi1qeRU0pYE/OpaTzaZmoFmMCVrhXhW6IjKn+DLUIdo
         Bq0b2Q+9CqDy6EXilVYr/HfKliG0VnrTZ/SunjhniFt2psA3+BMp11j+8BxNX6JkRb8x
         uyMoDV2aEs6OiIsQlROXcDwNFO9e525rfKgqy+MD55HlDkl4e7lsB16q+J4tt/MjU4VJ
         K5owi/TH0nvO4SZrkLrjXhL5cBM3oEKQL1pmGqk8XG1QskoVQuXpMMUzyNE2QC91a3E/
         AVpslDPydCSdDJA0w9cvRliB1G8JFRnySFmKJldZlk33S6O/qWzch5e0bJULhdxFSaJA
         EO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728616088; x=1729220888;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JBDimyqC4CJK4p2iBMj8GbFo0/9rbwMGrV3N2csFsfI=;
        b=MrSCT3QlNuSLDKHaCy4kDuZnbWR9f4Ld53PICHWQvSrhG63MXXNB7dFrVSkGAZ8CZ+
         GamLFFaduCBilOF4qoLR+SGgc2Ec6RQAFN2KmFtfadtLWH5dFDyiky5ebH9QpPp3eXn7
         I9RsN7pwLiD2wxxTDtlM+DFlFmgB6IbqBnBUeEIN/LjnqN4DxN8K4suzntdKdnc7Z5MM
         oxp5tDnQ7/5hkKeGPIaUFED5jJgREHa7k7w/3dLm0NTR/qGj51DkWy9i3kFzDTqL8U70
         FJjA0bgnAPzNIFLissNqX6PjhpugG0S3d07r9YONovZyu+BdIfdr5ByxtJ+ifoKT9rWH
         kN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJZsbUhrOhMxBKTO9AlGQPbhR0eMcOaEcD3LLiQdtF5zVdt8PEd+kCCV0ar487jZz+IWcPXkwhG3kr6SMrAPyLjU8oXyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKmoZy3Pfr5w0URm8WT2ZkUgMMHwNqAZPy0EqNDI5p64/4jBz
	AxYbPez2lTsOR38SK6+1M9hYcfVM/JXCX+uskItq9G6iFmECNIr5REHOR6f/K5emmH2A77iizYo
	=
X-Google-Smtp-Source: AGHT+IEq45tHLzd0BJhXzLGe1YJAlDo84n078XLgRxpwqpJN8UttW19ZEx28YGyczqACohCw1soA3Q==
X-Received: by 2002:a05:620a:444c:b0:7a9:c346:382c with SMTP id af79cd13be357-7b11a35f629mr149344885a.20.1728616088451;
        Thu, 10 Oct 2024 20:08:08 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b114956044sm97771285a.79.2024.10.10.20.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:08:07 -0700 (PDT)
Date: Thu, 10 Oct 2024 23:08:07 -0400
Message-ID: <1e6f94db91f0df07373ec1e0c8f3eced@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, apparmor@lists.ubuntu.com, bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/13] LSM: Add the lsm_prop data structure.
References: <20241009173222.12219-2-casey@schaufler-ca.com>
In-Reply-To: <20241009173222.12219-2-casey@schaufler-ca.com>

On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> When more than one security module is exporting data to audit and
> networking sub-systems a single 32 bit integer is no longer
> sufficient to represent the data. Add a structure to be used instead.
> 
> The lsm_prop structure definition is intended to keep the LSM
> specific information private to the individual security modules.
> The module specific information is included in a new set of
> header files under include/lsm. Each security module is allowed
> to define the information included for its use in the lsm_prop.
> SELinux includes a u32 secid. Smack includes a pointer into its
> global label list. The conditional compilation based on feature
> inclusion is contained in the include/lsm files.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: apparmor@lists.ubuntu.com
> Cc: bpf@vger.kernel.org
> Cc: selinux@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  include/linux/lsm/apparmor.h | 17 +++++++++++++++++
>  include/linux/lsm/bpf.h      | 16 ++++++++++++++++
>  include/linux/lsm/selinux.h  | 16 ++++++++++++++++
>  include/linux/lsm/smack.h    | 17 +++++++++++++++++
>  include/linux/security.h     | 20 ++++++++++++++++++++
>  5 files changed, 86 insertions(+)
>  create mode 100644 include/linux/lsm/apparmor.h
>  create mode 100644 include/linux/lsm/bpf.h
>  create mode 100644 include/linux/lsm/selinux.h
>  create mode 100644 include/linux/lsm/smack.h

Looks good to me, thanks for the lsm_prop rename.  As a FYI, I did add
a line to the MAINTAINERS entry for include/linux/lsm/.

--
paul-moore.com
