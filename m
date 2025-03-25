Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4FDDDA9
	for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926686; cv=none; b=akNsHszJ56e7uFE1sGnRIE5XjxU/95Wua+tOAQpObKv25MRlQuObQAz1kJyq8mrm5bQCqulztE6uTpdPel1wsH+qauyn/dZ2GJ6byZpd8nIatt3dEZdAgdeFpDIqFJHwiqE7ecgs36EtTl1IjKMkRLriRunf6Gld9DNjj5mx1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926686; c=relaxed/simple;
	bh=/4+bLAd5YIoSfto7uBkSvM5inHnQsWrkg2NKoQTN1ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJi17HgYcSqw/qz/Rwk48AQgm8LLhUQ6Ou/5hbzV+oQVBLZePTlEjg0aZ7SCoQ8pbO5dN70U1YJ01T2BMuMnf+oAm18ya2HpyhoRYioo/B7riij7sChFZXuwDcSvqhKqIrocX6lS+s8Yk2pZV93zSESsCSa5CQKztxwey3QHQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cAhb6xx5; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cAhb6xx5"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85e14ce87ceso3694839f.1
        for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742926684; x=1743531484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4+bLAd5YIoSfto7uBkSvM5inHnQsWrkg2NKoQTN1ps=;
        b=cAhb6xx5/FqYSdd/1pORUOfxDXuZwjI1+wO/qNjf+5iOaxo5aH6OrERWlUwDuyLJxz
         VKCHKuRLynpMWRS0zezpKRoORVHrqW/R7Y+YDgw9karI/FqV/q15HB11/8XpAn9SK2bP
         m/NPF0zyV73OYAN0tWiQJvRCSrf0Jgqrziu9qNDjPz9ss1hTIqsnRx4tw97dZBol3kiv
         57gmth1WbMErq9QcPwMjCvFiiXaQqgKUpbMzBgdUhs8E6H3UdfuQrape7k5yPTaGJ4Ky
         5IQiS22e7hQsHmDDGnP30mYfnghmmT46fk28Bnrtzo154xFqt15ve1u4/V2wMI10bh3N
         jvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926684; x=1743531484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4+bLAd5YIoSfto7uBkSvM5inHnQsWrkg2NKoQTN1ps=;
        b=j5OOJflD+Q35iatXtNInNVZNDCZ0xhgXRpAT+hRhQRsnXojN8JGgIqLFR1ix5MFdxh
         +hSZ1enqfIweYM3s+hDoTTmR6621QZ2/rg2+CrTQRUsqCKkaVSkiCjuptihPCuZvRvA/
         7sxNZlftZYBsQF/T6I1oUrmFqOlUNImvfVFbwa8uws8BCJ97N8DmmGkc23xqiCVuh59D
         UtcaSAzzyq2QB+YrZ2IWLwrdoE9s/aObD9Toga2HTU2JaeQGCv2zAp17M6FZ1ubZa8YY
         +/8v+AveD8vD71Cg4THAr2KZ78ZUH0ea2godr4Bk5s7OZ6yCtDgzFiDtwdpn5/f28RC2
         f7PA==
X-Forwarded-Encrypted: i=1; AJvYcCXHX/fqXC+ZNc9zbICP/sLW0PgTd27R05eN4ZQKdhK6y6CRsTq/zXERiUjZC/xm2HEBwLJdCY6r9TKJa9zBCXhRGTNYq78=@vger.kernel.org
X-Gm-Message-State: AOJu0YywAfV1cJpaWOnxsPtgr/vnOorG70tJ/SzQqMCgomg83QuAMfrk
	rYuF8psibxXspUKu5qL3l439ux6UyGZoAhvM3amJzB6meViTbyVqOMpdySDZ4Y4=
X-Gm-Gg: ASbGncu1kTkk5f3nBd6H+ZTSLENHeamBiqbuK+2psb0cT9HVw17aiKhq1OKazxmmRN1
	E7adA6Ty5/M3lGsAoNrPqncOC2cDZbhQ6Vpy2P/WheOtG08U+mFi3qNfZeFsQIhmG4+K8otioRZ
	gMga4n/XxHfM7cUx7RYlV9sw5mj+NUAA0q2qRdZLyD3K7XMRAWeL/O+ZA0NvNEG6dkQh5h1iPBU
	ZOCiLsmREEszu1BMjysti2O4w/PYjlkISOrCjx7nE5E+TyIjncWuRN9xBl9bLj3Wqp68ArLX3A+
	fo+/LlD0XwxrVnJRbV68RaiVVw==
X-Google-Smtp-Source: AGHT+IHerZJCcUba5+2uQMpJ6FxRljVNwdYl2gum46dsHYwuSY7HzXegJqiAeVDE22k7LOpkVelMjg==
X-Received: by 2002:a05:6602:b8f:b0:85b:36cc:201b with SMTP id ca18e2360f4ac-85e751c2403mr101382339f.2.1742926683683;
        Tue, 25 Mar 2025 11:18:03 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc13d74sm217164439f.11.2025.03.25.11.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:18:03 -0700 (PDT)
Date: Tue, 25 Mar 2025 13:18:00 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-integrity@vger.kernel.org,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudfalre.com
Subject: Re: [PATCH] ima: process_measurement() needlessly takes inode_lock()
 on MAY_READ
Message-ID: <Z-LzWCbROAI2H2Dx@CMGLRV3>
References: <20250325181616.79540-2-fred@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325181616.79540-2-fred@cloudflare.com>

My mistake, this is PATCH v2. I forgot to change the subject in git
send-email. I can resend if that's needed.

