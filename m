Received: from sonic316-19.consmr.mail.bf2.yahoo.com (sonic316-19.consmr.mail.bf2.yahoo.com [74.6.130.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA756136E3F
	for <linux-security-module@vger.kernel.org>; Sun,  6 Oct 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233852; cv=none; b=RhvdDwMeC5GCFlItv/owPEEXdwcKYwCxpI1czFADwct1/fs5jfc03cPjVDLxBe1x3ZAtWUUHI0QQSaKwc7Xwrj6LSMFMIUMkIDNu+95okPds2veWHteVH2uwz4knOmiRIE/BjGE5gN2w+VeripJPnuYJbI4oJQ9vTWLLfaLuC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233852; c=relaxed/simple;
	bh=fMII9us2++xNSnPZadZkE/ZitIrLJLWsSgQmRVvBs1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5ntP6C256d3htJ5ENymc9xjj3PkebDI/rQRPY2BmnfSmvrjcr4pCSWEMC0iCpCisTo0cBfrT5lQgoezi/E7jKlluE+gTaYMldWMTx73OK9syawjghhLeH/12e97w7I5el9b6RDr3iLWZ659ieGqGZ2dIvsCfsSHfQj+RD13ZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=X4b2JBPq; arc=none smtp.client-ip=74.6.130.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="X4b2JBPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728233843; bh=gJFEeKPIRPOr/SeHsNfbbqNGPOi9UOvs79X9dJ98KaA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=X4b2JBPq0HEYxHhnXyn5FUizXOkuO4YPQCj6W3/Hy2HAhlBQ1oG6GEx8Dzrr6Q20Mq3xDbz76NGqCZC6CQ1BlyrZEn0LtfBxBgQgCcc8hAoIcPcTy/PHspw1oL6GSJh/br93xQKw1cPi5Y2a7mSrUeDcb3+J3pFMcWYi82tQedIHFF7YPnz3fvka9PP+Mn/VdTziypLWYv/ZcJaYMtJtGmuEaVvW4IB3nFDn1h7u8wS89+xKacXMnBDXQbaks1j8BFi53ky31YkYL0+vFScST+YVXn+7aXgjOmiyJ6+7yk1FbWm1nMl0hbSKMiZDVc9ARslYrTlUUwBhZ3Lt3kR7CQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728233843; bh=bjOnuJacSzX6+wM9DnfhaH1Dldjm+rfgbFeoqTFR0MB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BtR1JTd/mtdMc0dzWAQKYlAyLg3tCvMD7/C6T+TyDeurkIXLcPRMwQ9GTYqSyEkHSNs1gKInaWoXxla6nhxGR/cV+ZnoA00pvuFkIs/Bb1vUQ8spfwWjotWdF7rUTqU5H1OF5DHV5soLl+ijUCv8N4tzoyUEuZUURVuCDUISS8mygoT7Nh1FEKZWbRpgeIORMgAruuEVzVviJVnoJ6QfX2mxQj+AdWaTY7fpI6wXTLS19mqQiqikuXm6+bzyySJ8tYI3BuC/HQNFIMLwYf6EpcmZb7CCbg9hBklBwR5mVS44JpZxB711je1IybZ10kKhNSpZuJXLhinHGgUQldIpog==
X-YMail-OSG: akUmIJwVM1kDPQZCqvUTNlSrszInL1hI0rpPGOUksYhexECmB855eDIZooWz2Dw
 ffOVw2x.FnhBjYeKXN3pswCFTq66VAWsfdxAvLiu9IsmtmwitO45sz8c00b4A68qvyumt3NBoJLp
 nIO1CEniE0VmIJKIV.GGnjV7nkB51Qt3rcGdHWwesUDXPZkay1sXccIM3O_ZvUC_RLnGzDe87y5R
 0KwOCueXDwxk_fdA3y.7vthUZOamQf1NZMRMmcaQpGX_LOtD0RGsYrkHfGDl6492EoIWKBm2KRFB
 uEPu1tsFOeI5ZJOOCEXEnnOM0KJTgqF1HME9iAIJoGWaZRGwfNpW88XuhjDrZnfz_zH2NdqGovN_
 jW1PIryA_d8N74EMZ5vsB4sxFhwptYSiqYT1sGUknI8Ppjh8POu9rW9UY2oB6LoSdC014iPIHvKs
 d6rgBJ6jDvl0spBcSFuyAJa1F5JdMa4lqqnD18BOfTRjgCkoNjRkP9XWgFPI8iYfTe9b61jrwOSe
 .ZY9joTmpw62hyOLbmhBNrNZP3LEx1xJ24L3ZCo2oKXFmRGNTmNYou9VmYZlNOUht6uechxzyq9r
 W149_00FVYfDWTVFTBt3_UtIAzxgsNCaQP4IaOCkIDiooufx6oAycIR_qPZ9QdxXu7ekxlBcxYGs
 tpbPOUy_H1SuTercwXBC6VGPWUEvMLdpgxVWHuuELmfgjQs1QEkFUqE59Yx4aQR16E020PHkCS4w
 kmWzoOs9ewF6Npk6YzBVp_0mpxBXfWjYJ5fbk7.LxSEM3PKd0sPdxzZNAkysoFJxg3X91O84bMHn
 t8semFFp9vhXkboWVqHRW45ZUkrjurrm4Kpa_LVUOtw5XpOtmsdakJvdD.jkSJq9OHIPrc8MtMkC
 0Z7fo7Spxedtyow65dl3l.3PQe3gzPUm1XFc0LX1oG0f1RFp57Ia1gXs2qY4.QhRGCfOmi3p9KNQ
 qwEt6VF8YRCetEwTwRCPZy_Tcp6LYyuyAn543QAk7whATag6RU54hpjqdXL9tTeG17ijvmVx02ks
 M3GfcYDYmiFrDhgLydc4MCj.Obb2IYVGsbdSQgagKh_HCOnIaZTns.9KGfavbUEe7i10pVU6G1EK
 rQkQkumfGyHt62bUBZ_62D9J0rtViQodHVBVyciV2azwsvD8ncp4hDyQZsZehy5N9iH2.NR5Vkv5
 tTslHgHMCpcXgBY5ai1vWkceslfs305SNNCNC6lPfGUZvH67a5Fm0FcR_jihm.8T3mKyjgtylmKd
 e3Wr501wyc_sn_A9jPqjNj5IDC8DQHG18vYKqAEVsT9sO8YC6l5G_8uuEUURuY5SmRKflYDc2PVd
 ZId0siMQxnQcGwNeW0YEUMmR5fL7g91nkQnvf2H7ylaUSTgwkDWY5lq0TzRaRqOhY4k4aC00ZuzN
 g0JhDLr_D2J0k035JR9IC_GOs1YBGFB3nrQs5JF37jXd95aNzax3EOtYvxczqqH96cwo35Hze96y
 svXrW8E5UiA1ioYE0y14d_cbZHQBNLAdmdLn2wf4Eek_NPEjo62ZcS3oHQsHkHYk4YHtQjwDFTGJ
 RAFurn9ptQX.8syyar4Qf_WdC3vr1sxfCTQdto6SbkjTYzQOjYnLJ7.mxvM54oNSx95nvImdAPVE
 RjwmvSpEmNsw1sxFSVOhO9Mqs9pCkaUmkgNJ4d7ffQc9PbTR4Whzi1mPwqL9_.BIH2uhFk9kqZvp
 f8bDfMIV6g2qiyD1lcWeq5ADMUnUn3vTG50a94N9i2tJy7dTOv6qrvMudFoEE6Dc7KcY44cwfc5F
 UffSPZbgkWjrnKvQVa0fe.uqbG3DBUf8.2a_GLOOzO1t9Fggh1lSXi2ciHRc_OWhQH5Oh7HmKSdA
 cA5jLwtqrL31.3JEezqNJfbm2gAeP1gP8bRowhpL_5ybyyb0iaMz3Y3e4WCXYyx0jRtS9L.AACiI
 d064OVHbxyi8BE4uRsmzuOfkCp8ZmLr27WB.VY1NBRpvAKUWUrbemENyN9ubYbTaKxFldy3Yh6pH
 EIAwSAceYBUJQZWSpU5k68tqvGvfROuyw5bvFb9U0wqBmk6vdsxeaHop35ZT9V8JgulbqVqj3R7A
 kYuQz1nhp5QN1Zhu0XIvSBAGW8jCj8ctCIGXSsCcAhRpei3E1ZtU5Q2JnPn4idtsKG7ihISHphDi
 iuPZGkQOW8zBHAHJE5F4fwZcreAAGCSVm3KDjWXKolOpYlRVGr4We4GX1ZIVuwaMQCfVj1kdSfgG
 q.6m_.NjNzKeMXDP3Is8GlHYrTv055msiImXL..MznKtdAQ8gegp5R2rsNpoqfzB4SBKdoHoIMm3
 wbfZ7EJPfo6t9yUIRYxp_NSJfpadF5Fv6
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fca2aa54-efe0-4616-9eda-4fc009e4a9b0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Sun, 6 Oct 2024 16:57:23 +0000
Received: by hermes--production-gq1-5d95dc458-m8nfd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bdeccc6a0311aacd46f33d6a1459fc1b;
          Sun, 06 Oct 2024 16:47:11 +0000 (UTC)
Message-ID: <050b614d-e74d-433f-8fb7-f13866cef643@schaufler-ca.com>
Date: Sun, 6 Oct 2024 09:47:09 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Fan Wu <wufan@linux.microsoft.com>, Micka??l Sala??n <mic@digikod.net>,
 Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <4eaea237-d259-44bb-a546-26a0558a4453@schaufler-ca.com>
 <20241005170235.GA24016@wind.enjellic.com>
 <034409ae-5d36-49d6-8073-adbff2a4404c@schaufler-ca.com>
 <20241006161835.GA29292@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241006161835.GA29292@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/6/2024 9:18 AM, Dr. Greg wrote:
> On Sat, Oct 05, 2024 at 11:58:32AM -0700, Casey Schaufler wrote:
>
>
>> The current thought is that we frown on an LSM desiring a specific
>> ordering and would probably reject one that required it.
> As well we should.
>
> Which is why TSEM has no interest in whether it is first, last,
> fourth, sixth, ninth or somewhere else in between, we would embrace
> someone choosing for us.
>
> Our preference, only internally, for going first is that when TSEM is
> in an infrastructure verification role, such as extended attribute
> verification, and since the last time we checked first fail terminates
> the LSM call chain, it seemed prudent with an eye on safety (we are
> big on safety out here in the Upper Midwest) to bail as fast as we can
> and issue a loud warning if there was evidence the LSM infrastructure
> or integrity status of the operating system had been tampered with.
>
> Casey, this is a time for you to have legendary impact on Linux
> security, well beyond LSM stacking and SMACK, you choose for us... :-)

I'm not sure what you're asking. If you want my advice on where to
put TSEM in an LSM stack I'd say you should make sure that you really
don't care. Should a distro decide to (someday) include TSEM, they
are likely to have reasons of their own for assigning the LSM order.

>>> For example, internally, we have TSEM 'models' whose only function is
>>> to validate that the extended security attributes of an inode match
>>> what the workload was unit tested to, in order to thwart offline
>>> modification attacks.  In this case you want TSEM to be running ahead
>>> of the security attribute based models, since presumably, you would
>>> not want those models making a decision on extended attributes that
>>> have been modified.
>>>
>>> Hopefully this clarifies the issue.
>>>
>>> We have a long standing question, that has never been answered,
>>> regarding module stacking and multiple MAC implementations on the same
>>> OS instance but we will leave that to another conversation.
>> I would be open to hearing which of the many open questions you're
>> referring to.
> It is no doubt a question that is simply secondary to our novitiate
> status in all of this.
>
> There was an LSM list thread started by, I believe a Korean Linux
> integrator.  I believe they were on an Ubuntu OS base platform running
> AppArmor and running a containerized Fedora implementation to
> experiment with SeLinux, I don't remember all the details, the
> exchange would be on lore.  They were somewhat disconcerted by the
> fact that when they threw the switch on SeLinux in the Fedora
> implementation things pretty much collapsed around them.
>
> Paul replied back and said that the LSM doesn't know anything about
> namespaces, so the impact of enabling SeLinux was OS wide.  He
> commented further that the above scheme could be implemented but there
> would have to be very sophisticated mutual exception policies in place
> between the two modeling strategies and composing something like that
> would be the domain of experts in the field.
>
> I had replied back to Paul and indicated that it was our understanding
> that with LSM stacking you get the union of all the implemented
> security models.  We had posed the question, in this hypothetical, if
> an unconfined system wide SeLinux policy would be needed to disallow
> all action by SeLinux, except for subject/object interactions that
> would occur in the subordinate OS instance, but I don't remember
> seeing a response, we may have missed it.

Nested SELinux policies are the realm of SELinux namespaces, which are
currently a gleam in Steven Smalley's eye. There's a huge difference
between having multiple SELinux policies on a system and having one
SELinux policy and one AppArmor policy. The latter is much simpler.

> Are we missing something in our interpretation of how this needs to
> work?
