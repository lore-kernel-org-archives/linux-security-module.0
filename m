Received: from sonic301-12.consmr.mail.ne1.yahoo.com (sonic301-12.consmr.mail.ne1.yahoo.com [66.163.184.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5D274FD0
	for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507452; cv=none; b=VGlPsiACZraZ6dCpig3b2ceKAOXrbca9Unu1xnwFuzQKf2raquDP3igVWI1p8nSgK+PFi21UuEF7Lp/ciLQlM0dTvylxX2W+5vNX1kgOvIA9KWooITxLrJJb1A9OhkRGqXoP6j8aJFYk9And8btd1iW+fjY0slANR4hhqTPuhwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507452; c=relaxed/simple;
	bh=Hdh8XkdmMraPWggPZVSWG77Mq4aMmXhUbXSfVBQ3x/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=NNzbVjZqaeAz6OCAzwtH2z+UifY1K8LyRg9ozl9tVVZ1jCjFcaFE6B8IA6ZmF5PbpMx5gVRPsWrxxFAzdSqHZ+Mc+Dqfxg4D1flshKqdAL2CkkH/gFUENTlK747GfECAmUDtETTrdYBctKv77NmbBYSM9UCCtWllDZ3HToht2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oxvFWbc+; arc=none smtp.client-ip=66.163.184.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oxvFWbc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760507449; bh=HiJTxvPrcA4KE9SH/1VAzY2LqvCZ+dCuA33vtdCXrDM=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=oxvFWbc+28XekpWK5GV0EGXsxqzEkUn9V1yUnp3U5wNTeat59dyNMn7zbnmvFTRxV0Y/TJ40ZpNyJhqQWK4ciXmQyLaycNiRa84AGYYBcEr7IytQaga0XCss3fb/ly5nk1E/us3u8uEEyYv/M9kQrysmC9ZZmLuZGmOTa3YStl09DoHM1IUkQNdIJPDpgTrlDJ9qjlAifhWXKIt1YHVZvvMO56Bb7hrGFuis5mgbj5MolkDYs1MaQTdWyohudqOJ8YDIe/A0wT7KojBk3TNTnEtn1Yr7ps8AgAUbtRUBrhPQRk95A+9ArnZQ+aqfyQpN2wFGQLwh2rpnvWaxB8YP+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760507449; bh=HVe8IjFcUMP0OUUMAva05RdWHjFd+KAtuhi9T3FCF6Q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oM3Kgumm7y8rK6K71/7+I8DS6Cl1/SLqdDKhIiWFhIPYqO+QNFzXjPzneeaDtIHLDb7fPk72jQ1TaRnxz4yhSs1DAt4TYZ0MtzXS98wzgWTtrYSj9O/rd7Z82wHa9li7V7Vxd0qUUDYrOaN7hFOK/8F1QcJS3hJ+1nSaweyJ0nOqCClVnlMyV8kRJPM8AlwOb9DTtQnc1MB8d2+pnNF9WBuLBM1Ww482Ng6GEBK2N6M74NcV5vZVU4lSdcXuY0Cj66d8vCLLVkPgWhnkcGA3Q3XbAC1l9/MO0uv2v+tDIi20QlKdiuz195n+bpmMotWDGlu+XQq+oVFW25S5KsNUPw==
X-YMail-OSG: 7U2fx1AVM1m1kIImi44m2.bXXOehC4CBpqrjcCv497oMXn7uJZnt_cL7A5EufjY
 HcPgrUcIdgSIh9Tby3VGHDHZX4u.2bP1WNy.UUxHS3MayPhgk3c1AksM4hbF3fqdYFz1YVvaZL8p
 _XI0YlC6d9yZVFiTlQpD9HCIMpQGTKMITG62Fyqta4XgH7..saajtmRg5qEFp09omGGgzQNFOS0x
 yzceC6.Cr5OEU0TV41GqycqGqsYzr5W84C4xtCmfp5xlaz.lIiIhpOjj8ghazFhwE283q0zA7X15
 RHgF0tD7rIcnW3skHV6u1YRrmMPNhJq.2QL.f2lMc8myr9Zd.XY7QHu4dbN8sQ3KVP7XiFOBXyUh
 jV1t8w_iVGI31BfrIOz62hbC1Icxss18dyEBj38defq2coyUj9RZ8SA7fbAUYj6s8ib6ZfXa67az
 PL_9J2iFddwtYBqgej6epdWp5fhEKmZ3QLtblkKUZbqu3t72sNXT9P.Wyq1ohAql2KKfowS6_JHs
 b70LnFI9vrrZS7.Yc.nFODxZFTcL4n1Ya0lG.6OIFYt_tqSuAXr1CAczvXZ7aPMgsHhLfEgHqGVN
 neejlL5jBiHHOqJtweRGuiiltIq0QC4NSDgyOiJjpI0LwAluYrUb4yR_iRhK3OFq8IMWgNa5xRUV
 _SSTQ9O8676tCHPKSW8biOsTZJbgDojokbVgRL8atbGbdJYxUpT6DC.QCNpMVS6TNDPj8ng7a2is
 0RVsVYlOnR.3CZlQUWowwcZU.3tK_JdIpum4LHui9zQ1nJ_mviCc3jKD498AjN7zcVMthKMdI0SF
 lrfciqS520djAQt.K04vui4bIbd1lgMWKresoKZObm0y_wMNmtW01pm8SnHf.ViekJSnPkr_SETO
 2HvXAVEn8t2sHgM7Gl4dukpSeb9DFVrcCjCVRY7YF0tiwf3hI1ja0itfGx54bRLncBQtU9BX9urR
 fIgb_WwXbYWJGosa8aV7CNxkfBdof3J1cLAI9bKYOp4jFMYq0BYBtiA_wYuK39Lo5GAYRiuDbQMk
 bpkyakcqvy20Nto5CXmFDLUi7O0gqHcgzd_7gc0c4ik5f9cGuzYm_Y5pCJn1qFPSxGHBMYv_SeYa
 nrGFmnweKr5qduqVY0xF48Nc_5c5yIaNDmi1e5PD7VNMFUk.MHR5mPfr1oAHbwsLslVAoWH2kuk_
 OQmkddbji1Wk3HwnnrQhIuuI82Ie2SMB_mTgKNFn4efOXXbmvagbh7caEPv8yid0LLl4HYzIOifz
 YBwrPw6xHom2zswT59R0ISRKrdNiCQN2csnrPAAustKNFj45CRbindRKOjjgjhtdYDrl7eBTvh_V
 TJmGeLbsPT_7Lg.xeFG6TInzBbCaF8hzumtKfiUMC_M_0NOhvf2e9zmJoIggsLsc3M9bEYVfDDCk
 DHYdJr6fp1g24dHxFRhgI48be5nbqglX37tfBWG1t_dU0LwqGjtraBWUKum0gjuY6.3PJpt9x8a4
 A5Zuzk1KWgHDiLAfovBpKX0DQBZ7G7X3l.vw9y52udZNnaxOsK.rAq7g7GbFNWIg5YdmV7irz4dZ
 z8UQZXJzQElu63OpV2_oKObNuNe6.xjOax82LwmLpe22LkOSEWOnbRAlW5BfqgFq4bjhkwkzMvIM
 OXcMKnrF2mCqiDqEL2cswSsS476_fEKhkFh4Gac5b.4wLTeWrAg8JB0ZIzA3uG7SzyJMA2kWemBv
 ziFH.bTXULc1A4USyFCUmtxlH4JVp7vnqblVUHS8tBLFCh301itNqrMGlBwEC9I.6QLR3bKuWFvL
 X9Kv2fGPNZWTjvp.F9CYYgBdVNGzJS1PGfE2n6Dm7yS7GKLMdcCnHr10mqQQEtUv1NpykgZdsBkn
 gDhmhOfNrM.Ux2P.LCn.M65Bdl5ZNB_gqLgyqkeSLXgu1cQD8HnTeV9uKU0ReJYVjw2wuwvX4jBx
 dYhLfX00_CSk2nOvu_VUPkwofHaHKO1mrbwXVmDvJdvSJjcfxaCiTof8eK7jAr9ettdG9uaPUDAi
 rbIX6eCxL.uBkam8NmYS_aVl5Kdy0coGIubTQS3LtVGlbcHLa30CcJouvCGViBElDf26.O0pmlXK
 p.j174q5LHlC7eVZ9VWVI58TyLyJiCU0gFG2zm_Pa0a8KUFaH1RaWE1J134AQcbvJZcFKBokp1Pt
 mWzwVSxLQzNeXfZVuDQUPDlyD9FfwTZctH1u8l8tMG33dyOs3vWp6nMX.eWFqbEskKUrJgFMUWj9
 yZSvoDgKiZ.XMrDy7gSdNVQAEiVrRqC4t6C_jFBkDhkLlBQrYwvPadoJAF..n4Fn16kL9zwzTlS_
 m2xo1hDQZRThnqIw2W40pB_C4QzHSg0VmMfnRgtl8gZHxFD5vTVKGiIjIPbmC
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1c121403-6995-4f53-bbfe-be70069dbe1c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Oct 2025 05:50:49 +0000
Received: by hermes--production-ir2-78d9d5f8b7-sp2tg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2eafccb7e3f29232072b693ccd54d29e;
          Wed, 15 Oct 2025 05:18:26 +0000 (UTC)
Message-ID: <1dad4179-d133-41ea-a76c-569a2f92fcbe@schaufler-ca.com>
Date: Tue, 14 Oct 2025 22:18:24 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/15] Audit: Create audit_stamp structure
To: Paul Moore <paul@paul-moore.com>
References: <20250621171851.5869-2-casey@schaufler-ca.com>
 <846555fc86ec02df31f55935e747a71f@paul-moore.com>
Content-Language: en-US
Cc: LSM List <linux-security-module@vger.kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <846555fc86ec02df31f55935e747a71f@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 10/14/2025 4:12 PM, Paul Moore wrote:
> On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Replace the timestamp and serial number pair used in audit records
>> with a structure containing the two elements.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  kernel/audit.c   | 17 +++++++++--------
>>  kernel/audit.h   | 13 +++++++++----
>>  kernel/auditsc.c | 22 +++++++++-------------
>>  3 files changed, 27 insertions(+), 25 deletions(-)
> Dropped as this patch was merged into Linus' tree during the v6.18
> merge window via another patchset.  To be clear, I generally don't have
> a problem with multiple patchsets including a few common patches, it
> helps prevent cross-dependencies between patchsets which is a good
> thing.
>
> --
> paul-moore.com

I'm off-grid for the rest of the month. Will respond to these many things
upon my return.

