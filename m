Received: from mail.tkos.co.il (unknown [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1A366553
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825010; cv=none; b=GF1ve2f6O1LfLtBnRiTvKtS1I1xFE100cLQzVkyjrMRVdWSXejTIpUecxQsqsJZNW+8wm+cUpAKyf5JhQgyuOIt9k+v50aUeLY05gHILvK2U4HKmVbRdCCsOCmxXIePp4th2uzd4QtfzRLT6NfCu20cjhhZN9Rt+hEWmlZNNsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825010; c=relaxed/simple;
	bh=I28k/tY3toZ2cfyrNFixPWiA0z/gEkxZmD63vJliiUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lip0VMtBx9dWNc1kiAH66J8MB+SOsDbFaUQmLQF91kivPIMjevGAgTkV9I5H3E5poInYad9gl4BJQ1keJx8sXUZNWF1ca6kqA5zvgRVRu4yblwUi0Rf32bTGKg0NrTJGhEdEaAwbCW33d9VK4ShcGNisPlZYCK1PQAZUEvSv7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=I01IZZ/S; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="I01IZZ/S"
Received: from localhost (unknown [10.0.8.2])
	by mail.tkos.co.il (Postfix) with ESMTP id E387C440CDB;
	Thu, 23 Jul 2026 19:42:58 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1784824978;
	bh=I28k/tY3toZ2cfyrNFixPWiA0z/gEkxZmD63vJliiUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I01IZZ/S7oTaZvZLduXjY3az2mtAvOOmKiWF3NLgiEUhOpBGWPHo1hAWPQOsXqsvk
	 byiWDpTrsos5esv297iaoB5/DjOcA+7gBULDvBU4qTBzTpwoFxsSFwsRPBOsloGJKW
	 lfwSeEW2/BZtQpASTGY3jF6JuusvSj8HHAgiGiXeXx3F6xAq3aZHJWeoiuoC6aPhdN
	 I3Z/pfwid40EVXWQ0ZJAm7seT1EnFXOHTEON0veofcgnlmswrw/hHuYMdqDVstL4Ue
	 lvuwjmijee/gA02i2Z3TKdN4lTcOIk9/Q9UtVCB2jcgVNnTVsajJQJ4VRWWtfIwNlK
	 bvZb8ySh8P33A==
From: Baruch Siach <baruch@tkos.co.il>
To: John Johansen <john.johansen@canonical.com>
Cc: Serge Hallyn <serge@hallyn.com>,  Ryan Lee <ryan.lee@canonical.com>,
  John Johansen <john@apparmor.net>,  Georgia Garcia
 <georgia.garcia@canonical.com>,  apparmor@lists.ubuntu.com,
  linux-security-module@vger.kernel.org
Subject: Re: [PATCH] apparmor: update website link
In-Reply-To: <ba05df8c-fb79-4a14-a9b9-15e50e7dc4bc@canonical.com> (John
	Johansen's message of "Wed, 22 Jul 2026 16:53:11 -0700")
References: <2ce1d4ec18b2b47ee7ddd9c1ad7be68e185aa69c.1784632742.git.baruch@tkos.co.il>
	<CAKCV-6vP2FKgTj5PT3xB_TDL+zLk7xYf2BNw6mKXfPb3OO2TWA@mail.gmail.com>
	<48d44625-7fa2-4e1c-8821-4d22208421ea@hallyn.com>
	<ba05df8c-fb79-4a14-a9b9-15e50e7dc4bc@canonical.com>
User-Agent: mu4e 1.14.2; emacs 30.2
Date: Thu, 23 Jul 2026 19:43:20 +0300
Message-ID: <87bjbxodw7.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi John, Serge,

On Wed, Jul 22 2026, John Johansen wrote:
> On 7/22/26 15:36, Serge Hallyn wrote:
>> Jul 22, 2026 11:41:27 Ryan Lee <ryan.lee@canonical.com>:
>>=20
>>> On Tue, Jul 21, 2026 at 4:40=E2=80=AFAM Baruch Siach <baruch@tkos.co.il=
> wrote:
>>>>
>>>> apparmor.wiki.kernel.org redirects to the current website.
>> Sure, but kernel.org seems less likely to go away, and the redirect can
>> easily be updated if needed.=C2=A0 Up to John of course, but i would lea=
ve it
>> as is.
>
> I am unsure of the best course, but atm I am inclined to leave it with
> kernel.org, Like you said the redirect can easily be updated.

Another problem this patch fixes is the use of unauthenticated
HTTP. This is less than ideal for a security feature. A MITM attacker
can easily redirect to somewhere else.

So a patch only switching to HTTPS should be fine, right?

baruch

>>>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>>>> ---
>>>> security/apparmor/Kconfig | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
>>>> index 1e3bd44643da..472aa38254be 100644
>>>> --- a/security/apparmor/Kconfig
>>>> +++ b/security/apparmor/Kconfig
>>>> @@ -11,7 +11,7 @@ config SECURITY_APPARMOR
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables t=
he AppArmor security module.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Required users=
pace tools (if they are not included in your
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distribution) =
and further information may be found at
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 http://apparmor.wiki=
.kernel.org
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://wiki.apparmo=
r.net
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you are uns=
ure how to answer this question, answer N.
>>>
>>> Reviewed-by: Ryan Lee <ryan.lee@canonical.com>

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
