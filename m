Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66E24B2A
	for <linux-security-module@vger.kernel.org>; Fri,  8 Mar 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936667; cv=none; b=MAk1unDvK6R7b2lPm869+Tra4bF+eBI/DqHHcBHct5Uf5e+1w/duN/2mjSdiH1yACbZ/hR3YhBHOFlLf1TRmXGkANLsyuVzlMbMJgBmy8NOVyJKoq6szpZrP6DFBf2dE7GrtnvWKe0i9PM5EIybBxeQJGloPf5hsZHJ6xgf0h3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936667; c=relaxed/simple;
	bh=lHKfxuGYf9lMNawlqgOVU6QWY6NK4e+AKPHbRZrlMGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONBvs3QiPlOKMQ5trmb9s1LfOflGXfjyaS/Eb61Aq+x3GlsEKoh+Hjbd/Hc7FH045ZrjFXw1QLyxPv8mwxLvwU6olo7wdv7+8pMmfgSlKS+rueml9VoH7qOkWlAr/xL8KyF8ww1y9Dx0f74YDRvGh6C4HFb/T3gunFpx15nQO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QhTINgcN; arc=none smtp.client-ip=66.163.191.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QhTINgcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1709936664; bh=T0vPjVSkmHvGqZQ14T0ckUmFLTbT5OBuXXFUZdgcV4w=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QhTINgcNuwXtp/DhK0HlyqRxq506RhR+wp4M643j1wdRCpNqgr8ECOGCSZjiVfQC59vEHMXlqm7/Fg6Q3w5EwE0nt0VyJ9YG0QxBYWRoE/btgX3mU4skbH+JtidVbEmvnokF2Tl6DlLJ1lvQo4DJtOCX9ZfpG1/iJ8y7RoPLxrLhJg7LiGCjHRK+2eA5iaRFw1d9JY7TJBtIZ7nfBbgw26DVx26IYlce+T6U6RPefrD2SMznj9v5snUNU9Si6+x31RLpnUAB6a/S1Nwzsjne65ptEQ5MlF66tULnh6cZ5rIDQuBJePFUlIrOH7++HtSWBbLzYYhkORkIQQJeZLrOFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1709936664; bh=feN2UsidFGxHPc3jlh8nFDEqhk6we8b80FiUockK6pk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QhMxffmi2OvbGT2lU7ydDfYN0vjrV8+heXrufxk6RvzctqddZCO5Nltw0O522VlUN/AJav/EP9TiYcQq8A10IvU4T+7l7viqCmuYZefV90YnCUzByfagdjgQmFAHZYRN4cv/VlpNt9h4unkp13WTvgxsxeDIM4b8lxFLeCykmHZZrbQoKdfFrpba3yzWp4vLsmabUXNbqw2Fv2BObGYDMaPVozJ00UtFSK2HhM+2MbKc09tAsa3SVyy82oPknPnIDvqdzaiy+T4p6cW37RxmtgRDVgbK1RLIWJY6eYCTeegNyj0vlNwFdKDL/R5N+J4WfHQh/d6k3F8yBJjIHfrwaw==
