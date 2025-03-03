Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A09214A7F
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019050; cv=none; b=d/gWsMN72OTsSFs3vCqXFKr8zA1HSIhjgJqPco3i43h2wcmq4UN3srk2SWzz7aLXx1L7LuatQ1CJQ6PIXArsrnn56b6RRuvDR31O+Cait2jpxTwYzRmY5FW1w75WQDYeKymFCBCt6srxh3R5TcETehJeXzzh47wTyuA2Aq5glKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019050; c=relaxed/simple;
	bh=DjZoDpQx+3a56jQoaSWpqK+uU3hYtW+dmvrFiohaUfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUahsdsKZpHALJelidBr0IGhkBHzfPdUbQa1Sgnan95zejMZl2tzchoHAXofdFUry90SoMkI/PTJjPWo69O7kWBJQrzALzTkU2MivRtK5e/JExTKVi5cFHGJ9mLCjH8i11ZMwYOjv/0RKalMEKyxA68rmB/4eRYbrkmBPnoJ0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Vvhx9974; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vvhx9974"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741019041; bh=cJY6YeZRBbInF6N6qIM/vg6kC/xFjdQ1iSja5yMPKy0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Vvhx9974QF3JumuIiR9QJndBMYjnAxJVZL+NKWAZmCqEyJOyq3qNnQzALrQ2LWWzsYSocMCyH52Nv2QUgm13ybvL1SUe0OGmj1OscE/EGrSOk4T5LSGs6ahMZlqG3jzbFwPFKfBU05kGokLITfv641HSghan3S8NOhkHw5yxcMVKx5u1htOqdR+9sPovHsPbu4QlGgxTNFPoMahFIi/J/CBPDT3s5zpchgTwOYMVuM3kYq6/g59f2ppj6laA5ufspSJZUbhChdDCmBAo1IjFR076z/hbKCrcDSeK9eW6yhUkzCGW1m6wyiMvpr9AH3AjXcTfgg1HFOGJsx2knT9m8w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741019041; bh=AfcOIM6Y3k8ZbpKMLAjVqGuHLJlM2f4H3LeT2LbT1E3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=g3fIww2ID3RTFPXYtp+31CW2KYP0kVamSdrOW6lCq3PVJD9qvcvQa2M9lmIbDa1f51l6YViwET0W4X9L6Py55/rJ1JKdm1YZ/ZL0GOvVtMwuSxGzXIHpejg4lU0hiJDumwdV5Q6TqwrYg9pOYA6BE9qnn2lwOzeKQZQUpLLGTWKXWdzN09FOAQ7JzmsBDcZfNprvuw1PlXVoWCXCRHXn2mnGZlejNcfJ3YfvCAc2POsZdVyO/2AHX9v6OPsqHLkIsIGDwWbsosMS+Nk2WC6Kg3+fko8oxnp1Pj6HhBXXTXC+9L1xvG1fK+dRW7XEqC7V/UJTMIytQ7cuBS8DiLEK3A==
