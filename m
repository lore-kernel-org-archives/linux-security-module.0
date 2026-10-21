Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.185.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601963;
	b=10G8IaRu38CI2v83ywHy3sNweIqzyh62Tc2J+e2jwFeAmjzhXNNEubUrNTucU1Vp5oWw
	 VkMap04MCD5TuoSXPFyjFMLmJeO5eXoOsQ/9dpR8SlkHik8EEWsLOMd4MUjtZ15SXtGuI
	 jOn+HxfNIyQ+EOKCnFLWkub/mJY0SLxWfZ7ktLFvRABfvVE8olOm1zmx+b+635gWdEdgd
	 qs98wXHYgD7S9dTYj9CjrB+IPtHtj2Ig+iaV81ZzVZZm0uWlsSQvgDNEhlwnY7xxZqVmM
	 QD4UWjxRVtfsE3N9BViDGkyEcYmvWBoDzNRFOcjU/RHhIiKdzldBaUaBB5mlDD+HhSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601963;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=kah1CZOWcJGjnZrMGrCQ0VvDoaKkFOiqXfkmX5BbHr8=;
	b=DUUQquHuseXj8ZgU92GHBOVdEkSb+o99FlV0VcVR/HWdXryjyp3B7WYsMrzmLoiVQPJ4
	 r/cWthPxeWChj+zxZy4P44wD5RzUVi9RikPd3qpMFw03FWIx+yIvY80E81c+qjflBqcg3
	 kKgBhSYvQou9JNdaYZxqDPk3rG0Xmp3kpzDUfm9Fe5ev5oZrClqC7BwroXFM1PdT3UYCD
	 GMpdNFXA5mDePLaMwt9iaXqLmOxNJzuNh0llP0RTBv7IkE+2qWaH6aMCryxBOyu+C6aj0
	 8z5RSDrQMhkn550m1xZzm+keHzAtMvRCI2iMrm3VNzq2oN4MeqTjCqjiPas9Ekuydhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schaufler-ca.com;
	spf=pass smtp.mailfrom=schaufler-ca.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=qMQnfBDi;
	arc=none smtp.remote-ip=66.163.185.153
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A17606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 16:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2A17606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=qMQnfBDi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792601961; bh=kah1CZOWcJGjnZrMGrCQ0VvDoaKkFOiqXfkmX5BbHr8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qMQnfBDia3rzQvnbPH1rRInnCtXPAP7wZxUN69jQdmj3/feNJUurhHOMBlYlDz6noeiMmcDw8D3O4VsFGFMc68sBU7kW9UooBIYSAnN7sc8q3CgvnBl6SlrGNLvn7X4DjI+bv+1/2OFC1fgQpEobvfQx3Or0w1h7HgHC2zANGhnkDTNdehZRGNSM1vY3+aw5PHGXjvaNz7toI9rFfbZ2qV0WaNHY8pYG+ddiJ+VuwMU2+a63TXX+xbcSlJxQUSFdKWWayhUQB0h5zMg4Ry2fjOtSIJ7w2qFcn5BK5OkWXtbSjDELJvZ5JhzuDfy9VaDrWDF0kYau8YoH/wgolRUgzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792601961; bh=9PleWcYR8e2xn5hY7aHEeHxiIX60ZkmF9ZqouUvxMwn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BiFURWH2inSJa7DFCFcZJwzBVBrLuIxN0cdXYla1/FI4QIgnjpsEUnivZv112EPYGJnvKMXlWURjSGrxzegCZc6npQ8F8GiIkCMZVHdqD/+vr/67no8e8pPnQFvpXgYs19P/40Y+1rFyltkA2GxCcMRtn3fBmBSZ1yrvhkz1/K5ccD2RgnOUD5ppzYTYrRHoNMfuGYU3z57cFbJXfZgehmzAs6YmxbKSKO4m/l89JzNp/t2GQP3OSvDH4hedXG4DzZC1LcRgTsNN3VILCvMirXj+L1Hx9eLf3/UbEFkKx+58zNXuLh5W5G+/bZFUkKTTPNqqVqyEJJ2flRpRVQZ8JQ==
X-YMail-OSG: LCA5RiIVM1mFSCBMSGrvZTC8G7qdX_QeTDLQPq11oZ4Qs99RUpqqME0f_B_mElZ
 l6.tE9BmQSqjGHTZGbu5..066d1.QaQxFtWQhzSbQaXqKv9BGyIywqx2ethhepd5Le6FRRzaBgvT
 IA5kBQUdG3bOvzIV8Mdg3nBI_l1Vw6U2HLt6PO4KsNeIahFcgcofhYolkU_geZBbhLYIVAuC407Y
 HvbLmP_rwk5D5uBG9Ck5xRyetpLcpQKf7QbYsUtP.8bAQyx5Q_DKSiBUK9W77Zo1DwP2joi6nKId
 azCcKYp3M3lk7toaR7qnZ3jmWyj0ZHcrPeGPdva5QynQCq7tx4Wf3_uUjq_gO03SL1p4T99TNaa0
 sIDF3HL.BTRJJ9wG4tWNiGQdpFQfzXDg0ZLx7ReBnXGGuaGQM.7Mf6WDB7BOPA2rFMF.jRlOy.PF
 YkK8ScMuhQFMupMZzQI9r0jBzRPPvY.AP2NJ2Bm_uVycbuEGE3k11XU2g_x_1vnZVgoQ70hoshl5
 c7DtDzSnTv8o3modT6ZdSdrlcQul8Ml4gUOdlQfZwJ5NplHl9tEgyua5GAx8vvnlM2XAPrFW5CjL
 hWFjiv0R_G90utoxLyOtsCsynU1DK0YWmKR0aHelhshp9Ik92VJfRLjPAapXvR1ZrT0z1LEb7kRc
 5E317PXytnV8Jp7oYSDMdHjrJZUMw_vdyRU5ecKfsC7Xmb0bgD6JRw9EH9XOLs5PXcvAZodtbQkK
 4FoVtN.J9jgRMVbRgqjsudq2xYgpq6ntEtCqoT0TSwWD8nORuSBy.3C1343SDhg7Y7H9woZcCjj4
 j3ym21r4ATvK8faXoConUY68Ct2M_v0k0r9ZafLWBaDmRxVHvMTean.IKYrqq8XvN5Ig7xk129vG
 HILg1N144lXulDiXI1UYiZKVOKuW9JXGXWk0bvw1wzqGUi.oLuG2IgPMuBvtGQgmXDrRsGkS8oKe
 wjjXUU5xri6qnDyGVb1EY0.4H6raaNgpLrBwb.spG0hbAJPhfSxgBns.YZpiVOH8F9yDWkogQ3CF
 Oc5sfT3VLkLCxu1.EfkYQsI1WbW6xjmcpPVawbpHSyX98Nf5fM1_1QD3MuUmaC6ehO55_yB9l.z6
 Re9XZczDI_95HTzLLfNiOIEI3qT.soQ5bTtLQsMcJk03ETZsfAyKc0ylSYplHM9e_iMNHjUPY0uM
 EVbxOX8_hf2rgWLMEawC9ES5oz9t7CFtGXLiNes2Jpev5e43XzLY28mQt6l.F5mw84Gx8D9rgKwt
 Hrxag5HrDqh0Pe5t8.HTz45sXVQqt7sq_0pak4Xvya6Ztzesc0XT9EfCuPq_9gjHBG2Pp0BZUPvM
 7GjTYYNV9nGProtYkPF70ABSabjDdYOOHJco2neGyV28BQm6flQyvfXC2DsXLUIA8MWd9iaJcXIO
 3snVF99t2NwPTCF825eJhnIjdPTxQSoACtUtGyZ7qj5lR9ck1wpavjNaU2YxsOlnJh9MPANCcWzG
 grDz5WAW3VtLpPUC.wjvvz.iYd_aGqnrQWtIBnB0.FvtevthzWTMu5UpFIboJfDL5qfkneyaX24c
 uKj7xwMxTsK03KM8wvImj5ZuXnRozbbeU0HZpaPElt_QyVpuv4JYRMcHm__iCAo.rOj7g07TUkcH
 dEBlnRsD0E7s3MHPqx8C6WN21R6vsy5X2ZbDXxbh1C2ZmRKkSadL0QqxNRcJ9e46FnF.1PdafapW
 9AyUruX88Y4VUp1EPcuU.34N7QRKobQ7N98TjaYtOsBV0cTF3oHfD3J8pCQ27V22nsqVoFaddqgy
 JdDWkDKsocrnRJn7l01fOgJovbUa3sRWC2YuDIEEHtlkEO8VFw18XzuC30JLHXC98rj5r0lPR5g5
 D7gOW3y_hng_S.bbgnIDbGwv3xuA0Vv_eawLObYrhnEBms1PDU7i28IufTfcYJqckL7WKnh3psBi
 0VJ_5yABobEbzCFT6Xv9kIJNCui0UgR4VSpUx1CQtqG12WwTIFsnXGRfQg0xZE.LVcMFPMTGrFQ8
 aI982JBxQoWpacnVh3SKkzmojx1r04A6WI7.AZTv1YnHu8aoZTDWiQz_aqeGisA9GNb2BiB4SCaA
 pqB0t7kUCPvh0Ic8i.cszWuYosiBbEy.dyTUNI_Hd5QZbcp3xMThX9eqxEpJR3Prooszu0RgBUWu
 gRUeji98ltpVfBZgpC8HqsDSaSwYhH7Qx5RS2ZcQrpV3PlazGfrWnwNktaL6IvnpxsZ84ZIk_q45
 N2vKv5blDyT86KvsV_F7z8m7hnVaLFROlo.sESARl5kSsfbP3jG1rMz_px8rm
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e7a1fa82-6891-4739-95f8-4de5b52417d8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 Oct 2026 16:59:21 +0000
Received: by hermes--production-gq1-fd7994565-ftb5j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9de1ca094d9183894955e8f06f19efe4;
          Wed, 21 Oct 2026 16:59:17 +0000 (UTC)
