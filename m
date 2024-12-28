Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078D161311;
	Sat, 28 Dec 2024 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735408197; cv=none; b=ElIKNr/BQpcmabOY3/DNLwpz00G+HzKbtQFh8bw5C0rugT/NLhuFTBiiaBXIRb4tmEoWXlAzArX9PMlzupcgYipnHoHtiPTMR5LhZGwS/lLKXyobdL5gK/k6O+c30PgXVMBzsgZ46zLYPOhEAmsUENa+upiQjWEzCWqCPEQVaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735408197; c=relaxed/simple;
	bh=RuMN1Q8CWlTjh15BMmmq58Rea3xmXVi45xWGzB/Hf+0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BZ3V91CV4sgnlW9mbA0JZsNvJ/lCvfWTcfFEse6KqOHRzVwSSAjCRi47JccuK203k3OXwWTd7ByOQXlhV8tN8Tz7heX+pmSWo10UEXVfMM4wXRUvolgEgCQBhB/TAUdTMb7WxskxS8RvlzRfuVcBiyLtpkd96gVvzhvIkmhR3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d+sjIZw4; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d+sjIZw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735408149; x=1736012949; i=markus.elfring@web.de;
	bh=Dl1BLACyXNqDO9AAAtAEIbXwAH2RJ7SGg5nb491p6UU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d+sjIZw4Wju4LgFXHiEoq+B7bW0lhWknN/LU0iVHTD7ju5rgUAZQHzMoIyGawrvh
	 hNSGzkD+f7j0mYSfRzJxDK2m/6Bno05hL7TsPHtutbxtpEB2lK30k9bcog5d2i4P6
	 TZSEsqs0gcuj0n+pTemjiS+iLPwErXfkJ1s7duo48cQhxNjj6v8ySheAhgMbRzr68
	 shrdWpa5OoJUi4aNn31Zo5TWVPCH4lPI66HWGDmX3/vP+mFURBEJa5LFtnaPdVaSo
	 jcilS0i8Y3wcDVDc/lEixKOJEBhd/sRl/Nmn1/jdh4s7g6ztwXSMxIPQ0VXWZCLFO
	 W692gYQZhhhppJ6lNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.40]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6sBp-1taGlO2B7n-010oRv; Sat, 28
 Dec 2024 18:49:09 +0100
Message-ID: <fda06873-1c64-4094-a3d3-07bbace16e96@web.de>
Date: Sat, 28 Dec 2024 18:49:01 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Anup Sharma <anupnewsmail@gmail.com>, James Morris <jmorris@namei.org>,
 Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan
 <skhan@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>
References: <20241228071920.3252-1-tanyaagarwal25699@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: US16x08: Initialize array before use
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241228071920.3252-1-tanyaagarwal25699@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kiiLnJAj5XBQQhU1lzye0o/Eg5kAY4fAaFPify0k3gShiQIuyaj
 bufONpQzslfCXFn7W0oH2JW9x4BmpVpl/L6YPv4QCqdLVAHRGNkL/o7H5nfXwjTIrjniCpW
 ZG8DY/YMAcscupeqOKdlOQIvjXHfkutmPSRQzuGJd6K/Xg1On1W4mrIHxNpJ+/3rt4X0ap6
 qZQVdoHO2+hSpuFYI+JDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sUOW7E/rA5w=;PzjNlfNXZO4LCIhGaYIniRwAzxq
 l1yI1zx8keh0UdBoRPguRN3r1jOJ28fosx03+CVkQaNXjrYysQIIPdyzmy3blc7PPMisiogae
 eLoTtXjjrivpqcF+uFYfAeIKdI9S0xKjbBn+jDyuZKiaHOxW/9WclqJUe6bfKIQs2sC1dYHuq
 vhjkpOW4sKNh2buRQpVVRo5n0wJ8BAswjlw3UkPw47HydOMC5yqk5mussj+u5t2H2/BlkwXQp
 mV7mWkDodYztpiBHnivu07mZxHnp6U2qEU3s4DQ7ARgOUCqA2EEgW3zs1n+3BFCh3qzMmuwD2
 V5dS+f4gcgDVa+VK/Z4C2laIFi0SfrEyWdDyavzmHcOadw6q2YWMD2wpyBU4w/xIlOjLWCQ/o
 +9BAfT6vYRnH/tp5mMkCb3pIplJbOVaWreYD7MW5iFVCuHoxiZZ2hbpWBNZ6VhH1K3hk4bnkg
 39KaORJcKAwBFTJaaGPoCjrpL0riW9Gq6uL0tussP5VysIkPl3IjngFfHZXuFVp9OwRFuMgcB
 Pzi6zbRkafHkQey97yu+Lkq5ppBJ/w5+b14gSAwoE9w2bqNDSAdvir75dZM5fKrESIUXeB1VO
 kzcLGKH7095075KI8/uZfzKphCQlQVykhd7dthQ9mKIa1Ut3Q91aA2X2WgWw+4FN+RWm/61ty
 23hwr2uRl+DeS7/V9ZNgKsFtaa4u+oNQUpE7k19lwuSOFaQLNY1iCfEpzxBZRZGznQZ3yWO86
 qKj7k8rN+R1zB6jnFRk+/t+TThzHWSBc8/UQTrOVpkiAesC3wlUpc51JGnG5y3bJeBsOkyJel
 Z54KqsqkD1w3Gg4Zzs8MsdWp1Y6UbbxzQ/+t/R8Y5u/S34mNHTIrkVW2Eh9ZJ3U6MGV77CW4X
 fGEkrOuz7pMj7njcKyWy09esfRGp7/zf9zsOfWpA42mbLUno1DdXdlhw+u0cmm7gPNk2rlEEa
 76ZN1Tp6B+TSAAqOMWyrzP0Fv7wq9FUc48nNBaM15ScIBDar8OW6evm0Fbp5Kw/dapUw6VqiI
 eniDAa/b/X+pA3jELd+rS2nXO0PdfXSUUXhWU2QNdLb03O05VS+hjBI74yM94cAJ7wAuq9/8S
 wlpLl7sfI=

> Initialize array before use in mixer_us16x08.c to prevent the
> issues related to uninitialized memory access.
=E2=80=A6

* You may occasionally put more than 61 characters into text lines
  of such a change description.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.13-rc4#n145


Regards,
Markus
