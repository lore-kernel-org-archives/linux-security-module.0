Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84725A2C8
	for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623586; cv=none; b=t/CRKM4W5yndQ1vDOA21rDyW4tY58tKvA3QG1Ls6vgmc3g/GLA7/bAa6mMflgFeHrDF3sp4Qpz9gjrqqjH2CrRLd9TwncaQvpm+spx5ok0C4DaOUcnT7QLyBXbZArlvVpnJm3dRdKC0jeEb5REfjFE/eFW/PuvGv67fCzK58aBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623586; c=relaxed/simple;
	bh=kdf/opkiaPi1wbVEP0I3N1fEYeXIFC4zRJ1yWTUzcGM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=hm0WaxSUIPXSAosAa/pyQZsi8QR0S9GfiJgna7nh1kus+99r9GJbTYBnXjSFWfTDQEYMWcR0WbHad5BT6UegS1f9AWXEXpTqSuwR5H7iyu9Gqzq4/7iR2L4SpXwT02AD2EO4nws0NamvuZLdLe+v3tNKsOz0m44BdMwP7xrxo8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RQEE1ssg; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RQEE1ssg"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-81076e81aabso95672785a.3
        for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757623582; x=1758228382; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNjmDRDjq4fT2fMT3D8inrfJWhzOs4XStOtEvDIlq+k=;
        b=RQEE1ssg9tNWnmRFeE7A96Fzx6pZtRPjKp1JAbXDBCswEBlUgRP7c1G2PT2ISmhAc5
         0Olmt7KzEVn7wJJh9JIFZY/0pv6158prccb4FiT68m6hkQojGReCBsd5pI/QFMYyspZb
         8eoivlZFQTcxZfnJYDBt+C9/0BgKIo7BfP0xbg1d/pB8MSIvZHjP0k/hzwjyNV6ei1fv
         +meXoOCBWb2DCUrf2hwGTN988wEINIwDqdCFqNI0mzfHj81dN6mkL5WDpn92khcVs5VN
         9sSwbQbRpJGvrlJHi3ODgitx3QBFZzgwIvzICb8uZmKFP0HJjhfoVlmLfd+B8u+TNI9p
         TViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757623582; x=1758228382;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tNjmDRDjq4fT2fMT3D8inrfJWhzOs4XStOtEvDIlq+k=;
        b=hP5a9I+u0jHw0GuPIAFBZGuGpHuu8EW9rBEWtqXimj7IZneueU0qfx1Ka3s6a6A9TJ
         sdNSsJOp4Fhzcn1SyLGdY5t9kuzYc5I40z7OUvXJ/r4QdWxIqb5yCGvOoi0lmVNOsDGU
         rZVLCowH/2ZcHIxSaMIjx6HfLrf/e1wsengJr1l3BmzB0moyyzf5nuem8skR32X40/K0
         yDnNLsMv4v2RC6ocGz3JSk/RG0wpfD1AxrTffSnshX5ECoA/4TImyfhSzwfwPH213b/Z
         flLO2uPkeLDiS2uQKSaZJvwAlApvyn3lAAysAbaajAOxDYf5NtoTzK8PjVBMqRV25DFp
         Ev/w==
X-Forwarded-Encrypted: i=1; AJvYcCWH+1speQ7Zz3pPIN4RT/gqwpwTg3dHGZ5P1E/KUiIrfTmMCd3ZGj2M14iWyZBQa37w/NLkliGPI3lbRv60dhoS6qTdods=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3NKnw82J3iSj7LVb2/uxGeVTSG1+/W3Mva9IRdGHNQw02L69
	iH3lweF1cQWUPibAAv1+6UBkEP/s6XTkTS9JBUgr63kqXDUZVfmCKgfRKvOAR98Q0w==
X-Gm-Gg: ASbGncvk90AA/66nB9hADk+PxbFVZxafPvFTldKHbiZwSBvMtzCtiz0EVL+Zr0xFSCa
	sdSX6AENOIhAQpJUodRLhAM+g4qlh9W0pAqzp8aykvanWfCcwmMOprX9Z0/r8+SJ6idIcSxiHI8
	UHQpdxvxDtWJOOSij9zOKpofk4PkuZI7DbJnlPDjVIwHolYpn9Ug3MONdqPgxMkQy7WQzbPULJe
	MLrrOB0v8sc6+3EhxQiZ3AziDzpUdL/7uNhdBVmAKH27czyah+/biq3KoBWeOuWtPuHhLfjDnZU
	JeJBz42De15c3PqD7mP5GOk+b2GgW2weU+7YkKk0+o1R3vx99fBRKSFSkHSbHLudASIRpn5givb
	fZt9j40TdRmUhupvaEufEWzHfPrPwtdV9V+5yvgtZj9HWLo+epLbGj7Nd49mFu8IIg8YWnH2CfB
	H0r50=
X-Google-Smtp-Source: AGHT+IFUfU1kwejubVPU2NBS3h5oB5sUNB3UbWeon4LOL5GqrQWNT7DOGhwAVGTwCEC2VfzuOogDtA==
X-Received: by 2002:a05:620a:a017:b0:816:d061:7d2d with SMTP id af79cd13be357-8240094385amr94531385a.70.1757623582083;
        Thu, 11 Sep 2025 13:46:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cd7041ddsm156936985a.32.2025.09.11.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:46:21 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:46:20 -0400
Message-ID: <23663be0b8dc2a435bcc46a3d52e9e19@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250910_1926/pstg-lib:20250910_1926/pstg-pwork:20250910_1926
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] pid: use ns_capable_noaudit() when determining net sysctl  permissions
References: <20250910192605.16431-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250910192605.16431-1-cgoettsche@seltendoof.de>

On Sep 10, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The capability check should not be audited since it is only being used
> to determine the inode permissions. A failed check does not indicate a
> violation of security policy but, when an LSM is enabled, a denial audit
> message was being generated.
> 
> The denial audit message can either lead to the capability being
> unnecessarily allowed in a security policy, or being silenced potentially
> masking a legitimate capability check at a later point in time.
> 
> Similar to commit d6169b0206db ("net: Use ns_capable_noaudit() when
> determining net sysctl permissions")
> 
> Fixes: 7863dcc72d0f ("pid: allow pid_max to be set per pid namespace")
> CC: Christian Brauner <brauner@kernel.org>
> CC: linux-security-module@vger.kernel.org
> CC: selinux@vger.kernel.org
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  kernel/pid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
