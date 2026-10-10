Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680C10F1
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590538; cv=pass; b=rL58Xn7flpaEx2xYSSeABzEbZCTqU3ns1X4DDy6BqJmeILPhkhiq3P3lf/ODIyiKOIFxmWjAAjxxZgu+QoD/+nrebcayp6iKYIKtOG8HOTiYm88VluVYXxoVf771j2Zc19X/igd55XptwesZxpwk/8ed4sDe2b0wWJH6/dwkol8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590538; c=relaxed/simple;
	bh=hXTeWRoHLQjJuetkdFQnlbxkl4pZIcomCQcGCLyZ9N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtFqjw1QvFfL+PVdmb0Ebgj1cLwEDch7Vf1hltVPfcTsDCWFY1ORh8VS3Yp9eaLQZf4ik2NVVWF3RFs+JbetpUWIPRWkOgh4/P6MHD28xu2yx0i7VUzWBpvdCqAz5ltLMYunH1x2ABYtax9BFwhpbyAaUimICtwRIQneKIH2d+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ2IcHlC; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ2IcHlC"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6711f05fb14so174461d50.2
        for <linux-security-module@vger.kernel.org>; Fri, 09 Oct 2026 17:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791590535; cv=none;
        d=google.com; s=arc-20260327;
        b=E9H2oIQdNu1MQZE/pBeV/YK7u3/Fq9N6URNLWMNR4vPWcb6lSioHwkFaPiPAA54cd7
         4QkRQ4eJFTYqD2yXRC+482uz49hT/YpUUDp1QtNpXQ5MVLmTGP+b0z4RMV26PTYilrY9
         815gbk9xjL2GreL4mEuuagJe68bTypoPeaAFxwAq4dgA9ENaASK7vaNqO9/WO1Dl5yBh
         bYJawN2mbEvye01i5k4yj8DNNbb+vgPrCBUWEnyfeADDYgd0ELw1bTMbNKKGvCT9zMH0
         uLiHg2JAIK2129BOY8v1xFXdoQcUTFwvv7S6xWHhkqdGbUL8d/QUWhjT8lSgSyTu2m0B
         wpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I99AZGsC3feH3Hx+ZXc5ABTbclG1gdclkr+/K7Qjuzk=;
        fh=31L0fT58/+pV9tTvvQ7o9xp2ln/zQZtti30j6z+21ao=;
        b=XKyHPWQpC1dbwpSrSGBHZFGG4V/shE5mWwLMOxPLfWPN0AfsuaofFfs++0CFCGoqGP
         scovORT6haVMIjxxl6j2HRgiNk9/yK8aCZCf+Cap+Z85tbrKFAtTUmHmTp6MXDd1Fo4t
         iNbAbl0DUzwv+3aTqovNKJjwcuHTe3jvNF35W1gYnMMjQB22cHxZ7IjcJR7tPe5G329q
         s6bs9+Gcxir7lVWUedcGjsK7XueLJWA0FKRp2fcFFpeqCtdrdihMg+tGGP0jZhPLGiBy
         g+rvZ1KYHahl29sub+cvsh59EDanpj9i26eDu6CrE1Ap98mtFSIPpy4BlPowz3HqXPeJ
         EReg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791590535; x=1792195335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I99AZGsC3feH3Hx+ZXc5ABTbclG1gdclkr+/K7Qjuzk=;
        b=XQ2IcHlCzUGoI+aHVwATlYqWC22g/E16vEgE9jVggPlosc1/WaKPU3aBwcaInbIyLe
         oEH+JXWYHoV75gE0ebBQIqTLKM1dd9H0Lm3eHuJS9OREGh2WOFarYHFqhvJemf9+12/a
         EOxXe++WPW6R8R1kttzjJoIYLYUOoFCLYgwEqxW0y7CBuPaL74tO87GtNkEjNOvFTrpr
         KmqpO2pwarlXyh14MC+6ptPvBfbEI4GI85ccVRkemDszgqyUhVoz6tlicEUVOx44xH/L
         N2e9UhUSep6ru55kk8F8LQs7LZLL6qbuUmr/2bSRWzlIek53QzgihMji/Oi/no+8o1TF
         zPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590535; x=1792195335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I99AZGsC3feH3Hx+ZXc5ABTbclG1gdclkr+/K7Qjuzk=;
        b=MrCt1tMUux00dljZIrVlSertPrKiNWRcMo47jQirtGv1ilXESHEnRHa6gGY04wrLln
         J6Foa6fjUvN97uYbe2mx7AHq+hTbHi4NwhWfWkfNRARpXKC0qjDwgFFXqglrQF24kvVB
         9a+fVT18aDINPOQKt+Lc7j0rM3ciSDSWNVTLF6X8sjohLTvuNhSw+wvFbCo9FRcyNrBG
         xpddAgmuXbjmntu/L7Kf1wW5rvpSXcx4sTVZ7uHlL6goONi8gsPxiKEGcDVF1swYfPE+
         tFIMwhVZBHxokermTXH/QXtg+dgICPpZqCoGEpCyUhiLcPDkvjPguJDQbWNDYmBRWq8G
         PHeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwebFczFx0BXdW/Qcn6D/8c0w9eMjfwn6dm/n4wXep7GTw0ujSbjbSwqfTi70UEx9+5JkuRk/hnlDGI8mjiXO2P0bs7saA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ352NV+08Xdu9Vl8u4W0jOq0tSn9OUloyoinlnvrRy97/ypdgp
	kpi+XADUB/3x/drKKN7ouHGdiACEobQRMcrR2I+FBpoBQH+K3eb3VRZ53+7rqj86pLe/2NmwX55
	jH/aWhxdXvAGLoggWpyoyFeKNoBNN9a4=
