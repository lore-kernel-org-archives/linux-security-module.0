Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8C3B3BE9
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417289; cv=pass; b=Acu5bdTtVKHfSFQyuwUlTNdnoVgySH5pQGue0PdkvlVYd9wgWNLdITcCT1WWBbLg++rQ+U1bF8bISibSlCl7g81XE1IechbbaZQGyOwVvjIQOajNs4QpMQ0CchYvmO3WlBP4qW+24G86B0kGFhF898rMfsu6ZTnxEs7zOTaYabs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417289; c=relaxed/simple;
	bh=87e/h89XFWKggR0lxBj+t5UvHrpbeUPa7F52O2ZMUZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekHNjm+C0lHQoB0IXpSgwAXc3sB2/HosTUqpPef3qo3Q2dltZoWVJx1LNJW/xSMxm242mIHUlgmPNtoCKaCQZ+nhIxgd98wBPRKInd5QkDf2INT8vv1hI39o3QtyAQTeQ9kgwtrmeMUA8cRT4VT47OK0x3Z7bHn0JasB1ke2gvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4vfOfdn; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4vfOfdn"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664b8b65192so491888d50.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2026 02:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783417287; cv=none;
        d=google.com; s=arc-20260327;
        b=BMKycYc4nBhnFTkC1tFlv7v1IL46+lOgsbXxM/4HBNCttEPj5ti/IXEM2sURNXCXq5
         Rod4Zdyz7RIKqmBLeZ6UguOaEc6U2wiehhYThB6zraQ8ekTxRMOiSgyPKpw7MZEqrRzB
         UwIT8/+yjQd+A53Tl4mTeSBIih0fLvnLWviA4A7Zpd6Mdag0T7DMCwcIgWexU4ET+xRM
         qryc3GbXfeq2RMJFriFIySzdCa6Es/x6uZzMa8GxfNc04ZycA0SRG/u5hwD8hINmd2kC
         YAzqtyzX/rvSCiWI46PcjBGAVvEJVbBy23h4pPYWex+KpGhDFw/1H1M015ZhhS1eESOa
         l8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=87e/h89XFWKggR0lxBj+t5UvHrpbeUPa7F52O2ZMUZQ=;
        fh=4GEB9djxxZVi8KuB56Pk4oUZvm1xhgBrm5A0LP+urP8=;
        b=lglbrc9pC/t/vnPkU/nOkqzFUr+9b81zgm5jJiBAGnC0EIemyRA67ns68cYgEUzed3
         MEjgE6uKkF/1B7NjmCGYeuRK+/c9pgqKh9QPPEiCWGAX+O/BJrV9Caff3p13KRXguNFO
         caVKFUAIS2OuLTzOk9sCICxWb5ea7M9og5URxIEAc0OIibAh0J7N+7pInHqgezWloGTt
         6uJTzXIHlVXRcMjsXURAKMfWgtxysKn7+jTJIxo1Q5BE6HeZD6T+FKfyp0UD8CBOttVz
         NMtFa+Hj4NcA36vbDUamOpQjHmlPkZrJW9IKBn9lbfJZdZhorSUC2p7Hu6KX+TPC2Ayp
         Hbyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783417287; x=1784022087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=87e/h89XFWKggR0lxBj+t5UvHrpbeUPa7F52O2ZMUZQ=;
        b=o4vfOfdnmi76okdjEzaCV5BGA02EPgme5TTEYmRYhFcx4bZtG6gd71pAyfUeIumTFh
         7T3D8LCqTnx2LVq+nTQSplqKF0VfmQPdsJB+1dUpDJ09r9mcxzbcdbrVWuTgHDcSMX2Z
         mvmctAZEfl8JN487HYcZVEUHnbe96rdRdVv0RatasjqOj35Qt3psLV+e3qwZCwxReuyY
         I2Y1wyd3Oe/Jq6Fyvg/9/MX4R5PSYejffvxbClHXOUQVCvVAmCXmHrcDyezstUP1OCzv
         yVPjW7oEsuCjZuno3psTsHHuOoyWMG4EvKDqjkeuVSP3Md5uSzwTPLREgewbInC0YsNq
         2V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417287; x=1784022087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87e/h89XFWKggR0lxBj+t5UvHrpbeUPa7F52O2ZMUZQ=;
        b=iflp/FVzZbVOt1lP2zE82IwZhO91t38h5nkJAPGqXyWjd7seAJ/x0S9HvXlBHRgJn8
         Tf8mBPSOtgRnWxYXCTyX3vrCCpMtmgYng6qjJuXrPV8OAZdym/gYlS8vJzbnDAE1Pwlo
         WYW5VSbJ3FA5RDabPgPlgea8rKUJ4a2xc0urkVMh1bfhSex+XiHbXP39nVuoIpBhhPnY
         gFNBqeMHi7MBVDLPbT+E8F/zPxHkKFE1m4wMl1qFYB0+2NhU0tj8TOliZUVfx2ZixZYC
         Xho0TtU/ca9f2zLzMuep8AJ/n1kI9ZeLgUOOtrUBbwIlm926ue4mfQtv7fVHxCIrGOhX
         GEDw==
