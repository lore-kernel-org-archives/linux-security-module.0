Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22521547E2
	for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541384; cv=none; b=NlXj+DvZ3Zlhx2wxbee4VOOTIfHsvF16b8ZsM5T//zHbiSu9h+Hcv88BqZ0Of170eTRtCjh1d7s1C8JxdSAzdIc/Kdc2iavQW1eS9etMw164PnwjN/potvRdGyeLXckqxg1v309QX5ZwfeBAPOz+5LBvl2Q1ljOEQTvofc/QRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541384; c=relaxed/simple;
	bh=P49RzAa9SdEPdNelbe0LpGG/WOml4l7jM/0SZCDOf3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VO0lQhZpiABLH3CX+7AisRvFBGUmolhxxAST+9SVIXlYRv4TZDojSbbre6/RO0XCsDi8yN2bysiVAnY62UfuZXPumElEJ3Az6wtNiqn+fSMzh8xuDKqDTOREHNkKK5+t5WpZSdJKbz26v34k1ATdD1NUaI7PmbBI9IiN5cZ4uTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=c5FDh1H/; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="c5FDh1H/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734541382; bh=U2Be5nyqR9PTDwMjbIWe2Cyum/Tkak+nQevNA+8z8kA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=c5FDh1H/QmZ8nra5jCbMrLT/wrMhkxhZMbS+oXy0TFcloLTG0jdpY2lQ/IEBtDO1l9VMvP8RS71fgnIvfTVsCNcsrM/IBNWjNIKxr3DCFi0Ol6lC0Yv8WfpYt5cyiiMYH3KiSoWAT8/ejB+bJMpZD3FeeUy3MWAWQz6deZpAVpK6QtYt6sCtL0bs3uBvZFimSH5QyH9u95fVFLy3AKt9TtWxjm6ztpu615O89cxKv1KF8PW+A/RkyuquvYsjPBxAb55gG++ND7jC5zFyLGZ4hn1laa1CRXrfc7z3QMJ4g6Cu93X+HtJJ+dii3SMQvW2ysJSPg0CMgFYaQphMzD/V7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734541382; bh=52cbhWme0Pu/ugHCperpJjNSNdjzM11KD8gtDYX2kPb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AoGuqjx0pZiR6C/j0RrRxncOQ3kfClxQv3qsPJcxQALbcdhMEa9PvTEEXn64T4CtJpV2RqC4ntqmWSmbWvtq8ukcpqeQo7vRoEUCJbxdlOZloNE6QgJ6zq0h0u+SdlZv8tyMM/BJ/xPelpLqjrhq6t5vTyJ9/00U4l+kHxKMMaliYXvSpBG6XrZmlUemlwIDOu2FY96eF+MQwxtHYLzAZK1KBF9iKYEQImWlGwezXhb1Vwd4wTvAkzBqao2nIxQ1DvM3X8JIaJBu0wOo9LKjdXjTdWvB/Y9E5FWIjJ3mxfo3nnBPogefxlQe1sSxLKJeKDcQgrmGkkTdNpjmeGuLtQ==
