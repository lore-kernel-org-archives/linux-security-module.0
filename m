Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5334D382
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784760109; cv=none; b=HZQoS8lvacFbxWt60NLTFeQDFX+0s/8BfZ6k/4nEWJZR3dtj/iwZrtYpnRF/A5qmXeaV5KpZaDPtr0Elkt0SdTmsCiyX4gA+/TvZCBQ/tqrx0Dxr8PzVjcQYvsLu4c7J6BgIxcb7V9iW4aPQGrhh26qGAY31a//ZTs1v1qXZ+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784760109; c=relaxed/simple;
	bh=UkvBJigrFJ+NDyBuMETPJybDse5G4X/lKG4s+fW5Bwg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aonBLJPQEemQi5ib6kfBD65Hb2Zbp5K4dC8G8T4K+T6XkVcJHb5v+utLJGkI15lIp2Oo4iLZS9u1ZvJpYbKm6x3Baa4MGD0/pj7xhhH8hoVSe8TCDea/GMAPJhW16DXQBTm5i2uATzNrrQOCF99v4EI3BFKUX4oc7KW1ZDpLZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=l1nydvB0; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="l1nydvB0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1784759783; bh=UkvBJigrFJ+NDyBuMETPJybDse5G4X/lKG4s+fW5Bwg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=l1nydvB0vfaFLRaW50glFBIvAbnBw6F4oIPayYLTdVDT7h7ksi3ndsYBPZHCrfBdO
	 GvyEeRlAv9UtQ58/7bV8w8eA15HPZPNE8kiyLL30YDvykt/+kD4MbBljk6k17yTGns
	 3aKL/18xMt66uH484+tGpEXp6p11KWlPoH6BJI3tmIHSCN2Fk3LDkAd0iRvtvPtzfl
	 CKayK7sGymlVp/58NzSMsuEt5WkDVx0VqZ+QXokHOnWwFz1JJyNir9FGC+49Dk4WdH
	 QtCSDvHdL9dst9qsKjfuABCEwVcD1B9uZp9pE9WFQ2P6eg2CZG7wODUN2DUxHWxrd1
	 J8xTFNP2YvA0g==
Received: from dummy.faircode.eu (unknown [172.56.88.240])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id 5C359271;
	Wed, 22 Jul 2026 17:36:21 -0500 (CDT)
Date: Wed, 22 Jul 2026 17:36:06 -0500
From: Serge Hallyn <serge@hallyn.com>
To: Ryan Lee <ryan.lee@canonical.com>
Cc: Baruch Siach <baruch@tkos.co.il>,
	John Johansen <john.johansen@canonical.com>,
	John Johansen <john@apparmor.net>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Message-ID: <48d44625-7fa2-4e1c-8821-4d22208421ea@hallyn.com>
In-Reply-To: <CAKCV-6vP2FKgTj5PT3xB_TDL+zLk7xYf2BNw6mKXfPb3OO2TWA@mail.gmail.com>
References: <2ce1d4ec18b2b47ee7ddd9c1ad7be68e185aa69c.1784632742.git.baruch@tkos.co.il> <CAKCV-6vP2FKgTj5PT3xB_TDL+zLk7xYf2BNw6mKXfPb3OO2TWA@mail.gmail.com>
Subject: Re: [PATCH] apparmor: update website link
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <48d44625-7fa2-4e1c-8821-4d22208421ea@hallyn.com>

Jul 22, 2026 11:41:27 Ryan Lee <ryan.lee@canonical.com>:

> On Tue, Jul 21, 2026 at 4:40=E2=80=AFAM Baruch Siach <baruch@tkos.co.il> =
wrote:
>>
>> apparmor.wiki.kernel.org redirects to the current website.


Sure, but kernel.org seems less likely to go away, and the redirect can
easily be updated if needed.=C2=A0 Up to John of course, but i would leave =
it
as is.



>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> security/apparmor/Kconfig | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
>> index 1e3bd44643da..472aa38254be 100644
>> --- a/security/apparmor/Kconfig
>> +++ b/security/apparmor/Kconfig
>> @@ -11,7 +11,7 @@ config SECURITY_APPARMOR
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables the =
AppArmor security module.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Required userspac=
e tools (if they are not included in your
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distribution) and=
 further information may be found at
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://apparmor.wiki.k=
ernel.org
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://wiki.apparmor.=
net
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you are unsure=
 how to answer this question, answer N.
>>
>> --
>> 2.53.0
>>
>>
>
> Reviewed-by: Ryan Lee <ryan.lee@canonical.com>

