Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360AC302CA2
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131879; cv=none; b=e7CA+1sZhwv91d4srxfO3xScQUOB6/sfaWGVyqV27ct61WjUwDbNIFPIB+LkhRbenRMga71KJ/u/iRrhks0qL4hqXGazLZbx4efAQzi8ozXaGpZrUMFpWATC33XON+rUOndrY+WQe/ic5+k6x0QMMmeXN+WBSnVrOmdinQCslDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131879; c=relaxed/simple;
	bh=jm07cNqujmJsz6ETfN/ZaqZkj9ZOG1ZyWaAGnftTQOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrAPxaE8lUvHX9yCWV/hPbZlSYDJOH5BvsD+9Eae5e08n1LVB/5xQG2ScQnUKmrhokRGLw5NejbzB4suyzCwJel4LNj4nXPwTlj2DpgyCtX8jrEKdbYDhOrGXoJUO7ddRRkQaOk7cSchtZDry/4ejt0aSBK7hXzWfNueVAJH7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qxQ2t6mL; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qxQ2t6mL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760131877; bh=DLpuuXFqNbqtDCgdc3OpUNFxQzGQ43wi3kmUOA0+q64=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qxQ2t6mL0PCt0Q4akU7mib9t+hPxU3fiWXsMO2l3OEHmCSJlTGyRpJgyohff89imJY3S7jyh7rX+PdanIMfjJuvm8KwoiYjQzBcl+La8YlKAvAfgxHmoUUHgWW32NNOI7+VpHQBga5ZaRif+8Qt4q2+Wb1DCFLg/FrSjsu7NJwxyFN85bRQL1Wz+tnLSymHvFVx0cPrCAe1tRpj5yZmnZlfEcaoQYLkZy3Esp/yh03cobFLWOA7MWgK7RusfpZnGWvX/9txee//Hd+FiMPv0pPPMstH3PSJZ7ezHs9nzzp8cWASInzaIH2HEJekK4zk96dEFkEtO2nDk4D4b/Dm+bw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760131877; bh=f1WKCvVLXmrR6cPdVElrsC8Qh4HEh74jE/vihtiJAon=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=t6an9VJKtGCZSDiJ9zD9bvXu8ly4w3ZQpJRcPUkIqlp94RLEGMHcvJ2/NZBx+e1y1b0quOnYVW5a13e3k7VuvQrwTwRyJnJm1q82u8h05F/QHG5mQEAPy/TrWqC6L/RAYpplimoKF7JHHQTBq38olMEGYIzww91LOQUBycwqa7HC1mAKmxjUa3HS17Dqjbb5WxDAGk81813qB7d4tTjd9qk8DNT0Btccp/MfWqC/Cyc7ZWZmTE6INvNDB/UFwW1bf/NVXJAsGassS3YSx9LfhYgV6c2fHrfpxNHtUlMqjOu139R/aX4132tL11cOYDpKcZQsPf539iK68i/eHQBmcA==
