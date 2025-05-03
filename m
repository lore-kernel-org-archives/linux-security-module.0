Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4712798E3
	for <linux-security-module@vger.kernel.org>; Sat,  3 May 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746292157; cv=none; b=nbNLpadtq5HfnNg9x9r636V/GhPJY35eQ9IcP//Jzhd+/Q7V+oGJ8RnF2aU2tZt75e037OejbicYmfkMbckKpARDc43LHX+Ii579Ha8WUAB9hQhpfGLostiRAcCedM3Hg3racjpyS6P3LpTfFVQgmb39NXcTvvnkN7S0PlVuxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746292157; c=relaxed/simple;
	bh=kXrtDwDmbaOhMdscUnfh1lqcoEytZM7XtQEhJEfyIPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2/df9bnq8F0z0l10lzyYqZ2WQ2vA03ChWCrm8d7AS9fkpJpylbEJBKNbDq6dpdKtso41vInLf5t+UgQPNgwTNrSnJMHqmCPLUspuIkrEJUsf1P3lMoyIFtAe6se3C0YCxRG08ktFlfkXGVAXNzwihLPna5+xpRVkeqNvDCbNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PiQMAhwd; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PiQMAhwd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746292147; bh=hjpIjRelMEUEdZxp0AUrZ6kuMQ6V5Qtr+RALk7GLI60=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PiQMAhwdDlDdFPaFbR58pIeG8KR5waCVNTZMRaS7xlrIczUuWtssJ/DGcjfDbAk6bGRJjLqz5ul8eWOUSLdhBSWDm/soYNGbYrSkJAf4CxcgUQAEng18bMrkII0LRVsj8o0VaM+HZjZxcpa8CJdtlGj18RuXaRbWvPnVBgzGwuMwp5GXXBF8EINxbPG8P89EUsHnXov7gpUJiEdLeDV2hyO0RyblOuGA3o170mMhz5I+J+s1bu38ccTJlZ9PKVN/ys2Gob969r++2G7ZdoUUzZDmZ5B7aJz4NZhJmadF5qIcl2CSd9EU39AdCd/aeTbuOBk7bPVamHIbn1QwiVRCew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746292147; bh=gPTxaFE44OjPFXB9xP/WqRn7Qj0yVAgYW2rk20qa4+c=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fXYJhxAhD3fWu9xJ+bIBVMKitBlEMa7ERxNVoVv2daRYbTINM1IWr7CQS/bKfUz5kPHU9uB/ylfZIycFVTuJRHTUJZnx2m08rgcOQtGKOpBXaY3+ncEi09Aw5A8Ct+gwmLnZJmP/ACm1CdZXc7FWuHwvtX4u2oSf01pBLdmpbJCt8juLN5twLofXAVswVhTWGe073wXajFki13sOjuv8tpgaB9mOI8FDYDy4tJ1qJJUzTQMWVamQed+04rh613+8kUD1Uk7DCP3BQ9HEPp4RR8VGko9d6Ef73UOxEY+fueG5fZrz1MeGJ+8FnIhNlbbJ3TXtt2BOpl32YSzZrhsEbw==
