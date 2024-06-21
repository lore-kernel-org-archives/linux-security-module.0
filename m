Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981A16C877
	for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008668; cv=none; b=mEXSXg2y2XhODHmSfyi6gaKdqn9m3DgnTs8TcaLOco2OffzqpzRdk+/xgkk+FioEoAh/ZR0PllGITAynFjsU+VL5pKWxlOm4LqerP+WktaCWxyu9DnsBBJh9c3M2vLrvW5Sp/ey1qqvBioYSovnQxpDU/UYLvrIaTtK1jlXGA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008668; c=relaxed/simple;
	bh=sVyjOfJZO+IoW9VJKQZYjE+kYCNI6kTj9mrzhNObKXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5yJAHmcNvCTMFf7V0oDi8nj3bRjikmbA8ri+9LQAdmC2VKRZiBwZjG+M92kd2L2TrF3t00qaEQQ2WGxlKE4eOQOzjzw84Ei22rrP/vxvFVvnoO6ge/QloccmNQ2VpVgZrPsHgh405mpbb46ixkSjz0HbAh5GH4sLBJojE/e0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sPsy0lp3; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sPsy0lp3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719008665; bh=P19Ilaj6gEH8rytHfVjwZ7uHtfZcbce3ktCVkx7vP40=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sPsy0lp30nw79teX39UFOhGlAw1EKt7WSE9Kz9C2Np62nAAuTH0Z6IECJ1OX1C0yeJTVV92vdAvShGnOLCjLe6pl+izV7t7NDS5rV44icuCCDFLQAWvO38JXZykrdFljz2Qh470FIYOVoPTJIWaJivNJAnIhAzgNeeACxFN2jDS7IyZ6gYhcH/PfnmQKsMqjp01/2ppHHDMOHlY5CcYBFWIyYbmZkfMrnXdrO+GA2tvIxafoDjMTC/eIbe4MdZt1xMsbL2zkKLS8G3R5VwxPtNwigeFKTRobfB0sH++qAfUs8ENWTHsUtAWrdqkKKPAa87jzhArsAT5NQYUBoh+9CQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1719008665; bh=NEFLtCkOu+GEhqwpyL67TouSdX1IKamOPKl6pTwsyH6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=s3AmalVINgwafaOQh55EkRwbLxXGrFemSPvZy3iH1RUjR3AJyWtNqJD4OLcgzxi9+QohfDqQOddFlGL5/OQb/RZCq5t4lF2z1dZGup9Eaaqvqg+5A5b31UCJH5FboTLbShRNazlvTUXLVlK4sWAc4crhaItsJ+e9Wj8Npc2Pdatbck8VVcQApOUNFoQ7WokKa+8cJaMLbt6Vc023nA4/gMVQBS9CXupyVTJEHY1s8Mf2XCQBdc3/2nBXeGFVyBMiM4RBKya8QjkEskZba14U5S8zmAZmwk1maN99AxHM4wnkE75JL/e/pgcf6KMBwvSQjed/i9reXTXgcLaXXlg0MQ==