X-Gm-Gg: AYBFou30Cns+BdkDyN58ZEI5DYYGYIQfGlUa2ysnxm4Y1/Tr52rD/yOikJtdx0+aBaJ
	HnKO0KuTAktOZ763MEeCTWEE5toilrpHLuoe1JgUeUOtzjOH7duwz/n0zGTjBqNW9OoMH642wPu
	vSbA2iuMr9zZe0PxuROUfBxJWe1C3kwivHxbBLgtTJNpXOGhbIScD5pyxD3HL9GI4tdqEQ7kByJ
	UEYVBXjw53FCYU7wASjLpER4g3+J74D9IdwUS4W6w0eeYcbmyEV9hRAkQvo81jwaZ9sMUW9L2Pu
	/n+RpW4ScfvAle3Z9xEjSLHrIAXMa8AAtEyMVU0b9NuVfZ6XTgeG5NiMhgIWcnZlVa0Y8LLaFcx
	Pmm/un8Fe
X-Received: by 2002:a05:690e:bc9:b0:677:c43e:c81b with SMTP id
 956f58d0204a3-67936059eeamr1294555d50.59.1791590534633; Fri, 09 Oct 2026
 17:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
 <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
 <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
 <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com>
 <20261009204554.GA778522@ax162> <EF8E7F67-39BF-4382-AB18-98E9D6111CA5@kernel.org>
In-Reply-To: <EF8E7F67-39BF-4382-AB18-98E9D6111CA5@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 9 Oct 2026 20:02:02 -0400
X-Gm-Features: AclHuK8tNFqb0iNpuhNaBpJsUFdnB_vd8X2cSDcjR__CA8pNTmkEAbFNAUmPMiA
Message-ID: <CAJJ9bXzLgzZG+836_2+pUVOWzndSFNoOh8Xu8Pw++_i1RMJzOg@mail.gmail.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Bill Wendling <morbo@google.com>, 
	Tingmao Wang <m@maowtm.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 7:52=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> I'm still catching up from travel, so apologies if this already got check=
ed, but has this been verified against GCC as well? Is it only a Clang prob=
lem?
>
> Regardless, if counted_by is not working for a given compiler version we'=
ll need to exclude its use by version. :(

It is only clang, not gcc.  See my comparison between gcc 15 and clang
21.1.8 output in [1].  I didn't test clang
 20 or 23 like Abel did, but it seems like we can't gate on any
available clang version.

[1] https://github.com/llvm/llvm-project/pull/228309#issuecomment-608047508=
6

Thanks,
Mike