X-YMail-OSG: Id1ofiAVM1nklkifOZlxyo46q3a3SykAs8Gx.um45OhXf9uLUg_XO1RV7oVn22O
 IXHdJdrKpqRlEcb68cDCPmoyztLWjW9p3WifFbH6loOrUAjhqHWX46szLGFsK.pXkyUQBjJLp6gk
 nGMcQqXeqAssVyS2kHOATKurBAay.vb0Yf116ohufOXuNH_0bip8CmY7gqvp1NsUaXwdejGEmCsb
 7ixvjA5BeYs.IXAKSaNj8juW0BT75bf.mGtqmmxpN45ungnrcRpAwVXK0PKm7bZNVWMOXnE0O5ST
 kSIvxx.kzFMAfindojM4k6yjBSb8voSNJ3vxoZJzV.Enjrjj19oUh4zHJB3MPL.kFTGTYGPFNRYH
 C2nkotGcxKdP2rleq8d_mhwoyISzzowZJFyAQZ5m1ROsfthnAEuezj2sV8Y5GqE3PDSpo0B0qAfw
 dMDRJQp_XZ_eu4oRZEu3NNovcM1nTwT1X.6enZ8bV1gO9Pf1s.7FDowTVItWQj_.C8Lbh6hke5Rb
 xaVm2JRyJgNNRieGYEwwmyxDyP23YCkNhNzLI.Hi8jlPvJ01.LHBTdUensIPIbNtXltmZ_6huoZL
 tQc9rD5z_bGWhsVdXaBTsB5AdBdHBWAnkby1QSY34MQz2VWyTa5Ehw5U3e6dUay0CZfNFgrZmfIM
 FNrmzKXoN4nNAxnOcj4AxFO8ZXgaN44iT.3y9EeqpnK8eYk8.XhihuSKrA9CXg.v1hWuWmI0YSYE
 mraQr2rHtG_6fP3IuoEbsoui7Fvy5TCSdjB8o2HC1nVz3FrF.HMyB5UHbiEDJmOLIUHtRd2njebg
 BlmqN6ZDxMAu.Ime83AsbD3_wYzjXimefkSEzBTOJNUK0opAEto9k2xZiXX_aFpPlN.xxUDFWNQP
 d9bbKQp5wUch0MXgk6e13MQGImDoGu1WFIENpoBwUgrZf3NeETfIcXaEtO0E4o4RmKqSftmFqKjl
 0hjcf_zzKvZcy2LPx3MpSRzcHxgC0UlpbId3z5rWUNCGiFEPsmtReAe.8mjeDjDpJKx5yMIlp1UC
 Rmmt8_lo__WkiaZKNHpG69jg6bUaLaWRd3oqV5zfWZ1plL5kLNDIZ8aZBc_RByJxpReBMnMjdpTw
 kLX_ZL08qsWXzlu7b.hzW3iRwyAmA5wgQJE4fuUxZneHdgojTNQdfllWgaQLFnUQqnFLVbPKqKYM
 y3T5KMIJeBhBxGGTx7QPQGr598io5ell2eCFVzYldKEyGgKxAC5gkTTzMcPtr4YdPXyBN7ZIVWXr
 GuslIFGI0vQSxADfaPQDLkfmmPmVKN23EpMfowJ9eJPNhZ0gdy0pnRnbA958QHtcH1nCIhr0eMxQ
 ro2ey2uVrHbrWof4VI3OvSw3aMV5WPxqGQeNbG.nqSvCOUwe9l3Owyn3iSF19xPHqbyHopy73Ds7
 M0JqVtZyOyTS6tt7n_TxR._R0_U1OfAeEh.EVRxwPXZyEVypu9fM4cytPh_yT.uCImqd0ooAQW0P
 SR5FLhIxzaZZwqxyG.ANbvNRUD_Uo7.CmM5_U4SOnMcrQuUZTwCtlBcMi7j4P3b19fBPTp9qx8FI
 QJ_JYX824yScZsH1QoPMvvnaVIXoDJYC2NyxNJCVHMQG3G3P77oJ_0Yp5x72BLotve3RfpwHdg9k
 dGEcvQJ484JMpY_yz7j0G2qt6zgH5cdt31TBhWEcRDDrGfMyrlmqG_t84DTLjBEnZLA_wObDSjXV
 AaNZIn4sJnzcgkZuOCoy7u0bkfi6G30vIrQmVysww.NzWlouapcz9Zulq8vHLsQUTqclBRpoKcgD
 KPphev5iss_MNwj8LdBE9kMiwYVfv6woSLbnwyYv8.Ipj2NqTuMTaerZSyUQj_a9tS7IBJprS9G0
 Jh8tZMjQXzXPPfIn6k6f7LSfGDg5EAHUtRC6ZE0oitJWXKZt7smVxzgxcOuO_l14NgHbIc54Rj8K
 Eg9jDLMQIsLynZulrTFJMS6yrL8g2xHjZBtysvtS4fQ9_bc5mVkm5bShErg8fzPtiwZhb76pUIR.
 9ccKPmGijjRNzzjwFMo8Ju9HXcP1N1tN5L6LEf0vYrTOLbSXLFenhlWuDXXyoL75BT1oW6HY66qB
 tsMUuKwdzG0WUM0A7zFQvnq7LNzBpgCOTgJPMKclC.I.GTNLTJTMYhHg1qIWF3pV9zdruIxmuMRo
 fDMxevPoQKiDpwsQUPonNcz5Qwlg_O.ic7bRH2VN710ykI7YdB4KQ11G331Q09bJ8_jNp.AJDGot
 aSxPnPxazjk6O5TwzAta8SLr8M7z8l72vYLngM2TAA1OovJGCdbBXQ3BodZkPoF8zhEMANcQoXEu
 qz_8_nA6T74EhGjl2qq23wwYyl2buow--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 691cd7ec-207a-49f0-ac5d-18752de62aab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 3 May 2025 17:09:07 +0000