X-YMail-OSG: hGfBxGkVM1k4VM0yrKEmEVt3LQ9LqCRqp7OhDBbmHFk04K5GtBGUGC8Us.ucgg2
 5cwwzwU5VEhZHbKF_.Ro3BSD4kGPvCo0JHgeho24aWBU3UOgW.EOY7n3BWSCB_N124xPGW2dqZrB
 ZeWiLO4eRbM19Q09jY8DKri6m.6qRrpapJfazzr917vvESLpDhKJP20PivHusz.x8lfqragx0G74
 EMoOMYnJwYW6WUBctrV5POyH5oGDZtQGfNCYzy13Tou3LOr.lGy05Px0kzkHGYCQ1fUcili4NOar
 JYvFOORvuzNPTvY_ao6zANrL0eBFBEpR8IxLDgOK0gmiPoYHTK62EHykb_A_nXpZcQ9ub2bpVwz0
 p3VBDQGZ68sP3NGaVzOG8x1ndh2mDgUEofUoBw7e.RG0cN4j38mNPgQYhAxKemJ8U_InjN3X9iAH
 d0KqhEIs.1cjAN4HRqbo5x5nr.k51ASZhwOOBHJBYCZ.bvUE0wL7fkMQKvu0umK445WtMEY6cJ68
 f5ltyjtOweOgiY.EfsjJdvFDuZXKtz9TiYhWPdjHP.4KF_AgRk2T8bsN.LFyvH.cnM6H_dl2towM
 _gYODXTC.ZshOkGRJpDjB4wQwkBcKLH2PqLKQ_Lh_L94S0rtGeuvMGrh1nbSzLQ3Bu65SwYZ4xm0
 bNxSXnlcvOoJ2iWGL1PXlr.Un9d2fUSc2J8VXDSXOweJbSAXxTm5jTFdp4yD_EQByVDjxyUFEimt
 UmAWXxRggbwFb8W0m.P2Nem7u8uaO5lA4E2wzGFliRsJRNQilLIDG3edHYZ.tlNnOsxzEGNSV6kr
 Nbg9l9E00SRt.JRjXRoJJ7bLD_NVVg.R3_xocnxdWj7GFo34PtlmRSOlG9D1vNWdswrIYuSNnoYq
 ZCfH5KRlARcHnuLkpZe2rxKSZ1J7Q8ztwlF0vB4pj7.xrtmc3Ta5mYEQ.GjDB4Qfn2fZXSl19Nt.
 q6p_0mCVNr2xRWeuCVkpCFHRvDvS4o3s1Ah0PxczHRkuIvakw4DtJvLFReMziZ9jPS8ko495D69u
 EiNCIDzK6pAkLtcZDdG7l8XQZqqh3I3929BAgbURPanM2IgsLsa.dmO0wt.lwiUfZnQIx6SCvs6b
 j0SdYixw7TPXgH4npXnn3Foh..1Zzlr4i1zCChGHT3h_56Tf7G1uQWM130c1epng7Hx6uPrsHEJ7
 kWMzNt1Baie1zCPOpP6osSoE2xcDS67mOo_It6VK07AMWc0fV490Y6itNSUt4qx.tSRpjQi.NLsI
 NGdgQWg8sQt0cW8dl7YLMlFTravJdBOrNCN_b_yikR8dQ6mg7Z_p08hw7SeLwakJHv.wfQ.j5x_3
 AIJkWxsX7gFilpMbfumU.CDSQhtdR4pkJlF51kg17mN_Z3yUay91LUDcDut0Qtyrkq.G3RAtbuyW
 9nYQW5PTmSf6WT0jiLxBgIsvJ7gn5nHSFgXzYcRICI6BA0yAYK4DiWcwB0dI3vfDsQ.hw.8sUiRM
 NuvkOJaoqEnrFYbv.nbGy1FkRtVAC_0PmnEfwkWIlFNcwGPV94sqn29nHezDz.W7c6GIr3Hin_zd
 RlT0buInQTV20H0dcWP3C736hlKZ.y5YeBr2aY0QDbH_9ztgGB3skCeB80IoJEUrAkDGEHOKC8ov
 1wA8Zjv7eutuV_jcaMs8RxbOS2Lwy2fAOANVismDg8pcP8eA5heTHDIAnxAJhIJsUeoOW9fnatdU
 SUQPlKFXmyzjoES4UWfoJfgFg14ei6HePM4MB617NAkKwl6.fPSiCUYZEbI.TCs1nvZopD5OkFUj
 Kz1LJCQfdaPoVmVk70w_OCIE8SUf71HHfT26sUYkgln8pXPLb3QNMahpGmReek.KH3Ko68SZG5wC
 TbXkkk5Gd7cbTUFg8qI8qRrwxTaCsKA5HSSf6V_AM_tty7Gjy4lnfjgEKb886TgjTIAt3UdDInK0
 Jd6TQjS0MZfd12ERsjHyG_ohKy9SXviGFVq46UVh2U9TBAS0sdG5fGjzc_b1wZKG.vaU96E4K8OM
 GA7bqedlWr4_lHQr3QZjQRnZ8mfK.Gp7qEgHabNVHteBSuaZX.dwm_HELMs_813Nsr8Q7I.0Ztbj
 PQBHrY0afwHPkucEqIHgw0KLQqfO8k0KdGB.gdgFxEcD4vQn9uVAvd9xsMMxOZ_p_VHinCH7yzPK
 36qacrZ0cyrzSxNGdL.2CgZpaC3cDsmyb38PY.w36moUEIFsPReQ9r.yK5SEKZMBMFwW5d9T.5dB
 ATSmfG5eZ1_.GN85zrQj4PbWh1BvR4Ahm4qzLkMbY0m6GGGTEEpyRh5x55SgPwpFPir_LB6Nj15o
 j8iko49k.62o-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: eca0b006-803d-4192-acf3-db026be07d72
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Mar 2025 16:24:01 +0000
Received: by hermes--production-gq1-75cc957d6c-8gmwz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID eed0aee7db19a514a6f254863dec36ba;
          Mon, 03 Mar 2025 16:23:59 +0000 (UTC)
Message-ID: <cbe48864-6f24-4992-b84a-027473f34617@schaufler-ca.com>
Date: Mon, 3 Mar 2025 08:23:58 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, jmorris@namei.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240826103728.3378-3-greg@enjellic.com>
 <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
 <20250117044731.GA31221@wind.enjellic.com>
 <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com>
 <20250225120114.GA13368@wind.enjellic.com>
 <2b09859e-e16b-4b58-987c-356d3fffa4fe@schaufler-ca.com>
 <20250227121207.GA15116@wind.enjellic.com>
 <b60f2453-9c7a-4e69-9520-8088c09f4070@schaufler-ca.com>
 <20250303101435.GA21445@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250303101435.GA21445@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/3/2025 2:14 AM, Dr. Greg wrote:
>  Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project

I give up.