X-YMail-OSG: zE42bZYVM1kvN4FsVTrIe804oxA3y1i6gH2s7ukeTj3wYeu88oxzngdhm.yvqbJ
 0xEtA60c3C7_HNv4EgwF18X2e9IH__e2F6zQiDsUQHCdaQ9_QBpccJV9WGMpnWaCxN2rN2jxRnke
 dgx6g7Am7n_F1Wkw__27CVsgIJJYE9C9cWhO50T4NCxp0fXdqtjAwoHRRFuez64RVzp_n94zRyvS
 I3n3VhloDBj53B.2SxbMMfTj1G6N.a4lNw47qaGSVVSiZ5DM3PbkjC_I06w42RtI1k9toYE_x0Pl
 T1xg7ZkIP9UVrNYhERAY80AmyubNuXmwToQrlw3ZmVBOJD_wqaDeMArOojajKPM5cqXto51wQ7zR
 eHYQghqt2PoK9P9jwgMI6XhjpdOfHNMq.h4X8B3ZYdQHDFZzgzqHN6r_l_joy8Ch1wBxTL8OuPCi
 5jBG5PRt03YW2joaxpAOWoBp0HWiv5pO9Z2rGesSOQ0oexlFR5NHcm2R9hJo8xIe0kxt2enkI42K
 fqq1bWT4qTdDeVyEzDRv1snl50DI1Ajpw8ph7UxOjhQdOK8Zek691ybpQqxhayC1cGz293g5R1On
 DuAgxS2wQU3ilbGXkEReH6R530jUqrImtsB79T8sH6dZ85xV0HxGKHoo0i8W264YUJt_K83t37cq
 ti.B8vRYYoNh3ocxLbRnSwvy.dsDLARlTuVx0YJab.jBahhF_vJmnbjT2bNtvpgLRTwmL.r60a8l
 gkz1ikBZlVuDbWPANpzNYgF294XawwxR4UIhJBRsQdNBCcObq_iKRLsM5cdbWx98KLgg6a1oNeIq
 QhGXAQRtW4WrPBYgqMJQqAT2ERB0bslZCr.psnaFtn7dgqcmchwi8acCTXwYyQ85Pa3azL8S3tvc
 cQw88mQL3tZEBpTSd4dfZ6UoKOixj2CDtEwEwISTT6BQLoZIizeQvuXsF91TvbFKZj6ntY70kdt1
 oPmEUz2YMBv1umr83Ut2E2P0RWJ6mMXWgs5fYY.CbuwgXBsiRf7USDScePeCFCceqKF9c_M4VVbt
 2FFBhpj2zRHDeH.3ZzOTko.KLUC4eIA0yvqkDC.XeQ2EJqu1KKGDwMnd0J4Kf1oLksoLuj_8G1kr
 fcJ8JtBJqPX71ciOQIXHAjAhFh4eD6FJB.SV91qlygeziIZIAtUMUsFYNA5l.CFwDF45noEQHAfJ
 eA9G8EH8aYn2EMyXVzLDUMvmo_y3tZ44S2i_BePW0ZIkqNq7C50FUdmPEk4r4LY.SWifL2eeXYz.
 0Z0sP05S_8HFD6biyoRWRosC6p7irZQbrzJb.qRywr.cUtVYlVvFSwyUlQlYJd4qVCsFDnnEN3c7
 vCes4T_SjBiSZNg34N5kEW7.yv9.bvHZue6OTz6xDox7HMs5re_6dJqfjGwvB..GgeK3AFJW4Dar
 vmPX.XpBi.Tjb6cw1O5q.zk8DGhxlt1MVW.KL7slyT0JjaYtw4JYHyXyC7M_JlywAwbrcL8_4kv.
 XQxrBe_YetNkzI629Io.wzrTdGwZY.zGtbUDIaaGlUZia4mcHRCorxox.GAVNU1r9WRknRR4jEL4
 TM7DflrwsnyQBGt2zmTYV3FoUsTw8oG6GiS96dkczxVbgdGRgVilZTnh4N2B440NVkoW9ur4A69z
 OnlkJgL2RMxViUuDsjOEnuiPcJGTIwx0JzWJoC.E6b4VMzmJMfsfEA1n_qFvpmmggaAzQb_yb7CY
 SYjDHptVCXAeGcel1kSchtw4SBUz.lWLM_7Mv3kGHADwpWrsvyZ9B8Oe5sj8EXETP3SNQTDKz98J
 EYZL4jsktTPV5Nb_waLsno5t5WZDZyCgo0Z5QU0IO2Z6CNzVbFGHroGS0SldagyTf6u45_cHxzS6
 qBf1OhuXuYRDg6gqBoOeINlEWI_2jmuyn49yC0u9uJU8fsJwEPHa3OMqL.C7haL7uWfZqi_WS_Et
 vF6lAYFYo6ofaY.xdvX0399RgIJZTq.1i0PPsoCWwDqPHG0CtxfOjM2_Jl.ap35GL.YGIVnUTr_B
 Gq5b28G_2xzNUiy1MQm3mhMWD5pZP43gi31ctCdzw7vDW46de.TVqQ16Gk14.Vclfn4H6tHxQUlZ
 Im98tljyWZG35XA_eteru_Sag_Jzl2digqdNn.J7j.WWsiNsxaD8p437181otpVm32GsJNLxwE.2
 ai4g095mFt9chIrZDJLSWsyYA5S86P6GhEOZOZJA9EmW5gdD3NT1jCJlWOG6TNLgJsca.7yBaTXu
 zsesBpFBbFlr0C6UpmNBj51M_tokmafyFdGE2xd2N9eWVSPZzlPOVuJ6R3IJQT0DFFqbpe.ERF.n
 exfJF3qP159KmtR9BKLo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 85555eee-e1f8-4db8-be99-7834908b3594
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 Mar 2024 22:24:24 +0000
Received: by hermes--production-gq1-5c57879fdf-llxbt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2c08ef0d57b63e5959879561bfd6bb1f;
          Fri, 08 Mar 2024 22:04:04 +0000 (UTC)
