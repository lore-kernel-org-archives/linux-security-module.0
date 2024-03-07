Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F5130AF8
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834066; cv=none; b=JQq5AAk+/6NdAdZsfLQs0NcdgrTLwh+fvRyPMR/XdtN3UaMM33xOA7qALjfF8/AhYeU5bby97C7VQd74Po4FSXi4TulvTgHp8MMVYX/9UGjxyzcJtQ8Vqb8xvqRl7TyhD9x/htXuWmUJeh81ZM9PU/CJAeBhcxjMtLfNSLJipBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834066; c=relaxed/simple;
	bh=gL2PUG8wkeC1np6GBiLpogsA+xXsDUCoIx/Wk/Y2ahg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=symh5PhBSsit10JmzoLIAxgcglqsyYIdu+BBvpf5U0pcFvvwkCTNQHUBt1K+cCbsb7sv6fWXYK1NOXa0SJIn/ZLnvDuBK0ll4I1ztgHs1t4aZDYM5mtYPeofo4vs+M52Pcvocrm1u+YXKPsl9IKS1AhAumX2wJvm5F1ZLSTxRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DU5jzMG9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DU5jzMG9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so10023215ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2024 09:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709834063; x=1710438863; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/X9WiAZ298nMlpwZKocfmBQTYiNw1IbFj7J55m43DY=;
        b=DU5jzMG9S2KQ3f4emnrXDRwe+CrWvJhdp7uQLvLQmX/vWpez7HiYJcyUfv9N+s8PF0
         eCuNU0gjp+ZUcucBXSGIW/4+klv2T1/vqFOUtiA3hpdot+rVEJRNp8E4Ugwt6lXgDBQN
         5arJjOvqnbD3XhwVga4zhl+eD6Qqz1/mxfTlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709834063; x=1710438863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/X9WiAZ298nMlpwZKocfmBQTYiNw1IbFj7J55m43DY=;
        b=WvBBEfa21HmqFT0kvuzjJp17aFteK/buCZ6IRaLdVbj65NIL10coEuZ19L9YxwFdGF
         qgmNxmDTewJa9zZGJKx0ZWNk5ItaRKeVVPPPH8wcanHXQUtfaB70kWIcLher6VJ2HOgz
         Dc6U2e1SJR8Y+/HXlxj4KARVpqD4r8PkORjWwBz0hHaQGJ9A7wA5/e09TqDdgCZgHSDn
         kzDBIN7QTedldhBDxA5u96GXSoqzYDW5i7lNaXNopxyfgvMhzNO0m5lHiobx5MQ0Edhl
         aSIZkgQ/8hb64R3s/F8if1fxhvr/cmZbKnbJf0LOXXJNNP7PaafD/L5YtKOi9o+FFNSa
         n3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVwN1huLUj1zoir2DbfttJmy+9kF5ptQzBRGTkkCjBwdmkuf5rs+aKU6nd3L3w/oTNObnV46VEViF38beOMNDdOhxc69a9eIXYUeNwub/mNtpGHyc/H
X-Gm-Message-State: AOJu0Yz07N7XxEJKwPa1NPQGdcWyl4BwNi8CSinCLuKzl1lLFFYFdmNq
	s3vW19f2mzXEXPcBH+0tY+mAx2HyQHsoLuHUL3YW36zeRJYgqHasBOBXTeEc9w==
X-Google-Smtp-Source: AGHT+IHUxQ9DWu9gysEex2ejtTK+1HHHKEo3vq3YQF4KtyNv591GHTuR4rvCLhlFEW54mpHAl/SO9Q==
X-Received: by 2002:a17:903:2348:b0:1d7:5d88:f993 with SMTP id c8-20020a170903234800b001d75d88f993mr9618761plh.41.1709834063497;
        Thu, 07 Mar 2024 09:54:23 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001d9edac54b1sm14951503plg.171.2024.03.07.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:54:22 -0800 (PST)
Date: Thu, 7 Mar 2024 09:54:22 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Use f_cred in security_file_open() hook
Message-ID: <202403070951.22E77FD709@keescook>
References: <20240307095203.1467189-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307095203.1467189-1-mic@digikod.net>

On Thu, Mar 07, 2024 at 10:52:03AM +0100, Mickaël Salaün wrote:
> Use landlock_cred(file->f_cred)->domain instead of
> landlock_get_current_domain() in security_file_open() hook
> implementation.
> 
> This should not change the current behavior but could avoid potential
> race conditions in case of current task's credentials change.
> 
> This will also ensure consistency with upcoming audit support relying on
> file->f_cred.
> 
> Add and use a new get_fs_domain() helper to mask non-filesystem domains.
> 
> file->f_cred is set by path_openat()/alloc_empty_file()/init_file() just
> before calling security_file_alloc().
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240307095203.1467189-1-mic@digikod.net

This looks sensible to me. It follows best practices[1] for avoiding
confused deputy attacks as well.

Reviewed-by: Kees Cook <keescook@chromium.org>

[1] https://docs.kernel.org/security/credentials.html?highlight=confused+deputy#open-file-credentials

-- 
Kees Cook