X-YMail-OSG: LpbVKJ0VM1kHBogIKr30izTZv6EK4wtjN7xH6tDGZtyRrUyP_B68iyI4jYbzSFH
 ox2ogO22wIxSxELIeqz94oVLwIlRmQXZ1E8SZ5vmSR80FiEAGZjm5YxHpQ_qFKvj3Q5syXaRuXRE
 RjsrN.GjmcrYgl3wIhbs5HUgQ0ABwUVvAp6CA9c4e5DW9HhxjMZeD0srh5L8PmQUSclGr.hvIEkt
 OEN82PemjITKM3xXiRGuiCMZni8pwMlInS44W.MDla.MRnpmq4YczabA0cSK_MsVwWF58C98sGIV
 9AOOe3yEOp0v6kJxENaCe3Dcdakmu3cryTspu4t7BDIspS1Tt9WxQE31BHMrz7ZuVBIPRWhqsuJk
 CfyKdYyAPP5kn_PjbIIXDzf1mAxOKU0RCffEKpBSttm8yG4C2NgmuJMLVeRk4uLNV16RQstCGykU
 a7C4ZW9X06Q3RKp2ZRvw3W69pN1cXCleGO_FoWNYRFo2gf63YeL9jp4qQ6gbBOKLSlhdBUtmSFGo
 YVi_x8RbUmCxSqBOTg08jBdZ6nWD_mZt7dN3W08x.gnxM.9o.mqTdXKh93kh_QT3jU2mziaUAyDT
 P4jXbvdXgXBQRwKpU4T1GDsPMlZLOAnQrhOPlT1K_jsi1J0wcT86wlWgtQ74l_NEaNPjgKDzjYWT
 BVE9Sp_HMum3CHcoy9zRfV5xRK6io1cCSXg7PTYU7EFDgFofwsRS1._sL6gVVTU7PhtiqiK.MAJj
 Y7PgebORx1O1Go1YZK6mupxrG1CDvl90yrZKT9XZrAyHUlbeaF_MZAFen6J4CNvMvEdvJdEMTkQ1
 4eix9.X3HdAjPWtUU20.wG3ULkBu4eN13l09t1XEGxLY5QLZBswWwN.Yo1_gcn0dcpYn8xVvbFUQ
 SADDXEfGnlNSmhG.XFEs5_3.SeRP6s3d2kFpYgpslwmAi1zq4C5tRmoZ_x9WmY88yZszLyvANwV6
 jtPXiVaFXDdfLbIe8R2vJzkDpK.tiVDwcJaQYb1EN8iJlYHb2mDC7fqVUt7n0BHHGrn.CoyvdnIs
 rr0Y7qWdFPg0TJq4Wo8_lpHSGJiGzI6c_2QlzIUqpV3qeXIY2j2zB36Q.YAH37_uVTkFEprxU_Xh
 8JVxIYVUpv7neXwk39EIh5j.95bi_Oj35F65eX.n0keRpao6B1XiYwz4nb5cyDQ4VSIcL3tEZA.J
 ALnwCV7D_t8PUokc7ogqF.BB4IXD_oHeube3DyWiYlzAMcXsH7YYkcMsiBzBIUnwiinOM8_J1Ecp
 a7CDaA8ucQzbUR8OnvTeVStEO5NrjDA9XSCNhXTJ5vCTYwBmy5ahfLPj9ZvUfqzY3g_c_g1he3fA
 8L9CJmeQXNq5qlzdZgJN2lsrvQtnlWV6qqu0j.12K4KEv3Caww8ZiEXaDvfiDATer6LQDdM5Fy5K
 o7mHTvX1nxuCd0DvS5yalSAt2fECK0koSwhRWL2RhFgW7w_cBIDfupxrcViLid9bspoH0WxZfNUu
 9Eaqkj1eC6fZFI9JrM.oEaVxWBBGZMb81IGUssAKq0aIphy4fvuwXN1LliUH3XWUQhSFppJmHx2K
 C3CC4VMNISdcgy9f0lyhNABYrlyzp47A6g1Y2ywnnoALDxTfx1nlYOC0y8NtTN7wGDv3m3dLm0hh
 yomdb24UF1wahbe93PrtCNGZ.x2qbsBRvF5o17Bxp1WfNO2lPJSqI5WuYyhl8WKfz6BN4h587qWA
 7DK0ZyAMdmHBfIK23JMl9YhLW1A0YUU5u0g1Hqrjf.6Oq1K8HDVgQWhYPK8_UBWuiF5ZSj9WZzWq
 gXMbdfP5FPEfwpUpHQblpW91FoT2hA3BQIKqlb7I_G9HovJQiYSjCDFXEuB9rHmzAcrlY3huf_3w
 A5ZuLtz9RDJ5n_W6Q_lUBUagKwT42DM2PloneQAFNvwGe_wb6ttoHhL8696cci7d72PhzBz.QY18
 UVyGA9jSrFv7SuxcL_j2Fe825VhFREySe_qALXGZD7JHRCSwL1O9z392YHuHMaVsMrSqx97jVksb
 QANbuxRRmKhTIL1wop7kkIf6hK9_qzAj0xhRVgQb3M2IHFbcIVrqTMl16AiQ1IqN0M3BwUYgmkwq
 .JvsKrEPO58swzUiXMecJGuTNH2RJW2su5mvs65UAqpXTEWNjEpWSTzfQjURzoxz.nSbju_t0AyV
 Xry_sLYpvaPh8hQ6_OA2DOq1OfFYRpJSVT6et1JvGBVubUfZWC2UrZn_mfiVqXzgQBAXygEFJHXH
 FQ0E3Y3IwNuzowKwWhYUJubl5kSSvJTU9TDwoBkPm45VOD0A2INJ2JZ8pVBNzMuHhJo.z0zpWylC
 viMX4yzQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6b825526-385f-4b5c-9dcb-3dda0333b2d8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2024 22:24:25 +0000