Message-ID: <c0b43c71-455e-4a40-a45b-37fc4a809434@schaufler-ca.com>
Date: Fri, 8 Mar 2024 14:04:03 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Content-Language: en-US
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>,
 Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>,
 Jorge Lucangeli Obes <jorgelo@chromium.org>,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area>
 <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <20240308.saiheoxai7eT@digikod.net>
 <CAHC9VhSjMLzfjm8re+3GN4PrAjO2qQW4Rf4o1wLchPDuqD-0Pw@mail.gmail.com>
 <20240308.eeZ1uungeeSa@digikod.net>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240308.eeZ1uungeeSa@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/8/2024 12:12 PM, Mickaël Salaün wrote:
> On Fri, Mar 08, 2024 at 02:22:58PM -0500, Paul Moore wrote:
>> On Fri, Mar 8, 2024 at 4:29 AM Mickaël Salaün <mic@digikod.net> wrote:
>>> On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
>>>> On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
>>>>> On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
>>>>>> On Thu, Mar 7, 2024 at 7:57 AM Günther Noack <gnoack@google.com> wrote:
>>>>>> I need some more convincing as to why we need to introduce these new
>>>>>> hooks, or even the vfs_masked_device_ioctl() classifier as originally
>>>>>> proposed at the top of this thread.  I believe I understand why
>>>>>> Landlock wants this, but I worry that we all might have different
>>>>>> definitions of a "safe" ioctl list, and encoding a definition into the
>>>>>> LSM hooks seems like a bad idea to me.
>>>>> I have no idea what a "safe" ioctl means here. Subsystems already
>>>>> restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
>>>>> "safe" clearly means something different here.
>>>> That was my problem with the first version as well, but I think
>>>> drawing the line between "implemented in fs/ioctl.c" and
>>>> "implemented in a random device driver fops->unlock_ioctl()"
>>>> seems like a more helpful definition.
>>>>
>>>> This won't just protect from calling into drivers that are lacking
>>>> a CAP_SYS_ADMIN check, but also from those that end up being
>>>> harmful regardless of the ioctl command code passed into them
>>>> because of stupid driver bugs.
>>> Indeed.
>>>
>>> "safe" is definitely not the right word, it is too broad, relative to
>>> use cases and threat models.  There is no "safe" IOCTL.
>>>
>>> Let's replace "safe IOCTL" with "IOCTL always allowed in a Landlock
>>> sandbox".
>> Which is a problem from a LSM perspective as we want to avoid hooks
>> which are tightly bound to a single LSM or security model.  It's okay
>> if a new hook only has a single LSM implementation, but the hook's
>> definition should be such that it is reasonably generalized to support
>> multiple LSM/models.

I've been watching this thread with some interest, as one of my side projects
has been an attempt to address the "CAP_SYS_ADMIN problem", and there looks
to be a lot of similarity between that and the "ioctl problem". In both cases
it comes down to a matter of:
	1. uniquely identifying the action
	2. providing the information to code that can act upon it
	3. providing "policy" to determine what to do about it

My thought for the CAP_SYS_ADMIN case was to provide a new LSM hook
security_sysadmin() that takes a single parameter which is the action ID.
I called the action ID a "chit", because it's short and all the good,
more descriptive words where taken. Calls to cap_able(CAP_SYS_ADMIN) could
be replaced by calls to security_sysadmin(chit). security_sysadmin() would
first call cap_able(CAP_SYSADMIN) and, if that succeeded, allow LSMs with
registered hooks (selinux_sysadmin() etc) the opportunity to disallow the
operation. I planned to include a small LSM (chits) that would allow the
operation only if the process had the chit on its chit list. Landlock could
add policy to deal with chits if so inclined.

A generalization of this scheme would be to leave the cap_able(CAP_SYS_ADMIN)
checks as they are and add an optional security_chit() hook for places where
additional enforcement information is desired. Adding

	security_chit(CHIT_IOCTL_TTY_SOMETHING)

to an ioctl would allow any LSM to make policy decisions about that ioctl
operation. Adding

	security_chit(CHIT_ERASE_TAPE_REGISTERS)

after a cap_able(CAP_SYS_ADMIN) could appease the driver writer who would
otherwise be begging for CAP_ERASE_TAPE_REGISTERS. My biggest concern with
this scheme is the management of chit values, which would have to be kept
in a uapi header.

A major advantage of this is that the security_chit() calls would only have
to be added where someone wants to take advantage of the mechanism. People
who are happy with CAP_SYS_ADMIN or ioctl as it is don't have to do anything,
and their code won't get churned for the new world order. The downside is the
potentially onerous process of deciding if an LSM cares about an action known
only by its number.

I have patches close to ready. The chit LSM isn't passing the laugh test quite
yet, so I'm holding it back for now. I wanted to bring this up before we go too
far down a more complicated path.

