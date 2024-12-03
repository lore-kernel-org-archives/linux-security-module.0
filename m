Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D013AD1C
	for <linux-security-module@vger.kernel.org>; Tue,  3 Dec 2024 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266477; cv=none; b=rsS4O6uXjTL9YOSK/wefRbhdY9MJTQRun/+ulxoQraGBzrzVjpF7Ql7WG2zdvZXhhA+Srv3uJUMXfDbU9ZBvUQqD2tD7smLypevt3oq3Lz9eIYfhvIFs2nGYhykcHp0z6fvzJYRe7yo22Xtg8qaoKCCxndtxxTTW1CAynuOR5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266477; c=relaxed/simple;
	bh=wBCDWArbkjXLajsGQCFOP5SNUlPq8dm9GTecMVLj5qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+vYRUZvnsEaCAfUqt4XEIR5j2D4iAVv4KmeCXfgaBNr/22ERUv9ZlG+6vJ2GSG/kN6oOthctEs/gf5iIE9qPUvrTaykTZzes9QgZ+NuBPCxL+AtOqRiynzFSj/ku974sjzDN35gcDxYQArztvRtmHUQBFEng4D22SjRyDG5+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=t0duTT66; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t0duTT66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733266473; bh=MxrP2bxdqUWrVMr4brsKg35HptKZI1Iq3UeggyHA++8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=t0duTT66pM4h4Tt61LMwd+ii+eYDziqb4/OH+NWoMmlsNWEgUOhqsw2he+yA06Pho28bDP1JwTLaq/6bTTlk4jR/o32Kat7wu8yqmzICPeBg3vRI42UjTgRgkHpfFym+C0ICfjdEw75IFOqUdg6zy2nMlClkgc+qkisZ0FioIancGg9j7DKn6Sik7+jFvt+z1ozWw2a1tCi+ZndagKzcwixiPIf++AI+YCNbPl+jdu0Ya5J3vEpv+bMuBz6VbCuAEq02D7Q5bgnoMLdpm7D3E5HdcRn7V9j30o9OBgecs0ffKS9hZPpWheNTAz5jy/B89nDycPldgoMdrXzsdLxEYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733266473; bh=JKYM0q82LFQykjEDf08z1k6CfYAr1vK5aYQi14an/PD=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UdR14Qj+uHWq7TnrUceglEkeGQktNOcSQSa14fZDxzogjgbWiQZTOqqMJfAPowDqzoTPzD3sqbRSpJHWZwAepXZ6EEdYKGFhFPrMnmJWIh72Ek5cp5YZXZdlRNo69CTJVM/TnyU3uGDy94tC7LphXUHJT5g2ewN6aAoCE9EVQzM6+HARvo+dI8RLKuoAFSsecO4KoekkukSKvOtUtX9l0QSJPGewOvaAdL4e31JdHg5Yz8eic7PCxwVh1PdoGV4wJ1IsL25T4UZqMFPMuKmJ4ReZ6saUL+xqDU2E+jvpbhvJqZct25EovCb4bXTzC2xnVLqItGay6y29a5UOZUHhlQ==