Received: by hermes--production-gq1-5b4c49485c-pghqv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 937a7f93953c1717f4f52ea5056797ad;
          Fri, 21 Jun 2024 22:24:22 +0000 (UTC)
Message-ID: <aae5d7de-d3ff-4a67-a8f6-fea293bee0f6@schaufler-ca.com>
Date: Fri, 21 Jun 2024 15:24:20 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 02/42] SM: Infrastructure management of the sock
 security
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-3-casey@schaufler-ca.com>
 <CAHC9VhQnzrHPRWKvWPSuFLWHhcXkwqeAfXsFbEdBBOMcACZorg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQnzrHPRWKvWPSuFLWHhcXkwqeAfXsFbEdBBOMcACZorg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/21/2024 1:31 PM, Paul Moore wrote:
> On Fri, Dec 15, 2023 at 5:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Move management of the sock->sk_security blob out
>> of the individual security modules and into the security
>> infrastructure. Instead of allocating the blobs from within
>> the modules the modules tell the infrastructure how much
>> space is required, and the space is allocated there.
>>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h         |  1 +
>>  security/apparmor/include/net.h   |  3 +-
>>  security/apparmor/lsm.c           | 20 +-------
>>  security/apparmor/net.c           |  2 +-
>>  security/security.c               | 36 ++++++++++++++-
>>  security/selinux/hooks.c          | 76 ++++++++++++++-----------------
>>  security/selinux/include/objsec.h |  5 ++
>>  security/selinux/netlabel.c       | 23 +++++-----
>>  security/smack/smack.h            |  5 ++
>>  security/smack/smack_lsm.c        | 70 ++++++++++++++--------------
>>  security/smack/smack_netfilter.c  |  4 +-
>>  11 files changed, 131 insertions(+), 114 deletions(-)
> I had to do some minor merge fixups, but I just merged this into the
> lsm/dev-staging branch to do some testing, assuming all goes well I'll
> move this over to the lsm/dev branch; I'll send another note if/when
> that happens.
>
> One of the things that has bothered me about the LSM framework is the
> inconsistency around allocation and management of the LSM security
> blobs (the `void *security` fields present in many kernel objects).
> In some cases the framework itself manages these fields, in other
> cases it is left up to the individual LSMs; while there are reasons
> for this (move to the framework on an as-needed basis), it is a little
> odd and with any inconsistency I worry about the potential for bugs.
> I think moving the allocation and management of all the LSM blobs into
> the LSM framework, similar to what was done here with the sock's
> sk_security field, would be a Very Good Thing and help bring some
> additional consistency to the LSM interfaces.  Looking quickly at only
> the SELinux code, I see six additional blobs that would need to be
> converted; it's possible there are others in use by other LSMs, but I
> haven't checked.
>
> Casey, is this something you would be interested in pursuing or would
> you rather I give it a shot?

I'm happy to do it. Would you like a separate patch set for this, or
should I add it to the stacking mega-set?