X-YMail-OSG: 4R.Id2cVM1lqqIxGsyOt7xiKCrc0.kZ.A5NMx1geX4kIovaTZzef9vXcAdUn0Lz
 4V.VJYH0W7IGwB85ebK5rNYnDxc4RKut4Ry6He2C54MUFnHRUxf0gcp6t1waOpUOcUsn.CsjFohb
 HQnJXbpKrisaRT78sJgIC0aW9ss6ybQVolU0J5.MU0.3T7L7gjrjDt0HSI3nSPTNSuUdeDj.1ksh
 HADxfWEUIy3iKJyG_rfs9a3Wh4uTCU6NDxIMRZPwR4yQr2lNqQRp.WLMkijWwDsGASQY.4cFOlBM
 EfJfWE6ArkmiykiOGX8lqfVagVWSWgV_1hCq3sD0MOP5fmSDmXtTUQcAStNaBuDpwrPYMVApylaM
 G0LvYVjp9jDcLewWGA0xQZGuLHFCW5uu9.m_IxJdPYgsR3rtjXLC3ImQEBtpJHRpabQ2IBYrdjS1
 fOSOVbNHDBLzpdk.tHZG.pausk1v6_aMp2v2k4JVmC38M_mnl3LaVglIGQXEXjhW2BQYUmDZj17u
 oCF3DYxDh.uguB2xwjG0PXQpzryJ1mN1dxaZitu1q89_vz0G1SmnMd0.TxfKlDOJNTBspwvZ7mUb
 RqwuJznRwZLCb5mHF4_dFntgWfyAtzbr5VGrNOzod7zDsX7GUAOPksSxFe8kZmnrZQAvj.DQkDLg
 x9UjCc0ZIaVO9y1mwcM28czLmB96UOZjhOsLuKiQRRfjFESREJps2CXBLYT9cn3zo7OHOjTNap98
 un0vPk1HGF9RJkkQAQ86Cv5UKY7DAlplyiFWsuIak6KGxe1S0MapesiwBo3q3jQOJsDZrKs9KRqa
 JUaDqHyvt_jkg5xg4z550cfEbMlh5Njkl6UiTxg8NmUXm3XaBlJoJULLdueAo2KavGWCtfE4VaEU
 PfoidspaBMdWIAemm7Ynqm_sbAVOCrg9hKbaXgsDwvqIonFCwXYZEuONVmxzXRH4jGZQMIAkNXmx
 zZ851v5gqnHDwPXqZ4B83_1acK4DJpVHGcpc9BVOwBGJfOn.4ategsoyyIwHmW9gpdh8cxkG7grS
 4p7Y_LrEh.3F2.Sf5PZtWyl2vMCVS.WO.Y_YyFNWpJfrWUs30md9M12wQjui_IzI760azrYTozi9
 Kx6xBNM6aVADvgmwRCMj6U1UEV9snuvk0sLU11Q4cQPz4aPY_DwTRW4TAefH6OGYsDK9VCzHJkIG
 5vE7zFynCwV0d3rPirjvg6EkMQBmZQwh211ejJSo4pVVoL06V9dtwuZF_sozF.R6wXHABszApiDT
 KyKoO4UP.tRQgLvRQRmIVUcV9L5OKeVo9EoAWqRpxstc61j0yCN1ss_tbJcyQTgXFv_o7lX1FF.A
 CnVdF98TOB_zDU3VM0Np67kJxnGyMJXJXuqE1ZKMtGGOubqafDZXazGSBzL_7_16Fy0o1zGxrQuI
 dgsyof7NJPcvt.xZFgYlrgkqtY.mG6okpY_7DKGVm.mAmaXK3ivJsqLJPewA6UMTMXk0IZWvdI2g
 Vw5HITDrE9RizL_85qKe4eHeCTeUNHKA2nNIAad1maeXR9kwKS_AOU7VuSE4rUx8G4GrebKXUshD
 6swJWI6lgHMY8kCFzkMh.7I0TKAFuUzaCJTcIZzhHJgZjCLP5u0glwe9S6sIWx2ux6Uih8x_zSSz
 WsrBlOO6CPUZXHtjMltTsoU6_Q7yBQkkLSFQdPn629ryCd1uy1_Nv.31r5GxCheIdjoEiod8dMRU
 FtAQGfX3jYYjFNMTTn5Ph1gjj7jnW1coiqAvgGyOABL8v1pR98KsqsPUodbnsQ45AV8C1NcyNBcY
 XVF5.F4GabUWZRUGGKH_5ZDgsFrmg62c8YEpeom47dKORkDXKSYhszyaEWMncsWfo2McptTDpRtl
 KAvxF.g1mtBvlq02k_g49GhyL4aNvlScrwN3GrYgHxBYycxlKDRckWBWVpmmpVPId6QyIYSlXFhk
 MLOkbWtscO5PEzppF4.JAyK6z9HGiO85zN1NcbgaDkd9xnCvsgkYss9mddLjn27HwGorM7WFP2gd
 x7Rdr.by92xppzFRVur2jgcTkWJLJuC15QtYKotg6DJ3m_KgkOBa.7smlCDZR1XiNW1kdHUoom76
 aZkBS5xbFMcOiIfdtMXC4t7hbJ2rx4PRRbH_MYrULaDH3LxZquIxS3b_0qExz_gJ0L309S67rWzU
 kcqGRxj_h63dfhonCMN2Gg48mrH5gUioen35IX81Ev_175BZhTsI0U3Guc2sBmaGAhZ9XlZkaE4l
 piz8Klhp1vCSf9zEaOVC7EkXl9_VIQX23cY.OaGesJL.xoBulR5DLVGTf2urB8gvqCm1_AczRkqA
 K5iXqHLOONv2eAZ0_3Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: aae4a878-c368-4734-8f1c-3e5ebf10e800
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Oct 2025 21:31:17 +0000
Received: by hermes--production-gq1-66b66ffd5-8qsph (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5ca4e18b572c15992d67a822f1821bda;
          Fri, 10 Oct 2025 21:11:00 +0000 (UTC)
Message-ID: <01879779-d529-40f2-8693-257cc598dcd7@schaufler-ca.com>
Date: Fri, 10 Oct 2025 14:10:57 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] LSM: Allow reservation of netlabel
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org,
 jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-3-casey@schaufler-ca.com>
 <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
 <ec89959d-c3a0-403d-bfb0-7405639eb0cf@schaufler-ca.com>
 <CAEjxPJ5N+vGS4rhBJmCfoW+rUnjPm7TVAC9reRmu6YCaJWTO+Q@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ5N+vGS4rhBJmCfoW+rUnjPm7TVAC9reRmu6YCaJWTO+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/10/2025 12:53 PM, Stephen Smalley wrote:
