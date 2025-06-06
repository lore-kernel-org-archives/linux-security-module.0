Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F161EF39F
	for <linux-security-module@vger.kernel.org>; Fri,  6 Jun 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749235356; cv=none; b=RtvJSTYa09JuA4NDX+BujApWeFuNssGxSpJEpsWYARkEk6iNc6pgmqZBBrwUimFj4w13vEoskYii0YuxRa+xFnkZi8Mv74mDM+natJ4mOInGLe11ztfPA/fTrj0rHbVd5cAUbrjSjQ3aJxW3W6UTkpbJzrZ8i9RFpfZNAVxRr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749235356; c=relaxed/simple;
	bh=4DgjjWoh7c3cj7ARkYAO2WEbbnzUG3glH/k+3d71cXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KVYpX5rhjEmp8xGkx0Ik1k+lqo1PIcV+caoKEvwSF/irjE3aAXPxHvjxxb6OPolFKoGODmkyJIo88GpPkMLV9lgWVidwr4BvQMx6bPoUEiqI57D82w9Sll63wbtq9A0iT0PKDIE3OeHVhy9fv2cdAXSvRuEGeAweDgVTHyYMGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SrQKGvHW; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SrQKGvHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749235347; bh=Z45bOFMnfd6UpjqgSYX27HvxvCvYQCwSls+EM4QpqgM=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=SrQKGvHWRbgJf9Ct5quPdCGU/8/D8mnYidDI/BWZokNfaFIYFHCKGx7EifWkw2z1ypsRV2mMpWJPlROrYdyoKFyXbCQIhvQhXHvi4IwmYYGwlCFdWgun77PTmMr3icIYstW7cVC4JJCc4IEqezNXg19A7QjdPFr5sBRjXSDaxPOqZR0qAu/L7BiQ/qV0p3QyWiJH9FuQmJaBdoOfgbv+sq2D4obExuZdgckd9bD5XbUEVvrKHIkGaiWFNOybvPJf3yvfxHqsIllGDdJRNgCU55MF1iclVoMQCBimMIJdMNZUH4Y6AGqOeAonLIag1JSWnyVGBo0rr/MlMeca0mn7fw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749235347; bh=BIPFxh8QlPdrP1GDlm0TCMnkI5Hd35ktjAt463xH6jR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ScUuToRRSgw4wI3ru77AS602XUPcFDY2icgkrkbfqgVrmjSc+9Xzqye49YWGLPlPiZoJfgCGmuqPlMXFgjjPVxYXwlIXHxxfpfB0I1ee3Zn7d1GepJIo7hpAA9+q0g36GexpNfutw6iG0mpge7E7sQ3IvoAxj8Y694kFed7+77Fx7ALrIObC8xDkDbGgBLNPQdvqwdn22nw/I2ep9kTRINeB2dqOdU7yUDi8W4/TAk9E7UukOuaCNBfQeEE726vJ1Amw0vER66e9EwGyw9rgzuVyh4KU31vlhelL2zO+qmbrgEBaphAjq+djZcXm1oOTGdxmFaTNhGdzFsSjZDApRw==