Received: by hermes--production-gq1-74d64bb7d7-w6q4t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa8147dd6b9de42c61252416e62d4a18;
          Sat, 03 May 2025 17:09:04 +0000 (UTC)
Message-ID: <cfcbf519-2d82-44bb-9d3f-b9e743f1911e@schaufler-ca.com>
Date: Sat, 3 May 2025 10:09:03 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] LSM deprecation / removal policies
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: Fan Wu <wufan@linux.microsoft.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>,
 Micah Morton <mortonm@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23772 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/3/2025 4:07 AM, Tetsuo Handa wrote:
> On 2025/05/03 5:01, Paul Moore wrote:
>> ## Removing LSM Hooks
>>
>> If a LSM hook is no longer used by any in-kernel LSMs, there is no ongoing work
>> in progress involving the hook, and no expectation of future work that will use
>> the hook, the LSM community may consider removal of the LSM hook.  The decision
>> to ultimately remove the LSM hook should balance ongoing maintenance and
>> performance concerns with the social challenges of reintroducing the hook if
>> it is needed at a later date.
> What about BPF-based LSM users? Since BPF-based LSMs cannot be in-kernel LSMs,
> it will be difficult for users of BPF-based LSMs to respond (that someone wants
> some to-be-removed LSM hook) when removal of an LSM hook is proposed.

That's dangerously close to suggesting that the LSM hook list is an external API.
It would be really inconvenient if hooks could never change or go away. It would
be especially bad if, for example, vfs changes made a hook obsolete. There is no
way that Al Viro is going to eschew a significant performance improvement to
maintain the interface or existence of an LSM hook.

>> ## Removing LSMs
>>
>> If a LSM has not been actively maintained for a period of time such that it is
>> becoming a maintenance burden for other developers, or there are serious
>> concerns about the LSM's ability to deliver on its stated purpose, the LSM
>> community may consider deprecating and ultimately removing the LSM from the
>> Linux kernel.  However, before considering deprecation, the LSM community
>> should make every reasonable effort to find a suitable maintainer for the LSM
>> while also surveying the major Linux distributions to better understand the
>> impact a deprecation would have on the downstream distro/user experience.  If
>> deprecation remains the only viable option, the following process should be
>> used as a starting point for deprecating the LSM:
> What about users using the major Linux distributions whose kernel's major version
> won't change frequently (e.g. some enterprise distro has 10 years of lifetime, and
> would require 3 or 4 years when updating such distro's major version) ? Such users
> likely fail to know that deprecation process is in progress, and likely suddenly
> be notified of removal of LSMs one day. I agree that the upstream kernel may need
> to remove no longer maintained LSMs, but it will be hard to make an assumption that
> any reasonable user has already seen the deprecation messages.

As you've pointed out many times in the past, users of major distributions are
unlikely to mess with the LSM configuration. If Redhat came to their senses and
replaced SELinux with a combination of Smack and TOMOYO very few would be the
wiser. :)