> On Fri, Oct 10, 2025 at 11:09 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/9/2025 11:53 AM, Stephen Smalley wrote:
>>> On Wed, Oct 1, 2025 at 5:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Allow LSMs to request exclusive access to the netlabel facility.
>>>> Provide mechanism for LSMs to determine if they have access to
>>>> netlabel. Update the current users of netlabel, SELinux and Smack,
>>>> to use and respect the exclusive use of netlabel.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>> diff --git a/security/security.c b/security/security.c
>>>> index e59e3d403de6..9eca10844b56 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -289,6 +289,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>>>>                 else
>>>>                         blob_sizes.lbs_secmark = true;
>>>>         }
>>>> +       if (needed->lbs_netlabel) {
>>>> +               if (blob_sizes.lbs_netlabel)
>>>> +                       needed->lbs_netlabel = false;
>>>> +               else
>>>> +                       blob_sizes.lbs_netlabel = true;
>>>> +
>>> Same principle here - if a LSM wants to use netlabel, it may want to
>>> guarantee that it truly has exclusive access to it no matter what the
>>> LSM order is.
>> And if SELinux and Smack both shout "I gotta have it!" who wins?
>> Does the system fail to boot? Do you assign it to the first requestor,
>> as this patch does explicitly?
>>
>> If LSMs can't be equal in the eyes of the infrastructure, If one (e.g. SELinux)
>> always gets its way regardless of the end user intent, I have a problem with
>> the whole thing.
> End user intent is unlikely to be expressed as a silent side effect of
> LSM order.

But that's what we have now with the "first exclusive LSM" rule.
And the patch doesn't have a "silent" side effect. An LSM is informed
at initialization whether it can use secmarks. An LSM could even
decide to use secmarks if it has been told not to. That would be wrong,
and probably not upstream acceptable, but in security the wild and wacky
happens all too often.

> If a security module supports its use without the use of secmark
> and/or netlabel and the end user wants to assign one or both to
> another security module, that's fine.

That is what this patch implements.

> But some security modules may not function correctly (or at all) if
> secmark and/or netlabel are silently disabled on them, and the end
> user needs a better way to express intent.

I'm open to suggestions. Would boot options lsm.secmark and lsm.netlabel
be sufficient to address your concern?