Message-ID: <0aeea80c-e3ac-4b6f-b1c9-ef18ea2964b3@schaufler-ca.com>
Date: Wed, 21 Oct 2026 09:59:15 -0700
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next 11/14] smack: specify SLAB_MAY_ACCOUNT for
 smack_rule cache
To: "Harry Yoo (Meta)" <harry@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>,
 Hao Ge <hao.ge@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
 <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-11-096800aa3330@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-11-096800aa3330@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26740 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/21/2026 4:46 AM, Harry Yoo (Meta) wrote:
> smk_copy_rules() allocates rules with the gfp passed from
> security_prepare_creds(), which is GFP_KERNEL_ACCOUNT. Specify
> SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.
>
> Path: fork() -> copy_creds() -> prepare_creds()
>   -> security_prepare_creds(GFP_KERNEL_ACCOUNT) -> smack_cred_prepare()
>   -> smk_copy_rules() -> kmem_cache_zalloc(smack_rule_cache)
>
> Assisted-by: LLM
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

How was this change tested?

> ---
>  security/smack/smack_lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8e88ac65fd7f..8a802578ac29 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5352,7 +5352,7 @@ static __init int smack_init(void)
>  	struct cred *cred = (struct cred *) current->cred;
>  	struct task_smack *tsp;
>  
> -	smack_rule_cache = KMEM_CACHE(smack_rule, 0);
> +	smack_rule_cache = KMEM_CACHE(smack_rule, SLAB_MAY_ACCOUNT);
>  	if (!smack_rule_cache)
>  		return -ENOMEM;
>  
>