X-YMail-OSG: yEUtj4gVM1n2m0tiudg5nFroB78rsxi2kr4MBuj_mY.MrvOYob4jZK4tEjNXhih
 EevAx7bCH9yf9Evfk0uuz8DU7IJihVwp_30hacgJ6VGobyGR_pAwqq6RaUEyn3a6Qu4wCAeoHfzP
 yqCBHbfHiT0YrXlB_ejvG3HVIKrMYGIxy163jPXax1JDzOLLdvVZCELKEJHIqM6rz0rCYWpDq21r
 pSctZLGxq.gosmWf7as8C1VhwRZGsZ_ye3SxnxnASursL_GzKxxwjH3x.GNjg.x0.1v3LkAWGaoW
 GtRHrxUAqBFIU33qQvZSAAdK5.u3JlasZOZcL8.86dEqIOtrsHmRfTrY88ig9OBsCTtncAIygvQy
 dSzZo5tov_EAG84O8oFUQd6fE6NpkTX80rDS6IOjwLCBAkUX9ZZxtDzAmOx6i22Rvbw6mXPjbpWg
 ebALhJ8_ppu1g_fz5H1uZtbH189bvvcT6A8Cd1cUPN4N5jq3jkHY8FO3ClaI21t6Mhjc.Tl5TmZZ
 VmWATeUJ6_iRprIXI3zM2S4unR2etoGr.NFVmJlW5EqZ5b_3wGUPMYPXQekELqXwvWFk2u1Y_4NS
 nL7Y3OHZm3WfnNPVEUKTm0WPSDBsLuuySMao5C5SeVUuhhMgF__JeVI4Ugycmkd5LoMmGwtvl5m_
 V43I4fH031gjZ0JVNnLMy_FHGAEYU2fpmMN.IBYwanRDoQ8lcQSh3WNcGlP7Z5D2B1TkSgLdE5AF
 Wcbapbzt_IbIj0Md25R1Mnk8h1vBzAzjDVsjsz8uHdVq15wT_YsSr0fQUue3M10glJqqe681aFp.
 nbniAGckjsSOv1iIWnFfpmxnZD2fRUOUzmracVejRYRoF7z761EmfIQ95Xn2craQGY8WZepnclL7
 EUg9WO7F1kr1BMIf9FznxfWL7NbXX3JRgSnsGuvq2laWqanDvZO4Dal8zpB1UrlPAYyrAE2LcHZo
 LCNeFPblfR.tQXhWB1YvUbYCUKQTtfglvsS8v9cjr1VWAY7C.nY6BLyN3c2ayCfTkdW_hirBG0j.
 JI_OhNrQPplgYZzyyfHxtrzRwHX45kyDdkee8aWL8ZmhgkZgEv8rZNUP.EoqhpJkfnijTeWMfhKQ
 CrUe.Sl68KiRVx9OuwfaWp82xYi9P5VQ9wzNsQCO102BQGf.XVWhJymtLxdHAMpXgfELyS1N1.RO
 G7qYYRVOtLRcCiINze2ZVAUNCB5GECbRirYzHhlyJTg2NaCf0ZzOnYTuBH4kV4foaHHYSSiTyK0W
 zUZd.OsC61oqTWj5B3oxWb7gT_RiKwpSnw5XBt1EjdLO6A.gONryYkFrPrLF8Ndd5mH.eDfwbz2n
 F2hSw5rTIvEdg7eSXmzhG.j3CRygbymGlDHW1wRmDSu7xKyhTWj1tigHiCL6OSf91T0KJzxMbJEL
 7g2FTpIr8uzyKxrBZwiIUUsNhYuL5JWzXjvpSuvGcNmq.K2a7L9Ky2cSRGKzVE7XmjHWBIeKP2R0
 w.etOs1IFhfwEAk4t9ch68rkUEuo8RnhRKd3Jl5ACu3DrFqXYnkhNthhUJxBNn_uFqHa1JJG3CJK
 Li_gkgBri1vTxGNsnS3iw55lYnOC6WNKWJQkwDAj0bY9NuCyDGuet9EYLXyZwMUjkwMiZXN_ftJS
 X4JFgTyq32Z5bb0PdBJ84LmuJdJU__mOtAxW3krqzQAeru__5W8wmUCQS4.i_IeYNNgcpqwZoOkK
 _SASdPE_JxiRy9VNp9Fn5hlhXCZUWg8l4ed00Xw1Ze4Yyq_mepgQ6rH0Jlx8DYPACNijhAFHhBRX
 k0_m1u_cglWN65XjWaT05C1B1JAOQg8vOEsdimaq1BgXZ1aowhOz9RqQ3nnSzz5L.UWONGi3ifCl
 CppLTpl3DDLsCCraEKerkLsEZkIcDLcxYa8ynA6HpEX79e4kS3cdQoXS9t1BiS_8zRZ7LrV3irtZ
 xatmCvTyNzC7pKJbg14mTuqVt.yuzZYsmeLZ271ZJjz_byaLVGrpT7wnReXZ4.W53nDnPrI4vezW
 HyJKUu_5eaT6OJoXA7WItKCy0NRaAxXcmfo1TGz5AgRBjxvCowWGy9U88oojPz34kVLGAM2Pyuwv
 wB8868D8nb.enbQ2HYbdeLmzjX0.4gRiw1kpyuDI_IokK1ketHScO7QIqB2uFhpbJLkhfljmMx0w
 oux2TDLWkT0WPN9aVpvVUvWAq1oUh.m3i1mxMRyzndLb6QqQo6yE8e68SPjREQ9BJL1mzehWKVYS
 s2Mvn_DOzTGg_LHbjp6gxLL58FT9s9jLdy_KLEubrC_yRuvJJKsEMS5lq8sJICdud4mmEHGDzGOy
 .dsyPT5C0JQYVTWbEXVveag_p9_6r9ILXyqZcYMx5efeZlqdMzw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: abe0c9a1-c56a-45eb-8240-8692074d8de5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 18 Dec 2024 17:03:02 +0000