X-Forwarded-Encrypted: i=1; AHgh+RoTYYPj57usd3MOiztWhpjSSTICeQBVo+OjCU52U3b9lg+bF9ERTsUKFcuSEhf0kwl8FT7JjDjwEobBTjraEW/5lGPnFS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVBs1Ks+mF5ENpMBGyvjQiuJ8YmIJSFzllsOvkhmstTkVvfb2
	kcR3Vqy7+7K0IpNy6emJXxDkNeBuZ00LmuPAnxPmYSQeALefdSMMViqLEVCiNO84X+xxA8qOWwh
	jjxIPueFcLPcsisYocayb1QamnOoC54Plgdk1T6LgSQ==
X-Gm-Gg: AfdE7ckHRkY6Xe6c95gaA62kccCLGztO4c5C4/LJ/NGehq0DnRcVCFcsU+WFHCknSBI
	TMbxRS+kbMLw0shzUY82TpXb8EnyjTKJVwtDm+DllC0QNUEx05pjTvLraH7GoIeO6i41EsdIzZ4
	DVSpbMBneGnI1vM4Y2UAnDH4oojXdCB8v+n1MHaTY71TjETX5O0uQaHzsVqbLSOiPRsl3kdCAyT
	0J//O9hhyYaNm5YlKFNkzGqcLjsJLfk6O60uPOCUZyxjujZJHh7W9ktWpfeLE7hpl1zpCF5OK1N
	rUqlqK1LRz3HdCM7LGNL6XDdLj/uJ1QIaNZ+0JmOZvxvjFgr4JS8gY6lPtTe4Q==
X-Received: by 2002:a05:690c:39c:b0:80c:c005:d5c9 with SMTP id
 00721157ae682-817234985e5mr118007977b3.6.1783417286753; Tue, 07 Jul 2026
 02:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625092819.1870049-1-doehyunbaek@gmail.com> <aj0fldJZ2dl0gas1@google.com>
In-Reply-To: <aj0fldJZ2dl0gas1@google.com>
From: Doehyun Baek <doehyunbaek@gmail.com>
Date: Tue, 7 Jul 2026 11:40:51 +0200
X-Gm-Features: AVVi8CcX8F9yn2jXEiqxeuKLaqtSPdgGtZoWXu4_H0L9weWneH6SGJykhOYOKrI
Message-ID: <CAN-j9UrCAkNgzj+xG8bRaOnducE16_O909Msi3EFVZjEJf9oAw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: landlock: Document fs.resolve_unix audit blocker
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Micka=C3=ABl,

Gentle ping on this documentation fix.

G=C3=BCnther reviewed it:

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

The patch still applies cleanly. Could this be picked up via the
Landlock tree?

Thanks,
Doehyun
