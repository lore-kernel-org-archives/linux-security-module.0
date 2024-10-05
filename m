Received: from sonic313-21.consmr.mail.bf2.yahoo.com (sonic313-21.consmr.mail.bf2.yahoo.com [74.6.133.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091EA155382
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144625; cv=none; b=SMrmgw+U4H2FATBYEoXU/jFQBKuP1sO1VnetikF59uhU6DvWUOeUgcweDaFI59MxgOoT9dNSvS/R/Cjdi31SWEdlmOFepH9izze1Kb7drMy8cbovglRw6KoYcJJoKyXXSzQ7ZYAABAX3l3vhAsDUMqvI3nHghymwsILLY70qZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144625; c=relaxed/simple;
	bh=ZLFkNnkHzNnt6ltVrqydLwGUQiEet7xmuh/tdtIiasA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=az31Lw7Bvm21vd3aB6hbU0vUOc3b91lC2Kyymd2LY5/Yby0/qMb/AhwdnHAG30c9BBXICtreE7E+GbCQxYiDagwzojF84yG5v50TWfpHUlgowptHDjIgM/4B9WcW3heKNAjVy+wDBy0IXQKI2gPsCJTTjd+gQvHaDkP/WAe1y1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JqzY95MR; arc=none smtp.client-ip=74.6.133.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JqzY95MR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728144617; bh=ZLFkNnkHzNnt6ltVrqydLwGUQiEet7xmuh/tdtIiasA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JqzY95MRPUWqf05LcFHMDyu4mNUvSL6FhROkDr18yzpKPcqGQ3ZODP2ZrBUMjORy4E4h1SAVTVv1DCH/jmC4NulJap76LJGmntF+lzdu9wX5Ey7m8t1fFaTMO7B8i/IKnoPAZ4RZVJGokX4MlqutdnxeLadBmA5qxA7jvQuuk8/J6vxuE2DAjJKxAb+4q6AB7wHrpUKwRApeQ2oj4LEC6Tufn318gUroANxZJl33o51dKq4rpsiYEoFDcKCQTASkGIOF3crTejARyKvfQSeHbyrM7pCBA+zg264kyPqFAoywcN6YbUgGeJ1/z+nqhpwEHTSCRhDotlZ2IbOAMElnug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728144617; bh=kQmsoQSneX5DetEn7q2pX8DrjMbIrI831YbsC/FHMIW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=L2tlr6sn6Jb2aGpkdQ1hx/GwGEMgey/4AoR5PxNEw2XBSlgxEDKjxR93mfW3K01ZNt/jYtpfNrGoWSwKBCZFnemv110PvTvP+zhJ5BY1fmt1tQYS5ksxrdaMPKH8VOY073bxl/M2albw5ZKzgJDcaK+RvRuq2eHYnhX8nj796RMdIHB26DDerjFqA6AyFAqH/E/okBxXG25ZGjyQ5fG/Xj2sh724isZTCsbAWz0TmBVLHfkl8X3NOFelUuEcCTlXmOz+/le4/u0JNsgn5VeBqqcp6mBDnTedOEelkfoBay8tNZjopXooNsi1GpfeFt5eF6bDNCwxYY077LMU8rjG6A==
X-YMail-OSG: weVt8jcVM1lZ7Ui4ph5cuKnZuiIjtlPvoI7n0tw8CrsqrvMKuYDPKW4PGIVCQNi
 atlX1SMNtxixtY46nwCofzq9uZYvLaSlqb7.BHd9v0MCoirZWNivZYzjOoor5qC75WdYNXy59pv5
 2aRe7OGRRp6PmxlgjPSFb_1aKzObEygz_4xdY75Tud.W4ihDb5CKNziVkM1mLvLm5rs47qxrx69i
 v0kXK0H376sSRYMlos.XxAcBg.uk9W0ruOwrKiaq.9DFzfvS_wNKu3kJ2XsRyO6AxcAnOPIuLKeW
 nzFseXshC_Y5dTIfbDcZiJ6jay5Q_eOzn0xJ6U2tal7BBWxckD8OQ2QGfVp.0RsimCbaX_Tl_M0q
 J_msENg0X1PX6j4mNgr5Bq9EnPmsY4jRgpWsYpbAjYElEKrnyKuImI_q9zg01kusWWW6MSlLWC.t
 25Wgp.h1KX44bY7Q3aa9jNGDaPmU4wfs4X2953k216rh6y369LtPvrTviLQuQV8h_t2fyYn_2rfV
 nhRm7GKEQwFmMh3uEvceZYKeQEtXDulkceqfOMFPIosvdGBCt0KUbgOYnZtHE4lHukoYzvo1qa9X
 XTXK_lpth8mCloJLaE4qTJbdN3DDGCpYMrEhWxowise3IAVqC6TGj2QZc1qZslLyAPAjety0Rxe6
 wJ4huKBakRHl0G.tpdtwuVlRMd7TuM3ZnWOoceo3Q7ZnhbxbMVrPPNKVts2IhyOX9kOv3igArAph
 _UjMS9INrjWaLhMP1Is.tDprcvRADUmKa8AQZI7GL0Q0uu_RW6Yg0rDePF7EeJ4d80gtRMs4UV3T
 Q0C1rJ.oAxvTCcL4NmkqtlR9.GT2prKGsSXNnk1XKB0.dmEuq1qpWc2U0xAcKOWgmD89JwWP41En
 s3F.HfJC0eVKmffiwCpAPkPx2wiz0Gic9GsNJKbsxWBe.gkZ0ghsQ7wgdpP5OH07NEU7AmSQ1Uei
 q8XiNt6FQEOqUhklNW1bU7kYp2cv36ITiJ.3mfkH3_7WBsVsDqMGNhsXXkf3qJZMf7Xi5aMqWV6m
 Hyt9H_ykfHjkhzzjmE0whfyXpWVxtQmLlTC69dFEZ.sGAqimlvXIN8etFkcBOIbXit2wdZ._n1R3
 eZuMR092h.RnibLpOkV6QFZV2.q2EN.f0xthiXKIjDxeohOLuroy9uNULPM4Ol054MHAVp7w91UE
 zEFequVkp3xULQ9XgKcK5WGb8wWllRqcJetTOUB5SLeWxtufPkOTpUxy0JfiqYSH3mHoHZ5dIoGa
 tlpY7tuOK4NlxOKtxENbeZAMTe0CHfIMbsqzwfTFZaDjqWOc3_QKGg21B0RPaoJ812s8gH5aT9P1
 0TyOnYAf2F5WLmC4a8Hwk4PFYoz5PmwqF.s_kybu11Sx_y.B8sZUHOmXFg9t.dMdKt0RrUvqRUe5
 gc2oFrhD0h41Hx1MzmSzREW_ESeyHZ9GnJMqoU_YnBEb2._zP0pxG5y6K.DDSHAjX62OTFr.VqQJ
 JA4rw6rmBeykgauZ5rZ4tg45xoyzNKUP5GIT9CKhPqbvTPbFPx5bMHGq7z.wnktbOhOX52mIIVFd
 O7E.FtLBDPkCdCceF1AY.qQZ_lL1K.6JSSLhyO3lGgosTH8tvdTuva7YK8fUwm.ACgp4B6VqJDbI
 luwffSdzlAbI8XldnUy1w0N8ieJvsunNnZ2n.qcpagy8f946JOqKEUkTlCtQkDVgIUpZ3Oaw5oAQ
 hQ7gGrUTGYJVRifZi80sxHE6nmAYndVqG4IUbawNNbDU5Ttf75T7wEpjLjxhxoLh.ZG6zbHzF6qs
 kDbLf4WBWyKOplmopfmch1eR4fn4KRIsRi5QfgdXJuDjr4Ie4ik3iNyAu0sDQ7vu.P4yWcHEsIIc
 GpUgIMzdZ6Tz2VX1fQWrxsL7qogWzIGlsjXlGVXRYF2o.CvVW02W7QK9y7aTfjGpm7WrRJxCuOWx
 EnpE_pnWaBknNcu9PodnkPV0a0bdgyYUmay32sgS0kQ3.Q1ir_J91MDSZUQiDVRsB2dCfRBQMTyA
 SXFJwDaR_k__AVU2zEbgJc8eqYJbLRYQLqUPJzcb0n5V14GytkqJ5SrPo3SJGDctaHvWt8g8vrSg
 MlKwnEDw.8I7iw.N_hOSI_0c1NkgelbCr7mkY.QP.MJN8IrHvYYQ9plWEgWiCAyEbofyBGCZ7X_m
 lVp4WDwTxMa02xYCzeMN3M.UQA1BwNVr8D8raBcwiB1sKrt.QOTp4cgwapTJDaUl.4FIC1fg9aDN
 6a5SU308htEFzfmK70_k6kh3aFxM4oh5F49wDmsEePepCdLz6QS.pwYscPOo.P15xGYRvf9TqZZ1
 a8OTN97wJYScwv5L3pgtRiUITM83Yrlhi0Nc-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 66ad0512-b3d5-4928-ac7b-ab2b32c65181
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Sat, 5 Oct 2024 16:10:17 +0000
Received: by hermes--production-gq1-5d95dc458-7jxgc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 041d0276e058f4541bfd54115b2a4a49;
          Sat, 05 Oct 2024 16:10:10 +0000 (UTC)
Message-ID: <4eaea237-d259-44bb-a546-26a0558a4453@schaufler-ca.com>
Date: Sat, 5 Oct 2024 09:10:08 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Fan Wu <wufan@linux.microsoft.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/5/2024 12:10 AM, Tetsuo Handa wrote:
> ... It is possible that an attempt to make it
> possible to use SELinux and Smack together is a wrong direction. Even if SELinux
> and TSEM conflicts about their security models (and cannot be used together), it
> might not be something we need to care...

In the past I have said that having SELinux and Smack on the same system
is the test case for module stacking, but that I didn't see it having a
practical application. I have since been presented with a use case that
seems reasonable. Because LSM is a mechanism for additional restrictions
it is impossible for two security models to "conflict". LSMs *must* be
written to allow for cases where access is denied for other reasons. You
never get to the MAC check if the DAC check has already failed. If TSEM
can't handle what SELinux or TOMOYO decides it shouldn't be accepted.

Of course, there are details of the Linux kernel (e.g. secmarks) that
prove the rule. These are not issues of "model", but of implementation.