X-YMail-OSG: oK1CvMkVM1mTgP9yC9t1zc1fK5vzpeEifVgd9XvS_JM792sCqFu.6nWcD9hZkCq
 vl4Rn578SSCB_TCcvDbWF7JGfy0OSFt7P_wrrCamnUMB2.7H9yCcqQ4.Nj8353h5Wh_S.Z97JZfT
 LwOiJXILpkph53hksTSBdOqSYLlUcNwVwQrBiQwMwTt3ltyeLFDAqi3Z4hb9XIFGG48CIt_lFw4q
 ao8mPsnQZEo.H_4t62tNAJJZwyuKL0FWJ8vb5Wz80PUcUe46hcGzgNCODu6nVZfVBzeAyd8WuV2T
 LbpCgWbQrfc5MZL6Ro55mgf9sild0pDVzgRUrpAgxp7IC_qJ0D3YcgdCFhD6jzGJoXQTT4ohDYK7
 I6BeUEsGk6u_MPEbmvkIgvSy2hjM_2_xf6kdix0vjxcLXPV5uBGxvYEM0FL2y8ktfIIMTyp4OwOG
 V3nKyZiDF6NwhfTpW5HNerkj94npg7QAWPUfghYuQZ0Wdc8IELg4qskJNX7eWsdCzlA7C7o4viOL
 Zm1vF6_N45ioYxbjLffS5eyXRWnKZH3D73fmNxHyvN_qdyyVK7Wr8QiXx_wVfLh0YNAYvuP8zKm0
 cFiEVYQ_Yaz1Y.cgCMN8VlJBvDDrKHjhX8aJPBZWZ_wcJ43H81FcWnssjneBfMWzHsSEJkT3VkZu
 9WBII2pi9oST2acJY_XclGeypXxBvvFmtWxtd_LCWnBprJACsnf7XD0UlB9ScruQ_2pgFW86Q7qL
 YoztlI8vcsAFceeDEn4yahxBqbm35iUzLFqKxbgRk7GD5.HNtWMwss5Vk8tOM4qdl0l_v6b2ac0U
 9JUEfliDnNe3YP1iskGpdcMeM8kmPzyVK.JJ0U6VsIxaLxVCr9ItlHuDp.bmEwf2E6.EuGy9Tml1
 f.HU9vM.y37WmfZNjmtPZ9bK0lu5wdZrEfiCrZlTCkSrNXhexJorOOTYgl7TX0qAqc9c9JtbS4.7
 hZGs1eftAkLYoQXAExf9clG2CI_Savrniw_8DRi8zPqjNnXCEIgFpeJbTqwj7zLvkByXxEe8BNif
 HbzszZPCdZoq_4jmKubM4BiIt9y..xXR7iXHto4lqEojYnWpQalw3Th7A7Iiw8cFCbN.u2kxqrKK
 LcwVYcnHNTRFtxVwdE7TYj4u2MDSgPrWmlRFfRiHh.YRPC7w.Zf3jrR1xCSbYuSP2BAnA6GRDzy3
 wuqNVXKEAm9TOsAlYorphk8lWuTdd.CtFvzGqHRy1q1.UooQWrqt3rNkN6QRFDg9wTq1WgEvF__V
 5U0rnUmIOi4.G_R7rK4c93D4kP.QLsKyrVe3S00kAHrGSs01JkENO3oAK2ruJtkAb96MEJsWUgMw
 uVv1u0Ak0_is.vxqI4Xmw1Q3_s3QwgfZrbPdPTuBp2S.Ne_JuWSQ5m1U8X1qD214lzyvBxhsAmij
 9UItgbpiH3nxWhSgu1wrBMQ0i7JK_.pqueluGcj_XuWcdf2WnXVXlORPMzDgFzyKHv5ebnNaeeh_
 2vqkzpQXwQs3t9xc0UnWPh4jf2uheNLJkw2OgQgXYJlTv4OYkVipDhM.HkD3p3F0sWIwwXTAiMO3
 52M.tPwY2tZtFC6Rlj7hf053QqXxJpvsXdXVK9KR4POJ7LVhNkRnlrigNQ_TvKSo0h2nE.Ct4W48
 hBSIVA4XL3i3Kip.TOxhkn5XMp78ig4gYdS1pQGO8SEgTV9mwLTfQaPSsFJPLr0t1gR.SJPeVoTB
 t5nZq5_QtboARYNdTvzDifNUhiWFCiTSaj2Ti4or8DgeNgRK2ZKf2gGUXAtNUg4yqNfd2imX9S.L
 M8wwhxB2ZYaPEWUEfXaCw34ws_fKsh1D0hhNbrE3diSP2P_6nx6yuXZpnZBzSfeITO_IjKcn2gdM
 euOC.ksJr3zmccmvEVEWkr6pYJek.nNa7VtLobLzaNXHaYvrEdx1Qdl8gJg..t9Wg0py1P_deqOz
 LbUumJVPo5SfydY6MsrxJ9RI8_HGJCeTt9uTOw4mHPI9Oyej_JRgJvZTKAsQizqBjKzfam7Cmwvm
 BFmvRikWsppMD5eJBAsrukRjvApsQtSnBor8t3M1slhkHPJHUTGCWN53JfhmySmaogWMdgYc.eFj
 It5aJBxgOs_f1knxFbnoNGBtdMsp_.zc0SqQp50RSlnvJZ_xbjsl2dYPHfCs0fhCDJU6MHk8DzFD
 DNUjocBbu1yzOiFgLWp1pws_gaQ12jGCdwSaTI_ISv7B5t9fiLhZ5a0tY7.XyP0O85pCHZQuRf5M
 ptRDy6y4Cy1r5T6oPaToxoJd5Yu4ScJkLz1IYF4qtJcoE0pDQEaBxNCfG_fe2Kq3NlysdeNtBsws
 9FFmRMHwuiHo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fec818d9-9295-4c14-bf58-3215d5ec8dde
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Jun 2025 18:42:27 +0000
Received: by hermes--production-gq1-74d64bb7d7-nrjbm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7fb09fc197117c1dc4660351a23278bc;
          Fri, 06 Jun 2025 18:32:17 +0000 (UTC)
Message-ID: <b1bf0aaf-0290-41a3-8bbc-a61c6c8b2e74@schaufler-ca.com>
Date: Fri, 6 Jun 2025 11:32:15 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: adding CAP_RESERVED_# bits
To: Luigi Semenzato <semenzato@google.com>,
 linux-security-module@vger.kernel.org
References: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23956 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/6/2025 10:57 AM, Luigi Semenzato wrote:
> Recently I inquired about the decision process for adding a CAP_DRM
> bit to capability.h (to become DRM master).  It occurred to me that
> the process for adding ANY bit would be fraught with controversies (to
> say the least).
>
> So I looked into maintaining a patch in our own kernel sources, but
> that was surprisingly messy due to the build-time dependencies of
> capability.h and the way we maintain and share sources internally for
> multiple kernel versions.  This would have been quite simple if there
> were a few reserved bits, such as CAP_RESERVED_0, ..,
> CAP_RESERVED_<N-1> with, say, N=3.
>
> Would this also be controversial?

Imagine that there was a CAP_RESERVED_0, and that Fedora used it
for DRM master control, Ubuntu used it for unsigned module loading,
an android used it to control making the battery explode. How could
you write applications so that their use of CAP_RESERVED_0 could be
considered safe?

> Thanks!
>
