Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E485114A8B
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526867; cv=none; b=VAHdoaRoAG4gPbgsNE/XXbUssgpeEPXimSIbIu94MHLWzGEfmVmOLUnWMMqEzxhXCQ+dUNRmeruXikp6p43Sn0oiWgKQAWflqWCsnAfIgfbq67relr/83EILeljVuHqkVBtWjVXBWsq5cYd+4LdWiJt8iHYIZJ7DZZ7gS8Bliq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526867; c=relaxed/simple;
	bh=ZJ60hk3W7oiFCeVzRzHrfxgk3H3Cz5Zfv9Fvf2olsOc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NfPm3iSDWcaOGHHefVEbVVPO0nGPBxSfetGU6j7qikyjei6ags9QpOhntfdC5bMCkK5NkKHW6SNa++J1ZhCx2z1GswQzAvr1R21PhtCGTnpOdTHbp4KfDlPEx8l4CINzhnyraO8ERzjAHPutqsFbwcTnYgR3zzxvL53YYYDZG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=fail smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=pvb6d8rm; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="pvb6d8rm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772526855; x=1772786055;
	bh=ZJ60hk3W7oiFCeVzRzHrfxgk3H3Cz5Zfv9Fvf2olsOc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pvb6d8rmBpMOIzl/0pSC36km3vpu/zMh6MJDGAk37rUYTD3m+dQ1di5/QpIpXwZKq
	 G5zjSutNOQXi/JZic5Aww6MB/z2h01Trl9yvau0TQgrO27MOtZrtEZ9YmEbuLqALJP
	 2ds36j5LIMRMFn2F2NzWMtQprWAWDsecicMuUgnWuO2pQ0BALvZHnkHmAMooZWbyun
	 DHG9pgncVHjqlGsizgZMXW134r1e1oz9cnO3K07ioQ6+qlcOsBdvP/6RlfTCppU0WW
	 QfumDNufkv5U9/dDRK5aNjzUa/yXvp3yrF6cS6j0KvhAXmvQmIl2kbSFiOuGjANsNY
	 LwxfnKfq/5keg==
Date: Tue, 03 Mar 2026 08:34:11 +0000
To: "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Government hackers changed my video title in my primary / main / master Youtube account recently
Message-ID: <FkYJqnaeKVKLmopK9YUA6Cz4-DGj1FUIe9sH_oVVmFbw2JocWG_qp9N1EPPTysxcVMTEiL1Bw8qn_x3R1tkspnJTPSE9dCL7dcj8zOwLDi0=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 42a9e1d7f4333d376b8f6e731fcda4b9ea1ce211
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Government hackers changed my video title in my primary / main / m=
aster Youtube account recently

Good day from Singapore,

My primary / main / master YouTube account is protected by two-factor secon=
d-factor authentication aka 2FA MFA. Yet government hackers were able to ch=
ange the title of my YouTube video easily.

My Youtube video title will usually match the video filename on my computer=
, 99.9% of the time.

On 4 Feb 2026 Wednesday, I had uploaded a video to Youtube.

The video filename on my computer is:

=E9=83=91=E5=B7=A7=E5=84=BF Jayner Teh Getai Performance 4 Feb 2026 Wednesd=
ay.mp4

However, a few days later, I noticed that my YouTube video title appeared t=
o have changed.

Government hackers had changed my Youtube video title to:

Jayner Teh Getai Performance, February 4, 2026, Wednesday

Yesterday 28 Feb 2026 Saturday at 6.14 PM, I made a verification check.

The Youtube video title does not match the video filename on my computer. I=
ndeed!

Immediately I know government hackers must have changed my Youtube video ti=
tle.

For the past 19 years since 2007, I know government hackers have control ov=
er my Android (Linux) phones, laptops, desktop computers, servers, and onli=
ne accounts.

This is because government hackers regularly love to purposely and delibera=
tely show off they can hack into my devices and accounts for the past 19 ye=
ars.

Recently, government hackers purposely and deliberately show off they are a=
ble to change my Youtube video title, when my primary / main / master Youtu=
be account is protected by 2FA MFA.

What are the motives and objectives of the government hackers in repeatedly=
 and regularly showing me they have access to my devices and accounts, purp=
osely and deliberately?

Government hackers could have chosen NOT to let me know they have hacked in=
to my devices and accounts for the past 19 years. They could have done it s=
ilently and stealthily. Why are they doing it so obviously?

Why? Is it to distract me from something else?

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical/Mental Problems/Poverty
1st March 2026 Sunday 10.31 PM Singapore Time

PS. A few minutes after making the above report, my vivo X100 Pro 5G Androi=
d (Linux) smartphone started playing music by itself without me doing anyth=
ing.