Received: by hermes--production-gq1-5dd4b47f46-5xsmt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12f7b58890c13094f67761df9a4a1cf5;
          Wed, 18 Dec 2024 16:42:41 +0000 (UTC)
Message-ID: <518fdb73-8daf-4181-a8e6-528e4824d955@schaufler-ca.com>
Date: Wed, 18 Dec 2024 08:42:39 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
To: Song Liu <songliubraving@meta.com>,
 "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
 "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
 "jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com"
 <serge@hallyn.com>, Kernel Team <kernel-team@meta.com>,
 "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
 <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com>
 <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
 <CAHC9VhRWhbFbeM0aNhatFTxZ+q0qKVKgPGUUKq4GuZMOzR2aJw@mail.gmail.com>
 <6E598674-720E-40CE-B3F2-B480323C1926@fb.com>
 <191ABC6C-1F0C-4B12-8785-C0548251ADDD@fb.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <191ABC6C-1F0C-4B12-8785-C0548251ADDD@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/17/2024 10:41 PM, Song Liu wrote:
>> On Dec 17, 2024, at 3:33 PM, Song Liu <songliubraving@meta.com> wrote:
> [...]
>
>>>> +
>>>>                               found = true;
>>>>                       }
>>>>               }
>>>> @@ -386,7 +389,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>>>>
>>>>       /* LSM_ORDER_LAST is always last. */
>>>>       for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>>>> -               if (lsm->order == LSM_ORDER_LAST)
>>>> +               if (lsm->order == LSM_ORDER_LAST && is_enabled(lsm))
>>>>                       append_ordered_lsm(lsm, "   last");
>> Before this change, lsm with order==LSM_ORDER_LAST is always considered
>> enabled, which is a bug (if I understand you and Casey correctly).
> According to commit 42994ee3cd7298b27698daa6848ed7168e72d056, LSMs with 
> order LSM_ORDER_LAST is expected to be always enabled:
>
> "Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> and put at the end of the LSM list, if selected in the kernel
> configuration. "
>
> Roberto, it feels weird to have two "last and always on" LSMs (ima and evm)
> I guess this is not the expected behavior? At least, it appears to be a
> surprise for Paul and Casey.

I can't speak for Paul, but having multiple "first" and "last" entries
comes as no surprise to me. We should probably have used LSM_ORDER_EARLY
and LSM_ORDER_LATE instead of LSM_ORDER_FIRST and LSM_ORDER_LAST. As for
"always on", I recall that being an artifact of compatibility for the
security= boot option.

> I will send patch that allow enable/disable ima and evm with lsm= cmdline.
> We can further discuss the topic with the patch. 
>
> Thanks,
> Song
>
>