X-YMail-OSG: w9qIoAQVM1k7F2tLrlhhCVECIbyQMZokU.WPvJQ_SRiDOkHIGfz2rVMQWVz1ncx
 qm50ES9F6wEzpLIXXBl5PXRcLEVkbDZ9OriR6umlk_Kh7jB0TqW.XWK5ESJHsaJe.wrivNSIZRV6
 jhySVU5QeweMv6mDbUE3NHEJ7X9oP9XWxObjsyO7Tlw8jNndlyIFixu412pNcOqm.WYXtrswpkjL
 91peT4ECvX.9BVz9NXUxpm1bzV7lz7DX5.C0O5HSaFPGw87j9WWctcqczjJWiAtNd4ciNMpTwkLV
 Kv5XQhe0yYKqKuocJp1QyFz8PLdYvlwCa8Hv.HqrBeupAViQ0DL_GKmOA.VHnluar6QX3i1WK9fn
 F2ht3ENZ3nEa7Fp7ji5wXuQ.OcI_Fs5gqay4G3wD_blc483bkQhwNrnSyEwmhfj5faDr6CzeJ2pa
 ZkZjm3JPg_OJihaQkM.jX1sU.YlK8Vu_aBYqmH8lDHP3gwcu.ipd0pFB4.UxNJZLTZk3cEeQvQLl
 t21J3fuHCM.fNRRK2exaS6fh7q7VK5GsRR0rWiKAHCIf26qNPmcZjAbR0kpEYNaqSidSY_ddogYV
 nrz0wWrggJgerbFiC_Nk2i8pC4OWJHj3gdmisFfVowcNrtdIBl0XBrnbG1kVxYLmFH2GEVHM4er3
 HUTzrZogwAnKpTPcuAo30FEeMrSyA5725V3XE750NE8wIjI11AEwb_t_mhFUwjG7E1zFY3dUCpuz
 Q_Qev5CAbb73XEXSROt0CRg6c6J_i3agIZtOhyrrXME1pfgffNSzA.3fr0ERd0bD8tLkRY5cKMPl
 iN0m532nfSjEdQsBWM.j8dzylfkCGvpT.hhY2y1FB47LOCtlZPpoLkMT_3AF_lDLhBlWaJRWyg5y
 t4R177CfYH4lTN3izI08NGDWUvIxO37GxQlh3NSiGkOea3md8n3mi13Uxet5fx3ncZixiF1JAH5E
 Gi3qK.0Ly9m2xti.0qOShKCMwFGs_H5Y02WdyKbEqnbz0svAnjPb1K9klv33ZVWbUxROKEbQsOoe
 x2T6r.y.jyWjsQu5Yq9WjmDin6xhZOkYlhc3HjXxOQ8qzThJcu12IkhU_fFM9NYhYHK5fnohNAk7
 u3tOis8XSsXyjSKZEwChgqesoii.Bt55BRPxyJwBRaOOw94tomuSZQYIxWbVpwmtp9hnDGinAyeE
 DKzzlQBR_oYcN0YpTVA2_EpeWbuim14baKCF6e69sWE7lSyAI0QbfsHuVWYEbEBjzbGLm67YCw3l
 K6jHpuaVEhcB2cI_xzVIWAbsmK_LB7dtqVXeJVld.iZf00V9kJEJr4j9U2B6ZP6lk.xAHEhNL5bs
 v5otWH2uXdJrPTOoyAtw463glCHazDhqVFyaIwe1Vhdxx3msZVD0r6L6OmW4kNSlK55P5vZzj8iM
 WvRqzMAwSWk146tksqIhOkwmk8O8yzcUJxHlCVIlHxEJPykSM9IMuQ8ZdQOAp_51M6SND7qZVWOJ
 KZa0Ec21R8MroSmDxaGplxdnXV_sb77o.aZVBrUbqvshGSOSHnxol5zhcCtqcsnKltj.WGCf8DuO
 yd2BpV49ces2taGPqt.zY_UrR3aSCCZEQ4f5RtO9lWRrsJgyMKnIu.8_Rm5Mo74ZKaD0fPmvuM3k
 xPU5FRK2twAhiDV8cW88_Q2VV3WlUa9GoYB_p7GkqRKwhQKDS5te2Oxh_HmarnXRPLiRgQm4ITkM
 ITtcO71yJQLplrrbr1vsOwQPjrEavC657mFPLeBsOqrYMmOKKs_05PSqy.Id48TQDtCio8WB3kxg
 ZVNz1T_DA9t4fvQXcy1syeMZ.OPtzs5qULd3O0..POYaQZtK4TqWEUgfj7mrX7ziNrXt1kjxne.5
 DeK.0GseKrxcFcNO3CHdWeTmeyZKc72KQ6C5R7CG279ZwpUg6nCENMQKib4Vxz6Ret6Oc96BKbDS
 0yxkRieDG55bnicq40oStGacoMWQGkT2lXVOAJGRwvgXetSUSr0hCnHY80XtJYSbbZNDw6CCh9S6
 lhmUBT0dbWXtFC4hqlweLP6DJJ8toskpYE72d7A3se_WSqRiTf7dfUPeRlFAlCCROMl7NqeAiYoC
 hzrXLTbkLlCNeK5wyECjSO8XVSt_RXEVmiNe88UXVWLmXR0H4xvO2wyUp2Gw63omsVH..G8D7pV8
 YR6jhMbFVuhmT3P7zbjZR0DCuPTNanQcUlRiKEuceH8z0K17RxUWB2KRA5fL9wIT_1uk0CeDdfBZ
 yk3HXYyEOFkllZqmAlZNdfPkQOkEtaABwSj8zt6ZodqDdtx2xKgTZTbLrtNxdoS1jsRVzqI8_5Re
 abqyEap8b2udbqs.e
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 02ec80c7-92fd-4db6-8d3c-27ff39dbfbd7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Dec 2024 22:54:33 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 85563a1da9b01404d95e3ee08c3888f4;
          Tue, 03 Dec 2024 22:54:30 +0000 (UTC)
Message-ID: <6bf287dd-36a6-48e4-b847-3030fe3f7bb9@schaufler-ca.com>
Date: Tue, 3 Dec 2024 14:54:28 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM: Replace secctx/len pairs with lsm_context
To: Paul Moore <paul@paul-moore.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <f16f8d81-3894-404d-baeb-febf2fba16f7.ref@schaufler-ca.com>
 <f16f8d81-3894-404d-baeb-febf2fba16f7@schaufler-ca.com>
 <CAHC9VhTfKfAeKKbe3P-ZxP-0Y01r0GF6pPvt=2FxvQzAeTGjag@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTfKfAeKKbe3P-ZxP-0Y01r0GF6pPvt=2FxvQzAeTGjag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/3/2024 1:59 PM, Paul Moore wrote:
> On Tue, Dec 3, 2024 at 2:29 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Paul, do you want a revised patch set for the lsm_context change,
>> or do you want to stick with what's in dev-staging?
> I figured I would just move dev-staging over (I've already ported them
> to v6.13-rc1 in my tree), but if you want to send out another patchset
> I guess that's fine too.  Although looking at the related patches in
> dev-staging right now, excluding the rust update from Alice, there is
> only a kdoc fix (me), a signedness fix (Dan Carpenter), and then the
> two fixes from you.  If you like, I can just squash your fixes into
> the relevant patches since there is no authorship issue, and to be
> frank I'm fine with squashing my kdoc fix too, which leaves us with
> just Dan's fix ... which I think is okay~ish to leave standalone, but
> if Dan's okay with squashing that I can do that too as it would be
> preferable.  Dan?
>
> In case anyone is wondering, yes, squashing does take a little bit of
> work on my end, but it borders on trivial, and it is much quicker than
> re-reviewing a patchset.

I figured that it could go either way. I won't resend. Thank you.
I'll move on to the next phase, which is about auditing multiple LSM
attributes.


